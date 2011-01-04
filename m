From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 4 Jan 2011 23:51:59 +0000
Subject: [PATCH] [ARM] orion5x: accelerate NAND on the TS-78xx
Message-ID: <20110104235158.GQ12386@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND supports 32bit reads and writes so lets stop shunting 8bit
chunks across the bus.

Doing a dumb 'dd' benchmark, this increases performance roughly like so:
 * read: 1.3MB/s to 3.4MB/s
 * write: 614kB/s to 882kB/s

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |   42 ++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 9a5d1ef..bcc21fe 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -191,6 +191,46 @@ static int ts78xx_ts_nand_dev_ready(struct mtd_info *mtd)
 	return readb(TS_NAND_CTRL) & 0x20;
 }
 
+static void ts78xx_ts_nand_write_buf(struct mtd_info *mtd,
+			const uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	void __iomem *io_base = chip->IO_ADDR_W;
+	uint32_t *buf32;
+	int i = 0;
+
+	while (len && (unsigned int)buf & 3) {
+		writeb(*buf++, io_base);
+		len--;
+	}
+	buf32 = (uint32_t *)buf;
+	while (i < len/4)
+		writel(buf32[i++], io_base);
+	i *= 4;
+	while (i < len)
+		writeb(buf[i++], io_base);
+}
+
+static void ts78xx_ts_nand_read_buf(struct mtd_info *mtd,
+			uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	void __iomem *io_base = chip->IO_ADDR_R;
+	uint32_t *buf32;
+	int i = 0;
+
+	while (len && (unsigned int)buf & 3) {
+		*buf++ = readb(io_base);
+		len--;
+	}
+	buf32 = (uint32_t *)buf;
+	while (i < len/4)
+		buf32[i++] = readl(io_base);
+	i *= 4;
+	while (i < len)
+		buf[i++] = readb(io_base);
+}
+
 const char *ts_nand_part_probes[] = { "cmdlinepart", NULL };
 
 static struct mtd_partition ts78xx_ts_nand_parts[] = {
@@ -233,6 +273,8 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
 		 */
 		.cmd_ctrl		= ts78xx_ts_nand_cmd_ctrl,
 		.dev_ready		= ts78xx_ts_nand_dev_ready,
+		.write_buf		= ts78xx_ts_nand_write_buf,
+		.read_buf		= ts78xx_ts_nand_read_buf,
 	},
 };
 
-- 
1.7.2.3
