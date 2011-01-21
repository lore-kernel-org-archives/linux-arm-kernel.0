From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 21 Jan 2011 21:07:32 +0100
Subject: [PATCH v2] ARM: mxs: irq_data conversion
In-Reply-To: <20110121094338.GE13235@n2100.arm.linux.org.uk>
References: <20110121094338.GE13235@n2100.arm.linux.org.uk>
Message-ID: <1295640452-9311-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

compared to (implicit) v1 ARCH_MXS doesn't select
GENERIC_HARDIRQS_NO_DEPRECATED anymore.

Best regards
Uwe

 arch/arm/mach-mxs/gpio.c  |   30 +++++++++++++++---------------
 arch/arm/mach-mxs/icoll.c |   16 ++++++++--------
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
index d7ad7a6..ba810db 100644
--- a/arch/arm/mach-mxs/gpio.c
+++ b/arch/arm/mach-mxs/gpio.c
@@ -68,29 +68,29 @@ static void set_gpio_irqenable(struct mxs_gpio_port *port, u32 index,
 	}
 }
 
-static void mxs_gpio_ack_irq(u32 irq)
+static void mxs_gpio_ack_irq(struct irq_data *d)
 {
-	u32 gpio = irq_to_gpio(irq);
+	u32 gpio = irq_to_gpio(d->irq);
 	clear_gpio_irqstatus(&mxs_gpio_ports[gpio / 32], gpio & 0x1f);
 }
 
-static void mxs_gpio_mask_irq(u32 irq)
+static void mxs_gpio_mask_irq(struct irq_data *d)
 {
-	u32 gpio = irq_to_gpio(irq);
+	u32 gpio = irq_to_gpio(d->irq);
 	set_gpio_irqenable(&mxs_gpio_ports[gpio / 32], gpio & 0x1f, 0);
 }
 
-static void mxs_gpio_unmask_irq(u32 irq)
+static void mxs_gpio_unmask_irq(struct irq_data *d)
 {
-	u32 gpio = irq_to_gpio(irq);
+	u32 gpio = irq_to_gpio(d->irq);
 	set_gpio_irqenable(&mxs_gpio_ports[gpio / 32], gpio & 0x1f, 1);
 }
 
 static int mxs_gpio_get(struct gpio_chip *chip, unsigned offset);
 
-static int mxs_gpio_set_irq_type(u32 irq, u32 type)
+static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 {
-	u32 gpio = irq_to_gpio(irq);
+	u32 gpio = irq_to_gpio(d->irq);
 	u32 pin_mask = 1 << (gpio & 31);
 	struct mxs_gpio_port *port = &mxs_gpio_ports[gpio / 32];
 	void __iomem *pin_addr;
@@ -158,9 +158,9 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
  * @param  enable       enable as wake-up if equal to non-zero
  * @return       This function returns 0 on success.
  */
-static int mxs_gpio_set_wake_irq(u32 irq, u32 enable)
+static int mxs_gpio_set_wake_irq(struct irq_data *d, unsigned int enable)
 {
-	u32 gpio = irq_to_gpio(irq);
+	u32 gpio = irq_to_gpio(d->irq);
 	u32 gpio_idx = gpio & 0x1f;
 	struct mxs_gpio_port *port = &mxs_gpio_ports[gpio / 32];
 
@@ -180,11 +180,11 @@ static int mxs_gpio_set_wake_irq(u32 irq, u32 enable)
 }
 
 static struct irq_chip gpio_irq_chip = {
-	.ack = mxs_gpio_ack_irq,
-	.mask = mxs_gpio_mask_irq,
-	.unmask = mxs_gpio_unmask_irq,
-	.set_type = mxs_gpio_set_irq_type,
-	.set_wake = mxs_gpio_set_wake_irq,
+	.irq_ack = mxs_gpio_ack_irq,
+	.irq_mask = mxs_gpio_mask_irq,
+	.irq_unmask = mxs_gpio_unmask_irq,
+	.irq_set_type = mxs_gpio_set_irq_type,
+	.irq_set_wake = mxs_gpio_set_wake_irq,
 };
 
 static void mxs_set_gpio_direction(struct gpio_chip *chip, unsigned offset,
diff --git a/arch/arm/mach-mxs/icoll.c b/arch/arm/mach-mxs/icoll.c
index 5dd43ba..0f4c120 100644
--- a/arch/arm/mach-mxs/icoll.c
+++ b/arch/arm/mach-mxs/icoll.c
@@ -34,7 +34,7 @@
 
 static void __iomem *icoll_base = MXS_IO_ADDRESS(MXS_ICOLL_BASE_ADDR);
 
-static void icoll_ack_irq(unsigned int irq)
+static void icoll_ack_irq(struct irq_data *d)
 {
 	/*
 	 * The Interrupt Collector is able to prioritize irqs.
@@ -45,22 +45,22 @@ static void icoll_ack_irq(unsigned int irq)
 			icoll_base + HW_ICOLL_LEVELACK);
 }
 
-static void icoll_mask_irq(unsigned int irq)
+static void icoll_mask_irq(struct irq_data *d)
 {
 	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
-			icoll_base + HW_ICOLL_INTERRUPTn_CLR(irq));
+			icoll_base + HW_ICOLL_INTERRUPTn_CLR(d->irq));
 }
 
-static void icoll_unmask_irq(unsigned int irq)
+static void icoll_unmask_irq(struct irq_data *d)
 {
 	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
-			icoll_base + HW_ICOLL_INTERRUPTn_SET(irq));
+			icoll_base + HW_ICOLL_INTERRUPTn_SET(d->irq));
 }
 
 static struct irq_chip mxs_icoll_chip = {
-	.ack = icoll_ack_irq,
-	.mask = icoll_mask_irq,
-	.unmask = icoll_unmask_irq,
+	.irq_ack = icoll_ack_irq,
+	.irq_mask = icoll_mask_irq,
+	.irq_unmask = icoll_unmask_irq,
 };
 
 void __init icoll_init_irq(void)
-- 
1.7.2.3
