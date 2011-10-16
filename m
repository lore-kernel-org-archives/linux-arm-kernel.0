From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 21:50:54 +0200
Subject: [PATCH 4/8] ARM: rtc/at91sam9: use ioremap and iounmap
In-Reply-To: <20111016194504.GK1459@game.jcrosoft.org>
References: <20111016194504.GK1459@game.jcrosoft.org>
Message-ID: <1318794658-27907-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/rtc-at91sam9.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index a3ad957..0c4b183 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -307,8 +307,12 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 1);
 
 	platform_set_drvdata(pdev, rtc);
-	rtc->rtt = (void __force __iomem *) (AT91_VA_BASE_SYS - AT91_BASE_SYS);
-	rtc->rtt += r->start;
+	rtc->rtt = ioremap(r->start, resource_size(r));
+	if (!rtc->rtt) {
+		dev_err(&pdev->dev, "failed to map registers, aborting.\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	mr = rtt_readl(rtc, MR);
 
@@ -371,6 +375,7 @@ static int __exit at91_rtc_remove(struct platform_device *pdev)
 
 	rtc_device_unregister(rtc->rtcdev);
 
+	iounmap(rtc->rtt);
 	platform_set_drvdata(pdev, NULL);
 	kfree(rtc);
 	return 0;
-- 
1.7.7
