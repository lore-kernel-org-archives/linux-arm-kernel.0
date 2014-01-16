From: b20788@freescale.com (Anson Huang)
Date: Thu, 16 Jan 2014 17:35:06 +0800
Subject: [PATCH V7 2/3] ARM: imx: add suspend in ocram support for i.mx6dl
In-Reply-To: <1389864907-4040-1-git-send-email-b20788@freescale.com>
References: <1389864907-4040-1-git-send-email-b20788@freescale.com>
Message-ID: <1389864907-4040-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6DL's suspend in ocram function is derived from i.MX6Q,
it can lower the DDR IO power from ~26mA at 1.5V to ~15mA at 1.5V,
measured on i.MX6DL SabreSD board, R25.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/pm-imx6q.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 5e1d3ab..fc57340 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -109,6 +109,18 @@ static const u32 imx6q_mmdc_io_offset[] = {
 	0x74c,			    /* GPR_ADDS */
 };
 
+static const u32 imx6dl_mmdc_io_offset[] = {
+	0x470, 0x474, 0x478, 0x47c, /* DQM0 ~ DQM3 */
+	0x480, 0x484, 0x488, 0x48c, /* DQM4 ~ DQM7 */
+	0x464, 0x490, 0x4ac, 0x4b0, /* CAS, RAS, SDCLK_0, SDCLK_1 */
+	0x4bc, 0x4c0, 0x4c4, 0x4c8, /* DRAM_SDQS0 ~ DRAM_SDQS3 */
+	0x4cc, 0x4d0, 0x4d4, 0x4d8, /* DRAM_SDQS4 ~ DRAM_SDQS7 */
+	0x764, 0x770, 0x778, 0x77c, /* GPR_B0DS ~ GPR_B3DS */
+	0x780, 0x784, 0x78c, 0x748, /* GPR_B4DS ~ GPR_B7DS */
+	0x4b4, 0x4b8, 0x750, 0x760, /* SODT0, SODT1, MODE_CTL, MODE */
+	0x74c,			    /* GPR_ADDS */
+};
+
 static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
 	.cpu_type = MXC_CPU_IMX6Q,
 	.mmdc_compat = "fsl,imx6q-mmdc",
@@ -119,6 +131,16 @@ static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
 	.mmdc_io_offset = imx6q_mmdc_io_offset,
 };
 
+static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
+	.cpu_type = MXC_CPU_IMX6DL,
+	.mmdc_compat = "fsl,imx6q-mmdc",
+	.src_compat = "fsl,imx6q-src",
+	.iomuxc_compat = "fsl,imx6dl-iomuxc",
+	.gpc_compat = "fsl,imx6q-gpc",
+	.mmdc_io_num = ARRAY_SIZE(imx6dl_mmdc_io_offset),
+	.mmdc_io_offset = imx6dl_mmdc_io_offset,
+};
+
 /*
  * This structure is for passing necessary data for low level ocram
  * suspend code(arch/arm/mach-imx/suspend-imx6.S), if this struct
@@ -505,7 +527,7 @@ void __init imx6q_pm_init(void)
 
 void __init imx6dl_pm_init(void)
 {
-	imx6_pm_common_init(NULL);
+	imx6_pm_common_init(&imx6dl_pm_data);
 }
 
 void __init imx6sl_pm_init(void)
-- 
1.7.9.5
