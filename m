From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 3 Nov 2009 12:03:12 +0800
Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
In-Reply-To: <771cded00911021819o705e0a07l4fa18b6846d17c1b@mail.gmail.com>
References: <771cded00911020342j5266b3c4ga4e94324c2369630@mail.gmail.com>
	<87ws28aly2.fsf@free.fr>
	<771cded00911021819o705e0a07l4fa18b6846d17c1b@mail.gmail.com>
Message-ID: <f17812d70911022003p4c91bf8cqe3aeda90c52f81eb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changes might be too much, I simplified it to the one below and
merged into 'fix':

commit c482ae4dcf23fd241321595d71bbe8aee33eabf5
Author: Haojian Zhuang <haojian.zhuang@marvell.com>
Date:   Mon Nov 2 14:02:21 2009 -0500

    [ARM] pxa: fix resume failure by saving/restoring IPRx registers

    Since interrupt handler is changed to use interrupt priority, we also need
    to save and restore these interrupt controller registers in suspend/resume
    routine.

    Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
    Tested-by: Daniel Mack <daniel@caiaq.de>
    Tested-by: Pavel Machek <pavel@ucw.cz>
    Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index d694ce2..6112af4 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -25,6 +25,8 @@

 #include "generic.h"

+#define MAX_INTERNAL_IRQS      128
+
 #define IRQ_BIT(n)     (((n) - PXA_IRQ(0)) & 0x1f)
 #define _ICMR(n)       (*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICMR2 : &ICMR))
 #define _ICLR(n)       (*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICLR2 : &ICLR))
@@ -122,6 +124,8 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 {
        int irq, i;

+       BUG_ON(irq_nr > MAX_INTERNAL_IRQS);
+
        pxa_internal_irq_nr = irq_nr;

        for (irq = PXA_IRQ(0); irq < PXA_IRQ(irq_nr); irq += 32) {
@@ -149,7 +153,8 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
 }

 #ifdef CONFIG_PM
-static unsigned long saved_icmr[2];
+static unsigned long saved_icmr[MAX_INTERNAL_IRQS/32];
+static unsigned long saved_ipr[MAX_INTERNAL_IRQS];

 static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
 {
@@ -159,6 +164,8 @@ static int pxa_irq_suspend(struct sys_device *dev,
pm_message_t state)
                saved_icmr[i] = _ICMR(irq);
                _ICMR(irq) = 0;
        }
+       for (i = 0; i < pxa_internal_irq_nr; i++)
+               saved_ipr[i] = IPR(i);

        return 0;
 }
@@ -171,6 +178,8 @@ static int pxa_irq_resume(struct sys_device *dev)
                _ICMR(irq) = saved_icmr[i];
                _ICLR(irq) = 0;
        }
+       for (i = 0; i < pxa_internal_irq_nr; i++)
+               IPR(i) = saved_ipr[i];

        ICCR = 1;
        return 0;
