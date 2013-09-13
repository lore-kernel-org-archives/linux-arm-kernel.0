From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri, 13 Sep 2013 09:47:22 +0200
Subject: [RFC PATCH 2/4] pinctrl: at91: fix sam9x5 debounce/deglitch functions
In-Reply-To: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
References: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1379058442-3321-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace at91_mux_get_deglitch with at91_mux_pio3_get_deglitch when using
sam9x5 (pio3) IP.
at91_mux_get_deglitch only test the activation of the "Input Filter" which
may be overloaded by the activation of the "Input Filter Slow Clock" to use
the input filter as a debounce filter instead of a deglitch filter.

Fix at91_mux_pio3_get_debounce to test the activation of the Input Filter
before testing the activation of the debounce filter (Input Filter Slow
Clock depends on Input Filter).

Fix at91_mux_pio3_set_debounce function to avoid disabling the deglitch
filter ("Input Filter") when debounce filter is disabled.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/pinctrl/pinctrl-at91.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 50b555a..6624bce 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -417,6 +417,14 @@ static void at91_mux_set_deglitch(void __iomem *pio, unsigned mask, bool is_on)
 	__raw_writel(mask, pio + (is_on ? PIO_IFER : PIO_IFDR));
 }
 
+static bool at91_mux_pio3_get_deglitch(void __iomem *pio, unsigned pin)
+{
+	if ((__raw_readl(pio + PIO_IFSR) >> pin) & 0x1)
+		return !((__raw_readl(pio + PIO_IFSCSR) >> pin) & 0x1);
+
+	return false;
+}
+
 static void at91_mux_pio3_set_deglitch(void __iomem *pio, unsigned mask, bool is_on)
 {
 	if (is_on)
@@ -428,7 +436,8 @@ static bool at91_mux_pio3_get_debounce(void __iomem *pio, unsigned pin, u32 *div
 {
 	*div = __raw_readl(pio + PIO_SCDR);
 
-	return (__raw_readl(pio + PIO_IFSCSR) >> pin) & 0x1;
+	return ((__raw_readl(pio + PIO_IFSR) >> pin) & 0x1) &&
+	       ((__raw_readl(pio + PIO_IFSCSR) >> pin) & 0x1);
 }
 
 static void at91_mux_pio3_set_debounce(void __iomem *pio, unsigned mask,
@@ -438,9 +447,8 @@ static void at91_mux_pio3_set_debounce(void __iomem *pio, unsigned mask,
 		__raw_writel(mask, pio + PIO_IFSCER);
 		__raw_writel(div & PIO_SCDR_DIV, pio + PIO_SCDR);
 		__raw_writel(mask, pio + PIO_IFER);
-	} else {
-		__raw_writel(mask, pio + PIO_IFDR);
-	}
+	} else
+		__raw_writel(mask, pio + PIO_IFSCDR);
 }
 
 static bool at91_mux_pio3_get_pulldown(void __iomem *pio, unsigned pin)
@@ -478,7 +486,7 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 	.mux_B_periph	= at91_mux_pio3_set_B_periph,
 	.mux_C_periph	= at91_mux_pio3_set_C_periph,
 	.mux_D_periph	= at91_mux_pio3_set_D_periph,
-	.get_deglitch	= at91_mux_get_deglitch,
+	.get_deglitch	= at91_mux_pio3_get_deglitch,
 	.set_deglitch	= at91_mux_pio3_set_deglitch,
 	.get_debounce	= at91_mux_pio3_get_debounce,
 	.set_debounce	= at91_mux_pio3_set_debounce,
-- 
1.7.9.5
