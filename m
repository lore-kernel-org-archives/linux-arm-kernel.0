From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 31 May 2013 14:44:54 -0700
Subject: [PATCH] mfd: twl4030: allow IRQ wake enable to succeed on subchip IRQs
Message-ID: <1370036694-26210-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The genirq IRQ wake method will default to failure if the irq_chip
does not provide a set_wake method.  However, for TWL4030 sub-chip
IRQs, we want the wake enable to succeed even though we don't provide
a set_wake method.  This allows sub-chip IRQs to still be flagged as
wakeup capable, and allow them to wakeup from suspend (or abort
suspend if they fire during suspend.)

To fix, use the IRQCHIP_SKIP_SET_WAKE flag in the irq_chip.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/mfd/twl4030-irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index a5f9888..3fa7df2 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -573,6 +573,7 @@ static struct irq_chip twl4030_sih_irq_chip = {
 	.irq_set_type	= twl4030_sih_set_type,
 	.irq_bus_lock	= twl4030_sih_bus_lock,
 	.irq_bus_sync_unlock = twl4030_sih_bus_sync_unlock,
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
 /*----------------------------------------------------------------------*/
-- 
1.8.2
