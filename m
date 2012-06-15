From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 15 Jun 2012 11:11:29 +0200
Subject: [PATCH v2 4/7] ARM: at91: fix irq_alloc_descs parameters for sparse
 irq
In-Reply-To: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
References: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1339751489-24346-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When SPARSE_IRQ is enabled, all NR_IRQS or mach_desc->nr_irqs will be allocated
by arch_probe_nr_irqs(). This caused irq_alloc_descs to allocate irq_descs
after the pre-allocated space. Make irq_alloc_descs search for an exact irq
range in order to get an error when it has been pre-allocated.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/irq.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index cabfba2..b0f83e2 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -32,6 +32,7 @@
 #include <linux/err.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
 
@@ -275,9 +276,9 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
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
