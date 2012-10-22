From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Oct 2012 12:46:54 +0300
Subject: [PATCH 4/8] i2c: omap: also complete() when stat becomes zero
In-Reply-To: <1350899218-13624-1-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Message-ID: <1350899218-13624-5-git-send-email-balbi@ti.com>
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
index e0eab38..6219522 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1021,9 +1021,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		}
 	} while (stat);
 
-	omap_i2c_complete_cmd(dev, err);
-
 out:
+	omap_i2c_complete_cmd(dev, err);
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	return IRQ_HANDLED;
-- 
1.8.0.rc0
