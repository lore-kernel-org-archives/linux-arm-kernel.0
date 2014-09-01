From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  1 Sep 2014 12:46:06 +0100
Subject: [PATCH] arm: use irq_set_affinity with force=false when migrating irqs
Message-ID: <1409571966-18343-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

Commit 01f8fa4f01d8("genirq: Allow forcing cpu affinity of interrupts")
enabled the forced irq_set_affinity which previously refused to route an
interrupt to an offline cpu.

Commit ffde1de64012("irqchip: Gic: Support forced affinity setting")
implements this force logic and disables the cpu online check for GIC
interrupt controller.

When __cpu_disable calls migrate_irqs, it disables the current cpu in
cpu_online_mask and uses forced irq_set_affinity to migrate the IRQs
away from the cpu but passes affinity mask with the cpu being offlined
also included in it.

If irq_set_affinity is called with force=true in a cpu hotplug path,
the caller must ensure that the cpu being offlined is not present in the
affinity mask or it may be selected as the target CPU, leading to the
interrupt not being migrated.

This patch fixes the issue by calling irq_set_affinity with force=false
so that cpu_online_mask is checked while setting the affinity in the
cpu hotplug path.

Tested on TC2 hotpluging CPU0 in and out. Without this patch the system
locks up as the IRQs are not migrated away from CPU0.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <stable@vger.kernel.org> # 3.10.x
---
 arch/arm/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Russell,

If you or tglx has no objections to this patch, I will put it
in your patch tracker.

Regards,
Sudeep

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 2c4257604513..5c4d38e32a51 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -175,7 +175,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	c = irq_data_get_irq_chip(d);
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
+	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
 		cpumask_copy(d->affinity, affinity);
 
 	return ret;
-- 
1.8.3.2
