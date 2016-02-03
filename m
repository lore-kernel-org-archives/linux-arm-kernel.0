From: k@japko.eu (Krzysztof Adamski)
Date: Thu,  4 Feb 2016 00:33:50 +0100
Subject: [PATCH v3 5/5] pinctrl: sunxi: Use pin number when calling
 sunxi_pmx_set
In-Reply-To: <1454542430-16572-1-git-send-email-k@japko.eu>
References: <1454542430-16572-1-git-send-email-k@japko.eu>
Message-ID: <1454542430-16572-6-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_pmx_set accepts pin number and then calculates offset by
subtracting pin_base from it. sunxi_pinctrl_gpio_get, on the other hand,
gets offset so we have to convert it to pin number so we won't get
negative value in sunxi_pmx_set.

This was only used on A10 so far, where there is only one GPIO chip with
pin_base set to 0 so it didn't matter. However H3 also requires this
workaround but have two pinmux sections, triggering problem for PL port.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 7a2465f..96f64a1 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -459,15 +459,16 @@ static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
 	u8 index = sunxi_data_offset(offset);
 	u32 set_mux = pctl->desc->irq_read_needs_mux &&
 			test_bit(FLAG_USED_AS_IRQ, &chip->desc[offset].flags);
+	u32 pin = offset + chip->base;
 	u32 val;
 
 	if (set_mux)
-		sunxi_pmx_set(pctl->pctl_dev, offset, SUN4I_FUNC_INPUT);
+		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_INPUT);
 
 	val = (readl(pctl->membase + reg) >> index) & DATA_PINS_MASK;
 
 	if (set_mux)
-		sunxi_pmx_set(pctl->pctl_dev, offset, SUN4I_FUNC_IRQ);
+		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_IRQ);
 
 	return !!val;
 }
-- 
2.1.4
