From: ping.bai@nxp.com (Bai Ping)
Date: Fri, 2 Dec 2016 14:39:31 +0800
Subject: [PATCH 08/11] ARM: imx: Add suspend/resume support for imx6sll
In-Reply-To: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1480660774-25055-9-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suspend/resume support for imx6sll.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 1515e49..2ed4316 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -145,6 +145,13 @@ struct imx6_pm_socdata {
 	0x494, 0x4b0,	            /* MODE_CTL, MODE, */
 };
 
+static const u32 imx6sll_mmdc_io_offset[] __initconst = {
+	0x294, 0x298, 0x29c, 0x2a0, /* DQM0 ~ DQM3 */
+	0x544, 0x54c, 0x554, 0x558, /* GPR_B0DS ~ GPR_B3DS */
+	0x530, 0x540, 0x2ac, 0x52c, /* MODE_CTL, MODE, SDCLK_0, GPR_ADDDS */
+	0x2a4, 0x2a8,		    /* SDCKE0, SDCKE1*/
+};
+
 static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
 	.mmdc_compat = "fsl,imx6q-mmdc",
 	.src_compat = "fsl,imx6q-src",
@@ -195,6 +202,15 @@ struct imx6_pm_socdata {
 	.mmdc_io_offset = imx6ul_mmdc_io_offset,
 };
 
+static const struct imx6_pm_socdata imx6sll_pm_data __initconst = {
+	.mmdc_compat = "fsl,imx6sll-mmdc",
+	.src_compat = "fsl,imx6sll-src",
+	.iomuxc_compat = "fsl,imx6sll-iomuxc",
+	.gpc_compat = "fsl,imx6sll-gpc",
+	.pl310_compat = "arm,pl310-cache",
+	.mmdc_io_num = ARRAY_SIZE(imx6sll_mmdc_io_offset),
+	.mmdc_io_offset = imx6sll_mmdc_io_offset,
+};
 /*
  * This structure is for passing necessary data for low level ocram
  * suspend code(arch/arm/mach-imx/suspend-imx6.S), if this struct
@@ -293,9 +309,10 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= 0x2 << BP_CLPCR_LPM;
 		val &= ~BM_CLPCR_VSTBY;
 		val &= ~BM_CLPCR_SBYOS;
-		if (cpu_is_imx6sl())
+		if (cpu_is_imx6sl() || cpu_is_imx6sll())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
+			cpu_is_imx6sll())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -310,9 +327,10 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= 0x3 << BP_CLPCR_STBY_COUNT;
 		val |= BM_CLPCR_VSTBY;
 		val |= BM_CLPCR_SBYOS;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6sll())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() ||
+		    cpu_is_imx6ul() || cpu_is_imx6sll())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -373,6 +391,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 			imx6sl_set_wait_clk(true);
 		/* Zzz ... */
 		cpu_do_idle();
+
 		if (cpu_is_imx6sl())
 			imx6sl_set_wait_clk(false);
 		imx_gpc_post_resume();
@@ -632,7 +651,10 @@ void __init imx6dl_pm_init(void)
 
 void __init imx6sl_pm_init(void)
 {
-	imx6_pm_common_init(&imx6sl_pm_data);
+	if (cpu_is_imx6sl())
+		imx6_pm_common_init(&imx6sl_pm_data);
+	else
+		imx6_pm_common_init(&imx6sll_pm_data);
 }
 
 void __init imx6sx_pm_init(void)
-- 
1.9.1
