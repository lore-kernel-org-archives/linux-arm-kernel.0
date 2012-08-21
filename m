From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 12:15:44 +0300
Subject: [RFC/PATCH 02/13] serial: omap: always return IRQ_HANDLED
In-Reply-To: <1345540555-24359-1-git-send-email-balbi@ti.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
Message-ID: <1345540555-24359-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if we enter our IRQ handler just to notice
that the our device didn't generate the IRQ,
that still means "handling" and IRQ, so let's
return IRQ_HANDLED.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 5c0d0bc..b4b95fc 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -417,7 +417,7 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	if (iir & UART_IIR_NO_INT) {
 		pm_runtime_mark_last_busy(&up->pdev->dev);
 		pm_runtime_put_autosuspend(&up->pdev->dev);
-		return IRQ_NONE;
+		return IRQ_HANDLED;
 	}
 
 	spin_lock_irqsave(&up->port.lock, flags);
-- 
1.7.12.rc3
