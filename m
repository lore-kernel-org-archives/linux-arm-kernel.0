From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  7 Jul 2012 17:47:20 -0300
Subject: [PATCH 2/3] rtc: rtc-mxc: Adapt to the new i.mx clock framework
In-Reply-To: <1341694041-7839-1-git-send-email-festevam@gmail.com>
References: <1341694041-7839-1-git-send-email-festevam@gmail.com>
Message-ID: <1341694041-7839-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/rtc/rtc-mxc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index e3e50d6..5d8456a 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -367,14 +367,14 @@ static int __init mxc_rtc_probe(struct platform_device *pdev)
 	pdata->ioaddr = devm_ioremap(&pdev->dev, res->start,
 				     resource_size(res));
 
-	pdata->clk = clk_get(&pdev->dev, "rtc");
+	pdata->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pdata->clk)) {
 		dev_err(&pdev->dev, "unable to get clock!\n");
 		ret = PTR_ERR(pdata->clk);
 		goto exit_free_pdata;
 	}
 
-	clk_enable(pdata->clk);
+	clk_prepare_enable(pdata->clk);
 	rate = clk_get_rate(pdata->clk);
 
 	if (rate == 32768)
@@ -426,7 +426,7 @@ static int __init mxc_rtc_probe(struct platform_device *pdev)
 exit_clr_drvdata:
 	platform_set_drvdata(pdev, NULL);
 exit_put_clk:
-	clk_disable(pdata->clk);
+	clk_disable_unprepare(pdata->clk);
 	clk_put(pdata->clk);
 
 exit_free_pdata:
@@ -440,7 +440,7 @@ static int __exit mxc_rtc_remove(struct platform_device *pdev)
 
 	rtc_device_unregister(pdata->rtc);
 
-	clk_disable(pdata->clk);
+	clk_disable_unprepare(pdata->clk);
 	clk_put(pdata->clk);
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.7.1
