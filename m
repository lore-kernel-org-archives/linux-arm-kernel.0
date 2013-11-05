From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 5 Nov 2013 18:44:16 +0530
Subject: [PATCH V3 6/7] ARM: OMAP4+: Correct Wakeup-gen code to use physical
 irq number
In-Reply-To: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1383657257-3458-7-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wakeup gen mask/unmask callback uses the irq element of the
irq_data to setup. The irq is the linux virtual irq number and
is same as the hardware irq number only when the parent irqchip
is setup as a legacy domain. When it is used as a linear domain,
the virtual irqs are allocated dynamically and wakeup gen code
cannot rely on these numbers to access the irq registers. Instead
use the hwirq element of the irq_data which represent the physical
irq number.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 813c615..b813f4b 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -134,7 +134,7 @@ static void wakeupgen_mask(struct irq_data *d)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
-	_wakeupgen_clear(d->irq, irq_target_cpu[d->irq]);
+	_wakeupgen_clear(d->hwirq, irq_target_cpu[d->hwirq]);
 	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
@@ -146,7 +146,7 @@ static void wakeupgen_unmask(struct irq_data *d)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
-	_wakeupgen_set(d->irq, irq_target_cpu[d->irq]);
+	_wakeupgen_set(d->hwirq, irq_target_cpu[d->hwirq]);
 	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
-- 
1.7.9.5
