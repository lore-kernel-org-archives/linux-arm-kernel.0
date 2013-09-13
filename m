From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri, 13 Sep 2013 09:51:44 +0200
Subject: [RFC PATCH 4/4] pinctrl: at91: check for debounce time conflicts
In-Reply-To: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
References: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1379058704-3451-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sam9x5 (pio3) PIO controller the debounce time config is shared across
all the pins of a given PIO bank (PIOA, PIOB, ...).

This patch adds checks before applying debounce config on a given pin.
If the pinctrl core tries to configure a debounce time on a given pin and
another pin on the same bank is already configured with a different
debounce time, the pin config with fail with -EINVAL.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/pinctrl/pinctrl-at91.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index ac9dbea..986e9bc 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -146,7 +146,7 @@ struct at91_pinctrl_mux_ops {
 	bool (*get_deglitch)(void __iomem *pio, unsigned pin);
 	void (*set_deglitch)(void __iomem *pio, unsigned mask, bool is_on);
 	bool (*get_debounce)(void __iomem *pio, unsigned pin, u32 *div);
-	void (*set_debounce)(void __iomem *pio, unsigned mask, bool is_on, u32 div);
+	int (*set_debounce)(void __iomem *pio, unsigned mask, bool is_on, u32 div);
 	bool (*get_pulldown)(void __iomem *pio, unsigned pin);
 	void (*set_pulldown)(void __iomem *pio, unsigned mask, bool is_on);
 	bool (*get_schmitt_trig)(void __iomem *pio, unsigned pin);
@@ -440,15 +440,26 @@ static bool at91_mux_pio3_get_debounce(void __iomem *pio, unsigned pin, u32 *div
 	       ((__raw_readl(pio + PIO_IFSCSR) >> pin) & 0x1);
 }
 
-static void at91_mux_pio3_set_debounce(void __iomem *pio, unsigned mask,
+static int at91_mux_pio3_set_debounce(void __iomem *pio, unsigned mask,
 				bool is_on, u32 div)
 {
 	if (is_on) {
+		div &= PIO_SCDR_DIV;
+
+		/* Check if another pin of this bank is already using debounce
+		 * option with a different debounce time */
+		if ((__raw_readl(pio + PIO_IFSR) &
+		     __raw_readl(pio + PIO_IFSCSR) & ~mask) &&
+		    (__raw_readl(pio + PIO_SCDR) & PIO_SCDR_DIV) != div)
+			return -EINVAL;
+
 		__raw_writel(mask, pio + PIO_IFSCER);
-		__raw_writel(div & PIO_SCDR_DIV, pio + PIO_SCDR);
+		__raw_writel(div, pio + PIO_SCDR);
 		__raw_writel(mask, pio + PIO_IFER);
 	} else
 		__raw_writel(mask, pio + PIO_IFSCDR);
+
+	return 0;
 }
 
 static bool at91_mux_pio3_get_pulldown(void __iomem *pio, unsigned pin)
@@ -750,6 +761,7 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 	struct at91_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	unsigned mask;
 	void __iomem *pio;
+	int ret;
 
 	dev_dbg(info->dev, "%s:%d, pin_id=%d, config=0x%lx", __func__, __LINE__, pin_id, config);
 	pio = pin_to_controller(info, pin_to_bank(pin_id));
@@ -765,8 +777,10 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
 		if (!info->ops->set_debounce)
 			return -ENOTSUPP;
 
-		info->ops->set_debounce(pio, mask, config & DEBOUNCE,
+		ret = info->ops->set_debounce(pio, mask, config & DEBOUNCE,
 				(config & DEBOUNCE_VAL) >> DEBOUNCE_VAL_SHIFT);
+		if (ret)
+			return ret;
 	} else if (info->ops->set_deglitch)
 		info->ops->set_deglitch(pio, mask, config & DEGLITCH);
 
-- 
1.7.9.5
