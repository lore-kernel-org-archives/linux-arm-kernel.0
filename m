From: agross@codeaurora.org (Andy Gross)
Date: Thu, 18 Dec 2014 14:59:52 -0600
Subject: [PATCH 1/4] pinctrl: qcom: Add multiple copy base support
In-Reply-To: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
References: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
Message-ID: <1418936395-14623-2-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Qualcomm pinctrl devices support functions that can be routed to multiple pins.
In some cases, there are additional mux registers that must be set for the pins
to work correctly.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c |   10 ++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h |    4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index e730935..17e2867 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -141,11 +141,13 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 {
 	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct msm_pingroup *g;
+	const struct msm_function *f;
 	unsigned long flags;
 	u32 val;
 	int i;
 
 	g = &pctrl->soc->groups[group];
+	f = &pctrl->soc->functions[function];
 
 	for (i = 0; i < g->nfuncs; i++) {
 		if (g->funcs[i] == function)
@@ -162,6 +164,14 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	val |= i << g->mux_bit;
 	writel(val, pctrl->regs + g->ctl_reg);
 
+	/*
+	 * if an alternate copy configuration is required, configure the pins to
+	 * steer the function to the correct set of pins.  This is used in cases
+	 * where we have more than one copy of the pins for a function
+	 */
+	if (f->requires_copy_select)
+		writel(f->copy_select_value, pctrl->regs + f->copy_select_reg);
+
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index b952c4b..7180587 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -25,6 +25,10 @@ struct msm_function {
 	const char *name;
 	const char * const *groups;
 	unsigned ngroups;
+
+	unsigned requires_copy_select;
+	unsigned copy_select_reg;
+	unsigned copy_select_value;
 };
 
 /**
-- 
Qualcomm Innovation Center, Inc
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
