From: b20788@freescale.com (Anson Huang)
Date: Wed, 5 Aug 2015 01:48:37 +0800
Subject: [PATCH 3/3] ARM: imx: add suspend/resume support for i.mx6ul
In-Reply-To: <1438710517-6515-1-git-send-email-b20788@freescale.com>
References: <1438710517-6515-1-git-send-email-b20788@freescale.com>
Message-ID: <1438710517-6515-3-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds suspend function for i.MX6UL, it supports
"standby" and "mem" mode, for "standby" mode, SoC will
enter STOP mode only, while for "mem" mode, SoC will
enter STOP mode and DDR IO will be set to low power
mode.

As i.MX6UL contains a "Cortex-A7" ARM core which has no
PL310, so we need to avoid any PL310 operations during
suspend/resume, also, we need to flush Cortex-A7's inernal
L2 cache before suspend.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/common.h       |  1 +
 arch/arm/mach-imx/mach-imx6ul.c  |  2 ++
 arch/arm/mach-imx/pm-imx6.c      | 46 ++++++++++++++++++++++++++++++++++------
 arch/arm/mach-imx/suspend-imx6.S |  3 +++
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 21e4e86..e2d5383 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -131,6 +131,7 @@ void imx6q_pm_init(void);
 void imx6dl_pm_init(void);
 void imx6sl_pm_init(void);
 void imx6sx_pm_init(void);
+void imx6ul_pm_init(void);
 
 #ifdef CONFIG_PM
 void imx51_pm_init(void);
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index f206506..f78c107 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -22,6 +22,7 @@ static void __init imx6ul_init_machine(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	imx_anatop_init();
+	imx6ul_pm_init();
 }
 
 static void __init imx6ul_init_irq(void)
@@ -29,6 +30,7 @@ static void __init imx6ul_init_irq(void)
 	imx_init_revision_from_anatop();
 	imx_src_init();
 	irqchip_init();
+	imx6_pm_ccm_init("fsl,imx6ul-ccm");
 }
 
 static const char *imx6ul_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 8ff8fc0..4470376 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -93,6 +93,7 @@ struct imx6_pm_socdata {
 	const char *src_compat;
 	const char *iomuxc_compat;
 	const char *gpc_compat;
+	const char *pl310_compat;
 	const u32 mmdc_io_num;
 	const u32 *mmdc_io_offset;
 };
@@ -137,11 +138,19 @@ static const u32 imx6sx_mmdc_io_offset[] __initconst = {
 	0x330, 0x334, 0x338, 0x33c, /* SDQS0 ~ SDQS3 */
 };
 
+static const u32 imx6ul_mmdc_io_offset[] __initconst = {
+	0x244, 0x248, 0x24c, 0x250, /* DQM0, DQM1, RAS, CAS */
+	0x27c, 0x498, 0x4a4, 0x490, /* SDCLK0, GPR_B0DS-B1DS, GPR_ADDS */
+	0x280, 0x284, 0x260, 0x264, /* SDQS0~1, SODT0, SODT1 */
+	0x494, 0x4b0,	            /* MODE_CTL, MODE, */
+};
+
 static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
 	.mmdc_compat = "fsl,imx6q-mmdc",
 	.src_compat = "fsl,imx6q-src",
 	.iomuxc_compat = "fsl,imx6q-iomuxc",
 	.gpc_compat = "fsl,imx6q-gpc",
+	.pl310_compat = "arm,pl310-cache",
 	.mmdc_io_num = ARRAY_SIZE(imx6q_mmdc_io_offset),
 	.mmdc_io_offset = imx6q_mmdc_io_offset,
 };
@@ -151,6 +160,7 @@ static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
 	.src_compat = "fsl,imx6q-src",
 	.iomuxc_compat = "fsl,imx6dl-iomuxc",
 	.gpc_compat = "fsl,imx6q-gpc",
+	.pl310_compat = "arm,pl310-cache",
 	.mmdc_io_num = ARRAY_SIZE(imx6dl_mmdc_io_offset),
 	.mmdc_io_offset = imx6dl_mmdc_io_offset,
 };
@@ -160,6 +170,7 @@ static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
 	.src_compat = "fsl,imx6sl-src",
 	.iomuxc_compat = "fsl,imx6sl-iomuxc",
 	.gpc_compat = "fsl,imx6sl-gpc",
