From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:34 -0700
Subject: [PATCH v5 21/23] usb: chipidea: msm: Be silent on probe defer errors
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-22-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If something fails in ci_hdrc_add_device() due to probe defer, we
shouldn't print an error message. Be silent in this case as we'll
try probe again later.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 316044dba0ac..f1ede7909f54 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -262,8 +262,9 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
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
2.10.0.297.gf6727b0
