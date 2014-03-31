From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 31 Mar 2014 14:49:55 -0700
Subject: [PATCH 2/4] pinctrl: msm: Make number of functions variable
Message-ID: <1396302597-31801-2-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The various pins may have different number of functions defined, so make this
number definable per pin instead of just increasing it to the largest one for
all of the platforms.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/pinctrl/pinctrl-msm.c     | 4 ++--
 drivers/pinctrl/pinctrl-msm.h     | 3 ++-
 drivers/pinctrl/pinctrl-msm8x74.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-msm.c b/drivers/pinctrl/pinctrl-msm.c
index 706809e..7d67d34 100644
--- a/drivers/pinctrl/pinctrl-msm.c
+++ b/drivers/pinctrl/pinctrl-msm.c
@@ -145,12 +145,12 @@ static int msm_pinmux_enable(struct pinctrl_dev *pctldev,
 	if (WARN_ON(g->mux_bit < 0))
 		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(g->funcs); i++) {
+	for (i = 0; i < g->nfuncs; i++) {
 		if (g->funcs[i] == function)
 			break;
 	}
 
-	if (WARN_ON(i == ARRAY_SIZE(g->funcs)))
+	if (WARN_ON(i == g->nfuncs))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pctrl->lock, flags);
diff --git a/drivers/pinctrl/pinctrl-msm.h b/drivers/pinctrl/pinctrl-msm.h
index 6e26f1b..7b2a227 100644
--- a/drivers/pinctrl/pinctrl-msm.h
+++ b/drivers/pinctrl/pinctrl-msm.h
@@ -65,7 +65,8 @@ struct msm_pingroup {
 	const unsigned *pins;
 	unsigned npins;
 
-	unsigned funcs[8];
+	unsigned *funcs;
+	unsigned nfuncs;
 
 	s16 ctl_reg;
 	s16 io_reg;
diff --git a/drivers/pinctrl/pinctrl-msm8x74.c b/drivers/pinctrl/pinctrl-msm8x74.c
index dde5529..57766d5 100644
--- a/drivers/pinctrl/pinctrl-msm8x74.c
+++ b/drivers/pinctrl/pinctrl-msm8x74.c
@@ -341,7 +341,7 @@ static const unsigned int sdc2_data_pins[] = { 151 };
 		.name = "gpio" #id,			\
 		.pins = gpio##id##_pins,		\
 		.npins = ARRAY_SIZE(gpio##id##_pins),	\
-		.funcs = {				\
+		.funcs = (int[]){			\
 			MSM_MUX_NA, /* gpio mode */	\
 			MSM_MUX_##f1,			\
 			MSM_MUX_##f2,			\
@@ -351,6 +351,7 @@ static const unsigned int sdc2_data_pins[] = { 151 };
 			MSM_MUX_##f6,			\
 			MSM_MUX_##f7			\
 		},					\
+		.nfuncs = 8,				\
 		.ctl_reg = 0x1000 + 0x10 * id,		\
 		.io_reg = 0x1004 + 0x10 * id,		\
 		.intr_cfg_reg = 0x1008 + 0x10 * id,	\
-- 
1.8.2.2
