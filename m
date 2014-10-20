From: dianders@chromium.org (Doug Anderson)
Date: Mon, 20 Oct 2014 16:27:49 -0700
Subject: [PATCH 3/4] pinctrl: rockchip: Parse pin groups before calling
 pinctrl_register()
In-Reply-To: <1413847670-12245-1-git-send-email-dianders@chromium.org>
References: <1413847670-12245-1-git-send-email-dianders@chromium.org>
Message-ID: <1413847670-12245-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like in (529301c pinctrl: samsung: Parse pin groups before
calling pinctrl_register()), Rockchip also needs to parse pin groups
earlier to make hogs work.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 65efb88..14a5683 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1263,6 +1263,10 @@ static int rockchip_pinctrl_register(struct platform_device *pdev,
 		}
 	}
 
+	ret = rockchip_pinctrl_parse_dt(pdev, info);
+	if (ret)
+		return ret;
+
 	info->pctl_dev = pinctrl_register(ctrldesc, &pdev->dev, info);
 	if (!info->pctl_dev) {
 		dev_err(&pdev->dev, "could not register pinctrl driver\n");
@@ -1280,12 +1284,6 @@ static int rockchip_pinctrl_register(struct platform_device *pdev,
 		pinctrl_add_gpio_range(info->pctl_dev, &pin_bank->grange);
 	}
 
-	ret = rockchip_pinctrl_parse_dt(pdev, info);
-	if (ret) {
-		pinctrl_unregister(info->pctl_dev);
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.1.0.rc2.206.gedb03e5
