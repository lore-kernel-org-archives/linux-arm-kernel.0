From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 8 Jan 2011 11:55:25 +0000
Subject: [PATCHv2] [ARM] orion5x: accelerate NAND on the TS-78xx
Message-ID: <20110108115525.GN12386@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND supports 32bit reads and writes so lets stop shunting 8bit
chunks across the bus.

Doing a dumb 'dd' benchmark, this increases performance roughly like so:
 * read: 1.3MB/s to 3.4MB/s
 * write: 614kB/s to 882kB/s

Changelog:
 v2: used approach suggested by Russell King instead
	<20110105003316.GJ24935@n2100.arm.linux.org.uk>
 v1: initial release <20110104235158.GQ12386@chipmunk>

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |   56 ++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index c1c1cd0..89682e1 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -191,6 +191,60 @@ static int ts78xx_ts_nand_dev_ready(struct mtd_info *mtd)
 	return readb(TS_NAND_CTRL) & 0x20;
 }
 
+static void ts78xx_ts_nand_write_buf(struct mtd_info *mtd,
+			const uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	void __iomem *io_base = chip->IO_ADDR_W;
+	unsigned long off = ((unsigned long)buf & 3);
+	int sz;
+
+	if (off) {
+		sz = min(4 - off, len);
+		writesb(io_base, buf, sz);
+		buf += sz;
+		len -= sz;
+	}
+
+	sz = len >> 2;
+	if (sz) {
+		u32 *buf32 = (u32 *)buf;
+		writesl(io_base, buf32, sz);
+		buf += sz << 2;
+		len -= sz << 2;
+	}
+
+	if (len)
+		writesb(io_base, buf, len);
+}
+
+static void ts78xx_ts_nand_read_buf(struct mtd_info *mtd,
+			uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	void __iomem *io_base = chip->IO_ADDR_R;
+	unsigned long off = ((unsigned long)buf & 3);
+	int sz;
+
+	if (off) {
+		sz = min(4 - off, len);
+		readsb(io_base, buf, sz);
+		buf += sz;
+		len -= sz;
+	}
+
+	sz = len >> 2;
+	if (sz) {
+		u32 *buf32 = (u32 *)buf;
+		readsl(io_base, buf32, sz);
+		buf += sz << 2;
+		len -= sz << 2;
+	}
+
+	if (len)
+		readsb(io_base, buf, len);
+}
+
 const char *ts_nand_part_probes[] = { "cmdlinepart", NULL };
 
 static struct mtd_partition ts78xx_ts_nand_parts[] = {
@@ -233,6 +287,8 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
 		 */
 		.cmd_ctrl		= ts78xx_ts_nand_cmd_ctrl,
 		.dev_ready		= ts78xx_ts_nand_dev_ready,
+		.write_buf		= ts78xx_ts_nand_write_buf,
+		.read_buf		= ts78xx_ts_nand_read_buf,
 	},
 };
 
-- 
1.7.2.3
