From: balbi@ti.com (Felipe Balbi)
Date: Fri, 14 Dec 2012 18:34:05 +0200
Subject: [PATCH REBASE 2/6] i2c: omap: also complete() when stat becomes zero
In-Reply-To: <1355502849-9289-1-git-send-email-balbi@ti.com>
References: <1355502849-9289-1-git-send-email-balbi@ti.com>
Message-ID: <1355502849-9289-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case we loop on IRQ handler until stat is
finally zero, we would end up in a situation
where all I2C transfers would misteriously
timeout because we were not calling complete()
in that situation.

Fix the issue by moving omap_i2c_complete_cmd()
call inside the 'out' label.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9a9cf7c..fcecb0b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1022,9 +1022,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		}
 	} while (stat);
 
-	omap_i2c_complete_cmd(dev, err);
-
 out:
+	omap_i2c_complete_cmd(dev, err);
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	return IRQ_HANDLED;
-- 
1.8.1.rc1.5.g7e0651a
