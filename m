From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 11 Nov 2009 11:36:59 +0200
Subject: [PATCH] [ARM] pxa3xx: add EXT_WAKEUP interrupts handling
Message-ID: <1257932219-15197-1-git-send-email-mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/pxa3xx.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 09b7b1a..1d56eee 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -30,6 +30,7 @@
 #include <mach/pm.h>
 #include <mach/dma.h>
 #include <mach/ssp.h>
+#include <mach/regs-intc.h>
 #include <plat/i2c.h>
 
 #include "generic.h"
@@ -45,6 +46,9 @@
 #define ACCR_D0CS	(1 << 26)
 #define ACCR_PCCE	(1 << 11)
 
+#define PECR_IE(n)	((1 << ((n) * 2)) << 28)
+#define PECR_IS(n)	((1 << ((n) * 2)) << 29)
+
 /* crystal frequency to static memory controller multiplier (SMCFS) */
 static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
 
@@ -530,6 +534,43 @@ static inline void pxa3xx_init_pm(void) {}
 #define pxa3xx_set_wake	NULL
 #endif
 
+static void pxa_ack_ext_wakeup(unsigned int irq)
+{
+	PECR |= PECR_IS(irq - IRQ_WAKEUP0);
+}
+
+static void pxa_mask_ext_wakeup(unsigned int irq)
+{
+	ICMR2 &= ~(1 << ((irq - PXA_IRQ(0)) & 0x1f));
+	PECR &= ~PECR_IE(irq - IRQ_WAKEUP0);
+}
+
+static void pxa_unmask_ext_wakeup(unsigned int irq)
+{
+	ICMR2 |= 1 << ((irq - PXA_IRQ(0)) & 0x1f);
+	PECR |= PECR_IE(irq - IRQ_WAKEUP0);
+}
+
+static struct irq_chip pxa_ext_wakeup_chip = {
+	.name		= "WAKEUP",
+	.ack		= pxa_ack_ext_wakeup,
+	.mask		= pxa_mask_ext_wakeup,
+	.unmask		= pxa_unmask_ext_wakeup,
+};
+
+static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
+{
+	int irq;
+
+	for (irq = IRQ_WAKEUP0; irq <= IRQ_WAKEUP1; irq++) {
+		set_irq_chip(irq, &pxa_ext_wakeup_chip);
+		set_irq_handler(irq, handle_edge_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	pxa_ext_wakeup_chip.set_wake = fn;
+}
+
 void __init pxa3xx_init_irq(void)
 {
 	/* enable CP6 access */
@@ -539,6 +580,7 @@ void __init pxa3xx_init_irq(void)
 	__asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));
 
 	pxa_init_irq(56, pxa3xx_set_wake);
+	pxa_init_ext_wakeup_irq(pxa3xx_set_wake);
 	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
 }
 
-- 
1.6.0.6
