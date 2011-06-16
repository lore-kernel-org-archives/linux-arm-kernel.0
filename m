From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 16 Jun 2011 13:42:52 -0300
Subject: [PATCH] ARM: mach-imx/mx31_3ds: Fix IOMUX for SPI1 signals
Message-ID: <1308242572-5158-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD on the mx31_3ds board is connected to CSPI1.

Fix the IOMUX settings so that LCD can work.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx31_3ds.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index ab2a626..a6160ee 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -53,11 +53,8 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_RXD1__RXD1,
 	IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO),
 	/*SPI0*/
-	MX31_PIN_CSPI1_SCLK__SCLK,
-	MX31_PIN_CSPI1_MOSI__MOSI,
-	MX31_PIN_CSPI1_MISO__MISO,
-	MX31_PIN_CSPI1_SPI_RDY__SPI_RDY,
-	MX31_PIN_CSPI1_SS2__SS2, /* CS for LCD */
+	IOMUX_MODE(MX31_PIN_DSR_DCE1, IOMUX_CONFIG_ALT1),
+	IOMUX_MODE(MX31_PIN_RI_DCE1, IOMUX_CONFIG_ALT1),
 	/* SPI 1 */
 	MX31_PIN_CSPI2_SCLK__SCLK,
 	MX31_PIN_CSPI2_MOSI__MOSI,
@@ -690,6 +687,9 @@ static void __init mx31_3ds_init(void)
 	int ret;
 
 	imx31_soc_init();
+
+	/* Configure SPI1 IOMUX */
+	mxc_iomux_set_gpr(MUX_PGP_CSPI_BB, true);
 
 	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
 				      "mx31_3ds");
-- 
1.6.0.4
