From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 21 Jun 2017 19:59:53 +0800
Subject: [PATCH V4 5/7] pinctrl: imx: remove gpio_request_enable and
 gpio_disable_free
In-Reply-To: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1498046395-30001-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_request_enable/disable_free actually are not quite necessary as
standard IMX pinctrl binding already sets GPIO mux from device tree,
e.g. VF610_PAD_PTB20__GPIO_42 or MX7D_PAD_SD2_CD_B__GPIO5_IO9
No need to do it again in gpio_request_enable.

And according to Stefan:
"For all GPIO I checked in upstream device trees we assign a pinctrl
to the same node, so in all cases gpio_request_enable/disable is really
unnecessary."

So it should be safe to simply remove it.

Cc: Stefan Agner <stefan@agner.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fugang Duan <fugang.duan@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
 * New patch.
   Instead of fixing gpio_request_enable/disable, we decided to remove it
   after dicussion with Stefan (see blow).
   https://www.spinics.net/lists/arm-kernel/msg583154.html
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 69 ---------------------------------
 1 file changed, 69 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index fc1ba3c..505fe79 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -255,73 +255,6 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 	return 0;
 }
 
-static int imx_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
-			struct pinctrl_gpio_range *range, unsigned offset)
-{
-	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
-	const struct imx_pin_reg *pin_reg;
-	struct group_desc *grp;
-	struct imx_pin *imx_pin;
-	unsigned int pin, group;
-	u32 reg;
-
-	/* Currently implementation only for shared mux/conf register */
-	if (!(info->flags & SHARE_MUX_CONF_REG))
-		return 0;
-
-	pin_reg = &info->pin_regs[offset];
-	if (pin_reg->mux_reg == -1)
-		return -EINVAL;
-
-	/* Find the pinctrl config with GPIO mux mode for the requested pin */
-	for (group = 0; group < pctldev->num_groups; group++) {
-		grp = pinctrl_generic_get_group(pctldev, group);
-		if (!grp)
-			continue;
-		for (pin = 0; pin < grp->num_pins; pin++) {
-			imx_pin = &((struct imx_pin *)(grp->data))[pin];
-			if (imx_pin->pin == offset && !imx_pin->mux_mode)
-				goto mux_pin;
-		}
-	}
-
-	return -EINVAL;
-
-mux_pin:
-	reg = readl(ipctl->base + pin_reg->mux_reg);
-	reg &= ~info->mux_mask;
-	reg |= imx_pin->config;
-	writel(reg, ipctl->base + pin_reg->mux_reg);
-
-	return 0;
-}
-
-static void imx_pmx_gpio_disable_free(struct pinctrl_dev *pctldev,
-			struct pinctrl_gpio_range *range, unsigned offset)
-{
-	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	struct imx_pinctrl_soc_info *info = ipctl->info;
-	const struct imx_pin_reg *pin_reg;
-	u32 reg;
-
-	/*
-	 * Only Vybrid has the input/output buffer enable flags (IBE/OBE)
-	 * They are part of the shared mux/conf register.
-	 */
-	if (!(info->flags & SHARE_MUX_CONF_REG))
-		return;
-
-	pin_reg = &info->pin_regs[offset];
-	if (pin_reg->mux_reg == -1)
-		return;
-
-	/* Clear IBE/OBE/PUE to disable the pin (Hi-Z) */
-	reg = readl(ipctl->base + pin_reg->mux_reg);
-	reg &= ~0x7;
-	writel(reg, ipctl->base + pin_reg->mux_reg);
-}
-
 static int imx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	   struct pinctrl_gpio_range *range, unsigned offset, bool input)
 {
@@ -357,8 +290,6 @@ static const struct pinmux_ops imx_pmx_ops = {
 	.get_function_name = pinmux_generic_get_function_name,
 	.get_function_groups = pinmux_generic_get_function_groups,
 	.set_mux = imx_pmx_set,
-	.gpio_request_enable = imx_pmx_gpio_request_enable,
-	.gpio_disable_free = imx_pmx_gpio_disable_free,
 	.gpio_set_direction = imx_pmx_gpio_set_direction,
 };
 
-- 
2.7.4
