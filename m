From: joe@perches.com (Joe Perches)
Date: Sun, 06 Mar 2011 15:54:38 -0800
Subject: [PATCH] ARM: orion5x: replace printk with pr_{err,info,...} in
	ts78xx-setup.c
In-Reply-To: <20110306100431.GG22117@chipmunk>
References: <20110306100431.GG22117@chipmunk>
Message-ID: <1299455678.22572.32.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-03-06 at 10:04 +0000, Alexander Clouter wrote:
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>

Hi Alexander.

It'd be good to add a #define pr_fmt.
That way every pr_<level> gets prefixed by tx78xx-setup.

Something like this:
---
 arch/arm/mach-orion5x/ts78xx-setup.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index c1c1cd0..98176a4 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -8,6 +8,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sysfs.h>
@@ -352,7 +354,7 @@ static int ts78xx_fpga_load_devices(void)
 	if (ts78xx_fpga.supports.ts_rtc.present == 1) {
 		tmp = ts78xx_ts_rtc_load();
 		if (tmp) {
-			printk(KERN_INFO "TS-78xx: RTC not registered\n");
+			pr_info("RTC not registered\n");
 			ts78xx_fpga.supports.ts_rtc.present = 0;
 		}
 		ret |= tmp;
@@ -360,7 +362,7 @@ static int ts78xx_fpga_load_devices(void)
 	if (ts78xx_fpga.supports.ts_nand.present == 1) {
 		tmp = ts78xx_ts_nand_load();
 		if (tmp) {
-			printk(KERN_INFO "TS-78xx: NAND not registered\n");
+			pr_info("NAND not registered\n");
 			ts78xx_fpga.supports.ts_nand.present = 0;
 		}
 		ret |= tmp;
@@ -368,7 +370,7 @@ static int ts78xx_fpga_load_devices(void)
 	if (ts78xx_fpga.supports.ts_rng.present == 1) {
 		tmp = ts78xx_ts_rng_load();
 		if (tmp) {
-			printk(KERN_INFO "TS-78xx: RNG not registered\n");
+			pr_info("RNG not registered\n");
 			ts78xx_fpga.supports.ts_rng.present = 0;
 		}
 		ret |= tmp;
@@ -395,9 +397,9 @@ static int ts78xx_fpga_load(void)
 {
 	ts78xx_fpga.id = readl(TS78XX_FPGA_REGS_VIRT_BASE);
 
-	printk(KERN_INFO "TS-78xx FPGA: magic=0x%.6x, rev=0x%.2x\n",
-			(ts78xx_fpga.id >> 8) & 0xffffff,
-			ts78xx_fpga.id & 0xff);
+	pr_info("FPGA: magic=0x%.6x, rev=0x%.2x\n",
+		(ts78xx_fpga.id >> 8) & 0xffffff,
+		ts78xx_fpga.id & 0xff);
 
 	ts78xx_fpga_supports();
 
@@ -423,10 +425,10 @@ static int ts78xx_fpga_unload(void)
 	 * UrJTAG SVN since r1381 can be used to reprogram the FPGA
 	 */
 	if (ts78xx_fpga.id != fpga_id) {
-		printk(KERN_ERR	"TS-78xx FPGA: magic/rev mismatch\n"
-			"TS-78xx FPGA: was 0x%.6x/%.2x but now 0x%.6x/%.2x\n",
-			(ts78xx_fpga.id >> 8) & 0xffffff, ts78xx_fpga.id & 0xff,
-			(fpga_id >> 8) & 0xffffff, fpga_id & 0xff);
+		pr_err("FPGA: magic/rev mismatch\n"
+		       "FPGA: was 0x%.6x/%.2x but now 0x%.6x/%.2x\n",
+		       (ts78xx_fpga.id >> 8) & 0xffffff, ts78xx_fpga.id & 0xff,
+		       (fpga_id >> 8) & 0xffffff, fpga_id & 0xff);
 		ts78xx_fpga.state = -1;
 		return -EBUSY;
 	}
@@ -454,7 +456,7 @@ static ssize_t ts78xx_fpga_store(struct kobject *kobj,
 	int value, ret;
 
 	if (ts78xx_fpga.state < 0) {
-		printk(KERN_ERR "TS-78xx FPGA: borked, you must powercycle asap\n");
+		pr_err("FPGA borked, you must powercycle asap\n");
 		return -EBUSY;
 	}
 
@@ -463,7 +465,7 @@ static ssize_t ts78xx_fpga_store(struct kobject *kobj,
 	else if (strncmp(buf, "offline", sizeof("offline") - 1) == 0)
 		value = 0;
 	else {
-		printk(KERN_ERR "ts78xx_fpga_store: Invalid value\n");
+		pr_err("%s: Invalid value\n", __func__);
 		return -EINVAL;
 	}
 
@@ -545,7 +547,7 @@ static void __init ts78xx_init(void)
 	ret = ts78xx_fpga_load();
 	ret = sysfs_create_file(power_kobj, &ts78xx_fpga_attr.attr);
 	if (ret)
-		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
+		pr_err("sysfs_create_file failed: %d\n", ret);
 }
 
 MACHINE_START(TS78XX, "Technologic Systems TS-78xx SBC")
