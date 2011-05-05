From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  5 May 2011 12:22:19 +0200
Subject: [PATCH 4/6] rtc: stmp3xxx: fix crash on boot
In-Reply-To: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
References: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1304590941-11813-5-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f44f7f96a20 ("RTC: Initialize kernel state from RTC") caused a
crash using the mxs/stmp-rtc driver.

The reason is that rtc_device_register() calls rtc_read_alarm() after
that change, when the driver does not have all driver data set up yet.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/rtc/rtc-stmp3xxx.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 2f8f32e..d3937eb 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -172,6 +172,7 @@ static int stmp3xxx_rtc_remove(struct platform_device *pdev)
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
 	free_irq(rtc_data->irq_1msec, &pdev->dev);
 	rtc_device_unregister(rtc_data->rtc);
+	platform_set_drvdata(pdev, NULL);
 	iounmap(rtc_data->io);
 	kfree(rtc_data);
 
@@ -212,11 +213,14 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		goto out_remap;
 	}
 
+	platform_set_drvdata(pdev, rtc_data);
+
 	mxs_reset_block(rtc_data->io);
 	__mxs_clrl(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
 			rtc_data->io + STMP3XXX_RTC_PERSISTENT0);
+
 	rtc_data->rtc = rtc_device_register(pdev->name, &pdev->dev,
 				&stmp3xxx_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc_data->rtc)) {
@@ -240,8 +244,6 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		goto out_irq1;
 	}
 
-	platform_set_drvdata(pdev, rtc_data);
-
 	return 0;
 
 out_irq1:
@@ -251,6 +253,7 @@ out_irq_alarm:
 			rtc_data->io + STMP3XXX_RTC_CTRL);
 	rtc_device_unregister(rtc_data->rtc);
 out_remap:
+	platform_set_drvdata(pdev, NULL);
 	iounmap(rtc_data->io);
 out_free:
 	kfree(rtc_data);
-- 
1.7.2.5
