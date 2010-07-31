From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 31 Jul 2010 06:22:27 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
Message-ID: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wakealarm capability was incorrectly set after the RTC was registered, which
resulted into the sysfs node not being created.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/rtc/rtc-pxa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index e9c6fa0..d76f187 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -403,6 +403,8 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 
 	rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
 
+	device_init_wakeup(dev, 1);
+
 	pxa_rtc->rtc = rtc_device_register("pxa-rtc", &pdev->dev, &pxa_rtc_ops,
 					   THIS_MODULE);
 	ret = PTR_ERR(pxa_rtc->rtc);
@@ -411,8 +413,6 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		goto err_rtc_reg;
 	}
 
-	device_init_wakeup(dev, 1);
-
 	return 0;
 
 err_rtc_reg:
-- 
1.7.1
