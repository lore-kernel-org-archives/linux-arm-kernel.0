From: timur@codeaurora.org (Timur Tabi)
Date: Tue,  7 Nov 2017 17:07:35 -0600
Subject: [PATCH 3/4] [v6] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
Message-ID: <1510096056-13765-4-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl-msm only accepts an array of GPIOs from 0 to n-1, and it expects
each group to support have only one pin (npins == 1).

We can support "sparse" GPIO maps if we allow for some groups to have zero
pins (npins == 0).  These pins are "hidden" from the rest of the driver
and gpiolib.

A new boolean 'sparse' indicates whether the GPIO map is sparse.  If any
GPIO has an 'npins' value of 0, then 'sparse' must be set to True.

Most access to unavailable GPIOs can be blocked via the gpio_chip.request
function.  The one exception is when gpiochip_add_data() scans all of
the GPIOs without "requesting" them.  To cover this case,
msm_gpio_get_direction() separately checks if the GPIO is available.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 48 +++++++++++++++++++++++++++++++++-----
 drivers/pinctrl/qcom/pinctrl-msm.h |  2 ++
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index ff491da64dab..66c68a314ca9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -507,6 +507,11 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 	};
 
 	g = &pctrl->soc->groups[offset];
+
+	/* If the GPIO group has no pins, then don't show it. */
+	if (!g->npins)
+		return;
+
 	ctl_reg = readl(pctrl->regs + g->ctl_reg);
 
 	is_out = !!(ctl_reg & BIT(g->oe_bit));
@@ -516,7 +521,7 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 
 	seq_printf(s, " %-8s: %-3s %d", g->name, is_out ? "out" : "in", func);
 	seq_printf(s, " %dmA", msm_regval_to_drive(drive));
-	seq_printf(s, " %s", pulls[pull]);
+	seq_printf(s, " %s\n", pulls[pull]);
 }
 
 static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -524,23 +529,36 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	unsigned gpio = chip->base;
 	unsigned i;
 
-	for (i = 0; i < chip->ngpio; i++, gpio++) {
+	for (i = 0; i < chip->ngpio; i++, gpio++)
 		msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
-		seq_puts(s, "\n");
-	}
 }
 
 #else
 #define msm_gpio_dbg_show NULL
 #endif
 
+/*
+ * If the requested GPIO has no pins, then treat it as unavailable.
+ * Otherwise, call the standard request function.
+ */
+static int msm_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct msm_pingroup *g = &pctrl->soc->groups[offset];
+
+	if (!g->npins)
+		return -ENODEV;
+
+	return gpiochip_generic_request(chip, offset);
+}
+
 static const struct gpio_chip msm_gpio_template = {
 	.direction_input  = msm_gpio_direction_input,
 	.direction_output = msm_gpio_direction_output,
 	.get_direction    = msm_gpio_get_direction,
 	.get              = msm_gpio_get,
 	.set              = msm_gpio_set,
-	.request          = gpiochip_generic_request,
+	.request          = msm_gpio_request,
 	.free             = gpiochip_generic_free,
 	.dbg_show         = msm_gpio_dbg_show,
 };
@@ -813,6 +831,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	struct gpio_chip *chip;
 	int ret;
 	unsigned ngpio = pctrl->soc->ngpios;
+	const struct msm_pingroup *groups = pctrl->soc->groups;
+	unsigned int i;
 
 	if (WARN_ON(ngpio > MAX_NR_GPIO))
 		return -EINVAL;
@@ -825,13 +845,29 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	chip->owner = THIS_MODULE;
 	chip->of_node = pctrl->dev->of_node;
 
+	/* If the GPIO map is sparse, then we need to disable specific IRQs */
+	if (pctrl->soc->sparse) {
+		chip->irq_need_valid_mask = true;
+		chip->line_need_valid_mask = true;
+	}
+
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
 		dev_err(pctrl->dev, "Failed register gpiochip\n");
 		return ret;
 	}
 
-	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
+	if (chip->line_need_valid_mask) {
+		for (i = 0; i < ngpio; i++)
+			if (!groups[i].npins) {
+				clear_bit(i, pctrl->chip.irq_valid_mask);
+				clear_bit(i, pctrl->chip.line_valid_mask);
+			}
+	}
+
+	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
+				     0, 0, ngpio);
+
 	if (ret) {
 		dev_err(pctrl->dev, "Failed to add pin range\n");
 		gpiochip_remove(&pctrl->chip);
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 9b9feea540ff..70762bcb84cb 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -107,6 +107,7 @@ struct msm_pingroup {
  * @ngroups:	    The numbmer of entries in @groups.
  * @ngpio:	    The number of pingroups the driver should expose as GPIOs.
  * @pull_no_keeper: The SoC does not support keeper bias.
+ * @sparse:         The GPIO map is sparse (some GPIOs have npins == 0)
  */
 struct msm_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -117,6 +118,7 @@ struct msm_pinctrl_soc_data {
 	unsigned ngroups;
 	unsigned ngpios;
 	bool pull_no_keeper;
+	bool sparse;
 };
 
 int msm_pinctrl_probe(struct platform_device *pdev,
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
