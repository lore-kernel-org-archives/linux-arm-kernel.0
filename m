From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 17 Jul 2017 18:44:00 -0500
Subject: [PATCH 2/3] [v2] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <1500335041-32711-1-git-send-email-timur@codeaurora.org>
References: <1500335041-32711-1-git-send-email-timur@codeaurora.org>
Message-ID: <1500335041-32711-3-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support sparse GPIO maps, pinctrl-msm client drivers can specify
that a given GPIO has a pin count of zero.  These GPIOs will be
considered "hidden".  Any attempt to claim the GPIO will fail, and they
will not be listed in debugfs.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 273badd..d0f09a3 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -494,6 +494,11 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 	};
 
 	g = &pctrl->soc->groups[offset];
+
+	/* If the GPIO group has no pins, then don't show it. */
+	if (!g->npins)
+		return;
+
 	ctl_reg = readl(pctrl->regs + g->ctl_reg);
 
 	is_out = !!(ctl_reg & BIT(g->oe_bit));
@@ -503,7 +508,7 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 
 	seq_printf(s, " %-8s: %-3s %d", g->name, is_out ? "out" : "in", func);
 	seq_printf(s, " %dmA", msm_regval_to_drive(drive));
-	seq_printf(s, " %s", pulls[pull]);
+	seq_printf(s, " %s\n", pulls[pull]);
 }
 
 static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -511,23 +516,30 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
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
 
+/* If the GPIO has no pins, then treat it as unavailable. */
+static int msm_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct msm_pingroup *g = &pctrl->soc->groups[offset];
+
+	return g->npins ? 0 : -ENODEV;
+}
+
 static struct gpio_chip msm_gpio_template = {
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
