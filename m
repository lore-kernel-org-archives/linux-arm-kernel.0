From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu,  2 Oct 2014 20:52:07 +0200
Subject: [PATCH v2 1/5] pinctrl: samsung: Make samsung_pinctrl_get_soc_data
 use ERR_PTR()
In-Reply-To: <1412275931-10807-1-git-send-email-tomasz.figa@gmail.com>
References: <1412275931-10807-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1412275931-10807-2-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the function returns a valid pointer on success and NULL on
error, so exact error code is lost. This patch changes return convention
of the function to use ERR_PTR() on error instead.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 4a47691c32b1..0504f0b75de8 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -988,7 +988,7 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 	id = of_alias_get_id(node, "pinctrl");
 	if (id < 0) {
 		dev_err(&pdev->dev, "failed to get alias id\n");
-		return NULL;
+		return ERR_PTR(-ENOENT);
 	}
 	match = of_match_node(samsung_pinctrl_dt_match, node);
 	ctrl = (struct samsung_pin_ctrl *)match->data + id;
@@ -1040,9 +1040,9 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	ctrl = samsung_pinctrl_get_soc_data(drvdata, pdev);
-	if (!ctrl) {
+	if (IS_ERR(ctrl)) {
 		dev_err(&pdev->dev, "driver data not available\n");
-		return -EINVAL;
+		return PTR_ERR(ctrl);
 	}
 	drvdata->ctrl = ctrl;
 	drvdata->dev = dev;
-- 
2.1.1
