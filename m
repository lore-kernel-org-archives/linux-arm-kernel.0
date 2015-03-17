From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 17 Mar 2015 16:38:10 +0100
Subject: [PATCH] rtc: at91rm9200: double locking bug in at91_rtc_interrupt()
In-Reply-To: <20150315104837.GC20691@mwanda>
References: <20150315104837.GC20691@mwanda>
Message-ID: <1426606690-18947-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dan Carpenter <dan.carpenter@oracle.com>

There is a typo here so we deadlock.

Fixes: dd1f1f391dd7 ('rtc: at91rm9200: rework wakeup and interrupt handling')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-also-by: David Dueck <davidcdueck@googlemail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi Andrew,

Can you please take care of this fix for 4.0?
If you fee that I'd better take it myself please tell me.

Thanks, bye.

 drivers/rtc/rtc-at91rm9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index b4f7744f6751..b283a1a573b3 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -324,7 +324,7 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
 
 		ret = IRQ_HANDLED;
 	}
-	spin_lock(&suspended_lock);
+	spin_unlock(&suspended_lock);
 
 	return ret;
 }
-- 
2.1.3
