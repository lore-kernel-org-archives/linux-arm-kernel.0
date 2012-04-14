From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 14 Apr 2012 19:00:54 +0100
Subject: [PATCH 3/3] ARM: orion5x: ts78xx debugging changes
In-Reply-To: <1334426454-3206-1-git-send-email-alex@digriz.org.uk>
References: <1334426454-3206-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1334426454-3206-4-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moved to using a redefined pr_fmt to spare having to manually
prefix every message line with 'ts78xx'.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 4ae822b..f6d1232 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -26,6 +26,9 @@
 #include "mpp.h"
 #include "ts78xx-fpga.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 /*****************************************************************************
  * TS-78xx Info
  ****************************************************************************/
@@ -141,10 +144,13 @@ static int ts78xx_ts_rtc_load(void)
 			} else
 				rc = platform_device_add(&ts78xx_ts_rtc_device);
 
+			if (rc)
+				pr_info("RTC could not be registered: %d\n", rc);
 			return rc;
 		}
 	}
 
+	pr_info("RTC not found\n");
 	return -ENODEV;
 };
 
@@ -319,6 +325,8 @@ static int ts78xx_ts_nand_load(void)
 	} else
 		rc = platform_device_add(&ts78xx_ts_nand_device);
 
+	if (rc)
+		pr_info("NAND could not be registered: %d\n", rc);
 	return rc;
 };
 
@@ -363,6 +371,8 @@ static int ts78xx_ts_rng_load(void)
 	} else
 		rc = platform_device_add(&ts78xx_ts_rng_device);
 
+	if (rc)
+		pr_info("RNG could not be registered: %d\n", rc);
 	return rc;
 };
 
@@ -402,7 +412,7 @@ static void ts78xx_fpga_supports(void)
 		/* enable devices if magic matches */
 		switch ((ts78xx_fpga.id >> 8) & 0xffffff) {
 		case TS7800_FPGA_MAGIC:
-			pr_warning("TS-7800 FPGA: unrecognized revision 0x%.2x\n",
+			pr_warning("unrecognised FPGA revision 0x%.2x\n",
 					ts78xx_fpga.id & 0xff);
 			ts78xx_fpga.supports.ts_rtc.present = 1;
 			ts78xx_fpga.supports.ts_nand.present = 1;
@@ -422,26 +432,20 @@ static int ts78xx_fpga_load_devices(void)
 
 	if (ts78xx_fpga.supports.ts_rtc.present == 1) {
 		tmp = ts78xx_ts_rtc_load();
-		if (tmp) {
-			pr_info("TS-78xx: RTC not registered\n");
+		if (tmp)
 			ts78xx_fpga.supports.ts_rtc.present = 0;
-		}
 		ret |= tmp;
 	}
 	if (ts78xx_fpga.supports.ts_nand.present == 1) {
 		tmp = ts78xx_ts_nand_load();
-		if (tmp) {
-			pr_info("TS-78xx: NAND not registered\n");
+		if (tmp)
 			ts78xx_fpga.supports.ts_nand.present = 0;
-		}
 		ret |= tmp;
 	}
 	if (ts78xx_fpga.supports.ts_rng.present == 1) {
 		tmp = ts78xx_ts_rng_load();
-		if (tmp) {
-			pr_info("TS-78xx: RNG not registered\n");
+		if (tmp)
 			ts78xx_fpga.supports.ts_rng.present = 0;
-		}
 		ret |= tmp;
 	}
 
@@ -466,7 +470,7 @@ static int ts78xx_fpga_load(void)
 {
 	ts78xx_fpga.id = readl(TS78XX_FPGA_REGS_VIRT_BASE);
 
-	pr_info("TS-78xx FPGA: magic=0x%.6x, rev=0x%.2x\n",
+	pr_info("FPGA magic=0x%.6x, rev=0x%.2x\n",
 			(ts78xx_fpga.id >> 8) & 0xffffff,
 			ts78xx_fpga.id & 0xff);
 
@@ -494,7 +498,7 @@ static int ts78xx_fpga_unload(void)
 	 * UrJTAG SVN since r1381 can be used to reprogram the FPGA
 	 */
 	if (ts78xx_fpga.id != fpga_id) {
-		pr_err("TS-78xx FPGA: magic/rev mismatch\n"
+		pr_err("FPGA magic/rev mismatch\n"
 			"TS-78xx FPGA: was 0x%.6x/%.2x but now 0x%.6x/%.2x\n",
 			(ts78xx_fpga.id >> 8) & 0xffffff, ts78xx_fpga.id & 0xff,
 			(fpga_id >> 8) & 0xffffff, fpga_id & 0xff);
@@ -525,7 +529,7 @@ static ssize_t ts78xx_fpga_store(struct kobject *kobj,
 	int value, ret;
 
 	if (ts78xx_fpga.state < 0) {
-		pr_err("TS-78xx FPGA: borked, you must powercycle asap\n");
+		pr_err("FPGA borked, you must powercycle ASAP\n");
 		return -EBUSY;
 	}
 
@@ -533,10 +537,8 @@ static ssize_t ts78xx_fpga_store(struct kobject *kobj,
 		value = 1;
 	else if (strncmp(buf, "offline", sizeof("offline") - 1) == 0)
 		value = 0;
-	else {
-		pr_err("ts78xx_fpga_store: Invalid value\n");
+	else
 		return -EINVAL;
-	}
 
 	if (ts78xx_fpga.state == value)
 		return n;
-- 
1.7.10
