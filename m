From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Nov 2011 17:30:49 +0000
Subject: [PATCH 2/2] ARM: mcx: fix local timer interrupt handling
In-Reply-To: <1320255049-12447-1-git-send-email-marc.zyngier@arm.com>
References: <1320255049-12447-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320255049-12447-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As local timer interrupts are now handled as normal interrupts,
remove the special case in the GIC handler.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/plat-mxc/gic.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-mxc/gic.c b/arch/arm/plat-mxc/gic.c
index b3b8eed..12f8f81 100644
--- a/arch/arm/plat-mxc/gic.c
+++ b/arch/arm/plat-mxc/gic.c
@@ -28,21 +28,14 @@ asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		if (irqnr == 1023)
 			break;
 
-		if (irqnr > 29 && irqnr < 1021)
+		if (irqnr > 15 && irqnr < 1021)
 			handle_IRQ(irqnr, regs);
 #ifdef CONFIG_SMP
-		else if (irqnr < 16) {
+		else {
 			writel_relaxed(irqstat, gic_cpu_base_addr +
 						GIC_CPU_EOI);
 			handle_IPI(irqnr, regs);
 		}
 #endif
-#ifdef CONFIG_LOCAL_TIMERS
-		else if (irqnr == 29) {
-			writel_relaxed(irqstat, gic_cpu_base_addr +
-						GIC_CPU_EOI);
-			handle_local_timer(regs);
-		}
-#endif
 	} while (1);
 }
-- 
1.7.0.4
