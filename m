From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Aug 2011 22:25:50 +0900
Subject: [PATCH 3/5] ARM: EXYNOS4: Add support PM for EXYNOS4212
In-Reply-To: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
References: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1314192352-14911-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

This patch moves regarding clock stuff of PM into clock
file to support PM on EXYNOS4210 and EXYNOS4212 with one
single kernel image. Because some clock registers are
different on each SoCs.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/clock-exynos4210.c        |   38 ++++++++++
 arch/arm/mach-exynos4/clock-exynos4212.c        |   34 +++++++++
 arch/arm/mach-exynos4/clock.c                   |   89 +++++++++++++++++++++++
 arch/arm/mach-exynos4/include/mach/regs-clock.h |    4 +
 arch/arm/mach-exynos4/pm.c                      |   79 ++------------------
 5 files changed, 172 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock-exynos4210.c b/arch/arm/mach-exynos4/clock-exynos4210.c
index fe74b91..a4b00b7 100644
--- a/arch/arm/mach-exynos4/clock-exynos4210.c
+++ b/arch/arm/mach-exynos4/clock-exynos4210.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/syscore_ops.h>
 
 #include <plat/cpu-freq.h>
 #include <plat/clock.h>
@@ -23,12 +24,24 @@
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/exynos4.h>
+#include <plat/pm.h>
 
 #include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/exynos4-clock.h>
 
+static struct sleep_save exynos4210_clock_save[] = {
+	SAVE_ITEM(S5P_CLKSRC_IMAGE),
+	SAVE_ITEM(S5P_CLKSRC_LCD1),
+	SAVE_ITEM(S5P_CLKDIV_IMAGE),
+	SAVE_ITEM(S5P_CLKDIV_LCD1),
+	SAVE_ITEM(S5P_CLKSRC_MASK_LCD1),
+	SAVE_ITEM(S5P_CLKGATE_IP_IMAGE_4210),
+	SAVE_ITEM(S5P_CLKGATE_IP_LCD1),
+	SAVE_ITEM(S5P_CLKGATE_IP_PERIR_4210),
+};
+
 static struct clksrc_clk *sysclks[] = {
 	/* nothing here yet */
 };
@@ -83,6 +96,29 @@ static struct clk init_clocks_off[] = {
 	},
 };
 
+#ifdef CONFIG_PM
+static int exynos4210_clock_suspend(void)
+{
+	s3c_pm_do_save(exynos4210_clock_save, ARRAY_SIZE(exynos4210_clock_save));
+
+	return 0;
+}
+
+static void exynos4210_clock_resume(void)
+{
+	s3c_pm_do_restore_core(exynos4210_clock_save, ARRAY_SIZE(exynos4210_clock_save));
+}
+
+#else
+#define exynos4210_clock_suspend NULL
+#define exynos4210_clock_resume NULL
+#endif
+
+struct syscore_ops exynos4210_clock_syscore_ops = {
+	.suspend	= exynos4210_clock_suspend,
+	.resume		= exynos4210_clock_resume,
+};
+
 void __init exynos4210_register_clocks(void)
 {
 	int ptr;
@@ -98,4 +134,6 @@ void __init exynos4210_register_clocks(void)
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+
+	register_syscore_ops(&exynos4210_clock_syscore_ops);
 }
diff --git a/arch/arm/mach-exynos4/clock-exynos4212.c b/arch/arm/mach-exynos4/clock-exynos4212.c
index 5a47a3f..4638a21 100644
--- a/arch/arm/mach-exynos4/clock-exynos4212.c
+++ b/arch/arm/mach-exynos4/clock-exynos4212.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/syscore_ops.h>
 
 #include <plat/cpu-freq.h>
 #include <plat/clock.h>
@@ -23,12 +24,20 @@
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/exynos4.h>
+#include <plat/pm.h>
 
 #include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/exynos4-clock.h>
 
