From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 Jan 2014 01:39:19 +0100
Subject: [PATCH v2 07/21] pinctrl: mvebu: move generic group name generation
In-Reply-To: <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390869573-27624-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MVEBU SoC pinctrl allows SoC specific drivers to pass a range of mpp
pins without a corresponding name. Each pin in this range is then
translated into a single-pin group with an auto-generated name. To allow
some redesign of the driver, move name generation for those pin ranges
down to where the groups are created.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/pinctrl/mvebu/pinctrl-mvebu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index 90c35b20a7af..375666b0abc3 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -631,7 +631,6 @@ int mvebu_pinctrl_probe(struct platform_device *pdev, void __iomem *base)
 	pctl->desc.npins = 0;
 	for (n = 0; n < soc->ncontrols; n++) {
 		struct mvebu_mpp_ctrl *ctrl = &soc->controls[n];
-		char *names;
 
 		pctl->desc.npins += ctrl->npins;
 		/* initial control pins */
@@ -649,14 +648,6 @@ int mvebu_pinctrl_probe(struct platform_device *pdev, void __iomem *base)
 		}
 
 		/* generic mvebu register control */
-		names = devm_kzalloc(&pdev->dev, ctrl->npins * 8, GFP_KERNEL);
-		if (!names) {
-			dev_err(&pdev->dev, "failed to alloc mpp names\n");
-			return -ENOMEM;
-		}
-		for (k = 0; k < ctrl->npins; k++)
-			sprintf(names + 8*k, "mpp%d", ctrl->pid+k);
-		ctrl->name = names;
 		pctl->num_groups += ctrl->npins;
 	}
 
@@ -689,7 +680,18 @@ int mvebu_pinctrl_probe(struct platform_device *pdev, void __iomem *base)
 		pctl->groups[gid].npins = ctrl->npins;
 
 		/* generic mvebu register control maps to a number of groups */
-		if (!ctrl->mpp_get && !ctrl->mpp_set) {
+		if (!ctrl->name) {
+			char *names = devm_kzalloc(&pdev->dev,
+						   ctrl->npins * 8, GFP_KERNEL);
+			if (!names) {
+				dev_err(&pdev->dev, "failed to alloc mpp names\n");
+				return -ENOMEM;
+			}
+			for (k = 0; k < ctrl->npins; k++)
+				sprintf(names + 8*k, "mpp%d", ctrl->pid+k);
+			ctrl->name = names;
+
+			pctl->groups[gid].name = &ctrl->name[0];
 			pctl->groups[gid].npins = 1;
 
 			for (k = 1; k < ctrl->npins; k++) {
-- 
1.8.5.2
