From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:13 +0100
Subject: [PATCH 42/54] ARM: shark: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134113.GQ15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-shark/irq.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-shark/irq.c b/arch/arm/mach-shark/irq.c
index c04eb6a..831fc66 100644
--- a/arch/arm/mach-shark/irq.c
+++ b/arch/arm/mach-shark/irq.c
@@ -30,35 +30,35 @@ static unsigned char cached_irq_mask[2] = { 0xfb, 0xff };
  * These have to be protected by the irq controller spinlock
  * before being called.
  */
-static void shark_disable_8259A_irq(unsigned int irq)
+static void shark_disable_8259A_irq(struct irq_data *d)
 {
 	unsigned int mask;
-	if (irq<8) {
-	  mask = 1 << irq;
+	if (d->irq<8) {
+	  mask = 1 << d->irq;
 	  cached_irq_mask[0] |= mask;
 	  outb(cached_irq_mask[1],0xA1);
 	} else {
-	  mask = 1 << (irq-8);
+	  mask = 1 << (d->irq-8);
 	  cached_irq_mask[1] |= mask;
 	  outb(cached_irq_mask[0],0x21);
 	}
 }
 
-static void shark_enable_8259A_irq(unsigned int irq)
+static void shark_enable_8259A_irq(struct irq_data *d)
 {
 	unsigned int mask;
-	if (irq<8) {
-	  mask = ~(1 << irq);
+	if (d->irq<8) {
+	  mask = ~(1 << d->irq);
 	  cached_irq_mask[0] &= mask;
 	  outb(cached_irq_mask[0],0x21);
 	} else {
-	  mask = ~(1 << (irq-8));
+	  mask = ~(1 << (d->irq-8));
 	  cached_irq_mask[1] &= mask;
 	  outb(cached_irq_mask[1],0xA1);
 	}
 }
 
-static void shark_ack_8259A_irq(unsigned int irq){}
+static void shark_ack_8259A_irq(struct irq_data *d){}
 
 static irqreturn_t bogus_int(int irq, void *dev_id)
 {
@@ -69,10 +69,10 @@ static irqreturn_t bogus_int(int irq, void *dev_id)
 static struct irqaction cascade;
 
 static struct irq_chip fb_chip = {
-	.name	= "XT-PIC",
-	.ack	= shark_ack_8259A_irq,
-	.mask	= shark_disable_8259A_irq,
-	.unmask = shark_enable_8259A_irq,
+	.name		= "XT-PIC",
+	.irq_ack	= shark_ack_8259A_irq,
+	.irq_mask	= shark_disable_8259A_irq,
+	.irq_unmask	= shark_enable_8259A_irq,
 };
 
 void __init shark_init_irq(void)
-- 
1.7.1
