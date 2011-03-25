From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 25 Mar 2011 12:52:47 -0300
Subject: [PATCH] ARM: mx53: Print silicon revision on boot
Message-ID: <1301068367-18937-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having the silicon revision to appear on the boot log is a useful information.

MX31, MX35 and MX51 already show the silicon revision on boot. 

Add support for displaying such information for MX53 as well.

Tested on a mx53loco board, where it shows:

CPU identified as i.MX53, silicon rev 2.0

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c     |    1 +
 arch/arm/mach-mx5/cpu.c                 |   23 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 arch/arm/plat-mxc/include/mach/mx53.h   |   13 -------------
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index cc6ad1c..e014289 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1555,6 +1555,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	clk_enable(&iim_clk);
 	mx53_revision();
 	clk_disable(&iim_clk);
+	mx53_display_revision();
 
 	/* Set SDHC parents to be PLL2 */
 	clk_set_parent(&esdhc1_clk, &pll2_sw_clk);
diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index 3b4c307..6ef7856 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -127,6 +127,29 @@ int mx53_revision(void)
 }
 EXPORT_SYMBOL(mx53_revision);
 
+void mx53_display_revision(void)
+{
+	int rev;
+	char *srev;
+	rev = mx53_revision();
+
+	switch (rev) {
+	case IMX_CHIP_REVISION_1_0:
+		srev = IMX_CHIP_REVISION_1_0_STRING;
+		break;
+	case IMX_CHIP_REVISION_2_0:
+		srev = IMX_CHIP_REVISION_2_0_STRING;
+		break;
+	case IMX_CHIP_REVISION_2_1:
+		srev = IMX_CHIP_REVISION_2_1_STRING;
+		break;
+	default:
+		srev = IMX_CHIP_REVISION_UNKNOWN_STRING;
+	}
+	printk(KERN_INFO "CPU identified as i.MX53, silicon rev %s\n", srev);
+}
+EXPORT_SYMBOL(mx53_display_revision);
+
 static int __init post_cpu_init(void)
 {
 	unsigned int reg;
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index a22ebe1..bfa1ffc 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -68,4 +68,5 @@ extern void mxc91231_arch_reset(int, const char *);
 extern void mxc91231_prepare_idle(void);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
+extern int mx53_display_revision(void);
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index ace1786..9d2a1ef 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -337,17 +337,4 @@
 #define MX53_INT_GPIO7_LOW	107
 #define MX53_INT_GPIO7_HIGH	108
 
-/* silicon revisions specific to i.MX53 */
-#define MX53_CHIP_REV_1_0		0x10
-#define MX53_CHIP_REV_1_1		0x11
-#define MX53_CHIP_REV_1_2		0x12
-#define MX53_CHIP_REV_1_3		0x13
-#define MX53_CHIP_REV_2_0		0x20
-#define MX53_CHIP_REV_2_1		0x21
-#define MX53_CHIP_REV_2_2		0x22
-#define MX53_CHIP_REV_2_3		0x23
-#define MX53_CHIP_REV_3_0		0x30
-#define MX53_CHIP_REV_3_1		0x31
-#define MX53_CHIP_REV_3_2		0x32
-
 #endif /* ifndef __MACH_MX53_H__ */
-- 
1.6.0.4
