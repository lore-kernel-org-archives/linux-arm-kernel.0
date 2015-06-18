From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Jun 2015 14:43:29 +0200
Subject: [PATCH] clk: at91: add PMC sama5d2 support
Message-ID: <1434631409-4919-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new sama5d2 SoC and adapt capabilities.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/clk/at91/pmc.c           | 15 +++++++++++++++
 include/dt-bindings/clock/at91.h |  1 +
 include/linux/clk/at91_pmc.h     |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index bed2ce6b3cb9..3ac059678486 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -207,6 +207,14 @@ static const struct at91_pmc_caps at91sam9x5_caps = {
 			  AT91_PMC_MOSCRCS | AT91_PMC_CFDEV,
 };
 
+static const struct at91_pmc_caps sama5d2_caps = {
+	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_MCKRDY |
+			  AT91_PMC_LOCKU | AT91_PMC_PCK0RDY |
+			  AT91_PMC_PCK1RDY | AT91_PMC_PCK2RDY |
+			  AT91_PMC_MOSCSELS | AT91_PMC_MOSCRCS |
+			  AT91_PMC_CFDEV | AT91_PMC_GCKRDY,
+};
+
 static const struct at91_pmc_caps sama5d3_caps = {
 	.available_irqs = AT91_PMC_MOSCS | AT91_PMC_LOCKA | AT91_PMC_MCKRDY |
 			  AT91_PMC_LOCKU | AT91_PMC_PCK0RDY |
@@ -443,6 +451,13 @@ static void __init of_at91sam9x5_pmc_setup(struct device_node *np)
 CLK_OF_DECLARE(at91sam9x5_clk_pmc, "atmel,at91sam9x5-pmc",
 	       of_at91sam9x5_pmc_setup);
 
+static void __init of_sama5d2_pmc_setup(struct device_node *np)
+{
+	of_at91_pmc_setup(np, &sama5d2_caps);
+}
+CLK_OF_DECLARE(sama5d2_clk_pmc, "atmel,sama5d2-pmc",
+	       of_sama5d2_pmc_setup);
+
 static void __init of_sama5d3_pmc_setup(struct device_node *np)
 {
 	of_at91_pmc_setup(np, &sama5d3_caps);
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 0b4cb999a3f7..ab3ee241d10c 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -18,5 +18,6 @@
 #define AT91_PMC_MOSCSELS	16		/* Main Oscillator Selection */
 #define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
 #define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
+#define AT91_PMC_GCKRDY		24		/* Generated Clocks */
 
 #endif
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index ae61860e6892..1e6932222e11 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -164,6 +164,7 @@ extern void __iomem *at91_pmc_base;
 #define		AT91_PMC_MOSCSELS	(1 << 16)		/* Main Oscillator Selection [some SAM9] */
 #define		AT91_PMC_MOSCRCS	(1 << 17)		/* Main On-Chip RC [some SAM9] */
 #define		AT91_PMC_CFDEV		(1 << 18)		/* Clock Failure Detector Event [some SAM9] */
+#define		AT91_PMC_GCKRDY		(1 << 24)		/* Generated Clocks */
 #define	AT91_PMC_IMR		0x6c			/* Interrupt Mask Register */
 
 #define AT91_PMC_PLLICPR	0x80			/* PLL Charge Pump Current Register */
-- 
2.1.3
