From: B56489@freescale.com (Yunhui Cui)
Date: Thu, 14 Apr 2016 11:50:52 +0800
Subject: [PATCH 6/9] mtd: spi-nor: Support R/W for S25FS-S family flash
In-Reply-To: <1460605855-6689-1-git-send-email-B56489@freescale.com>
References: <1460605855-6689-1-git-send-email-B56489@freescale.com>
Message-ID: <1460605855-6689-7-git-send-email-B56489@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yunhui Cui <yunhui.cui@nxp.com>

With the physical sectors combination, S25FS-S family flash
requires some special operations for read/write functions.

Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 157841d..91ee920 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -39,6 +39,10 @@
 
 #define SPI_NOR_MAX_ID_LEN	6
 #define SPI_NOR_MAX_ADDR_WIDTH	4
+/* Added for S25FS-S family flash */
+#define SPINOR_CONFIG_REG3_OFFSET      0x800004
+#define CR3V_4KB_ERASE_UNABLE  0x8
+#define SPINOR_S25FS_FAMILY_ID 0x81
 
 struct flash_info {
 	char		*name;
@@ -78,6 +82,7 @@ struct flash_info {
 };
 
 #define JEDEC_MFR(info)	((info)->id[0])
+#define EXT_ID(info)	((info)->id[5])
 
 static const struct flash_info *spi_nor_match_id(const char *name);
 
@@ -881,6 +886,7 @@ static const struct flash_info spi_nor_ids[] = {
 	 */
 	{ "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "s25fs256s1", INFO6(0x010219, 0x4d0181, 64 * 1024, 512, 0)},
 	{ "s25fl256s0", INFO(0x010219, 0x4d00, 256 * 1024, 128, 0) },
 	{ "s25fl256s1", INFO(0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
@@ -1018,6 +1024,53 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 	return ERR_PTR(-ENODEV);
 }
 
+/*
+ * The S25FS-S family physical sectors may be configured as a
+ * hybrid combination of eight 4-kB parameter sectors
+ * at the top or bottom of the address space with all
+ * but one of the remaining sectors being uniform size.
+ * The Parameter Sector Erase commands (20h or 21h) must
+ * be used to erase the 4-kB parameter sectors individually.
+ * The Sector (uniform sector) Erase commands (D8h or DCh)
+ * must be used to erase any of the remaining
+ * sectors, including the portion of highest or lowest address
+ * sector that is not overlaid by the parameter sectors.
+ * The uniform sector erase command has no effect on parameter sectors.
+ */
+static int spansion_s25fs_disable_4kb_erase(struct spi_nor *nor)
+{
+	struct fsl_qspi *q;
+	u32 cr3v_addr  = SPINOR_CONFIG_REG3_OFFSET;
+	u8 cr3v = 0x0;
+	int ret = 0x0;
+
+	q = nor->priv;
+
+	nor->cmd_buf[2] = cr3v_addr >> 16;
+	nor->cmd_buf[1] = cr3v_addr >> 8;
+	nor->cmd_buf[0] = cr3v_addr >> 0;
+
+	ret = nor->read_reg(nor, SPINOR_OP_SPANSION_RDAR, &cr3v, 1);
+	if (ret)
+		return ret;
+	if (cr3v & CR3V_4KB_ERASE_UNABLE)
+		return 0;
+	ret = nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
+	if (ret)
+		return ret;
+	cr3v = CR3V_4KB_ERASE_UNABLE;
+	nor->program_opcode = SPINOR_OP_SPANSION_WRAR;
+	nor->write(nor, cr3v_addr, 1, NULL, &cr3v);
+
+	ret = nor->read_reg(nor, SPINOR_OP_SPANSION_RDAR, &cr3v, 1);
+	if (ret)
+		return ret;
+	if (!(cr3v & CR3V_4KB_ERASE_UNABLE))
+		return -EPERM;
+
+	return 0;
+}
+
 static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
@@ -1311,6 +1364,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		spi_nor_wait_till_ready(nor);
 	}
 
+	if (EXT_ID(info) == SPINOR_S25FS_FAMILY_ID) {
+		ret = spansion_s25fs_disable_4kb_erase(nor);
+		if (ret)
+			return ret;
+	}
+
 	if (!mtd->name)
 		mtd->name = dev_name(dev);
 	mtd->priv = nor;
-- 
2.1.0.27.g96db324