+	.pl310_compat = "arm,pl310-cache",
 	.mmdc_io_num = ARRAY_SIZE(imx6sl_mmdc_io_offset),
 	.mmdc_io_offset = imx6sl_mmdc_io_offset,
 };
@@ -169,10 +180,21 @@ static const struct imx6_pm_socdata imx6sx_pm_data __initconst = {
 	.src_compat = "fsl,imx6sx-src",
 	.iomuxc_compat = "fsl,imx6sx-iomuxc",
 	.gpc_compat = "fsl,imx6sx-gpc",
+	.pl310_compat = "arm,pl310-cache",
 	.mmdc_io_num = ARRAY_SIZE(imx6sx_mmdc_io_offset),
 	.mmdc_io_offset = imx6sx_mmdc_io_offset,
 };
 
+static const struct imx6_pm_socdata imx6ul_pm_data __initconst = {
+	.mmdc_compat = "fsl,imx6ul-mmdc",
+	.src_compat = "fsl,imx6ul-src",
+	.iomuxc_compat = "fsl,imx6ul-iomuxc",
+	.gpc_compat = "fsl,imx6ul-gpc",
+	.pl310_compat = NULL,
+	.mmdc_io_num = ARRAY_SIZE(imx6ul_mmdc_io_offset),
+	.mmdc_io_offset = imx6ul_mmdc_io_offset,
+};
+
 /*
  * This structure is for passing necessary data for low level ocram
  * suspend code(arch/arm/mach-imx/suspend-imx6.S), if this struct
@@ -290,7 +312,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= BM_CLPCR_SBYOS;
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -330,6 +352,10 @@ static int imx6q_suspend_finish(unsigned long val)
 		 * as we need to float DDR IO.
 		 */
 		local_flush_tlb_all();
+		/* check if need to flush internal L2 cache */
+		if (!((struct imx6_cpu_pm_info *)
+			suspend_ocram_base)->l2_base.vbase)
+			flush_cache_all();
 		imx6_suspend_in_ocram_fn(suspend_ocram_base);
 	}
 
@@ -470,6 +496,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 	suspend_ocram_base = __arm_ioremap_exec(ocram_pbase,
 		MX6Q_SUSPEND_OCRAM_SIZE, false);
 
+	memset(suspend_ocram_base, 0, sizeof(*pm_info));
 	pm_info = suspend_ocram_base;
 	pm_info->pbase = ocram_pbase;
 	pm_info->resume_addr = virt_to_phys(v7_cpu_resume);
@@ -505,11 +532,13 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 		goto gpc_map_failed;
 	}
 
-	ret = imx6_pm_get_base(&pm_info->l2_base, "arm,pl310-cache");
-	if (ret) {
-		pr_warn("%s: failed to get pl310-cache base %d!\n",
-			__func__, ret);
-		goto pl310_cache_map_failed;
+	if (socdata->pl310_compat) {
+		ret = imx6_pm_get_base(&pm_info->l2_base, socdata->pl310_compat);
+		if (ret) {
+			pr_warn("%s: failed to get pl310-cache base %d!\n",
+				__func__, ret);
+			goto pl310_cache_map_failed;
+		}
 	}
 
 	pm_info->ddr_type = imx_mmdc_get_ddr_type();
@@ -610,3 +639,8 @@ void __init imx6sx_pm_init(void)
 {
 	imx6_pm_common_init(&imx6sx_pm_data);
 }
+
+void __init imx6ul_pm_init(void)
+{
+	imx6_pm_common_init(&imx6ul_pm_data);
+}
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index b99987b..76ee2ce 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -79,12 +79,15 @@
 	/* sync L2 cache to drain L2's buffers to DRAM. */
 #ifdef CONFIG_CACHE_L2X0
 	ldr	r11, [r0, #PM_INFO_MX6Q_L2_V_OFFSET]
+	teq	r11, #0
+	beq	6f
 	mov	r6, #0x0
 	str	r6, [r11, #L2X0_CACHE_SYNC]
 1:
 	ldr	r6, [r11, #L2X0_CACHE_SYNC]
 	ands	r6, r6, #0x1
 	bne	1b
+6:
 #endif
 
 	.endm
-- 
1.9.1
