From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 15:45:29 +0000
Subject: [PATCH 2/2] pinctrl: nomadik: Allow prcm_base to be extracted from
 Device Tree
In-Reply-To: <1357919129-1928-1-git-send-email-lee.jones@linaro.org>
References: <1357919129-1928-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357919129-1928-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik Pinctrl driver requires access to some PRCMU registers
in order to run with full functionality. When Device Tree is
disabled the required PRCMU base address is passed in via platform
data, so in order for Device Tree booting to be as functional, we
need a similar mechanism to fetch it from Device Tree.

The new semantics goes like this: Parse the Device Tree and look
for the PRCMU node using a provided Phandle. Obtain the ioremaped
address from that node. If one was supplied via platform data
over-write it with anything found in Device Tree. Fail if either
the prcm_base can't be found if we're running on anything other
than an STN8815 ASIC.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 292c909..4954302 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -25,6 +25,7 @@
 #include <linux/irqdomain.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
@@ -1856,6 +1857,7 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *prcm_np;
 	struct nmk_pinctrl *npct;
 	struct resource *res;
 	unsigned int version = 0;
@@ -1884,21 +1886,26 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	if (version == PINCTRL_NMK_DB8540)
 		nmk_pinctrl_db8540_init(&npct->soc);
 
+	if (np) {
+		prcm_np = of_parse_phandle(np, "prcm", 0);
+		if (prcm_np)
+			npct->prcm_base = of_iomap(prcm_np, 0);
+	}
+
+	/* Allow platform passed information to over-write DT. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res) {
+	if (res)
 		npct->prcm_base = devm_ioremap(&pdev->dev, res->start,
 					       resource_size(res));
-		if (!npct->prcm_base) {
-			dev_err(&pdev->dev,
-				"failed to ioremap PRCM registers\n");
-			return -ENOMEM;
+	if (!npct->prcm_base) {
+		if (version == PINCTRL_NMK_STN8815) {
+			dev_info(&pdev->dev,
+				 "No PRCM base, "
+				 "assuming no ALT-Cx control is available\n");
+		} else {
+			dev_err(&pdev->dev, "missing PRCM base address\n");
+			return -EINVAL;
 		}
-	} else if (version == PINCTRL_NMK_STN8815) {
-		dev_info(&pdev->dev,
-			 "No PRCM base, assume no ALT-Cx control is available\n");
-	} else {
-		dev_err(&pdev->dev, "missing PRCM base address\n");
-		return -EINVAL;
 	}
 
 	/*
-- 
1.7.9.5
