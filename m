From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:36 -0700
Subject: [PATCH 19/21] usb: chipidea: msm: Be silent on probe defer errors
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <20160626072838.28082-20-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If something fails in ci_hdrc_add_device() due to probe defer, we
shouldn't print an error message. Be silent in this case as we'll
try probe again later.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 7d191928e55b..2ed9a181f4b6 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -241,7 +241,8 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
 				     pdev->num_resources, &ci->pdata);
 	if (IS_ERR(plat_ci)) {
-		dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
+		if (PTR_ERR(plat_ci) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
 		ret = PTR_ERR(plat_ci);
 		goto err_mux;
 	}
-- 
2.9.0.rc2.8.ga28705d
