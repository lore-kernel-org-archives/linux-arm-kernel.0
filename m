From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Aug 2013 14:18:32 +0100
Subject: [PATCH RESEND] irqchip: gic: fix boot for chained gics
Message-ID: <1376399912-20157-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, would you be able to take this patch? It's a resend of the version I
sent back in June [1], with the addition of Catalin's Reviewed-by.

Sudeep has just been hit by the bug [2]. I've tested the patch against
v3.11-rc5 and it still applies cleanly and solves the issue.

I'm happy to rework it if you have any comments?

Cheers,
Mark

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/176550.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191586.html

---->8----
As of c0114709ed: "irqchip: gic: Perform the gic_secondary_init() call
via CPU notifier", booting on a platform with chained gics (e.g.
Realview EB ARM11MPCore) will result in the gic_cpu_notifier being
registered twice, corrupting the cpu notifier list and rendering the
platform unbootable.

This patch ensures that we only register the notifier for the first gic,
allowing platforms with chained gics to boot. At the same time we limit
the pointlessly duplicated calls to set_smp_cross_call and
set_handle_irq to the first gic registered.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ee7c503..810b117 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -808,12 +808,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	if (WARN_ON(!gic->domain))
 		return;
 
+	if (gic_nr == 0) {
 #ifdef CONFIG_SMP
-	set_smp_cross_call(gic_raise_softirq);
-	register_cpu_notifier(&gic_cpu_notifier);
+		set_smp_cross_call(gic_raise_softirq);
+		register_cpu_notifier(&gic_cpu_notifier);
 #endif
-
-	set_handle_irq(gic_handle_irq);
+		set_handle_irq(gic_handle_irq);
+	}
 
 	gic_chip.flags |= gic_arch_extn.flags;
 	gic_dist_init(gic);
-- 
1.8.1.1
