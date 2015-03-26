From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 12:18:49 +0000
Subject: [PATCH] pinctrl: at91: convert __raw to endian agnostic IO
Message-ID: <1427372329-26005-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use endian agnostic _relaxed IO accessors instead of the __raw ones.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com> (maintainer:PIN CONTROLLER -...)
CC: Linus Walleij <linus.walleij@linaro.org> (maintainer:PIN CONTROL SUBSY...)
CC: linux-arm-kernel at lists.infradead.org (moderated list:PIN CONTROLLER -...)
CC: linux-gpio at vger.kernel.org (open list:PIN CONTROL SUBSY...)
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/pinctrl/pinctrl-at91.c | 50 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index f4cd0b9..cdd47dc 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -451,18 +451,18 @@ static enum at91_mux at91_mux_get_periph(void __iomem *pio, unsigned mask)
 
 static bool at91_mux_get_deglitch(void __iomem *pio, unsigned pin)
 {
-	return (__raw_readl(pio + PIO_IFSR) >> pin) & 0x1;
+	return (readl_relaxed(pio + PIO_IFSR) >> pin) & 0x1;
 }
 
 static void at91_mux_set_deglitch(void __iomem *pio, unsigned mask, bool is_on)
 {
-	__raw_writel(mask, pio + (is_on ? PIO_IFER : PIO_IFDR));
+	writel_relaxed(mask, pio + (is_on ? PIO_IFER : PIO_IFDR));
 }
 
 static bool at91_mux_pio3_get_deglitch(void __iomem *pio, unsigned pin)
 {
-	if ((__raw_readl(pio + PIO_IFSR) >> pin) & 0x1)
-		return !((__raw_readl(pio + PIO_IFSCSR) >> pin) & 0x1);
+	if ((readl_relaxed(pio + PIO_IFSR) >> pin) & 0x1)
+		return !((readl_relaxed(pio + PIO_IFSCSR) >> pin) & 0x1);
 
 	return false;
 }
@@ -470,55 +470,55 @@ static bool at91_mux_pio3_get_deglitch(void __iomem *pio, unsigned pin)
 static void at91_mux_pio3_set_deglitch(void __iomem *pio, unsigned mask, bool is_on)
 {
 	if (is_on)
-		__raw_writel(mask, pio + PIO_IFSCDR);
+		writel_relaxed(mask, pio + PIO_IFSCDR);
 	at91_mux_set_deglitch(pio, mask, is_on);
 }
 
 static bool at91_mux_pio3_get_debounce(void __iomem *pio, unsigned pin, u32 *div)
 {
-	*div = __raw_readl(pio + PIO_SCDR);
+	*div = readl_relaxed(pio + PIO_SCDR);
 
-	return ((__raw_readl(pio + PIO_IFSR) >> pin) & 0x1) &&
-	       ((__raw_readl(pio + PIO_IFSCSR) >> pin) & 0x1);
+	return ((readl_relaxed(pio + PIO_IFSR) >> pin) & 0x1) &&
+	       ((readl_relaxed(pio + PIO_IFSCSR) >> pin) & 0x1);
 }
 
 static void at91_mux_pio3_set_debounce(void __iomem *pio, unsigned mask,
 				bool is_on, u32 div)
 {
 	if (is_on) {
-		__raw_writel(mask, pio + PIO_IFSCER);
-		__raw_writel(div & PIO_SCDR_DIV, pio + PIO_SCDR);
-		__raw_writel(mask, pio + PIO_IFER);
+		writel_relaxed(mask, pio + PIO_IFSCER);
+		writel_relaxed(div & PIO_SCDR_DIV, pio + PIO_SCDR);
+		writel_relaxed(mask, pio + PIO_IFER);
 	} else
-		__raw_writel(mask, pio + PIO_IFSCDR);
+		writel_relaxed(mask, pio + PIO_IFSCDR);
 }
 
 static bool at91_mux_pio3_get_pulldown(void __iomem *pio, unsigned pin)
 {
-	return !((__raw_readl(pio + PIO_PPDSR) >> pin) & 0x1);
+	return !((readl_relaxed(pio + PIO_PPDSR) >> pin) & 0x1);
 }
 
 static void at91_mux_pio3_set_pulldown(void __iomem *pio, unsigned mask, bool is_on)
 {
 	if (is_on)
-		__raw_writel(mask, pio + PIO_PUDR);
+		writel_relaxed(mask, pio + PIO_PUDR);
 
-	__raw_writel(mask, pio + (is_on ? PIO_PPDER : PIO_PPDDR));
+	writel_relaxed(mask, pio + (is_on ? PIO_PPDER : PIO_PPDDR));
 }
 
 static void at91_mux_pio3_disable_schmitt_trig(void __iomem *pio, unsigned mask)
 {
-	__raw_writel(__raw_readl(pio + PIO_SCHMITT) | mask, pio + PIO_SCHMITT);
+	writel_relaxed(readl_relaxed(pio + PIO_SCHMITT) | mask, pio + PIO_SCHMITT);
 }
 
 static bool at91_mux_pio3_get_schmitt_trig(void __iomem *pio, unsigned pin)
 {
-	return (__raw_readl(pio + PIO_SCHMITT) >> pin) & 0x1;
+	return (readl_relaxed(pio + PIO_SCHMITT) >> pin) & 0x1;
 }
 
 static inline u32 read_drive_strength(void __iomem *reg, unsigned pin)
 {
-	unsigned tmp = __raw_readl(reg);
+	unsigned tmp = readl_relaxed(reg);
 
 	tmp = tmp >> two_bit_pin_value_shift_amount(pin);
 
@@ -554,13 +554,13 @@ static unsigned at91_mux_sam9x5_get_drivestrength(void __iomem *pio,
 
 static void set_drive_strength(void __iomem *reg, unsigned pin, u32 strength)
 {
-	unsigned tmp = __raw_readl(reg);
+	unsigned tmp = readl_relaxed(reg);
 	unsigned shift = two_bit_pin_value_shift_amount(pin);
 
 	tmp &= ~(DRIVE_STRENGTH_MASK  <<  shift);
 	tmp |= strength << shift;
 
-	__raw_writel(tmp, reg);
+	writel_relaxed(tmp, reg);
 }
 
 static void at91_mux_sama5d3_set_drivestrength(void __iomem *pio, unsigned pin,
@@ -1538,9 +1538,9 @@ void at91_pinctrl_gpio_suspend(void)
 
 		pio = gpio_chips[i]->regbase;
 
-		backups[i] = __raw_readl(pio + PIO_IMR);
-		__raw_writel(backups[i], pio + PIO_IDR);
-		__raw_writel(wakeups[i], pio + PIO_IER);
+		backups[i] = readl_relaxed(pio + PIO_IMR);
+		writel_relaxed(backups[i], pio + PIO_IDR);
+		writel_relaxed(wakeups[i], pio + PIO_IER);
 
 		if (!wakeups[i])
 			clk_disable_unprepare(gpio_chips[i]->clock);
@@ -1565,8 +1565,8 @@ void at91_pinctrl_gpio_resume(void)
 		if (!wakeups[i])
 			clk_prepare_enable(gpio_chips[i]->clock);
 
-		__raw_writel(wakeups[i], pio + PIO_IDR);
-		__raw_writel(backups[i], pio + PIO_IER);
+		writel_relaxed(wakeups[i], pio + PIO_IDR);
+		writel_relaxed(backups[i], pio + PIO_IER);
 	}
 }
 
-- 
2.1.4
