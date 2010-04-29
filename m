From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 29 Apr 2010 10:22:12 -0400
Subject: [PATCH] [ARM] pxa: extend to support 96 IRQs
Message-ID: <mailman.336.1272528928.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend to support 96 IRQs for PXA950.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/irq.c    |    9 ++++++---
 arch/arm/mach-pxa/pxa3xx.c |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 1beb40f..bb5a0c7 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -27,9 +27,12 @@

 #define MAX_INTERNAL_IRQS	128

-#define IRQ_BIT(n)	(((n) - PXA_IRQ(0)) & 0x1f)
-#define _ICMR(n)	(*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICMR2 : &ICMR))
-#define _ICLR(n)	(*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICLR2 : &ICLR))
+#define _IDX(n)		((n) - PXA_IRQ(0))
+#define IRQ_BIT(n)	(_IDX(n) & 0x1f)
+#define _ICMR(n)	(*((_IDX(n) < 32) ? &ICMR			\
+			: ((_IDX(n) < 64) ? &ICMR2 : &ICMR3)))
+#define _ICLR(n)	(*((_IDX(n) < 32) ? &ICLR			\
+			: ((_IDX(n) < 64) ? &ICLR2 : &ICLR3)))

 /*
  * This is for peripheral IRQs internal to the PXA chip.
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 4d7c03e..6285951 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -581,7 +581,7 @@ void __init pxa3xx_init_irq(void)
 	value |= (1 << 6);
 	__asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));

-	pxa_init_irq(56, pxa3xx_set_wake);
+	pxa_init_irq(96, pxa3xx_set_wake);
 	pxa_init_ext_wakeup_irq(pxa3xx_set_wake);
 	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
 }
-- 
1.5.6.5
