From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 26 Aug 2011 13:35:22 +0800
Subject: [[PATCH v3 5/6] ARM: mx35: use generic function for displaying
	silicon revision
In-Reply-To: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
References: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1314336923-25162-6-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update to use generic function for displaying silicon revision

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clock-imx35.c       |    3 ++-
 arch/arm/mach-imx/cpu-imx35.c         |   30 ++++++++++++++----------------
 arch/arm/plat-mxc/include/mach/mx3x.h |    9 +--------
 3 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 88b62a0..abf30d4 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -537,7 +537,8 @@ int __init mx35_clocks_init()
 	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
 
 	clk_enable(&iim_clk);
-	mx35_read_cpu_rev();
+	imx_print_silicon_rev("i.MX35", mx35_revision());
+	clk_disable(&iim_clk);
 
 #ifdef CONFIG_MXC_USE_EPIT
 	epit_timer_init(&epit1_clk,
diff --git a/arch/arm/mach-imx/cpu-imx35.c b/arch/arm/mach-imx/cpu-imx35.c
index 6637cd8..846e46e 100644
--- a/arch/arm/mach-imx/cpu-imx35.c
+++ b/arch/arm/mach-imx/cpu-imx35.c
@@ -13,32 +13,30 @@
 #include <mach/hardware.h>
 #include <mach/iim.h>
 
-unsigned int mx35_cpu_rev;
-EXPORT_SYMBOL(mx35_cpu_rev);
+static int mx35_cpu_rev = -1;
 
-void __init mx35_read_cpu_rev(void)
+static int mx35_read_cpu_rev(void)
 {
 	u32 rev;
-	char *srev;
 
 	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
 	switch (rev) {
 	case 0x00:
-		mx35_cpu_rev = IMX_CHIP_REVISION_1_0;
-		srev = "1.0";
-		break;
+		return IMX_CHIP_REVISION_1_0;
 	case 0x10:
-		mx35_cpu_rev = IMX_CHIP_REVISION_2_0;
-		srev = "2.0";
-		break;
+		return IMX_CHIP_REVISION_2_0;
 	case 0x11:
-		mx35_cpu_rev = IMX_CHIP_REVISION_2_1;
-		srev = "2.1";
-		break;
+		return IMX_CHIP_REVISION_2_1;
 	default:
-		mx35_cpu_rev = IMX_CHIP_REVISION_UNKNOWN;
-		srev = "unknown";
+		return IMX_CHIP_REVISION_UNKNOWN;
 	}
+}
+
+int mx35_revision(void)
+{
+	if (mx35_cpu_rev == -1)
+		mx35_cpu_rev = mx35_read_cpu_rev();
 
-	printk(KERN_INFO "CPU identified as i.MX35, silicon rev %s\n", srev);
+	return mx35_cpu_rev;
 }
+EXPORT_SYMBOL(mx35_revision);
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index e1850f4..30dbf42 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -187,14 +187,7 @@
 /* Mandatory defines used globally */
 
 #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
-extern unsigned int mx35_cpu_rev;
-extern void mx35_read_cpu_rev(void);
-
-static inline int mx35_revision(void)
-{
-	return mx35_cpu_rev;
-}
-
+extern int mx35_revision(void);
 extern int mx31_revision(void);
 #endif
 
-- 
1.7.4.1
