From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:05 +0200
Subject: [PATCH 15/33] rtc: imx dryice: Add missing clk_prepare
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-16-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

prepare the clock before enabling it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/rtc/rtc-imxdi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index d93a960..891cd6c 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -405,7 +405,7 @@ static int dryice_rtc_probe(struct platform_device *pdev)
 	imxdi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(imxdi->clk))
 		return PTR_ERR(imxdi->clk);
-	clk_enable(imxdi->clk);
+	clk_prepare_enable(imxdi->clk);
 
 	/*
 	 * Initialize dryice hardware
@@ -470,7 +470,7 @@ static int dryice_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 err:
-	clk_disable(imxdi->clk);
+	clk_disable_unprepare(imxdi->clk);
 	clk_put(imxdi->clk);
 
 	return rc;
@@ -487,7 +487,7 @@ static int __devexit dryice_rtc_remove(struct platform_device *pdev)
 
 	rtc_device_unregister(imxdi->rtc);
 
-	clk_disable(imxdi->clk);
+	clk_disable_unprepare(imxdi->clk);
 	clk_put(imxdi->clk);
 
 	return 0;
-- 
1.7.10
