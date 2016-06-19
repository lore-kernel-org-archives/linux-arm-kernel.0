From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 19 Jun 2016 09:55:53 +0300
Subject: [PATCH] ARM: i.MX: Fix FIQ interrupt handling for TZIC
Message-ID: <1466319353-19559-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ number should be translated from VIRQ to HWIRQ for TZIC.
As a solution for this issue, move existing translation code
from AVIC to common place.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/avic.c       | 19 ++++++++-----------
 arch/arm/mach-imx/irq-common.c |  6 ++++--
 arch/arm/mach-imx/tzic.c       |  6 +++---
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 7fa176e..1afccae 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -55,23 +55,20 @@ static void __iomem *avic_base;
 static struct irq_domain *domain;
 
 #ifdef CONFIG_FIQ
-static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
+static int avic_set_irq_fiq(unsigned int hwirq, unsigned int type)
 {
-	struct irq_data *d = irq_get_irq_data(irq);
 	unsigned int irqt;
 
-	irq = d->hwirq;
-
-	if (irq >= AVIC_NUM_IRQS)
+	if (hwirq >= AVIC_NUM_IRQS)
 		return -EINVAL;
 
-	if (irq < AVIC_NUM_IRQS / 2) {
-		irqt = imx_readl(avic_base + AVIC_INTTYPEL) & ~(1 << irq);
-		imx_writel(irqt | (!!type << irq), avic_base + AVIC_INTTYPEL);
+	if (hwirq < AVIC_NUM_IRQS / 2) {
+		irqt = imx_readl(avic_base + AVIC_INTTYPEL) & ~(1 << hwirq);
+		imx_writel(irqt | (!!type << hwirq), avic_base + AVIC_INTTYPEL);
 	} else {
-		irq -= AVIC_NUM_IRQS / 2;
-		irqt = imx_readl(avic_base + AVIC_INTTYPEH) & ~(1 << irq);
-		imx_writel(irqt | (!!type << irq), avic_base + AVIC_INTTYPEH);
+		hwirq -= AVIC_NUM_IRQS / 2;
+		irqt = imx_readl(avic_base + AVIC_INTTYPEH) & ~(1 << hwirq);
+		imx_writel(irqt | (!!type << hwirq), avic_base + AVIC_INTTYPEH);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-imx/irq-common.c b/arch/arm/mach-imx/irq-common.c
index 0a920d1..210d36e 100644
--- a/arch/arm/mach-imx/irq-common.c
+++ b/arch/arm/mach-imx/irq-common.c
@@ -33,8 +33,10 @@ int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
 	gc = irq_get_chip_data(irq);
 	if (gc && gc->private) {
 		exirq = gc->private;
-		if (exirq->set_irq_fiq)
-			ret = exirq->set_irq_fiq(irq, type);
+		if (exirq->set_irq_fiq) {
+			struct irq_data *d = irq_get_irq_data(irq);
+			ret = exirq->set_irq_fiq(irqd_to_hwirq(d), type);
+		}
 	}
 
 	return ret;
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index ae23d50..4399abd 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -56,14 +56,14 @@ static struct irq_domain *domain;
 #define TZIC_NUM_IRQS 128
 
 #ifdef CONFIG_FIQ
-static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
+static int tzic_set_irq_fiq(unsigned int hwirq, unsigned int type)
 {
 	unsigned int index, mask, value;
 
-	index = irq >> 5;
+	index = hwirq >> 5;
 	if (unlikely(index >= 4))
 		return -EINVAL;
-	mask = 1U << (irq & 0x1F);
+	mask = 1U << (hwirq & 0x1F);
 
 	value = imx_readl(tzic_base + TZIC_INTSEC0(index)) | mask;
 	if (type)
-- 
2.4.9
