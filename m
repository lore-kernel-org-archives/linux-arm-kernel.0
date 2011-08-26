From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 26 Aug 2011 13:35:23 +0800
Subject: [[PATCH v3 6/6] ARM: mx5: use generic function for displaying silicon
	revision
In-Reply-To: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
References: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1314336923-25162-7-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update to use generic function for displaying silicon revision

Tested on my mx53 loco board:
CPU identified as i.MX53, silicon rev 2.0

Test on my mx51 babbage board:
CPU identified as i.MX51, silicon rev 3.0

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
v2: print mx51 To3 correctly
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +--
 arch/arm/mach-mx5/cpu.c             |   74 ++++++++---------------------------
 2 files changed, 19 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index f7bf996..0e23e1d 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1548,9 +1548,8 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 	clk_enable(&main_bus_clk);
 
 	clk_enable(&iim_clk);
-	mx51_revision();
+	imx_print_silicon_rev("i.MX51", mx51_revision());
 	clk_disable(&iim_clk);
-	mx51_display_revision();
 
 	/* move usb_phy_clk to 24MHz */
 	clk_set_parent(&usb_phy1_clk, &osc_clk);
@@ -1592,9 +1591,8 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	clk_enable(&main_bus_clk);
 
 	clk_enable(&iim_clk);
-	mx53_revision();
+	imx_print_silicon_rev("i.MX53", mx53_revision());
 	clk_disable(&iim_clk);
-	mx53_display_revision();
 
 	/* Set SDHC parents to be PLL2 */
 	clk_set_parent(&esdhc1_clk, &pll2_sw_clk);
diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index 86f87da..5c53282 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -18,7 +18,7 @@
 #include <mach/hardware.h>
 #include <asm/io.h>
 
-static int cpu_silicon_rev = -1;
+static int mx5_cpu_rev = -1;
 
 #define IIM_SREV 0x24
 #define MX50_HW_ADADIG_DIGPROG	0xB0
@@ -28,11 +28,14 @@ static int get_mx51_srev(void)
 	void __iomem *iim_base = MX51_IO_ADDRESS(MX51_IIM_BASE_ADDR);
 	u32 rev = readl(iim_base + IIM_SREV) & 0xff;
 
-	if (rev == 0x0)
+	switch (rev) {
+	case 0x0:
 		return IMX_CHIP_REVISION_2_0;
-	else if (rev == 0x10)
+	case 0x10:
 		return IMX_CHIP_REVISION_3_0;
-	return 0;
+	default:
+		return IMX_CHIP_REVISION_UNKNOWN;
+	}
 }
 
 /*
@@ -45,33 +48,13 @@ int mx51_revision(void)
 	if (!cpu_is_mx51())
 		return -EINVAL;
 
-	if (cpu_silicon_rev == -1)
-		cpu_silicon_rev = get_mx51_srev();
+	if (mx5_cpu_rev == -1)
+		mx5_cpu_rev = get_mx51_srev();
 
-	return cpu_silicon_rev;
+	return mx5_cpu_rev;
 }
 EXPORT_SYMBOL(mx51_revision);
 
-void mx51_display_revision(void)
-{
-	int rev;
-	char *srev;
-	rev = mx51_revision();
-
-	switch (rev) {
-	case IMX_CHIP_REVISION_2_0:
-		srev = IMX_CHIP_REVISION_2_0_STRING;
-		break;
-	case IMX_CHIP_REVISION_3_0:
-		srev = IMX_CHIP_REVISION_3_0_STRING;
-		break;
-	default:
-		srev = IMX_CHIP_REVISION_UNKNOWN_STRING;
-	}
-	printk(KERN_INFO "CPU identified as i.MX51, silicon rev %s\n", srev);
-}
-EXPORT_SYMBOL(mx51_display_revision);
-
 #ifdef CONFIG_NEON
 
 /*
@@ -121,10 +104,10 @@ int mx53_revision(void)
 	if (!cpu_is_mx53())
 		return -EINVAL;
 
-	if (cpu_silicon_rev == -1)
-		cpu_silicon_rev = get_mx53_srev();
+	if (mx5_cpu_rev == -1)
+		mx5_cpu_rev = get_mx53_srev();
 
-	return cpu_silicon_rev;
+	return mx5_cpu_rev;
 }
 EXPORT_SYMBOL(mx53_revision);
 
@@ -134,7 +117,7 @@ static int get_mx50_srev(void)
 	u32 rev;
 
 	if (!anatop) {
-		cpu_silicon_rev = -EINVAL;
+		mx5_cpu_rev = -EINVAL;
 		return 0;
 	}
 
@@ -159,36 +142,13 @@ int mx50_revision(void)
 	if (!cpu_is_mx50())
 		return -EINVAL;
 
-	if (cpu_silicon_rev == -1)
-		cpu_silicon_rev = get_mx50_srev();
+	if (mx5_cpu_rev == -1)
+		mx5_cpu_rev = get_mx50_srev();
 
-	return cpu_silicon_rev;
+	return mx5_cpu_rev;
 }
 EXPORT_SYMBOL(mx50_revision);
 
-void mx53_display_revision(void)
-{
-	int rev;
-	char *srev;
-	rev = mx53_revision();
-
-	switch (rev) {
-	case IMX_CHIP_REVISION_1_0:
-		srev = IMX_CHIP_REVISION_1_0_STRING;
-		break;
-	case IMX_CHIP_REVISION_2_0:
-		srev = IMX_CHIP_REVISION_2_0_STRING;
-		break;
-	case IMX_CHIP_REVISION_2_1:
-		srev = IMX_CHIP_REVISION_2_1_STRING;
-		break;
-	default:
-		srev = IMX_CHIP_REVISION_UNKNOWN_STRING;
-	}
-	printk(KERN_INFO "CPU identified as i.MX53, silicon rev %s\n", srev);
-}
-EXPORT_SYMBOL(mx53_display_revision);
-
 static int __init post_cpu_init(void)
 {
 	unsigned int reg;
-- 
1.7.4.1
