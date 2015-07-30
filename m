From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:24:31 +0200
Subject: [PATCH 4/5] rtc: at91sam9: get sclk rate after enabling it
In-Reply-To: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215872-27794-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See help for clk_get_rate(): "obtain the current clock rate (in Hz) for a
clock source. This is only valid once the clock source has been enabled."

It currently returns the correct value but that may not stay that way.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 23f721d049b2..f9e85ace5e71 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -425,18 +425,19 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->sclk))
 		return PTR_ERR(rtc->sclk);
 
-	sclk_rate = clk_get_rate(rtc->sclk);
-	if (!sclk_rate || sclk_rate > AT91_RTT_RTPRES) {
-		dev_err(&pdev->dev, "Invalid slow clock rate\n");
-		return -EINVAL;
-	}
-
 	ret = clk_prepare_enable(rtc->sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
 	}
 
+	sclk_rate = clk_get_rate(rtc->sclk);
+	if (!sclk_rate || sclk_rate > AT91_RTT_RTPRES) {
+		dev_err(&pdev->dev, "Invalid slow clock rate\n");
+		ret = -EINVAL;
+		goto err_clk;
+	}
+
 	mr = rtt_readl(rtc, MR);
 
 	/* unless RTT is counting at 1 Hz, re-initialize it */
-- 
2.1.4