+static struct sleep_save exynos4212_clock_save[] = {
+	SAVE_ITEM(S5P_CLKSRC_IMAGE),
+	SAVE_ITEM(S5P_CLKDIV_IMAGE),
+	SAVE_ITEM(S5P_CLKGATE_IP_IMAGE_4212),
+	SAVE_ITEM(S5P_CLKGATE_IP_PERIR_4212),
+};
+
 static struct clk *clk_src_mpll_user_list[] = {
 	[0] = &clk_fin_mpll,
 	[1] = &clk_mout_mpll.clk,
@@ -59,6 +68,29 @@ static struct clk init_clocks_off[] = {
 	/* nothing here yet */
 };
 
+#ifdef CONFIG_PM
+static int exynos4212_clock_suspend(void)
+{
+	s3c_pm_do_save(exynos4212_clock_save, ARRAY_SIZE(exynos4212_clock_save));
+
+	return 0;
+}
+
+static void exynos4212_clock_resume(void)
+{
+	s3c_pm_do_restore_core(exynos4212_clock_save, ARRAY_SIZE(exynos4212_clock_save));
+}
+
+#else
+#define exynos4212_clock_suspend NULL
+#define exynos4212_clock_resume NULL
+#endif
+
+struct syscore_ops exynos4212_clock_syscore_ops = {
+	.suspend	= exynos4212_clock_suspend,
+	.resume		= exynos4212_clock_resume,
+};
+
 void __init exynos4212_register_clocks(void)
 {
 	int ptr;
@@ -81,4 +113,6 @@ void __init exynos4212_register_clocks(void)
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+
+	register_syscore_ops(&exynos4212_clock_syscore_ops);
 }
diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index eb99467..99c2a1f 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/syscore_ops.h>
 
 #include <plat/cpu-freq.h>
 #include <plat/clock.h>
@@ -21,12 +22,77 @@
 #include <plat/s5p-clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/exynos4.h>
+#include <plat/pm.h>
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/sysmmu.h>
 #include <mach/exynos4-clock.h>
 
+static struct sleep_save exynos4_clock_save[] = {
+	SAVE_ITEM(S5P_CLKDIV_LEFTBUS),
+	SAVE_ITEM(S5P_CLKGATE_IP_LEFTBUS),
+	SAVE_ITEM(S5P_CLKDIV_RIGHTBUS),
+	SAVE_ITEM(S5P_CLKGATE_IP_RIGHTBUS),
+	SAVE_ITEM(S5P_CLKSRC_TOP0),
+	SAVE_ITEM(S5P_CLKSRC_TOP1),
+	SAVE_ITEM(S5P_CLKSRC_CAM),
+	SAVE_ITEM(S5P_CLKSRC_TV),
+	SAVE_ITEM(S5P_CLKSRC_MFC),
+	SAVE_ITEM(S5P_CLKSRC_G3D),
+	SAVE_ITEM(S5P_CLKSRC_LCD0),
+	SAVE_ITEM(S5P_CLKSRC_MAUDIO),
+	SAVE_ITEM(S5P_CLKSRC_FSYS),
+	SAVE_ITEM(S5P_CLKSRC_PERIL0),
+	SAVE_ITEM(S5P_CLKSRC_PERIL1),
+	SAVE_ITEM(S5P_CLKDIV_CAM),
+	SAVE_ITEM(S5P_CLKDIV_TV),
+	SAVE_ITEM(S5P_CLKDIV_MFC),
+	SAVE_ITEM(S5P_CLKDIV_G3D),
+	SAVE_ITEM(S5P_CLKDIV_LCD0),
+	SAVE_ITEM(S5P_CLKDIV_MAUDIO),
+	SAVE_ITEM(S5P_CLKDIV_FSYS0),
+	SAVE_ITEM(S5P_CLKDIV_FSYS1),
+	SAVE_ITEM(S5P_CLKDIV_FSYS2),
+	SAVE_ITEM(S5P_CLKDIV_FSYS3),
+	SAVE_ITEM(S5P_CLKDIV_PERIL0),
+	SAVE_ITEM(S5P_CLKDIV_PERIL1),
+	SAVE_ITEM(S5P_CLKDIV_PERIL2),
+	SAVE_ITEM(S5P_CLKDIV_PERIL3),
+	SAVE_ITEM(S5P_CLKDIV_PERIL4),
+	SAVE_ITEM(S5P_CLKDIV_PERIL5),
+	SAVE_ITEM(S5P_CLKDIV_TOP),
+	SAVE_ITEM(S5P_CLKSRC_MASK_TOP),
+	SAVE_ITEM(S5P_CLKSRC_MASK_CAM),
+	SAVE_ITEM(S5P_CLKSRC_MASK_TV),
+	SAVE_ITEM(S5P_CLKSRC_MASK_LCD0),
+	SAVE_ITEM(S5P_CLKSRC_MASK_MAUDIO),
+	SAVE_ITEM(S5P_CLKSRC_MASK_FSYS),
+	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL0),
+	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL1),
+	SAVE_ITEM(S5P_CLKDIV2_RATIO),
+	SAVE_ITEM(S5P_CLKGATE_SCLKCAM),
+	SAVE_ITEM(S5P_CLKGATE_IP_CAM),
+	SAVE_ITEM(S5P_CLKGATE_IP_TV),
+	SAVE_ITEM(S5P_CLKGATE_IP_MFC),
+	SAVE_ITEM(S5P_CLKGATE_IP_G3D),
+	SAVE_ITEM(S5P_CLKGATE_IP_LCD0),
+	SAVE_ITEM(S5P_CLKGATE_IP_FSYS),
+	SAVE_ITEM(S5P_CLKGATE_IP_GPS),
+	SAVE_ITEM(S5P_CLKGATE_IP_PERIL),
+	SAVE_ITEM(S5P_CLKGATE_BLOCK),
+	SAVE_ITEM(S5P_CLKSRC_MASK_DMC),
+	SAVE_ITEM(S5P_CLKSRC_DMC),
+	SAVE_ITEM(S5P_CLKDIV_DMC0),
+	SAVE_ITEM(S5P_CLKDIV_DMC1),
+	SAVE_ITEM(S5P_CLKGATE_IP_DMC),
+	SAVE_ITEM(S5P_CLKSRC_CPU),
+	SAVE_ITEM(S5P_CLKDIV_CPU),
+	SAVE_ITEM(S5P_CLKDIV_CPU + 0x4),
+	SAVE_ITEM(S5P_CLKGATE_SCLKCPU),
+	SAVE_ITEM(S5P_CLKGATE_IP_CPU),
+};
+
 struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
 	.rate		= 27000000,
