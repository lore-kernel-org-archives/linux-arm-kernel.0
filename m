From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 May 2014 23:20:55 +0800
Subject: [PATCH] pinctrl: sunxi: fix pin numbers passed to register offset
 helpers
Message-ID: <1400772055-3852-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pin numbers passed to sunxi_*_reg helpers to get the correct
registers should be the pin offset for the PIO block, not the
absolute number we use that is based on the alphanumeric labels
Allwinner uses.

This patch subtracts .pin_base from the pin number passed to these
functions, so the driver accesses the correct registers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi,

This patch fixes the pinctrl driver failing to set pinmuxes for the R_PIO
block found on the A31 and A23. The problem was found while working on
bringing up the A23 SoC. The R_UART pins weren't properly muxed when
the bootloader didn't use them.

A thank you to Boris who also verified the issue.


Cheers,
ChenYu

---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f6522b5..59962fa 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -280,6 +280,7 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct sunxi_pinctrl_group *g = &pctl->groups[group];
 	unsigned long flags;
+	unsigned pin = g->pin - pctl->desc->pin_base;
 	u32 val, mask;
 	u16 strength;
 	u8 dlevel;
@@ -303,23 +304,23 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 			 *   3: 40mA
 			 */
 			dlevel = strength / 10 - 1;
-			val = readl(pctl->membase + sunxi_dlevel_reg(g->pin));
-			mask = DLEVEL_PINS_MASK << sunxi_dlevel_offset(g->pin);
+			val = readl(pctl->membase + sunxi_dlevel_reg(pin));
+			mask = DLEVEL_PINS_MASK << sunxi_dlevel_offset(pin);
 			writel((val & ~mask)
-				| dlevel << sunxi_dlevel_offset(g->pin),
-				pctl->membase + sunxi_dlevel_reg(g->pin));
+				| dlevel << sunxi_dlevel_offset(pin),
+				pctl->membase + sunxi_dlevel_reg(pin));
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
-			val = readl(pctl->membase + sunxi_pull_reg(g->pin));
-			mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
-			writel((val & ~mask) | 1 << sunxi_pull_offset(g->pin),
-				pctl->membase + sunxi_pull_reg(g->pin));
+			val = readl(pctl->membase + sunxi_pull_reg(pin));
+			mask = PULL_PINS_MASK << sunxi_pull_offset(pin);
+			writel((val & ~mask) | 1 << sunxi_pull_offset(pin),
+				pctl->membase + sunxi_pull_reg(pin));
 			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			val = readl(pctl->membase + sunxi_pull_reg(g->pin));
-			mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
-			writel((val & ~mask) | 2 << sunxi_pull_offset(g->pin),
-				pctl->membase + sunxi_pull_reg(g->pin));
+			val = readl(pctl->membase + sunxi_pull_reg(pin));
+			mask = PULL_PINS_MASK << sunxi_pull_offset(pin);
+			writel((val & ~mask) | 2 << sunxi_pull_offset(pin),
+				pctl->membase + sunxi_pull_reg(pin));
 			break;
 		default:
 			break;
@@ -376,6 +377,7 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 
 	spin_lock_irqsave(&pctl->lock, flags);
 
+	pin -= pctl->desc->pin_base;
 	val = readl(pctl->membase + sunxi_mux_reg(pin));
 	mask = MUX_PINS_MASK << sunxi_mux_offset(pin);
 	writel((val & ~mask) | config << sunxi_mux_offset(pin),
-- 
2.0.0.rc2
