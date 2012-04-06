From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 6 Apr 2012 20:18:09 +0800
Subject: [PATCH 1/1] pinctrl: fix pinmux_check_ops error checking
Message-ID: <1333714689-22450-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Do not use get_functions_count before checking.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinmux.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 375b214..8849830 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -33,11 +33,12 @@
 int pinmux_check_ops(struct pinctrl_dev *pctldev)
 {
 	const struct pinmux_ops *ops = pctldev->desc->pmxops;
-	unsigned nfuncs = ops->get_functions_count(pctldev);
+	unsigned nfuncs;
 	unsigned selector = 0;
 
 	/* Check that we implement required operations */
-	if (!ops->get_functions_count ||
+	if (!ops ||
+	    !ops->get_functions_count ||
 	    !ops->get_function_name ||
 	    !ops->get_function_groups ||
 	    !ops->enable ||
@@ -45,11 +46,12 @@ int pinmux_check_ops(struct pinctrl_dev *pctldev)
 		return -EINVAL;
 
 	/* Check that all functions registered have names */
+	nfuncs = ops->get_functions_count(pctldev);
 	while (selector < nfuncs) {
 		const char *fname = ops->get_function_name(pctldev,
 							   selector);
 		if (!fname) {
-			pr_err("pinmux ops has no name for function%u\n",
+			dev_err(pctldev->dev, "pinmux ops has no name for function%u\n",
 				selector);
 			return -EINVAL;
 		}
-- 
1.7.0.4
