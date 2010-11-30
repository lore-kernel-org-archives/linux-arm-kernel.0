From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:56 +0100
Subject: [PATCH 27/54] ARM: lh7a40x: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133656.GB15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-lh7a40x/arch-kev7a400.c |   20 +++++-----
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c |   25 +++++++------
 arch/arm/mach-lh7a40x/irq-lh7a400.c   |   30 ++++++++--------
 arch/arm/mach-lh7a40x/irq-lh7a404.c   |   60 ++++++++++++++++----------------
 arch/arm/mach-lh7a40x/irq-lpd7a40x.c  |   22 ++++++------
 5 files changed, 79 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-lh7a40x/arch-kev7a400.c b/arch/arm/mach-lh7a40x/arch-kev7a400.c
index 9088c16..71129c3 100644
--- a/arch/arm/mach-lh7a40x/arch-kev7a400.c
+++ b/arch/arm/mach-lh7a40x/arch-kev7a400.c
@@ -46,28 +46,28 @@ void __init kev7a400_map_io(void)
 
 static u16 CPLD_IRQ_mask;	/* Mask for CPLD IRQs, 1 == unmasked */
 
-static void kev7a400_ack_cpld_irq (u32 irq)
+static void kev7a400_ack_cpld_irq(struct irq_data *d)
 {
-	CPLD_CL_INT = 1 << (irq - IRQ_KEV7A400_CPLD);
+	CPLD_CL_INT = 1 << (d->irq - IRQ_KEV7A400_CPLD);
 }
 
-static void kev7a400_mask_cpld_irq (u32 irq)
+static void kev7a400_mask_cpld_irq(struct irq_data *d)
 {
-	CPLD_IRQ_mask &= ~(1 << (irq - IRQ_KEV7A400_CPLD));
+	CPLD_IRQ_mask &= ~(1 << (d->irq - IRQ_KEV7A400_CPLD));
 	CPLD_WR_PB_INT_MASK = CPLD_IRQ_mask;
 }
 
-static void kev7a400_unmask_cpld_irq (u32 irq)
+static void kev7a400_unmask_cpld_irq(struct irq_data *d)
 {
-	CPLD_IRQ_mask |= 1 << (irq - IRQ_KEV7A400_CPLD);
+	CPLD_IRQ_mask |= 1 << (d->irq - IRQ_KEV7A400_CPLD);
 	CPLD_WR_PB_INT_MASK = CPLD_IRQ_mask;
 }
 
 static struct irq_chip kev7a400_cpld_chip = {
-	.name	= "CPLD",
-	.ack	= kev7a400_ack_cpld_irq,
-	.mask	= kev7a400_mask_cpld_irq,
-	.unmask	= kev7a400_unmask_cpld_irq,
+	.name		= "CPLD",
+	.irq_ack	= kev7a400_ack_cpld_irq,
+	.irq_mask	= kev7a400_mask_cpld_irq,
+	.irq_unmask	= kev7a400_unmask_cpld_irq,
 };
 
 
diff --git a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
index 7315a56..e735546 100644
--- a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
+++ b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
@@ -159,7 +159,7 @@ static void __init lpd7a40x_init (void)
 #endif
 }
 
-static void lh7a40x_ack_cpld_irq (u32 irq)
+static void lh7a40x_ack_cpld_irq(struct irq_data *d)
 {
 	/* CPLD doesn't have ack capability, but some devices may */
 
@@ -167,14 +167,14 @@ static void lh7a40x_ack_cpld_irq (u32 irq)
 	/* The touch control *must* mask the interrupt because the
 	 * interrupt bit is read by the driver to determine if the pen
 	 * is still down. */
-	if (irq == IRQ_TOUCH)
+	if (d->irq == IRQ_TOUCH)
 		CPLD_INTERRUPTS |= CPLD_INTMASK_TOUCH;
 #endif
 }
 
