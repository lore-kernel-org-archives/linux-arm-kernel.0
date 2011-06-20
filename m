From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 20 Jun 2011 10:37:13 -0300
Subject: [PATCH v2] ARM: mach-imx/mx31_3ds: Fix IOMUX for SPI1 signals
Message-ID: <1308577033-10678-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Original code was assuming that the CSPI1 pins on the
MX31PDK were the primary pin function, which is incorrect.

On MX31PDK board these are the pins that provide CSPI1 functionality:

DSR_DCE1 (ALT mode 1) --> CSPI1_CLK
RI_DCE1 (ALT mode 1) --> CSPI1_RDY

DTR_DTE1  -->CSI1_MOSI
DSR_DTE1 --> CSPI1_MISO
DTR_DCE2 ---> CSPI1_SS2

The 3 IOMUX settings above are done via GPR as per Table A-1 of the MX31RM.

This patch fixes the CSPI1 IOMUX and makes the LCD to be functional.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:

- Provided better explanation about this change on the commit message

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
