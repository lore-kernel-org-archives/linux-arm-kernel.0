From: stefan@agner.ch (Stefan Agner)
Date: Fri,  8 Jan 2016 10:50:30 -0800
Subject: [PATCH] pinctrl: freescale: imx: implement gpio_disable_free for
 Vybrid
Message-ID: <1452279030-5459-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Freescale Vybrid SoC has GPIO capabilities as part of the
IOMUXC. To enable GPIO's, the gpio_request_enable callback has
been implemented, however the corsponding gpio_disable_free
callback is missing. So far, disabling (unexporting) a GPIO left
the pin in its last state.

Implement a proper gpio_disable_free function which clears the
three enable bits which influence the state (IBE, OBE and PUE).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index a5bb939..4c435cf 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -341,6 +341,31 @@ mux_pin:
 	return 0;
 }
 
+static void imx_pmx_gpio_disable_free(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range, unsigned offset)
+{
+	struct imx_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
+	const struct imx_pin_reg *pin_reg;
+	u32 reg;
+
+	/*
+	 * Only Vybrid has the input/output buffer enable flags (IBE/OBE)
+	 * They are part of the shared mux/conf register.
+	 */
+	if (!(info->flags & SHARE_MUX_CONF_REG))
+		return;
+
+	pin_reg = &info->pin_regs[offset];
+	if (pin_reg->mux_reg == -1)
+		return;
+
+	/* Clear IBE/OBE/PUE to disable the pin (Hi-Z) */
+	reg = readl(ipctl->base + pin_reg->mux_reg);
+	reg &= ~0x7;
+	writel(reg, ipctl->base + pin_reg->mux_reg);
+}
+
 static int imx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	   struct pinctrl_gpio_range *range, unsigned offset, bool input)
 {
@@ -377,6 +402,7 @@ static const struct pinmux_ops imx_pmx_ops = {
 	.get_function_groups = imx_pmx_get_groups,
 	.set_mux = imx_pmx_set,
 	.gpio_request_enable = imx_pmx_gpio_request_enable,
+	.gpio_disable_free = imx_pmx_gpio_disable_free,
 	.gpio_set_direction = imx_pmx_gpio_set_direction,
 };
 
-- 
2.6.4
