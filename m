From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 29 Jun 2017 19:42:18 -0500
Subject: [PATCH 1/2] pinctrl: qcom: disable GPIO groups with no pins
Message-ID: <1498783339-749-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support sparse GPIO maps, pinctrl-msm client drivers can specify
that a given GPIO has a pin count of zero.  These GPIOs will be
considered "hidden".  Any attempt to claim the GPIO will fail, and they
will not be listed in debugfs.

However, when the driver probes, it calls gpiochip_add_data() which
wants to initialize the direction of all the GPIOs, even the ones that
are unavailable.  Therefore, msm_gpio_get_direction() checks to make
sure the pin is available.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 273badd..e915db4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -165,7 +165,22 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+/*
+ * Request a GPIO. If the number of pins for this GPIO group is zero,
+ * then assume that the GPIO is unavailable.
+ */
+static int msm_request(struct pinctrl_dev *pctldev, unsigned int offset)
+{
+	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct msm_pingroup *g;
+
+	g = &pctrl->soc->groups[offset];
+
+	return g->npins ? 0 : -ENODEV;
+}
+
 static const struct pinmux_ops msm_pinmux_ops = {
+	.request		= msm_request,
 	.get_functions_count	= msm_get_functions_count,
 	.get_function_name	= msm_get_function_name,
 	.get_function_groups	= msm_get_function_groups,
@@ -430,6 +445,14 @@ static int msm_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 	g = &pctrl->soc->groups[offset];
 
+	/*
+	 * If the GPIO is unavailable, just return error.  This is necessary
+	 * because the GPIO layer tries to initialize the direction of all
+	 * the GPIOs, even the ones that are unavailable.
+	 */
+	if (!g->npins)
+		return -ENODEV;
+
 	val = readl(pctrl->regs + g->ctl_reg);
 
 	/* 0 = output, 1 = input */
@@ -494,6 +517,11 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 	};
 
 	g = &pctrl->soc->groups[offset];
+
+	/* If the GPIO group has no pins, then don't show it. */
+	if (!g->npins)
+		return;
+
 	ctl_reg = readl(pctrl->regs + g->ctl_reg);
 
 	is_out = !!(ctl_reg & BIT(g->oe_bit));
@@ -503,7 +531,7 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 
 	seq_printf(s, " %-8s: %-3s %d", g->name, is_out ? "out" : "in", func);
 	seq_printf(s, " %dmA", msm_regval_to_drive(drive));
-	seq_printf(s, " %s", pulls[pull]);
+	seq_printf(s, " %s\n", pulls[pull]);
 }
 
 static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -511,10 +539,8 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	unsigned gpio = chip->base;
 	unsigned i;
 
-	for (i = 0; i < chip->ngpio; i++, gpio++) {
+	for (i = 0; i < chip->ngpio; i++, gpio++)
 		msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
-		seq_puts(s, "\n");
-	}
 }
 
 #else
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
