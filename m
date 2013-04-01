From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue,  2 Apr 2013 00:22:43 +0100
Subject: [PATCH 4/6] arm: orion5x: move ts78xx to use rtc-m48t86 driver side
 memory interface
In-Reply-To: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364858565-17192-5-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove platform_data hooks into rtc-m48t86 and use named resource regions.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |   78 ++++++++--------------------------
 1 file changed, 17 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index ffe3603..613216f 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
-#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/timeriomem-rng.h>
@@ -80,78 +79,35 @@ static struct mv_sata_platform_data ts78xx_sata_data = {
 /*****************************************************************************
  * RTC M48T86 - nicked^Wborrowed from arch/arm/mach-ep93xx/ts72xx.c
  ****************************************************************************/
-#define TS_RTC_CTRL	(TS78XX_FPGA_REGS_VIRT_BASE + 0x808)
-#define TS_RTC_DATA	(TS78XX_FPGA_REGS_VIRT_BASE + 0x80c)
+#define TS_RTC_INDEX	(TS78XX_FPGA_REGS_PHYS_BASE + 0x808)
+#define TS_RTC_DATA	(TS78XX_FPGA_REGS_PHYS_BASE + 0x80c)
 
-static unsigned char ts78xx_ts_rtc_readbyte(unsigned long addr)
-{
-	writeb(addr, TS_RTC_CTRL);
-	return readb(TS_RTC_DATA);
-}
-
-static void ts78xx_ts_rtc_writebyte(unsigned char value, unsigned long addr)
-{
-	writeb(addr, TS_RTC_CTRL);
-	writeb(value, TS_RTC_DATA);
-}
-
-static struct m48t86_ops ts78xx_ts_rtc_ops = {
-	.readbyte	= ts78xx_ts_rtc_readbyte,
-	.writebyte	= ts78xx_ts_rtc_writebyte,
+static struct resource ts78xx_ts_rtc_resource[] = {
+	DEFINE_RES_NAMED(TS_RTC_INDEX, 4, "rtc_index", IORESOURCE_MEM),
+	DEFINE_RES_NAMED(TS_RTC_DATA, 4, "rtc_data", IORESOURCE_MEM),
 };
 
 static struct platform_device ts78xx_ts_rtc_device = {
 	.name		= "rtc-m48t86",
 	.id		= -1,
-	.dev		= {
-		.platform_data	= &ts78xx_ts_rtc_ops,
-	},
-	.num_resources	= 0,
+	.resource	= ts78xx_ts_rtc_resource,
+	.num_resources	= ARRAY_SIZE(ts78xx_ts_rtc_resource),
 };
 
-/*
- * TS uses some of the user storage space on the RTC chip so see if it is
- * present; as it's an optional feature at purchase time and not all boards
- * will have it present
- *
- * I've used the method TS use in their rtc7800.c example for the detection
- *
- * TODO: track down a guinea pig without an RTC to see if we can work out a
- *		better RTC detection routine
- */
 static int ts78xx_ts_rtc_load(void)
 {
 	int rc;
-	unsigned char tmp_rtc0, tmp_rtc1;
-
-	tmp_rtc0 = ts78xx_ts_rtc_readbyte(126);
-	tmp_rtc1 = ts78xx_ts_rtc_readbyte(127);
-
-	ts78xx_ts_rtc_writebyte(0x00, 126);
-	ts78xx_ts_rtc_writebyte(0x55, 127);
-	if (ts78xx_ts_rtc_readbyte(127) == 0x55) {
-		ts78xx_ts_rtc_writebyte(0xaa, 127);
-		if (ts78xx_ts_rtc_readbyte(127) == 0xaa
-				&& ts78xx_ts_rtc_readbyte(126) == 0x00) {
-			ts78xx_ts_rtc_writebyte(tmp_rtc0, 126);
-			ts78xx_ts_rtc_writebyte(tmp_rtc1, 127);
-
-			if (ts78xx_fpga.supports.ts_rtc.init == 0) {
-				rc = platform_device_register(&ts78xx_ts_rtc_device);
-				if (!rc)
-					ts78xx_fpga.supports.ts_rtc.init = 1;
-			} else
-				rc = platform_device_add(&ts78xx_ts_rtc_device);
-
-			if (rc)
-				pr_info("RTC could not be registered: %d\n",
-					rc);
-			return rc;
-		}
-	}
 
-	pr_info("RTC not found\n");
-	return -ENODEV;
+	if (ts78xx_fpga.supports.ts_rtc.init == 0) {
+		rc = platform_device_register(&ts78xx_ts_rtc_device);
+		if (!rc)
+			ts78xx_fpga.supports.ts_rtc.init = 1;
+	} else
+		rc = platform_device_add(&ts78xx_ts_rtc_device);
+
+	if (rc)
+		pr_info("RTC could not be registered: %d\n", rc);
+	return rc;
 };
 
 static void ts78xx_ts_rtc_unload(void)
-- 
1.7.10.4
