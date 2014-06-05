From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu,  5 Jun 2014 10:53:07 +0100
Subject: [RFC v3 2/9] arm: fiq: Allow EOI to be communicated to the intc
In-Reply-To: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1401961994-18033-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern ARM systems require an EOI to be sent to the interrupt controller
on completion of both IRQ and FIQ. The FIQ code currently does not provide
any API to perform this. This patch provides this API, implemented by
hooking into main irq driver in a similar way to the existing
enable_fiq()/disable_fiq().

All existing in-kernel callers of init_FIQ() and fiq_add_mapping() have
been reviewed to check they meet the documented restriction.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/fiq.h |  2 ++
 arch/arm/kernel/fiq.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
index 75d98c6..10d22eb 100644
--- a/arch/arm/include/asm/fiq.h
+++ b/arch/arm/include/asm/fiq.h
@@ -39,6 +39,8 @@ extern void set_fiq_handler(void *start, unsigned int length);
 extern struct irq_data *lookup_fiq_irq_data(int fiq);
 extern void enable_fiq(int fiq);
 extern void disable_fiq(int fiq);
+extern void eoi_fiq_with_irq_data(struct irq_data *d);
+extern void eoi_fiq(int fiq);
 extern void fiq_add_mapping(int irq, int fiq_virq, unsigned int length);
 
 /* helpers defined in fiqasm.S: */
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 177939c..ed01162 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -164,6 +164,25 @@ void disable_fiq(int fiq)
 	disable_irq(d->irq);
 }
 
+/* This call ends a FIQ and does not perform radix tree lookups. Use this
+ * if the FIQ interrupt rate is expected to be extremely high.
+ */
+void eoi_fiq_with_irq_data(struct irq_data *irq_data)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(irq_data);
+}
+EXPORT_SYMBOL(eoi_fiq_with_irq_data);
+
+void eoi_fiq(int fiq)
+{
+	struct irq_data *d = lookup_fiq_irq_data(fiq);
+	BUG_ON(!d);
+	eoi_fiq_with_irq_data(d);
+}
+EXPORT_SYMBOL(eoi_fiq);
+
 EXPORT_SYMBOL(set_fiq_handler);
 EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
 EXPORT_SYMBOL(__get_fiq_regs);	/* defined in fiqasm.S */
@@ -175,6 +194,9 @@ EXPORT_SYMBOL(disable_fiq);
 
 /*
  * Add a mapping between a normal IRQ and a FIQ shadow.
+ *
+ * By providing a mapping the interrupt controller is guaranteeing not
+ * to use spin locks from .irq_eoi
  */
 void fiq_add_mapping(int irq, int fiq_virq, unsigned int length)
 {
@@ -194,6 +216,12 @@ void fiq_add_mapping(int irq, int fiq_virq, unsigned int length)
 	mutex_unlock(&fiq_virq_mutex);
 }
 
+/*
+ * Set the offset between normal IRQs and their FIQ shadows.
+ *
+ * By providing an offset the interrupt controller is guaranteeing not
+ * to use spin locks from .irq_eoi
+ */
 void __init init_FIQ(int start)
 {
 	fiq_start = start;
-- 
1.9.0
