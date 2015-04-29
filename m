From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 Apr 2015 14:04:58 +0800
Subject: [PATCH 05/11] ARM: imx6: set initial power mode in pm function
In-Reply-To: <CAMAWPa8cyybpdgO+Po=7YUnCFkrnyHKKihgddzrUpHfAW=7brA@mail.gmail.com>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
 <1430058672-9267-6-git-send-email-shawn.guo@linaro.org>
 <CAMAWPa8cyybpdgO+Po=7YUnCFkrnyHKKihgddzrUpHfAW=7brA@mail.gmail.com>
Message-ID: <20150429060446.GA27573@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, Apr 28, 2015 at 11:42:48AM -0700, Kevin Hilman wrote:
> Hi Shawn,
> 
> On Sun, Apr 26, 2015 at 7:31 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Rather than setting initial low-power mode in every single i.MX6 clock
> > initialization function, we should really do that in pm code.  Let's
> > move imx6q_set_lpm(WAIT_CLOCKED) call into imx6_pm_common_init().
> >
> > While at it, let's rename the function to imx6_set_lpm() since it's
> > actually common for all i.MX6 SoCs.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Some boot failures on imx6[1] (multi_v7_defconfig) were bisected down
> to this patch.  A simple revert doesn't build, so I was unable tot
> test a direct revert.  However, from the boot failures you can see
> that while multi_v7_defconfig boots fail, the imx_v6_v7_defconfig
> boots fine.

This reminds me that cpuidle support is not turned on in
imx_v6_v7_defconfig.  I will send a patch to enable it for testing
coverage.

> Disabling CONFIG_CPU_IDLE in multi_v7_defconfig allows
> this to start booting again on my wandboard quad, so I think there is
> something wrong with the cpuidle changes.

I just tracked down the issue, and sent a fix like below.

The kernelci.org boot automation farm helps.  Thanks.

Shawn

----8<-------------------------------
>From 056a5da1b56a057762eccd52b5b6b920c7f56b14 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 29 Apr 2015 13:07:03 +0800
Subject: [PATCH] ARM: imx6: initialize CCM_CLPCR_LPM into RUN mode earlier

Commit 4631960d26da ("ARM: imx6: set initial power mode in pm function")
moves imx6_set_lpm() from clock init function into
imx6_pm_common_init().  This causes a hang when cpuidle support is
enabled.  The reason for that is ARM core clock is shut down
unexpectedly by WAIT mode.  It happens with the following call stack:

    cpuidle_register_governor()
        cpuidle_switch_governor()
            cpuidle_uninstall_idle_handler()
                synchronize_sched()
                    wait_rcu_gp()
                        wait_for_completion()

When wait_for_completion() is called as above, all cores are idle/WFI.
Hence, the reset value of CCM_CLPCR_LPM - WAIT mode, will trigger a
hardware shutdown of the ARM core clock.

To fix the regression, we need to ensure that CCM_CLPCR_LPM is
initialized into RUN mode earlier than cpuidle governor registration,
which is a postcore_initcall.  This patch creates function
imx6_pm_ccm_init() to map CCM block and initialize CCM_CLPCR_LPM into
RUN mode, and have the function called from machine .init_irq hook,
which should be early enough.

Reported-by: Kevin Hilman <khilman@kernel.org>
Fixes: 4631960d26da ("ARM: imx6: set initial power mode in pm function")
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h      |  1 +
 arch/arm/mach-imx/mach-imx6q.c  |  1 +
 arch/arm/mach-imx/mach-imx6sl.c |  1 +
 arch/arm/mach-imx/mach-imx6sx.c |  1 +
 arch/arm/mach-imx/pm-imx6.c     | 28 ++++++++++++++++++----------
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index d1e2873f807e..fbd86f1b7f3b 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -123,6 +123,7 @@ static inline void v7_cpu_resume(void) {}
 static inline void imx6_suspend(void __iomem *ocram_vbase) {}
 #endif
 