@@ -1180,6 +1246,28 @@ static struct clk *clks[] __initdata = {
 	/* Nothing here yet */
 };
 
+#ifdef CONFIG_PM
+static int exynos4_clock_suspend(void)
+{
+	s3c_pm_do_save(exynos4_clock_save, ARRAY_SIZE(exynos4_clock_save));
+	return 0;
+}
+
+static void exynos4_clock_resume(void)
+{
+	s3c_pm_do_restore_core(exynos4_clock_save, ARRAY_SIZE(exynos4_clock_save));
+}
+
+#else
+#define exynos4_clock_suspend NULL
+#define exynos4_clock_resume NULL
+#endif
+
+struct syscore_ops exynos4_clock_syscore_ops = {
+	.suspend	= exynos4_clock_suspend,
+	.resume		= exynos4_clock_resume,
+};
+
 void __init exynos4_register_clocks(void)
 {
 	int ptr;
@@ -1195,5 +1283,6 @@ void __init exynos4_register_clocks(void)
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	register_syscore_ops(&exynos4_clock_syscore_ops);
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
index e75d0f8..6c37ebe 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
@@ -86,6 +86,8 @@
 #define S5P_CLKGATE_IP_IMAGE		(soc_is_exynos4210() ? \
 					S5P_CLKREG(0x0C930) : \
 					S5P_CLKREG(0x04930))
+#define S5P_CLKGATE_IP_IMAGE_4210	S5P_CLKREG(0x0C930)
+#define S5P_CLKGATE_IP_IMAGE_4212	S5P_CLKREG(0x04930)
 #define S5P_CLKGATE_IP_LCD0		S5P_CLKREG(0x0C934)
 #define S5P_CLKGATE_IP_FSYS		S5P_CLKREG(0x0C940)
 #define S5P_CLKGATE_IP_GPS		S5P_CLKREG(0x0C94C)
