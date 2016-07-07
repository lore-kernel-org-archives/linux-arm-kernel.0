From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu,  7 Jul 2016 15:21:11 -0700
Subject: [PATCH v2 20/22] usb: chipidea: msm: Be silent on probe defer errors
In-Reply-To: <20160707222114.1673-1-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
Message-ID: <20160707222114.1673-21-stephen.boyd@linaro.org>
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
index 5c486c15e043..d4cc45f8e65e 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -257,8 +257,9 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
 				     pdev->num_resources, &ci->pdata);
 	if (IS_ERR(plat_ci)) {
-		dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
 		ret = PTR_ERR(plat_ci);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
 		goto err_mux;
 	}
 
-- 
2.9.0.rc2.8.ga28705d