+void imx6_pm_ccm_init(const char *ccm_compat);
 void imx6q_pm_init(void);
 void imx6dl_pm_init(void);
 void imx6sl_pm_init(void);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 3ab61549ce0f..9602cc12d2f1 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -393,6 +393,7 @@ static void __init imx6q_init_irq(void)
 	imx_init_l2cache();
 	imx_src_init();
 	irqchip_init();
+	imx6_pm_ccm_init("fsl,imx6q-ccm");
 }
 
 static const char * const imx6q_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 12a1b098fc6a..300326373166 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -66,6 +66,7 @@ static void __init imx6sl_init_irq(void)
 	imx_init_l2cache();
 	imx_src_init();
 	irqchip_init();
+	imx6_pm_ccm_init("fsl,imx6sl-ccm");
 }
 
 static const char * const imx6sl_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index f17b7004c24b..6a0b0614de29 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -86,6 +86,7 @@ static void __init imx6sx_init_irq(void)
 	imx_init_l2cache();
 	imx_src_init();
 	irqchip_init();
+	imx6_pm_ccm_init("fsl,imx6sx-ccm");
 }
 
 static void __init imx6sx_init_late(void)
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 27bc80dab2d8..b01650d94f91 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -89,7 +89,6 @@ struct imx6_pm_base {
 
 struct imx6_pm_socdata {
 	u32 ddr_type;
-	const char *ccm_compat;
 	const char *mmdc_compat;
 	const char *src_compat;
 	const char *iomuxc_compat;
@@ -139,7 +138,6 @@ static const u32 imx6sx_mmdc_io_offset[] __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
-	.ccm_compat = "fsl,imx6q-ccm",
 	.mmdc_compat = "fsl,imx6q-mmdc",
 	.src_compat = "fsl,imx6q-src",
 	.iomuxc_compat = "fsl,imx6q-iomuxc",
@@ -149,7 +147,6 @@ static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
-	.ccm_compat = "fsl,imx6q-ccm",
 	.mmdc_compat = "fsl,imx6q-mmdc",
 	.src_compat = "fsl,imx6q-src",
 	.iomuxc_compat = "fsl,imx6dl-iomuxc",
@@ -159,7 +156,6 @@ static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
-	.ccm_compat = "fsl,imx6sl-ccm",
 	.mmdc_compat = "fsl,imx6sl-mmdc",
 	.src_compat = "fsl,imx6sl-src",
 	.iomuxc_compat = "fsl,imx6sl-iomuxc",
@@ -169,7 +165,6 @@ static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6sx_pm_data __initconst = {
-	.ccm_compat = "fsl,imx6sx-ccm",
 	.mmdc_compat = "fsl,imx6sx-mmdc",
 	.src_compat = "fsl,imx6sx-src",
 	.iomuxc_compat = "fsl,imx6sx-iomuxc",
@@ -553,16 +548,11 @@ put_node:
 static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 					*socdata)
 {
-	struct device_node *np;
 	struct regmap *gpr;
 	int ret;
 
-	np = of_find_compatible_node(NULL, NULL, socdata->ccm_compat);
-	ccm_base = of_iomap(np, 0);
 	WARN_ON(!ccm_base);
 
-	imx6_set_lpm(WAIT_CLOCKED);
-
 	if (IS_ENABLED(CONFIG_SUSPEND)) {
 		ret = imx6q_suspend_init(socdata);
 		if (ret)
@@ -583,6 +573,24 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 				   IMX6Q_GPR1_GINT);
 }
 
+void __init imx6_pm_ccm_init(const char *ccm_compat)
+{
+	struct device_node *np;
+	u32 val;
+
+	np = of_find_compatible_node(NULL, NULL, ccm_compat);
+	ccm_base = of_iomap(np, 0);
+	BUG_ON(!ccm_base);
+
+	/*
+	 * Initialize CCM_CLPCR_LPM into RUN mode to avoid ARM core
+	 * clock being shut down unexpectedly by WAIT mode.
+	 */
+	val = readl_relaxed(ccm_base + CLPCR);
+	val &= ~BM_CLPCR_LPM;
+	writel_relaxed(val, ccm_base + CLPCR);
+}
+
 void __init imx6q_pm_init(void)
 {
 	imx6_pm_common_init(&imx6q_pm_data);
-- 
1.9.1