@@ -93,6 +95,8 @@
 #define S5P_CLKGATE_IP_PERIR		(soc_is_exynos4210() ? \
 					S5P_CLKREG(0x0C960) : \
 					S5P_CLKREG(0x08960))
+#define S5P_CLKGATE_IP_PERIR_4210	S5P_CLKREG(0x0C960)
+#define S5P_CLKGATE_IP_PERIR_4212	S5P_CLKREG(0x08960)
 #define S5P_CLKGATE_BLOCK		S5P_CLKREG(0x0C970)
 
 #define S5P_CLKSRC_MASK_DMC		S5P_CLKREG(0x10300)
diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index bc6ca94..62e4f43 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -41,7 +41,6 @@ static struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = S5P_CLKSRC_MASK_CAM			, .val = 0x11111111, },
 	{ .reg = S5P_CLKSRC_MASK_TV			, .val = 0x00000111, },
 	{ .reg = S5P_CLKSRC_MASK_LCD0			, .val = 0x00001111, },
-	{ .reg = S5P_CLKSRC_MASK_LCD1			, .val = 0x00001111, },
 	{ .reg = S5P_CLKSRC_MASK_MAUDIO			, .val = 0x00000001, },
 	{ .reg = S5P_CLKSRC_MASK_FSYS			, .val = 0x01011111, },
 	{ .reg = S5P_CLKSRC_MASK_PERIL0			, .val = 0x01111111, },
@@ -49,6 +48,10 @@ static struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = S5P_CLKSRC_MASK_DMC			, .val = 0x00010000, },
 };
 
