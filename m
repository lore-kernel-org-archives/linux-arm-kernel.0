From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 15 Dec 2014 17:15:51 +0100
Subject: [PATCH 4/5] rtc: at91: request IRQs with IRQF_SUSPEND_NOACTION
In-Reply-To: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1418660152-17185-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ line connected to RTC blocks are often shared with a timer device
which request the IRQ with IRQF_NO_SUSPEND.
Since the RTC drivers are correctly disabling IRQs when entering suspend
we can safely request the IRQ with IRQF_SUSPEND_NOACTION so that irq core
can suspend this specific handler.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/rtc/rtc-at91rm9200.c | 2 +-
 drivers/rtc/rtc-at91sam9.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 70a5d94..0ed504f 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -401,7 +401,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 					AT91_RTC_CALEV);
 
 	ret = devm_request_irq(&pdev->dev, irq, at91_rtc_interrupt,
-				IRQF_SHARED,
+				IRQF_SHARED | IRQF_SUSPEND_NOACTION,
 				"at91_rtc", pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ %d already in use.\n", irq);
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 6b9aaf1..e7f8eed 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -421,7 +421,8 @@ static int at91_rtc_probe(struct platform_device *pdev)
 
 	/* register irq handler after we know what name we'll use */
 	ret = devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
-				IRQF_SHARED, dev_name(&rtc->rtcdev->dev), rtc);
+				IRQF_SHARED | IRQF_SUSPEND_NOACTION,
+				dev_name(&rtc->rtcdev->dev), rtc);
 	if (ret) {
 		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", rtc->irq);
 		return ret;
-- 
1.9.1
