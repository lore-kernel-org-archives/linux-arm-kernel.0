From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 5 Jun 2012 16:47:42 +0200
Subject: [PATCH 2/4] ARM: at91: fix irq_alloc_descs parameters for sparse irq
In-Reply-To: <1338907664-24646-1-git-send-email-ludovic.desroches@atmel.com>
References: <1338907664-24646-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1338907664-24646-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

When SPARSE_IRQ is enabled, all NR_IRQS or mach_desc->nr_irqs will be allocated
by arch_probe_nr_irqs(). This caused irq_alloc_descs to allocate irq_descs
after the pre-allocated space. Make irq_alloc_descs search for an exact irq
range in order to get an error when it has been pre-allocated.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index cabfba2..e5adee4 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -275,9 +275,9 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 		panic("Unable to ioremap AIC registers\n");
 
 	/* Add irq domain for AIC */
-	irq_base = irq_alloc_descs(-1, 0, NR_AIC_IRQS, 0);
+	irq_base = irq_alloc_descs(0, 0, NR_AIC_IRQS, 0);
 	if (irq_base < 0) {
-		WARN(1, "Cannot allocate irq_descs, assuming pre-allocated\n");
+		pr_warn("Cannot allocate irq_descs, assuming pre-allocated\n");
 		irq_base = 0;
 	}
 	at91_aic_domain = irq_domain_add_legacy(at91_aic_np, NR_AIC_IRQS,
-- 
1.7.5.4