+static struct sleep_save exynos4210_set_clksrc[] = {
+	{ .reg = S5P_CLKSRC_MASK_LCD1			, .val = 0x00001111, },
+};
+
 static struct sleep_save exynos4_epll_save[] = {
 	SAVE_ITEM(S5P_EPLL_CON0),
 	SAVE_ITEM(S5P_EPLL_CON1),
@@ -60,77 +63,6 @@ static struct sleep_save exynos4_vpll_save[] = {
 };
 
 static struct sleep_save exynos4_core_save[] = {
-	/* CMU side */
-	SAVE_ITEM(S5P_CLKDIV_LEFTBUS),
-	SAVE_ITEM(S5P_CLKGATE_IP_LEFTBUS),
-	SAVE_ITEM(S5P_CLKDIV_RIGHTBUS),
-	SAVE_ITEM(S5P_CLKGATE_IP_RIGHTBUS),
-	SAVE_ITEM(S5P_CLKSRC_TOP0),
-	SAVE_ITEM(S5P_CLKSRC_TOP1),
-	SAVE_ITEM(S5P_CLKSRC_CAM),
-	SAVE_ITEM(S5P_CLKSRC_TV),
-	SAVE_ITEM(S5P_CLKSRC_MFC),
-	SAVE_ITEM(S5P_CLKSRC_G3D),
-	SAVE_ITEM(S5P_CLKSRC_IMAGE),
-	SAVE_ITEM(S5P_CLKSRC_LCD0),
-	SAVE_ITEM(S5P_CLKSRC_LCD1),
-	SAVE_ITEM(S5P_CLKSRC_MAUDIO),
-	SAVE_ITEM(S5P_CLKSRC_FSYS),
-	SAVE_ITEM(S5P_CLKSRC_PERIL0),
-	SAVE_ITEM(S5P_CLKSRC_PERIL1),
-	SAVE_ITEM(S5P_CLKDIV_CAM),
-	SAVE_ITEM(S5P_CLKDIV_TV),
-	SAVE_ITEM(S5P_CLKDIV_MFC),
-	SAVE_ITEM(S5P_CLKDIV_G3D),
-	SAVE_ITEM(S5P_CLKDIV_IMAGE),
-	SAVE_ITEM(S5P_CLKDIV_LCD0),
-	SAVE_ITEM(S5P_CLKDIV_LCD1),
-	SAVE_ITEM(S5P_CLKDIV_MAUDIO),
-	SAVE_ITEM(S5P_CLKDIV_FSYS0),
-	SAVE_ITEM(S5P_CLKDIV_FSYS1),
-	SAVE_ITEM(S5P_CLKDIV_FSYS2),
-	SAVE_ITEM(S5P_CLKDIV_FSYS3),
-	SAVE_ITEM(S5P_CLKDIV_PERIL0),
-	SAVE_ITEM(S5P_CLKDIV_PERIL1),
-	SAVE_ITEM(S5P_CLKDIV_PERIL2),
-	SAVE_ITEM(S5P_CLKDIV_PERIL3),
-	SAVE_ITEM(S5P_CLKDIV_PERIL4),
-	SAVE_ITEM(S5P_CLKDIV_PERIL5),
-	SAVE_ITEM(S5P_CLKDIV_TOP),
-	SAVE_ITEM(S5P_CLKSRC_MASK_TOP),
-	SAVE_ITEM(S5P_CLKSRC_MASK_CAM),
-	SAVE_ITEM(S5P_CLKSRC_MASK_TV),
-	SAVE_ITEM(S5P_CLKSRC_MASK_LCD0),
-	SAVE_ITEM(S5P_CLKSRC_MASK_LCD1),
-	SAVE_ITEM(S5P_CLKSRC_MASK_MAUDIO),
-	SAVE_ITEM(S5P_CLKSRC_MASK_FSYS),
-	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL0),
-	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL1),
-	SAVE_ITEM(S5P_CLKDIV2_RATIO),
-	SAVE_ITEM(S5P_CLKGATE_SCLKCAM),
-	SAVE_ITEM(S5P_CLKGATE_IP_CAM),
-	SAVE_ITEM(S5P_CLKGATE_IP_TV),
-	SAVE_ITEM(S5P_CLKGATE_IP_MFC),
-	SAVE_ITEM(S5P_CLKGATE_IP_G3D),
-	SAVE_ITEM(S5P_CLKGATE_IP_IMAGE),
-	SAVE_ITEM(S5P_CLKGATE_IP_LCD0),
-	SAVE_ITEM(S5P_CLKGATE_IP_LCD1),
-	SAVE_ITEM(S5P_CLKGATE_IP_FSYS),
-	SAVE_ITEM(S5P_CLKGATE_IP_GPS),
-	SAVE_ITEM(S5P_CLKGATE_IP_PERIL),
-	SAVE_ITEM(S5P_CLKGATE_IP_PERIR),
-	SAVE_ITEM(S5P_CLKGATE_BLOCK),
-	SAVE_ITEM(S5P_CLKSRC_MASK_DMC),
-	SAVE_ITEM(S5P_CLKSRC_DMC),
-	SAVE_ITEM(S5P_CLKDIV_DMC0),
-	SAVE_ITEM(S5P_CLKDIV_DMC1),
-	SAVE_ITEM(S5P_CLKGATE_IP_DMC),
-	SAVE_ITEM(S5P_CLKSRC_CPU),
-	SAVE_ITEM(S5P_CLKDIV_CPU),
-	SAVE_ITEM(S5P_CLKDIV_CPU + 0x4),
-	SAVE_ITEM(S5P_CLKGATE_SCLKCPU),
-	SAVE_ITEM(S5P_CLKGATE_IP_CPU),
-
 	/* GIC side */
 	SAVE_ITEM(S5P_VA_GIC_CPU + 0x000),
 	SAVE_ITEM(S5P_VA_GIC_CPU + 0x004),
@@ -268,6 +200,9 @@ static void exynos4_pm_prepare(void)
 
 	s3c_pm_do_restore_core(exynos4_set_clksrc, ARRAY_SIZE(exynos4_set_clksrc));
 
+	if (soc_is_exynos4210())
+		s3c_pm_do_restore_core(exynos4210_set_clksrc, ARRAY_SIZE(exynos4210_set_clksrc));
+
 }
 
 static int exynos4_pm_add(struct sys_device *sysdev)
-- 
1.7.1
