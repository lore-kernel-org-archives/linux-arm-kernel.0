From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 15 Jul 2015 15:38:28 +0100
Subject: [PATCH 1/2] irqchip: gic: enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Message-ID: <1436971109-20189-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC controller doesn't provides any facility to configure the wakeup
sources. For the same reason, GIC chip implementation can't provide
irq_set_wake functionality, but that results in the irqchip core
preventing the systems from entering sleep states like "suspend to RAM".

The GICv1/v2 controllers supports wakeup events. It signals these wakeup
events even when CPU interface is disabled which means the wakeup
outputs are always enabled with the required logic in always-on domain.
An implementation can powerdown the GIC completely, but then the wake-up
must be relayed to some control logic within the power controller that
acts as wake-up interrupt controller.

Setting the IRQCHIP_SKIP_SET_WAKE flags will ensure that the interrupts
from GIC can work as wakeup interrupts and resume from suspend-to-{idle,
ram}. The wakeup interrupt sources need to use enable_irq_wake() and the
irqchip core will then set the IRQD_WAKEUP_STATE flag.

Also it's always safer to mask all the non wakeup interrupts are masked
at the chip level when suspending. The irqchip infrastructure can handle
masking of those interrupts at the chip level. The chip implementation
just have to indicate that with IRQCHIP_MASK_ON_SUSPEND.

This patch enables IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND so
that the irqchip core allows and handles the power managemant wake up
modes.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/irqchip/irq-gic.c   | 4 +++-
 drivers/irqchip/irq-hip04.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

Hi,

Most of the platforms with GICv1/v2 implementing S2R are setting up
these flags already. This patch moves the logic to the GIC driver so
that any further duplication is avoided.

Regards,
Sudeep

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4dd88264dff5..eda24604a0f3 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -324,7 +324,9 @@ static struct irq_chip gic_chip = {
 #endif
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
-	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
 };

 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 0cae45d10695..91a9fa3d3b11 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -202,7 +202,9 @@ static struct irq_chip hip04_irq_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= hip04_irq_set_affinity,
 #endif
-	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
 };

 static u16 hip04_get_cpumask(struct hip04_irq_data *intc)
--
1.9.1
