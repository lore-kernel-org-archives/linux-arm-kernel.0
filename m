From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 13 May 2012 23:19:01 +0800
Subject: [PATCH 2/2] pinctrl: mxs: skip gpio nodes for group creation
In-Reply-To: <1336922341-7089-1-git-send-email-shawn.guo@linaro.org>
References: <1336922341-7089-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336922341-7089-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent added mxs gpio device tree bindings require gpio nodes
defined under pinctrl node too.  The pinctrl-mxs driver should skip
these node for group parsing and creating.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pinctrl/pinctrl-mxs.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c
index 787ae7b..ab63d38 100644
--- a/drivers/pinctrl/pinctrl-mxs.c
+++ b/drivers/pinctrl/pinctrl-mxs.c
@@ -393,6 +393,7 @@ static int __devinit mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *child;
 	struct mxs_function *f;
+	const char *gpio_compat = "fsl,mxs-gpio";
 	const char *fn, *fnull = "";
 	int i = 0, idxf = 0, idxg = 0;
 	int ret;
@@ -407,6 +408,8 @@ static int __devinit mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	/* Count total functions and groups */
 	fn = fnull;
 	for_each_child_of_node(np, child) {
+		if (of_device_is_compatible(child, gpio_compat))
+			continue;
 		soc->ngroups++;
 		/* Skip pure pinconf node */
 		if (of_property_read_u32(child, "reg", &val))
@@ -431,6 +434,8 @@ static int __devinit mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	fn = fnull;
 	f = &soc->functions[idxf];
 	for_each_child_of_node(np, child) {
+		if (of_device_is_compatible(child, gpio_compat))
+			continue;
 		if (of_property_read_u32(child, "reg", &val))
 			continue;
 		if (strcmp(fn, child->name)) {
@@ -444,6 +449,8 @@ static int __devinit mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	idxf = 0;
 	fn = fnull;
 	for_each_child_of_node(np, child) {
+		if (of_device_is_compatible(child, gpio_compat))
+			continue;
 		if (of_property_read_u32(child, "reg", &val)) {
 			ret = mxs_pinctrl_parse_group(pdev, child,
 						      idxg++, NULL);
-- 
1.7.5.4
