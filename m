From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 3 Jul 2012 15:44:58 -0300
Subject: [PATCH 2/2] ASoC: imx-mc13783: Add audmux settings for mx27pdk
In-Reply-To: <1341341098-9510-1-git-send-email-fabio.estevam@freescale.com>
References: <1341341098-9510-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1341341098-9510-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx27pdk board also has a mc13783 codec.

Add support for it and do a run-time machine type check to perform the correct
audiomux settings.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: <alsa-devel@alsa-project.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-mc13783.c |   49 +++++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index f59c349..549b31f 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -111,22 +111,39 @@ static int __devinit imx_mc13783_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	imx_audmux_v2_configure_port(MX31_AUDMUX_PORT4_SSI_PINS_4,
-		IMX_AUDMUX_V2_PTCR_SYN,
-		IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0) |
-		IMX_AUDMUX_V2_PDCR_MODE(1) |
-		IMX_AUDMUX_V2_PDCR_INMMASK(0xfc));
-	imx_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0,
-		IMX_AUDMUX_V2_PTCR_SYN |
-		IMX_AUDMUX_V2_PTCR_TFSDIR |
-		IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
-		IMX_AUDMUX_V2_PTCR_TCLKDIR |
-		IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
-		IMX_AUDMUX_V2_PTCR_RFSDIR |
-		IMX_AUDMUX_V2_PTCR_RFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
-		IMX_AUDMUX_V2_PTCR_RCLKDIR |
-		IMX_AUDMUX_V2_PTCR_RCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4),
-		IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT4_SSI_PINS_4));
+	if (machine_is_mx31_3ds()) {
+		imx_audmux_v2_configure_port(MX31_AUDMUX_PORT4_SSI_PINS_4,
+			IMX_AUDMUX_V2_PTCR_SYN,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0) |
+			IMX_AUDMUX_V2_PDCR_MODE(1) |
+			IMX_AUDMUX_V2_PDCR_INMMASK(0xfc));
+		imx_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0,
+			IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+			IMX_AUDMUX_V2_PTCR_RFSDIR |
+			IMX_AUDMUX_V2_PTCR_RFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+			IMX_AUDMUX_V2_PTCR_RCLKDIR |
+			IMX_AUDMUX_V2_PTCR_RCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4),
+			IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT4_SSI_PINS_4));
+	} else if (machine_is_mx27_3ds()) {
+		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			IMX_AUDMUX_V1_PCR_SYN |
+			IMX_AUDMUX_V1_PCR_TFSDIR |
+			IMX_AUDMUX_V1_PCR_TCLKDIR |
+			IMX_AUDMUX_V1_PCR_RFSDIR |
+			IMX_AUDMUX_V1_PCR_RCLKDIR |
+			IMX_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+			IMX_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+			IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4)
+		);
+		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
+			IMX_AUDMUX_V1_PCR_SYN |
+			IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
+		);
+	}
 
 	return ret;
 }
-- 
1.7.1
