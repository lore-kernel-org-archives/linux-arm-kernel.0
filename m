From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:15 +0100
Subject: [PATCH 44/54] ARM: stmp37xx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134115.GS15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-stmp37xx/stmp37xx.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-stmp37xx/stmp37xx.c b/arch/arm/mach-stmp37xx/stmp37xx.c
index 8c7d6fb..a9aed06 100644
--- a/arch/arm/mach-stmp37xx/stmp37xx.c
+++ b/arch/arm/mach-stmp37xx/stmp37xx.c
@@ -43,11 +43,11 @@
 /*
  * IRQ handling
  */
-static void stmp37xx_ack_irq(unsigned int irq)
+static void stmp37xx_ack_irq(struct irq_data *d)
 {
 	/* Disable IRQ */
-	stmp3xxx_clearl(0x04 << ((irq % 4) * 8),
-		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + irq / 4 * 0x10);
+	stmp3xxx_clearl(0x04 << ((d->irq % 4) * 8),
+		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + d->irq / 4 * 0x10);
 
 	/* ACK current interrupt */
 	__raw_writel(1, REGS_ICOLL_BASE + HW_ICOLL_LEVELACK);
@@ -56,24 +56,24 @@ static void stmp37xx_ack_irq(unsigned int irq)
 	(void)__raw_readl(REGS_ICOLL_BASE + HW_ICOLL_STAT);
 }
 
-static void stmp37xx_mask_irq(unsigned int irq)
+static void stmp37xx_mask_irq(struct irq_data *d)
 {
 	/* IRQ disable */
-	stmp3xxx_clearl(0x04 << ((irq % 4) * 8),
-		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + irq / 4 * 0x10);
+	stmp3xxx_clearl(0x04 << ((d->irq % 4) * 8),
+		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + d->irq / 4 * 0x10);
 }
 
-static void stmp37xx_unmask_irq(unsigned int irq)
+static void stmp37xx_unmask_irq(struct irq_data *d)
 {
 	/* IRQ enable */
-	stmp3xxx_setl(0x04 << ((irq % 4) * 8),
-		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + irq / 4 * 0x10);
+	stmp3xxx_setl(0x04 << ((d->irq % 4) * 8),
+		REGS_ICOLL_BASE + HW_ICOLL_PRIORITYn + d->irq / 4 * 0x10);
 }
 
 static struct irq_chip stmp37xx_chip = {
-	.ack	= stmp37xx_ack_irq,
-	.mask	= stmp37xx_mask_irq,
-	.unmask = stmp37xx_unmask_irq,
+	.irq_ack	= stmp37xx_ack_irq,
+	.irq_mask	= stmp37xx_mask_irq,
+	.irq_unmask	= stmp37xx_unmask_irq,
 };
 
 void __init stmp37xx_init_irq(void)
-- 
1.7.1
