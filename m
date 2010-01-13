From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 13 Jan 2010 21:55:38 +0800
Subject: [PATCH 3/3] [ARM] pxa: fix irq suspend/resume for pxa25x
In-Reply-To: <1263390938-3354-1-git-send-email-eric.y.miao@gmail.com>
References: <1263390938-3354-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263390938-3354-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA25x does not have IPR registers, saving and restoring should happen
only for pxa27x and pxa3xx.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/irq.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 6112af4..1beb40f 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -164,8 +164,11 @@ static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
 		saved_icmr[i] = _ICMR(irq);
 		_ICMR(irq) = 0;
 	}
-	for (i = 0; i < pxa_internal_irq_nr; i++)
-		saved_ipr[i] = IPR(i);
+
+	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
+		for (i = 0; i < pxa_internal_irq_nr; i++)
+			saved_ipr[i] = IPR(i);
+	}
 
 	return 0;
 }
@@ -174,12 +177,15 @@ static int pxa_irq_resume(struct sys_device *dev)
 {
 	int i, irq = PXA_IRQ(0);
 
+	if (cpu_is_pxa27x() || cpu_is_pxa3xx()) {
+		for (i = 0; i < pxa_internal_irq_nr; i++)
+			IPR(i) = saved_ipr[i];
+	}
+
 	for (i = 0; irq < PXA_IRQ(pxa_internal_irq_nr); i++, irq += 32) {
 		_ICMR(irq) = saved_icmr[i];
 		_ICLR(irq) = 0;
 	}
-	for (i = 0; i < pxa_internal_irq_nr; i++)
-		IPR(i) = saved_ipr[i];
 
 	ICCR = 1;
 	return 0;
-- 
1.6.3.3
