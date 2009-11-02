From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 2 Nov 2009 14:02:21 -0500
Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
Message-ID: <mailman.101.1257160692.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since interrupt handler is changed to use interrupt priority, we also need to
save and restore these interrupt controller registers in suspend/resume
routine.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/irq.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index d694ce2..cdc272b 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -150,6 +150,7 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)

 #ifdef CONFIG_PM
 static unsigned long saved_icmr[2];
+static unsigned long saved_ipr[128];

 static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
 {
@@ -159,6 +160,10 @@ static int pxa_irq_suspend(struct sys_device
*dev, pm_message_t state)
 		saved_icmr[i] = _ICMR(irq);
 		_ICMR(irq) = 0;
 	}
+	if (pxa_internal_irq_nr > 128)
+		BUG();
+	for (i = 0; i < pxa_internal_irq_nr; i++)
+		saved_ipr[i] = IPR(i);

 	return 0;
 }
@@ -171,6 +176,8 @@ static int pxa_irq_resume(struct sys_device *dev)
 		_ICMR(irq) = saved_icmr[i];
 		_ICLR(irq) = 0;
 	}
+	for (i = 0; i < pxa_internal_irq_nr; i++)
+		IPR(i) = saved_ipr[i];

 	ICCR = 1;
 	return 0;
-- 
1.5.6.5
