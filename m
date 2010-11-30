From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:38 +0100
Subject: [PATCH 04/54] ARM: ITE 8152: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132538.GE15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/common/it8152.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 1bec96e..fa708f7 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -31,8 +31,10 @@
 
 #define MAX_SLOTS		21
 
-static void it8152_mask_irq(unsigned int irq)
+static void it8152_mask_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
        if (irq >= IT8152_LD_IRQ(0)) {
 	       __raw_writel((__raw_readl(IT8152_INTC_LDCNIMR) |
 			    (1 << (irq - IT8152_LD_IRQ(0)))),
@@ -48,8 +50,10 @@ static void it8152_mask_irq(unsigned int irq)
        }
 }
 
-static void it8152_unmask_irq(unsigned int irq)
+static void it8152_unmask_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
        if (irq >= IT8152_LD_IRQ(0)) {
 	       __raw_writel((__raw_readl(IT8152_INTC_LDCNIMR) &
 			     ~(1 << (irq - IT8152_LD_IRQ(0)))),
@@ -67,9 +71,9 @@ static void it8152_unmask_irq(unsigned int irq)
 
 static struct irq_chip it8152_irq_chip = {
 	.name		= "it8152",
-	.ack		= it8152_mask_irq,
-	.mask		= it8152_mask_irq,
-	.unmask		= it8152_unmask_irq,
+	.irq_ack	= it8152_mask_irq,
+	.irq_mask	= it8152_mask_irq,
+	.irq_unmask	= it8152_unmask_irq,
 };
 
 void it8152_init_irq(void)
-- 
1.7.1
