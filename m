From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:18 +0200
Subject: [PATCH 2/9] ARM i.MX avic: do not depend on MXC_INTERNAL_IRQS
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This becomes meaningless in subsequent patches.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/avic.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 09e2bd0..55d2534 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -46,6 +46,8 @@
 #define AVIC_FIPNDH		0x60	/* fast int pending high */
 #define AVIC_FIPNDL		0x64	/* fast int pending low */
 
+#define AVIC_NUM_IRQS 64
+
 void __iomem *avic_base;
 
 #ifdef CONFIG_MXC_IRQ_PRIOR
@@ -54,7 +56,7 @@ static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
 	unsigned int temp;
 	unsigned int mask = 0x0F << irq % 8 * 4;
 
-	if (irq >= MXC_INTERNAL_IRQS)
+	if (irq >= AVIC_NUM_IRQS)
 		return -EINVAL;;
 
 	temp = __raw_readl(avic_base + AVIC_NIPRIORITY(irq / 8));
@@ -72,14 +74,14 @@ static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
 {
 	unsigned int irqt;
 
-	if (irq >= MXC_INTERNAL_IRQS)
+	if (irq >= AVIC_NUM_IRQS)
 		return -EINVAL;
 
-	if (irq < MXC_INTERNAL_IRQS / 2) {
+	if (irq < AVIC_NUM_IRQS / 2) {
 		irqt = __raw_readl(avic_base + AVIC_INTTYPEL) & ~(1 << irq);
 		__raw_writel(irqt | (!!type << irq), avic_base + AVIC_INTTYPEL);
 	} else {
-		irq -= MXC_INTERNAL_IRQS / 2;
+		irq -= AVIC_NUM_IRQS / 2;
 		irqt = __raw_readl(avic_base + AVIC_INTTYPEH) & ~(1 << irq);
 		__raw_writel(irqt | (!!type << irq), avic_base + AVIC_INTTYPEH);
 	}
@@ -138,7 +140,7 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	/* all IRQ no FIQ */
 	__raw_writel(0, avic_base + AVIC_INTTYPEH);
 	__raw_writel(0, avic_base + AVIC_INTTYPEL);
-	for (i = 0; i < MXC_INTERNAL_IRQS; i++) {
+	for (i = 0; i < AVIC_NUM_IRQS; i++) {
 		irq_set_chip_and_handler(i, &mxc_avic_chip.base,
 					 handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
-- 
1.7.4.1
