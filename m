From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 17 Feb 2013 19:42:54 +0800
Subject: [PATCH v9 08/10] pinctrl: single: set function mask as optional
In-Reply-To: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361101376-3783-9-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Hisilicon's pin controller is divided into two parts. One is the
function mux, and the other is pin configuration. These two parts are
in the different memory regions. So make pinctrl-single,function-mask
as optional property. Then we can define pingroups without valid
function mux that is only used for pin configuration.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinctrl-single.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 8b9dd95..fe8f321 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -350,6 +350,9 @@ static int pcs_enable(struct pinctrl_dev *pctldev, unsigned fselector,
 	int i;
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
+	/* If function mask is null, needn't enable it. */
+	if (!pcs->fmask)
+		return 0;
 	func = radix_tree_lookup(&pcs->ftree, fselector);
 	if (!func)
 		return -EINVAL;
@@ -384,6 +387,10 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
 	int i;
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
+	/* If function mask is null, needn't disable it. */
+	if (!pcs->fmask)
+		return;
+
 	func = radix_tree_lookup(&pcs->ftree, fselector);
 	if (!func) {
 		dev_err(pcs->dev, "%s could not find function%i\n",
@@ -427,6 +434,10 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 	int mux_bytes = 0;
 	unsigned data;
 
+	/* If function mask is null, return directly. */
+	if (!pcs->fmask)
+		return -ENOTSUPP;
+
 	list_for_each_safe(pos, tmp, &pcs->gpiofuncs) {
 		frange = list_entry(pos, struct pcs_gpiofunc_range, node);
 		if (pin >= frange->offset + frange->npins
@@ -969,10 +980,17 @@ static int pcs_probe(struct platform_device *pdev)
 	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
 			 "register width not specified\n");
 
-	PCS_GET_PROP_U32("pinctrl-single,function-mask", &pcs->fmask,
-			 "function register mask not specified\n");
-	pcs->fshift = ffs(pcs->fmask) - 1;
-	pcs->fmax = pcs->fmask >> pcs->fshift;
+	ret = of_property_read_u32(np, "pinctrl-single,function-mask",
+				   &pcs->fmask);
+	if (!ret) {
+		pcs->fshift = ffs(pcs->fmask) - 1;
+		pcs->fmax = pcs->fmask >> pcs->fshift;
+	} else {
+		/* If mask property doesn't exist, function mux is invalid. */
+		pcs->fmask = 0;
+		pcs->fshift = 0;
+		pcs->fmax = 0;
+	}
 
 	ret = of_property_read_u32(np, "pinctrl-single,function-off",
 					&pcs->foff);
-- 
1.7.10.4
