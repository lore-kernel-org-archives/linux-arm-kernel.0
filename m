From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 14 Aug 2015 15:20:29 +0300
Subject: [PATCH v3 5/6] irqchip: crossbar: fix irq masking at suspend
In-Reply-To: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
References: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1439554830-19502-6-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All ARM GIC IRQs have to masked during suspend if they are not
wakeup source - this is expected behavior.Now this is not happen, since
switching to use IRQ domain hierarchy, because suspend_device_irq()
only checks flags in the last IRQ chip in hierarchy for
IRQCHIP_MASK_ON_SUSPEND bit set. And in the case of TI OMAP DRA7 the
last IRQ chip is TI Crossbar which do not have this flag set.

In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
  ARM GIC <- OMAP wakeupgen <- TI CBAR
ARM GIC - IRQCHIP_MASK_ON_SUSPEND=n
OMAP wakeupgen - IRQCHIP_MASK_ON_SUSPEND=y
TI CBAR - IRQCHIP_MASK_ON_SUSPEND=n

Hence, fix by adding IRQCHIP_MASK_ON_SUSPEND for TI Crossbar IRQ chip.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/irqchip/irq-crossbar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 3ba58e7..f5a72cc 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -70,6 +70,7 @@ static struct irq_chip crossbar_chip = {
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_wake		= irq_chip_set_wake_parent,
 	.irq_set_type		= irq_chip_set_type_parent,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
-- 
2.5.0
