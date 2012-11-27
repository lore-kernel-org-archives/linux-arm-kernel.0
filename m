From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 27 Nov 2012 14:18:14 +0530
Subject: [PATCH v5 09/12] pwm: pwm-tiehrpwm: pinctrl support
In-Reply-To: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1354006097-25895-10-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for pwm-tiehrpwm if pinctrl driver available, else
bail out with warning message.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
Changes since v4:
	- Changes warning message.

 drivers/pwm/pwm-tiehrpwm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index d3194c0..e8683bc 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "pwm-tipwmss.h"
 
@@ -415,6 +416,11 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct ehrpwm_pwm_chip *pc;
 	u16 status;
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "unable to select pin group\n");
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc) {
-- 
1.7.0.4
