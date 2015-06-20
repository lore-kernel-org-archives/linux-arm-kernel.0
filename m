From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 20 Jun 2015 19:12:37 +0200
Subject: [PATCH v3 3/6] rtc: mxc: use a second rtc clock
In-Reply-To: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
References: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
Message-ID: <1434820360-21935-4-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc RTC needs two clocks, one for the input
reference, and one for the IP. But this driver
was only using one clock (for the reference).
This patch add the second clock (for the IP).

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/rtc/rtc-mxc.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 09d422b..e916a91 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -79,7 +79,8 @@ struct rtc_plat_data {
 	struct rtc_device *rtc;
 	void __iomem *ioaddr;
 	int irq;
-	struct clk *clk;
+	struct clk *clk_rtc;
+	struct clk *clk_ipg;
 	struct rtc_time g_rtc_alarm;
 	enum imx_rtc_type devtype;
 };
@@ -373,17 +374,24 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata->ioaddr))
 		return PTR_ERR(pdata->ioaddr);
 
-	pdata->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pdata->clk)) {
-		dev_err(&pdev->dev, "unable to get clock!\n");
-		return PTR_ERR(pdata->clk);
+	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(pdata->clk_ipg)) {
+		dev_err(&pdev->dev, "unable to get ipg clock!\n");
+		return PTR_ERR(pdata->clk_ipg);
 	}
 
-	ret = clk_prepare_enable(pdata->clk);
+	ret = clk_prepare_enable(pdata->clk_ipg);
 	if (ret)
 		return ret;
 
-	rate = clk_get_rate(pdata->clk);
+	pdata->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
+	if (IS_ERR(pdata->clk_rtc)) {
+		dev_err(&pdev->dev, "unable to get rtc clock!\n");
+		ret = PTR_ERR(pdata->clk_rtc);
+		goto exit_put_clk;
+	}
+
+	rate = clk_get_rate(pdata->clk_rtc);
 
 	if (rate == 32768)
 		reg = RTC_INPUT_CLK_32768HZ;
@@ -432,7 +440,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 exit_put_clk:
-	clk_disable_unprepare(pdata->clk);
+	clk_disable_unprepare(pdata->clk_ipg);
 
 	return ret;
 }
@@ -441,7 +449,7 @@ static int mxc_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(pdata->clk);
+	clk_disable_unprepare(pdata->clk_ipg);
 
 	return 0;
 }
-- 
1.7.4.4
