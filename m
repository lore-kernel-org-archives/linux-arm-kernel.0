From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 18 Sep 2015 17:49:26 +0200
Subject: [PATCH linux-next 2/4] mtd: spi-nor: properly detect the memory when
 it boots in Quad or Dual mode
In-Reply-To: <cover.1442590224.git.cyrille.pitchen@atmel.com>
References: <cover.1442590224.git.cyrille.pitchen@atmel.com>
Message-ID: <ff017e6364ad4e893bdafba3a12c992aa5cb4870.1442590224.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The quad (or dual) mode of a spi-nor memory may be enabled at boot time by
non-volatile bits in some setting register. Also such a mode may have
already been enabled at early stage by some boot loader.

Hence, we should not guess the spi-nor memory is always configured for the
regular SPI 1-1-1 protocol.

Micron and Macronix memories, once their Quad (or dual for Micron) mode
enabled, no longer process the regular JEDEC Read ID (0x9f) command but
instead reply to a new command: JEDEC Read ID Multiple I/O (0xaf).
Besides, in Quad mode both memory manufacturers expect ALL commands to
use the SPI 4-4-4 protocol. For Micron memories, enabling their Dual mode
implies to use the SPI 2-2-2 protocol for ALL commands.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 52 +++++++++++++++++++++++++++++++++++++++----
 include/linux/mtd/spi-nor.h   | 23 +++++++++++++++++--
 2 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8818d4325d20..b857e9be2026 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -61,6 +61,11 @@ struct flash_info {
 
 #define JEDEC_MFR(info)	((info)->id[0])
 
+struct read_id_config {
+	enum read_mode		mode;
+	enum spi_protocol	proto;
+};
+
 static const struct flash_info *spi_nor_match_id(const char *name);
 
 /*
@@ -701,11 +706,16 @@ static const struct flash_info spi_nor_ids[] = {
 	{ },
 };
 
-static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
+static const struct flash_info *spi_nor_read_id(struct spi_nor *nor,
+						enum read_mode mode)
 {
-	int			tmp;
+	int			i, tmp;
 	u8			id[SPI_NOR_MAX_ID_LEN];
 	const struct flash_info	*info;
+	static const struct read_id_config configs[] = {
+		{SPI_NOR_QUAD, SPI_PROTO_4_4_4},
+		{SPI_NOR_DUAL, SPI_PROTO_2_2_2}
+	};
 
 	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
 	if (tmp < 0) {
@@ -713,6 +723,34 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(tmp);
 	}
 
+	/* Special case for Micron/Macronix qspi nor. */
+	if ((id[0] == 0xff && id[1] == 0xff && id[2] == 0xff) ||
+	    (id[0] == 0x00 && id[1] == 0x00 && id[2] == 0x00))
+		for (i = 0; i < ARRAY_SIZE(configs); ++i) {
+			if (configs[i].mode != mode)
+				continue;
+
+			/* Set this protocol for all commands. */
+			nor->reg_proto = configs[i].proto;
+			nor->read_proto = configs[i].proto;
+			nor->write_proto = configs[i].proto;
+			nor->erase_proto = configs[i].proto;
+
+			/*
+			 * Multiple I/O Read ID only returns the Manufacturer ID
+			 * (1 byte) and the Device ID (2 bytes). So we reset the
+			 * remaining bytes.
+			 */
+			memset(id, 0, sizeof(id));
+			tmp = nor->read_reg(nor, SPINOR_OP_MIO_RDID, id, 3);
+			if (tmp < 0) {
+				dev_dbg(nor->dev,
+					"error %d reading JEDEC ID Multi I/O\n",
+					tmp);
+				return ERR_PTR(tmp);
+			}
+		}
+
 	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
 		info = &spi_nor_ids[tmp];
 		if (info->id_len) {
@@ -1012,11 +1050,17 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	if (ret)
 		return ret;
 
+	/* Reset SPI protocol for all commands */
+	nor->erase_proto = SPI_PROTO_1_1_1;
+	nor->read_proto = SPI_PROTO_1_1_1;
+	nor->write_proto = SPI_PROTO_1_1_1;
+	nor->reg_proto = SPI_PROTO_1_1_1;
+
 	if (name)
 		info = spi_nor_match_id(name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info)
-		info = spi_nor_read_id(nor);
+		info = spi_nor_read_id(nor, mode);
 	if (IS_ERR_OR_NULL(info))
 		return -ENOENT;
 
@@ -1027,7 +1071,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	if (name && info->id_len) {
 		const struct flash_info *jinfo;
 
-		jinfo = spi_nor_read_id(nor);
+		jinfo = spi_nor_read_id(nor, mode);
 		if (IS_ERR(jinfo)) {
 			return PTR_ERR(jinfo);
 		} else if (jinfo != info) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 672595a381c5..97e52ee475e9 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -57,8 +57,9 @@
 #define SPINOR_OP_BRWR		0x17	/* Bank register write */
 
 /* Used for Micron flashes only. */
-#define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
-#define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
+#define SPINOR_OP_MIO_RDID	0xaf	/* Multiple I/O Read JEDEC ID */
+#define SPINOR_OP_RD_EVCR	0x65    /* Read EVCR register */
+#define SPINOR_OP_WD_EVCR	0x61    /* Write EVCR register */
 
 /* Status Register bits. */
 #define SR_WIP			1	/* Write in progress */
@@ -87,6 +88,16 @@ enum read_mode {
 	SPI_NOR_QUAD,
 };
 
+enum spi_protocol {
+	SPI_PROTO_1_1_1,	/* SPI */
+	SPI_PROTO_1_1_2,	/* Dual Output */
+	SPI_PROTO_1_1_4,	/* Quad Output */
+	SPI_PROTO_1_2_2,	/* Dual IO */
+	SPI_PROTO_1_4_4,	/* Quad IO */
+	SPI_PROTO_2_2_2,	/* Dual Command */
+	SPI_PROTO_4_4_4,	/* Quad Command */
+};
+
 #define SPI_NOR_MAX_CMD_SIZE	8
 enum spi_nor_ops {
 	SPI_NOR_OPS_READ = 0,
@@ -117,6 +128,10 @@ struct mtd_info;
  * @flash_read:		the mode of the read
  * @sst_write_second:	used by the SST write operation
  * @flags:		flag options for the current SPI-NOR (SNOR_F_*)
+ * @erase_proto:	the SPI protocol used by erase operations
+ * @read_proto:		the SPI protocol used by read operations
+ * @write_proto:	the SPI protocol used by write operations
+ * @reg_proto		the SPI protocol used by read_reg/write_reg operations
  * @cmd_buf:		used by the write_reg
  * @prepare:		[OPTIONAL] do some preparations for the
  *			read/write/erase/lock/unlock operations
@@ -143,6 +158,10 @@ struct spi_nor {
 	u8			read_opcode;
 	u8			read_dummy;
 	u8			program_opcode;
+	enum spi_protocol	erase_proto;
+	enum spi_protocol	read_proto;
+	enum spi_protocol	write_proto;
+	enum spi_protocol	reg_proto;
 	enum read_mode		flash_read;
 	bool			sst_write_second;
 	u32			flags;
-- 
1.8.2.2
