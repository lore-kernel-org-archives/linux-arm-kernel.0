From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 16:58:11 +0800
Subject: [PATCH 4/4] pwm: pwm-mxs: add pinctrl support
In-Reply-To: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
References: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340701091-8488-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call pinctrl subsystem to set up pwm pin.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/pwm-mxs.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index bbda509..dd25975 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
@@ -130,6 +131,7 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct mxs_pwm_chip *mxs;
 	struct resource *res;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
@@ -141,6 +143,10 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	if (!mxs->base)
 		return -EADDRNOTAVAIL;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		return PTR_ERR(pinctrl);
+
 	mxs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mxs->clk))
 		return PTR_ERR(mxs->clk);
-- 
1.7.5.4
