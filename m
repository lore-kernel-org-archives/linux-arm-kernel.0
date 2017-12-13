From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 13 Dec 2017 12:30:17 -0600
Subject: [PATCH 2/3] [v8] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
Message-ID: <1513189818-7384-3-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl-msm only accepts an array of GPIOs from 0 to n-1, and it expects
each group to support have only one pin (npins == 1).

We can support "sparse" GPIO maps if we allow for some groups to have zero
pins (npins == 0).  These pins are "hidden" from the rest of the driver
and gpiolib.

Access to unavailable GPIOs is blocked via a request callback.  If the
requested GPIO is unavailable, -EACCES is returned, which prevents
further access to that GPIO.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7a960590ecaa..d45b4c2b5af1 100644
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
+		return -EACCES;
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
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
