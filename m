From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:49 +0100
Subject: [PATCH 07/54] ARM: vic: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132549.GH15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/common/vic.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index ba65f6e..9dce36e 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -204,26 +204,26 @@ static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 res
 static inline void vic_pm_register(void __iomem *base, unsigned int irq, u32 arg1) { }
 #endif /* CONFIG_PM */
 
-static void vic_ack_irq(unsigned int irq)
+static void vic_ack_irq(struct irq_data *d)
 {
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->irq & 31;
 	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
 	/* moreover, clear the soft-triggered, in case it was the reason */
 	writel(1 << irq, base + VIC_INT_SOFT_CLEAR);
 }
 
-static void vic_mask_irq(unsigned int irq)
+static void vic_mask_irq(struct irq_data *d)
 {
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->irq & 31;
 	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
 }
 
-static void vic_unmask_irq(unsigned int irq)
+static void vic_unmask_irq(struct irq_data *d)
 {
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->irq & 31;
 	writel(1 << irq, base + VIC_INT_ENABLE);
 }
 
@@ -242,10 +242,10 @@ static struct vic_device *vic_from_irq(unsigned int irq)
 	return NULL;
 }
 
-static int vic_set_wake(unsigned int irq, unsigned int on)
+static int vic_set_wake(struct irq_data *d, unsigned int on)
 {
-	struct vic_device *v = vic_from_irq(irq);
-	unsigned int off = irq & 31;
+	struct vic_device *v = vic_from_irq(d->irq);
+	unsigned int off = d->irq & 31;
 	u32 bit = 1 << off;
 
 	if (!v)
@@ -267,10 +267,10 @@ static int vic_set_wake(unsigned int irq, unsigned int on)
 
 static struct irq_chip vic_chip = {
 	.name		= "VIC",
-	.ack		= vic_ack_irq,
-	.mask		= vic_mask_irq,
-	.unmask		= vic_unmask_irq,
-	.set_wake	= vic_set_wake,
+	.irq_ack	= vic_ack_irq,
+	.irq_mask	= vic_mask_irq,
+	.irq_unmask	= vic_unmask_irq,
+	.irq_set_wake	= vic_set_wake,
 };
 
 static void __init vic_disable(void __iomem *base)
-- 
1.7.1
