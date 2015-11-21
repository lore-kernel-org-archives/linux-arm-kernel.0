From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 21 Nov 2015 19:04:51 +0100
Subject: [PATCH 4/6] pinctrl: pxa: pxa2xx: add pin configuration support
In-Reply-To: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
References: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1448129093-20722-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin configuration for pxa2xx architectures. PXA doesn't provide any
bias, push, pull capabilities. The only capability is to set a state for
the pins when the platform enter sleep or deep sleep mode.

The state of a pin is set by :
 - whether the GPIO direction was input or output
 - if it is output, a register set programs whether the pin should be
   held to ground or VccIO

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index a4ba82459af8..e01914460219 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -184,7 +184,70 @@ static const struct pinmux_ops pxa2xx_pinmux_ops = {
 	.gpio_set_direction = pxa2xx_pmx_gpio_set_direction,
 };
 
+static int pxa2xx_pconf_group_get(struct pinctrl_dev *pctldev,
+				  unsigned group,
+				  unsigned long *config)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pxa_pinctrl_group *g = pctl->groups + group;
+	unsigned long flags;
+	unsigned pin = g->pin;
+	void __iomem *pgsr = pctl->base_pgsr[pin / 32];
+	u32 val;
+
+	spin_lock_irqsave(&pctl->lock, flags);
+	val = readl_relaxed(pgsr) & BIT(pin % 32);
+	*config = val ? PIN_CONFIG_LOW_POWER_MODE : 0;
+	spin_unlock_irqrestore(&pctl->lock, flags);
+
+	dev_dbg(pctl->dev, "get sleep gpio state(pin=%d) %d\n",
+		pin, !!val);
+	return 0;
+}
+
+static int pxa2xx_pconf_group_set(struct pinctrl_dev *pctldev,
+				  unsigned group,
+				  unsigned long *configs,
+				  unsigned num_configs)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pxa_pinctrl_group *g = pctl->groups + group;
+	unsigned long flags;
+	unsigned pin = g->pin;
+	void __iomem *pgsr = pctl->base_pgsr[pin / 32];
+	int i, is_set = 0;
+	u32 val;
+
+	for (i = 0; i < num_configs; i++) {
+		switch (pinconf_to_config_param(configs[i])) {
+		case PIN_CONFIG_LOW_POWER_MODE:
+			is_set = pinconf_to_config_argument(configs[i]);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	dev_dbg(pctl->dev, "set sleep gpio state(pin=%d) %d\n",
+		pin, is_set);
+
+	spin_lock_irqsave(&pctl->lock, flags);
+	val = readl_relaxed(pgsr);
+	val = (val & ~BIT(pin % 32)) | (is_set ? BIT(pin % 32) : 0);
+	writel_relaxed(val, pgsr);
+	spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static const struct pinconf_ops pxa2xx_pconf_ops = {
+	.pin_config_group_get	= pxa2xx_pconf_group_get,
+	.pin_config_group_set	= pxa2xx_pconf_group_set,
+	.is_generic		= true,
+};
+
 static struct pinctrl_desc pxa2xx_pinctrl_desc = {
+	.confops	= &pxa2xx_pconf_ops,
 	.pctlops	= &pxa2xx_pctl_ops,
 	.pmxops		= &pxa2xx_pinmux_ops,
 };
-- 
2.1.4
