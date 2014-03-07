From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  6 Mar 2014 22:44:46 -0800
Subject: [PATCH 7/7] pinctrl: msm: Simplify msm_config_reg() and callers
In-Reply-To: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
References: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1394174686-8358-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to check for a negative reg here because reg is
always the same and is always non-negative. Also, collapse the
switch statement down for the duplicate cases.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/pinctrl-msm.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-msm.c b/drivers/pinctrl/pinctrl-msm.c
index bdfb697194f6..534dd117dab4 100644
--- a/drivers/pinctrl/pinctrl-msm.c
+++ b/drivers/pinctrl/pinctrl-msm.c
@@ -202,28 +202,17 @@ static const struct pinmux_ops msm_pinmux_ops = {
 static int msm_config_reg(struct msm_pinctrl *pctrl,
 			  const struct msm_pingroup *g,
 			  unsigned param,
-			  s16 *reg,
 			  unsigned *mask,
 			  unsigned *bit)
 {
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		*reg = g->ctl_reg;
-		*bit = g->pull_bit;
-		*mask = 3;
-		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		*reg = g->ctl_reg;
-		*bit = g->pull_bit;
-		*mask = 3;
-		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		*reg = g->ctl_reg;
 		*bit = g->pull_bit;
 		*mask = 3;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		*reg = g->ctl_reg;
 		*bit = g->drv_bit;
 		*mask = 7;
 		break;
@@ -232,12 +221,6 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
 		return -ENOTSUPP;
 	}
 
-	if (*reg < 0) {
-		dev_err(pctrl->dev, "Config param %04x not supported on group %s\n",
-			param, g->name);
-		return -ENOTSUPP;
-	}
-
 	return 0;
 }
 
@@ -275,17 +258,16 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
 	unsigned mask;
 	unsigned arg;
 	unsigned bit;
-	s16 reg;
 	int ret;
 	u32 val;
 
 	g = &pctrl->soc->groups[group];
 
-	ret = msm_config_reg(pctrl, g, param, &reg, &mask, &bit);
+	ret = msm_config_reg(pctrl, g, param, &mask, &bit);
 	if (ret < 0)
 		return ret;
 
-	val = readl(pctrl->regs + reg);
+	val = readl(pctrl->regs + g->ctl_reg);
 	arg = (val >> bit) & mask;
 
 	/* Convert register value to pinconf value */
@@ -325,7 +307,6 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 	unsigned mask;
 	unsigned arg;
 	unsigned bit;
-	s16 reg;
 	int ret;
 	u32 val;
 	int i;
@@ -336,7 +317,7 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
-		ret = msm_config_reg(pctrl, g, param, &reg, &mask, &bit);
+		ret = msm_config_reg(pctrl, g, param, &mask, &bit);
 		if (ret < 0)
 			return ret;
 
@@ -371,10 +352,10 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 		}
 
 		spin_lock_irqsave(&pctrl->lock, flags);
-		val = readl(pctrl->regs + reg);
+		val = readl(pctrl->regs + g->ctl_reg);
 		val &= ~(mask << bit);
 		val |= arg << bit;
-		writel(val, pctrl->regs + reg);
+		writel(val, pctrl->regs + g->ctl_reg);
 		spin_unlock_irqrestore(&pctrl->lock, flags);
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
