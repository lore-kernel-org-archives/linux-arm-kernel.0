From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 25 Nov 2010 15:18:28 +0000
Subject: [PATCH 2/3] ARM: S3C64XX: Convert S3C64xx irq-eint to use new irq_
	methods
In-Reply-To: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1290698309-7691-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel 2.6.37 adds new interrupt methods which take a struct irq_data
rather than an irq number. Conver S3C64xx irq-eint to use this with a
simple textual substitution.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/irq-eint.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/irq-eint.c b/arch/arm/mach-s3c64xx/irq-eint.c
index 1a1aa5d..169ee29 100644
--- a/arch/arm/mach-s3c64xx/irq-eint.c
+++ b/arch/arm/mach-s3c64xx/irq-eint.c
@@ -32,39 +32,39 @@
 #define eint_offset(irq)	((irq) - IRQ_EINT(0))
 #define eint_irq_to_bit(irq)	(1 << eint_offset(irq))
 
-static inline void s3c_irq_eint_mask(unsigned int irq)
+static inline void s3c_irq_eint_mask(struct irq_data *data)
 {
 	u32 mask;
 
 	mask = __raw_readl(S3C64XX_EINT0MASK);
-	mask |= eint_irq_to_bit(irq);
+	mask |= eint_irq_to_bit(data->irq);
 	__raw_writel(mask, S3C64XX_EINT0MASK);
 }
 
-static void s3c_irq_eint_unmask(unsigned int irq)
+static void s3c_irq_eint_unmask(struct irq_data *data)
 {
 	u32 mask;
 
 	mask = __raw_readl(S3C64XX_EINT0MASK);
-	mask &= ~eint_irq_to_bit(irq);
+	mask &= ~eint_irq_to_bit(data->irq);
 	__raw_writel(mask, S3C64XX_EINT0MASK);
 }
 
-static inline void s3c_irq_eint_ack(unsigned int irq)
+static inline void s3c_irq_eint_ack(struct irq_data *data)
 {
-	__raw_writel(eint_irq_to_bit(irq), S3C64XX_EINT0PEND);
+	__raw_writel(eint_irq_to_bit(data->irq), S3C64XX_EINT0PEND);
 }
 
-static void s3c_irq_eint_maskack(unsigned int irq)
+static void s3c_irq_eint_maskack(struct irq_data *data)
 {
 	/* compiler should in-line these */
-	s3c_irq_eint_mask(irq);
-	s3c_irq_eint_ack(irq);
+	s3c_irq_eint_mask(data);
+	s3c_irq_eint_ack(data);
 }
 
-static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
+static int s3c_irq_eint_set_type(struct irq_data *data, unsigned int type)
 {
-	int offs = eint_offset(irq);
+	int offs = eint_offset(data->irq);
 	int pin, pin_val;
 	int shift;
 	u32 ctrl, mask;
@@ -140,11 +140,11 @@ static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
 
 static struct irq_chip s3c_irq_eint = {
 	.name		= "s3c-eint",
-	.mask		= s3c_irq_eint_mask,
-	.unmask		= s3c_irq_eint_unmask,
-	.mask_ack	= s3c_irq_eint_maskack,
-	.ack		= s3c_irq_eint_ack,
-	.set_type	= s3c_irq_eint_set_type,
+	.irq_mask	= s3c_irq_eint_mask,
+	.irq_unmask	= s3c_irq_eint_unmask,
+	.irq_mask_ack	= s3c_irq_eint_maskack,
+	.irq_ack	= s3c_irq_eint_ack,
+	.irq_set_type	= s3c_irq_eint_set_type,
 	.irq_set_wake	= s3c_irqext_wake,
 };
 
-- 
1.7.1
