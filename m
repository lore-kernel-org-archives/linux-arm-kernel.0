From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu,  8 Oct 2015 23:34:29 +0200
Subject: [PATCH 1/6] watchdog: at91sam9: use devm_request_irq instead of
 request_irq
In-Reply-To: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1444340074-15437-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

free_irq was missing in the module remove function, fix it by using
devm_request_irq instead of request_irq.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/watchdog/at91sam9_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 434353a..88f56b5 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -209,7 +209,7 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 			 "min heartbeat and max heartbeat might be too close for the system to handle it correctly\n");
 
 	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
-		err = request_irq(wdt->irq, wdt_interrupt,
+		err = devm_request_irq(&pdev->dev, wdt->irq, wdt_interrupt,
 				  IRQF_SHARED | IRQF_IRQPOLL |
 				  IRQF_NO_SUSPEND,
 				  pdev->name, wdt);
-- 
2.5.1
