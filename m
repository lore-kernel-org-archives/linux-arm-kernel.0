From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 31 May 2018 10:06:09 +0800
Subject: [PATCH 2/2] ARM: imx: add mem mode suspend for i.MX6SLL
In-Reply-To: <1527732369-19740-1-git-send-email-Anson.Huang@nxp.com>
References: <1527732369-19740-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1527732369-19740-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mem mode suspend for i.MX6SLL, when linux
kernel suspend, SoC will enter STOP mode,
ARM core will be power gated and MMDC IO
will be set to low power mode.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index d319b20..791e1fd 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -130,6 +130,13 @@ static const u32 imx6sl_mmdc_io_offset[] __initconst = {
 	0x330, 0x334, 0x320,        /* SDCKE0, SDCKE1, RESET */
 };
 
+static const u32 imx6sll_mmdc_io_offset[] __initconst = {
+	0x294, 0x298, 0x29c, 0x2a0, /* DQM0 ~ DQM3 */
+	0x544, 0x54c, 0x554, 0x558, /* GPR_B0DS ~ GPR_B3DS */
+	0x530, 0x540, 0x2ac, 0x52c, /* MODE_CTL, MODE, SDCLK_0, GPR_ADDDS */
+	0x2a4, 0x2a8,		    /* SDCKE0, SDCKE1*/
+};
+
 static const u32 imx6sx_mmdc_io_offset[] __initconst = {
 	0x2ec, 0x2f0, 0x2f4, 0x2f8, /* DQM0 ~ DQM3 */
 	0x60c, 0x610, 0x61c, 0x620, /* GPR_B0DS ~ GPR_B3DS */
@@ -175,6 +182,16 @@ static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
 	.mmdc_io_offset = imx6sl_mmdc_io_offset,
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
+
 static const struct imx6_pm_socdata imx6sx_pm_data __initconst = {
 	.mmdc_compat = "fsl,imx6sx-mmdc",
 	.src_compat = "fsl,imx6sx-src",
@@ -314,7 +331,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl() || cpu_is_imx6sx())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull())
+		    cpu_is_imx6ull() || cpu_is_imx6sll())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -631,7 +648,10 @@ void __init imx6dl_pm_init(void)
 
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
2.7.4
