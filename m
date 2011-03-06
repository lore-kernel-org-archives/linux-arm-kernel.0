From: alex@digriz.org.uk (Alexander Clouter)
Date: Sun, 6 Mar 2011 10:04:31 +0000
Subject: [PATCH] ARM: orion5x: replace printk with pr_{err,info,...} in
	ts78xx-setup.c
Message-ID: <20110306100431.GG22117@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 8554707..edb1dd2 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -402,7 +402,7 @@ static void ts78xx_fpga_supports(void)
 		/* enable devices if magic matches */
 		switch ((ts78xx_fpga.id >> 8) & 0xffffff) {
 		case TS7800_FPGA_MAGIC:
-			printk(KERN_WARNING "TS-7800 FPGA: unrecognized revision 0x%.2x\n",
+			pr_warning("TS-7800 FPGA: unrecognized revision 0x%.2x\n",
 					ts78xx_fpga.id & 0xff);
 			ts78xx_fpga.supports.ts_rtc.present = 1;
 			ts78xx_fpga.supports.ts_nand.present = 1;
@@ -423,7 +423,7 @@ static int ts78xx_fpga_load_devices(void)
 	if (ts78xx_fpga.supports.ts_rtc.present == 1) {
 		tmp = ts78xx_ts_rtc_load();
 		if (tmp) {
-			printk(KERN_INFO "TS-78xx: RTC not registered\n");
+			pr_info("TS-78xx: RTC not registered\n");
 			ts78xx_fpga.supports.ts_rtc.present = 0;
 		}
 		ret |= tmp;
@@ -431,7 +431,7 @@ static int ts78xx_fpga_load_devices(void)
 	if (ts78xx_fpga.supports.ts_nand.present == 1) {
 		tmp = ts78xx_ts_nand_load();
 		if (tmp) {
-			printk(KERN_INFO "TS-78xx: NAND not registered\n");
+			pr_info("TS-78xx: NAND not registered\n");
 			ts78xx_fpga.supports.ts_nand.present = 0;
 		}
 		ret |= tmp;
@@ -439,7 +439,7 @@ static int ts78xx_fpga_load_devices(void)
 	if (ts78xx_fpga.supports.ts_rng.present == 1) {
 		tmp = ts78xx_ts_rng_load();
 		if (tmp) {
-			printk(KERN_INFO "TS-78xx: RNG not registered\n");
+			pr_info("TS-78xx: RNG not registered\n");
 			ts78xx_fpga.supports.ts_rng.present = 0;
 		}
 		ret |= tmp;
@@ -466,7 +466,7 @@ static int ts78xx_fpga_load(void)
 {
 	ts78xx_fpga.id = readl(TS78XX_FPGA_REGS_VIRT_BASE);
 
-	printk(KERN_INFO "TS-78xx FPGA: magic=0x%.6x, rev=0x%.2x\n",
+	pr_info("TS-78xx FPGA: magic=0x%.6x, rev=0x%.2x\n",
 			(ts78xx_fpga.id >> 8) & 0xffffff,
 			ts78xx_fpga.id & 0xff);
 
@@ -494,7 +494,7 @@ static int ts78xx_fpga_unload(void)
 	 * UrJTAG SVN since r1381 can be used to reprogram the FPGA
 	 */
 	if (ts78xx_fpga.id != fpga_id) {
-		printk(KERN_ERR	"TS-78xx FPGA: magic/rev mismatch\n"
+		pr_err("TS-78xx FPGA: magic/rev mismatch\n"
 			"TS-78xx FPGA: was 0x%.6x/%.2x but now 0x%.6x/%.2x\n",
 			(ts78xx_fpga.id >> 8) & 0xffffff, ts78xx_fpga.id & 0xff,
 			(fpga_id >> 8) & 0xffffff, fpga_id & 0xff);
@@ -525,7 +525,7 @@ static ssize_t ts78xx_fpga_store(struct kobject *kobj,
 	int value, ret;
 
 	if (ts78xx_fpga.state < 0) {
-		printk(KERN_ERR "TS-78xx FPGA: borked, you must powercycle asap\n");
+		pr_err("TS-78xx FPGA: borked, you must powercycle asap\n");
 		return -EBUSY;
 	}
 
@@ -534,7 +534,7 @@ static ssize_t ts78xx_fpga_store(struct kobject *kobj,
 	else if (strncmp(buf, "offline", sizeof("offline") - 1) == 0)
 		value = 0;
 	else {
-		printk(KERN_ERR "ts78xx_fpga_store: Invalid value\n");
+		pr_err("ts78xx_fpga_store: Invalid value\n");
 		return -EINVAL;
 	}
 
@@ -616,7 +616,7 @@ static void __init ts78xx_init(void)
 	ret = ts78xx_fpga_load();
 	ret = sysfs_create_file(power_kobj, &ts78xx_fpga_attr.attr);
 	if (ret)
-		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
+		pr_err("sysfs_create_file failed: %d\n", ret);
 }
 
 MACHINE_START(TS78XX, "Technologic Systems TS-78xx SBC")
-- 
1.7.4.1