-static void lh7a40x_mask_cpld_irq (u32 irq)
+static void lh7a40x_mask_cpld_irq(struct irq_data *d)
 {
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_LPD7A40X_ETH_INT:
 		CPLD_INTERRUPTS |= CPLD_INTMASK_ETHERNET;
 		break;
@@ -186,9 +186,9 @@ static void lh7a40x_mask_cpld_irq (u32 irq)
 	}
 }
 
-static void lh7a40x_unmask_cpld_irq (u32 irq)
+static void lh7a40x_unmask_cpld_irq(struct irq_data *d)
 {
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_LPD7A40X_ETH_INT:
 		CPLD_INTERRUPTS &= ~CPLD_INTMASK_ETHERNET;
 		break;
@@ -201,17 +201,17 @@ static void lh7a40x_unmask_cpld_irq (u32 irq)
 }
 
 static struct irq_chip lpd7a40x_cpld_chip = {
-	.name	= "CPLD",
-	.ack	= lh7a40x_ack_cpld_irq,
-	.mask	= lh7a40x_mask_cpld_irq,
-	.unmask	= lh7a40x_unmask_cpld_irq,
+	.name		= "CPLD",
+	.irq_ack	= lh7a40x_ack_cpld_irq,
+	.irq_mask	= lh7a40x_mask_cpld_irq,
+	.irq_unmask	= lh7a40x_unmask_cpld_irq,
 };
 
 static void lpd7a40x_cpld_handler (unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int mask = CPLD_INTERRUPTS;
 
-	desc->chip->ack (irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	if ((mask & (1<<0)) == 0)	/* WLAN */
 		generic_handle_irq(IRQ_LPD7A40X_ETH_INT);
@@ -221,7 +221,8 @@ static void lpd7a40x_cpld_handler (unsigned int irq, struct irq_desc *desc)
 		generic_handle_irq(IRQ_TOUCH);
 #endif
 
-	desc->chip->unmask (irq); /* Level-triggered need this */
+	/* Level-triggered need this */
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 
diff --git a/arch/arm/mach-lh7a40x/irq-lh7a400.c b/arch/arm/mach-lh7a40x/irq-lh7a400.c
index 1ad3afc..f2e7e65 100644
--- a/arch/arm/mach-lh7a40x/irq-lh7a400.c
+++ b/arch/arm/mach-lh7a40x/irq-lh7a400.c
@@ -21,34 +21,34 @@
 
   /* CPU IRQ handling */
 
-static void lh7a400_mask_irq (u32 irq)
+static void lh7a400_mask_irq(struct irq_data *d)
 {
-	INTC_INTENC = (1 << irq);
+	INTC_INTENC = (1 << d->irq);
 }
 
-static void lh7a400_unmask_irq (u32 irq)
+static void lh7a400_unmask_irq(struct irq_data *d)
 {
-	INTC_INTENS = (1 << irq);
+	INTC_INTENS = (1 << d->irq);
 }
 
-static void lh7a400_ack_gpio_irq (u32 irq)
+static void lh7a400_ack_gpio_irq(struct irq_data *d)
 {
-	GPIO_GPIOFEOI = (1 << IRQ_TO_GPIO (irq));
-	INTC_INTENC = (1 << irq);
+	GPIO_GPIOFEOI = (1 << IRQ_TO_GPIO (d->irq));
+	INTC_INTENC = (1 << d->irq);
 }
 
 static struct irq_chip lh7a400_internal_chip = {
-	.name	= "MPU",
-	.ack	= lh7a400_mask_irq, /* Level triggering -> mask is ack */
-	.mask	= lh7a400_mask_irq,
-	.unmask	= lh7a400_unmask_irq,
+	.name		= "MPU",
+	.irq_ack	= lh7a400_mask_irq, /* Level triggering -> mask is ack */
+	.irq_mask	= lh7a400_mask_irq,
+	.irq_unmask	= lh7a400_unmask_irq,
 };
 
 static struct irq_chip lh7a400_gpio_chip = {
-	.name	= "GPIO",
-	.ack	= lh7a400_ack_gpio_irq,
-	.mask	= lh7a400_mask_irq,
-	.unmask	= lh7a400_unmask_irq,
+	.name		= "GPIO",
+	.irq_ack	= lh7a400_ack_gpio_irq,
+	.irq_mask	= lh7a400_mask_irq,
+	.irq_unmask	= lh7a400_unmask_irq,
 };
 
 
diff --git a/arch/arm/mach-lh7a40x/irq-lh7a404.c b/arch/arm/mach-lh7a40x/irq-lh7a404.c
index 12b045b..14b1733 100644
--- a/arch/arm/mach-lh7a40x/irq-lh7a404.c
+++ b/arch/arm/mach-lh7a40x/irq-lh7a404.c
@@ -43,64 +43,64 @@ static unsigned char irq_pri_vic2[] = {
 
   /* CPU IRQ handling */
 
-static void lh7a404_vic1_mask_irq (u32 irq)
+static void lh7a404_vic1_mask_irq(struct irq_data *d)
 {
-	VIC1_INTENCLR = (1 << irq);
+	VIC1_INTENCLR = (1 << d->irq);
 }
 
-static void lh7a404_vic1_unmask_irq (u32 irq)
+static void lh7a404_vic1_unmask_irq(struct irq_data *d)
 {
-	VIC1_INTEN = (1 << irq);
+	VIC1_INTEN = (1 << d->irq);
 }
 
-static void lh7a404_vic2_mask_irq (u32 irq)
+static void lh7a404_vic2_mask_irq(struct irq_data *d)
 {
-	VIC2_INTENCLR = (1 << (irq - 32));
+	VIC2_INTENCLR = (1 << (d->irq - 32));
 }
 
-static void lh7a404_vic2_unmask_irq (u32 irq)
+static void lh7a404_vic2_unmask_irq(struct irq_data *d)
 {
-	VIC2_INTEN = (1 << (irq - 32));
+	VIC2_INTEN = (1 << (d->irq - 32));
 }
 
-static void lh7a404_vic1_ack_gpio_irq (u32 irq)
+static void lh7a404_vic1_ack_gpio_irq(struct irq_data *d)
 {
-	GPIO_GPIOFEOI = (1 << IRQ_TO_GPIO (irq));
-	VIC1_INTENCLR = (1 << irq);
+	GPIO_GPIOFEOI = (1 << IRQ_TO_GPIO (d->irq));
+	VIC1_INTENCLR = (1 << d->irq);
 }
 
-static void lh7a404_vic2_ack_gpio_irq (u32 irq)
+static void lh7a404_vic2_ack_gpio_irq(struct irq_data *d)
 {
-	GPIO_GPIOFEOI = (1 << IRQ_TO_GPIO (irq));
-	VIC2_INTENCLR = (1 << irq);
+	GPIO_GPIOFEOI = (1 << IRQ_TO_GPIO (d->irq));
+	VIC2_INTENCLR = (1 << d->irq);
 }
 
 static struct irq_chip lh7a404_vic1_chip = {
-	.name	= "VIC1",
-	.ack	= lh7a404_vic1_mask_irq, /* Because level-triggered */
-	.mask	= lh7a404_vic1_mask_irq,
-	.unmask	= lh7a404_vic1_unmask_irq,
+	.name		= "VIC1",
+	.irq_ack	= lh7a404_vic1_mask_irq, /* Because level-triggered */
+	.irq_mask	= lh7a404_vic1_mask_irq,
+	.irq_unmask	= lh7a404_vic1_unmask_irq,
 };
 
 static struct irq_chip lh7a404_vic2_chip = {
-	.name	= "VIC2",
-	.ack	= lh7a404_vic2_mask_irq, /* Because level-triggered */
-	.mask	= lh7a404_vic2_mask_irq,
-	.unmask	= lh7a404_vic2_unmask_irq,
+	.name		= "VIC2",
+	.irq_ack	= lh7a404_vic2_mask_irq, /* Because level-triggered */
+	.irq_mask	= lh7a404_vic2_mask_irq,
+	.irq_unmask	= lh7a404_vic2_unmask_irq,
 };
 
 static struct irq_chip lh7a404_gpio_vic1_chip = {
-	.name	= "GPIO-VIC1",
-	.ack	= lh7a404_vic1_ack_gpio_irq,
-	.mask	= lh7a404_vic1_mask_irq,
-	.unmask	= lh7a404_vic1_unmask_irq,
+	.name		= "GPIO-VIC1",
+	.irq_ack	= lh7a404_vic1_ack_gpio_irq,
+	.irq_mask	= lh7a404_vic1_mask_irq,
+	.irq_unmask	= lh7a404_vic1_unmask_irq,
 };
 
 static struct irq_chip lh7a404_gpio_vic2_chip = {
-	.name	= "GPIO-VIC2",
-	.ack	= lh7a404_vic2_ack_gpio_irq,
-	.mask	= lh7a404_vic2_mask_irq,
-	.unmask	= lh7a404_vic2_unmask_irq,
+	.name		= "GPIO-VIC2",
+	.irq_ack	= lh7a404_vic2_ack_gpio_irq,
+	.irq_mask	= lh7a404_vic2_mask_irq,
+	.irq_unmask	= lh7a404_vic2_unmask_irq,
 };
 
   /* IRQ initialization */
diff --git a/arch/arm/mach-lh7a40x/irq-lpd7a40x.c b/arch/arm/mach-lh7a40x/irq-lpd7a40x.c
index fd033bb..1bfdcdd 100644
--- a/arch/arm/mach-lh7a40x/irq-lpd7a40x.c
+++ b/arch/arm/mach-lh7a40x/irq-lpd7a40x.c
@@ -20,14 +20,14 @@
 
 #include "common.h"
 
-static void lh7a40x_ack_cpld_irq (u32 irq)
+static void lh7a40x_ack_cpld_irq(struct irq_data *d)
 {
 	/* CPLD doesn't have ack capability */
 }
 
-static void lh7a40x_mask_cpld_irq (u32 irq)
+static void lh7a40x_mask_cpld_irq(struct irq_data *d)
 {
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_LPD7A40X_ETH_INT:
 		CPLD_INTERRUPTS = CPLD_INTERRUPTS | 0x4;
 		break;
@@ -37,9 +37,9 @@ static void lh7a40x_mask_cpld_irq (u32 irq)
 	}
 }
 
-static void lh7a40x_unmask_cpld_irq (u32 irq)
+static void lh7a40x_unmask_cpld_irq(struct irq_data *d)
 {
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_LPD7A40X_ETH_INT:
 		CPLD_INTERRUPTS = CPLD_INTERRUPTS & ~ 0x4;
 		break;
@@ -50,17 +50,17 @@ static void lh7a40x_unmask_cpld_irq (u32 irq)
 }
 
 static struct irq_chip lh7a40x_cpld_chip = {
-	.name	= "CPLD",
-	.ack	= lh7a40x_ack_cpld_irq,
-	.mask	= lh7a40x_mask_cpld_irq,
-	.unmask	= lh7a40x_unmask_cpld_irq,
+	.name		= "CPLD",
+	.irq_ack	= lh7a40x_ack_cpld_irq,
+	.irq_mask	= lh7a40x_mask_cpld_irq,
+	.irq_unmask	= lh7a40x_unmask_cpld_irq,
 };
 
 static void lh7a40x_cpld_handler (unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int mask = CPLD_INTERRUPTS;
 
-	desc->chip->ack (irq);
+	desc->irq_data.chip->ack (irq);
 
 	if ((mask & 0x1) == 0)	/* WLAN */
 		generic_handle_irq(IRQ_LPD7A40X_ETH_INT);
@@ -68,7 +68,7 @@ static void lh7a40x_cpld_handler (unsigned int irq, struct irq_desc *desc)
 	if ((mask & 0x2) == 0)	/* Touch */
 		generic_handle_irq(IRQ_LPD7A400_TS);
 
-	desc->chip->unmask (irq); /* Level-triggered need this */
+	desc->irq_data.chip->unmask (irq); /* Level-triggered need this */
 }
 
 
-- 
1.7.1
