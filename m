From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 21 Nov 2015 19:04:50 +0100
Subject: [PATCH 3/6] pinctrl: pxa: pxa2xx: add pin muxing
In-Reply-To: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
References: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1448129093-20722-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is inspired from the sunxi driver. The pxa architecture
specificities leading to the driver are :
 - each pin has 8 possible alternate functions
 - 4 of these are output kind
 - 4 of these are input kind
 - there is always a "gpio input" and "gpio output" function
 - the function matrix is very scattered :
   - some functions can be found on 5 different pads
   - the number of functions is greater than the number of pins
   - there is no "topology" grouping of pins (such as all SPI in one
     corner of the die)

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 121 +++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index baded1a8745b..a4ba82459af8 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -64,8 +64,129 @@ static const struct pinctrl_ops pxa2xx_pctl_ops = {
 	.get_group_pins		= pxa2xx_pctrl_get_group_pins,
 };
 
+static struct pxa_desc_function *
+pxa_desc_by_func_group(struct pxa_pinctrl *pctl, const char *pin_name,
+		       const char *func_name)
+{
+	int i;
+	struct pxa_desc_function *df;
+
+	for (i = 0; i < pctl->npins; i++) {
+		const struct pxa_desc_pin *pin = pctl->ppins + i;
+
+		if (!strcmp(pin->pin.name, pin_name))
+			for (df = pin->functions; df->name; df++)
+				if (!strcmp(df->name, func_name))
+					return df;
+	}
+
+	return NULL;
+}
+
+static int pxa2xx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+					 struct pinctrl_gpio_range *range,
+					 unsigned pin,
+					 bool input)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long flags;
+	uint32_t val;
+	void __iomem *gpdr;
+
+	gpdr = pctl->base_gpdr[pin / 32];
+	dev_dbg(pctl->dev, "set_direction(pin=%d): dir=%d\n",
+		pin, !input);
+
+	spin_lock_irqsave(&pctl->lock, flags);
+
+	val = readl_relaxed(gpdr);
+	val = (val & ~BIT(pin % 32)) | (input ? 0 : BIT(pin % 32));
+	writel_relaxed(val, gpdr);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+
+static const char *pxa2xx_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					    unsigned function)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pxa_pinctrl_function *pf = pctl->functions + function;
+
+	return pf->name;
+}
+
+static int pxa2xx_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->nfuncs;
+}
+
+static int pxa2xx_pmx_get_func_groups(struct pinctrl_dev *pctldev,
+				      unsigned function,
+				      const char * const **groups,
+				      unsigned * const num_groups)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pxa_pinctrl_function *pf = pctl->functions + function;
+
+	*groups = pf->groups;
+	*num_groups = pf->ngroups;
+
+	return 0;
+}
+
+static int pxa2xx_pmx_set_mux(struct pinctrl_dev *pctldev, unsigned function,
+			      unsigned tgroup)
+{
+	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pxa_pinctrl_group *group = pctl->groups + tgroup;
+	struct pxa_desc_function *df;
+	int pin, shift;
+	unsigned long flags;
+	void __iomem *gafr, *gpdr;
+	u32 val;
+
+
+	df = pxa_desc_by_func_group(pctl, group->name,
+				    (pctl->functions + function)->name);
+	if (!df)
+		return -EINVAL;
+
+	pin = group->pin;
+	gafr = pctl->base_gafr[pin / 16];
+	gpdr = pctl->base_gpdr[pin / 32];
+	shift = (pin % 16) << 1;
+	dev_dbg(pctl->dev, "set_mux(pin=%d): af=%d dir=%d\n",
+		pin, df->muxval >> 1, df->muxval & 0x1);
+
+	spin_lock_irqsave(&pctl->lock, flags);
+
+	val = readl_relaxed(gafr);
+	val = (val & ~(0x3 << shift)) | ((df->muxval >> 1) << shift);
+	writel_relaxed(val, gafr);
+
+	val = readl_relaxed(gpdr);
+	val = (val & ~BIT(pin % 32)) | ((df->muxval & 1) ? BIT(pin % 32) : 0);
+	writel_relaxed(val, gpdr);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
+
+	return 0;
+}
+static const struct pinmux_ops pxa2xx_pinmux_ops = {
+	.get_functions_count = pxa2xx_get_functions_count,
+	.get_function_name = pxa2xx_pmx_get_func_name,
+	.get_function_groups = pxa2xx_pmx_get_func_groups,
+	.set_mux = pxa2xx_pmx_set_mux,
+	.gpio_set_direction = pxa2xx_pmx_gpio_set_direction,
+};
+
 static struct pinctrl_desc pxa2xx_pinctrl_desc = {
 	.pctlops	= &pxa2xx_pctl_ops,
+	.pmxops		= &pxa2xx_pinmux_ops,
 };
 
 static const struct pxa_pinctrl_function *
-- 
2.1.4
