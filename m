From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  7 Feb 2012 19:40:43 +0100
Subject: [RFC PATCH] ARM: at91/aic: add irq domain and device tree support
Message-ID: <1328640043-23859-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a try of generic irq chip and irqdomain new helper functions.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
This is only a RFC and the the documentation will be taken
from previous patch for AIC already sent.

The multi handler mode allows to simplify the reverse mapping operation
before calling the handle_IRQ function.

This patch goes on top of 3.3-rc2 and a bunch of at91 patches + irqdomain/next
form Grant Likely and pl061-domain-v5 from Rob Herring.

This attempt does not work well for the moment. if you have any hint...
On the other hand, I am not sure to having taken the latest irqdomain work form
Grant...

With several debug macros turned on, I have the following log:

[..]

NR_IRQS:192
of_irq_init: init atmel,at91rm9200-aic @ c055a9ec, parent   (null)
irq: Allocated domain of type 2 @0xc78027e0

[..]

of_irq_map_one: dev=/ahb/apb/timer at fffffd30, index=0
 intspec=1 intlen=2
 intsize=2 intlen=2
of_irq_map_raw: par=/ahb/apb/interrupt-controller at fffff000,intspec=[0x00000001
0x00000004...],ointsize=2
of_irq_map_raw: ipar=/ahb/apb/interrupt-controller at fffff000, size=2
 -> addrsize=1
 -> got it !
irq: irq_create_mapping(0xc78027e0, 0x1)
irq: -> using domain @c78027e0
irq: irq 1 on domain /ahb/apb/interrupt-controller at fffff000 mapped to virtual irq 1
Got PIT irq = 1
Now, enable PIT IRQ!
Console: colour dummy device 80x30
Calibrating delay loop... irq 0, desc: c0429104, depth: 1, count: 0, unhandled: 0
->handle_irq():  c0041adc, handle_bad_irq+0x0/0x204
->irq_data.chip(): c042e548, no_irq_chip+0x0/0x5c
->action():   (null)
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 0, desc: c0429104, depth: 1, count: 0, unhandled: 0
->handle_irq():  c0041adc, handle_bad_irq+0x0/0x204
->irq_data.chip(): c042e548, no_irq_chip+0x0/0x5c
->action():   (null)
   IRQ_NOPROBE set
 IRQ_NOREQUEST set

[.. and again ..]

 arch/arm/Kconfig                              |    3 +
 arch/arm/mach-at91/board-dt.c                 |    1 +
 arch/arm/mach-at91/include/mach/at91_aic.h    |    2 +
 arch/arm/mach-at91/include/mach/entry-macro.S |    9 --
 arch/arm/mach-at91/irq.c                      |  151 +++++++++++++++++--------
 5 files changed, 108 insertions(+), 58 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c146065..af3431c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -323,6 +323,9 @@ config ARCH_AT91
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
+	select MULTI_IRQ_HANDLER
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 processors.
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index 0579315..735b273 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -122,4 +122,5 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	.init_irq	= at91_dt_init_irq,
 	.init_machine	= at91_dt_device_init,
 	.dt_compat	= at91_dt_board_compat,
+	.handle_irq	= at91_handle_irq,
 MACHINE_END
diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
index 3045781..0cd3d8d 100644
--- a/arch/arm/mach-at91/include/mach/at91_aic.h
+++ b/arch/arm/mach-at91/include/mach/at91_aic.h
@@ -24,6 +24,8 @@ extern void __iomem *at91_aic_base;
 
 #define at91_aic_write(field, value) \
 	__raw_writel(value, at91_aic_base + field);
+
+void at91_handle_irq(struct pt_regs *regs);
 #else
 .extern at91_aic_base
 #endif
diff --git a/arch/arm/mach-at91/include/mach/entry-macro.S b/arch/arm/mach-at91/include/mach/entry-macro.S
index 423eea0..05f8e26 100644
--- a/arch/arm/mach-at91/include/mach/entry-macro.S
+++ b/arch/arm/mach-at91/include/mach/entry-macro.S
@@ -17,17 +17,8 @@
 	.endm
 
 	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =at91_aic_base		@ base virtual address of AIC peripheral
-	ldr	\base, [\base]
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\irqnr, [\base, #AT91_AIC_IVR]		@ read IRQ vector register: de-asserts nIRQ to processor (and clears interrupt)
-	ldr	\irqstat, [\base, #AT91_AIC_ISR]	@ read interrupt source number
-	teq	\irqstat, #0				@ ISR is 0 when no current interrupt, or spurious interrupt
-	streq	\tmp, [\base, #AT91_AIC_EOICR]		@ not going to be handled further, then ACK it now.
 	.endm
 
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index be6b639..5a50e86 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -24,32 +24,29 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/types.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
+#include <asm/exception.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
-void __iomem *at91_aic_base;
-
-static void at91_aic_mask_irq(struct irq_data *d)
-{
-	/* Disable interrupt on AIC */
-	at91_aic_write(AT91_AIC_IDCR, 1 << d->irq);
-}
-
-static void at91_aic_unmask_irq(struct irq_data *d)
-{
-	/* Enable interrupt on AIC */
-	at91_aic_write(AT91_AIC_IECR, 1 << d->irq);
-}
+void __iomem	*at91_aic_base;
+static struct irq_chip_generic *at91_aic_gc;
+struct device_node *at91_aic_np;
 
 unsigned int at91_extern_irq;
 
-#define is_extern_irq(irq) ((1 << (irq)) & at91_extern_irq)
+#define is_extern_irq(hwirq) ((1 << (hwirq)) & at91_extern_irq)
 
 static int at91_aic_set_type(struct irq_data *d, unsigned type)
 {
@@ -63,13 +60,13 @@ static int at91_aic_set_type(struct irq_data *d, unsigned type)
 		srctype = AT91_AIC_SRCTYPE_RISING;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		if ((d->irq == AT91_ID_FIQ) || is_extern_irq(d->irq))		/* only supported on external interrupts */
+		if ((d->hwirq == AT91_ID_FIQ) || is_extern_irq(d->hwirq))		/* only supported on external interrupts */
 			srctype = AT91_AIC_SRCTYPE_LOW;
 		else
 			return -EINVAL;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		if ((d->irq == AT91_ID_FIQ) || is_extern_irq(d->irq))		/* only supported on external interrupts */
+		if ((d->hwirq == AT91_ID_FIQ) || is_extern_irq(d->hwirq))		/* only supported on external interrupts */
 			srctype = AT91_AIC_SRCTYPE_FALLING;
 		else
 			return -EINVAL;
@@ -78,39 +75,34 @@ static int at91_aic_set_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 	}
 
-	smr = at91_aic_read(AT91_AIC_SMR(d->irq)) & ~AT91_AIC_SRCTYPE;
-	at91_aic_write(AT91_AIC_SMR(d->irq), smr | srctype);
+	smr = at91_aic_read(AT91_AIC_SMR(d->hwirq)) & ~AT91_AIC_SRCTYPE;
+	at91_aic_write(AT91_AIC_SMR(d->hwirq), smr | srctype);
 	return 0;
 }
 
 #ifdef CONFIG_PM
 
-static u32 wakeups;
 static u32 backups;
 
-static int at91_aic_set_wake(struct irq_data *d, unsigned value)
+void at91_irq_suspend(struct irq_data *d)
 {
-	if (unlikely(d->irq >= 32))
-		return -EINVAL;
-
-	if (value)
-		wakeups |= (1 << d->irq);
-	else
-		wakeups &= ~(1 << d->irq);
-
-	return 0;
-}
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
-void at91_irq_suspend(void)
-{
 	backups = at91_aic_read(AT91_AIC_IMR);
 	at91_aic_write(AT91_AIC_IDCR, backups);
-	at91_aic_write(AT91_AIC_IECR, wakeups);
+
+	irq_gc_lock(gc);
+	at91_aic_write(AT91_AIC_IECR, gc->wake_active);
+	irq_gc_unlock(gc);
 }
 
-void at91_irq_resume(void)
+void at91_irq_resume(struct irq_data *d)
 {
-	at91_aic_write(AT91_AIC_IDCR, wakeups);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+
+	irq_gc_lock(gc);
+	at91_aic_write(AT91_AIC_IDCR, gc->wake_active);
+	irq_gc_unlock(gc);
 	at91_aic_write(AT91_AIC_IECR, backups);
 }
 
@@ -118,40 +110,86 @@ void at91_irq_resume(void)
 #define at91_aic_set_wake	NULL
 #endif
 
-static struct irq_chip at91_aic_chip = {
-	.name		= "AIC",
-	.irq_ack	= at91_aic_mask_irq,
-	.irq_mask	= at91_aic_mask_irq,
-	.irq_unmask	= at91_aic_unmask_irq,
-	.irq_set_type	= at91_aic_set_type,
-	.irq_set_wake	= at91_aic_set_wake,
+static void __init at91_aic_init_gc(struct irq_chip_generic *gc)
+
+{
+	struct irq_chip_type *ct = gc->chip_types;
+
+	at91_aic_gc = gc;
+	gc->wake_enabled = IRQ_MSK(NR_AIC_IRQS);
+	ct->chip.irq_ack = irq_gc_mask_set_bit;
+	ct->chip.irq_mask = irq_gc_mask_set_bit;
+	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+	ct->chip.irq_set_type = at91_aic_set_type;
+	ct->chip.irq_set_wake = irq_gc_set_wake;
+	ct->regs.mask = AT91_AIC_IDCR;
+	ct->regs.enable = AT91_AIC_IECR;
+}
+
+#if defined(CONFIG_OF)
+static int __init __at91_aic_of_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	at91_aic_np = node;
+	at91_aic_base = of_iomap(at91_aic_np, 0);
+	return 0;
+}
+
+static const struct of_device_id aic_ids[] __initconst = {
+	{ .compatible = "atmel,at91rm9200-aic", .data = __at91_aic_of_init },
+	{ /*sentinel*/ }
 };
 
+static void __init at91_aic_of_init(void)
+{
+	of_irq_init(aic_ids);
+}
+#else
+static void __init at91_aic_of_init(void) {}
+#endif
+
 /*
  * Initialize the AIC interrupt controller.
  */
 void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 {
-	unsigned int i;
-
-	at91_aic_base = ioremap(AT91_AIC, 512);
+	unsigned int	i;
+	int		irq_base;
+	int		ret;
+
+	if(of_have_populated_dt()) {
+		at91_aic_of_init();
+		irq_base = -1;
+	} else {
+		at91_aic_base = ioremap(AT91_AIC, 512);
+		irq_base = AIC_BASE_IRQ;
+	}
 
 	if (!at91_aic_base)
-		panic("Impossible to ioremap AT91_AIC\n");
+		panic("AIC: Unable to ioremap AIC registers\n");
+
+	ret = irq_setup_generic_chip_domain("AIC", of_node_get(at91_aic_np),
+				      1, irq_base, at91_aic_base,
+				      handle_level_irq,
+				      NR_AIC_IRQS,
+				      IRQ_GC_INIT_MASK_CACHE,
+				      IRQ_NOREQUEST | IRQ_NOPROBE, 0,
+				      at91_aic_init_gc, NULL);
+
+	if (ret)
+		printk(KERN_CRIT "Unable to get generic chip domain\n");
 
 	/*
 	 * The IVR is used by macro get_irqnr_and_base to read and verify.
 	 * The irq number is NR_AIC_IRQS when a spurious interrupt has occurred.
 	 */
 	for (i = 0; i < NR_AIC_IRQS; i++) {
+
 		/* Put irq number in Source Vector Register: */
 		at91_aic_write(AT91_AIC_SVR(i), i);
 		/* Active Low interrupt, with the specified priority */
 		at91_aic_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
 
-		irq_set_chip_and_handler(i, &at91_aic_chip, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-
 		/* Perform 8 End Of Interrupt Command to make sure AIC will not Lock out nIRQ */
 		if (i < 8)
 			at91_aic_write(AT91_AIC_EOICR, 0);
@@ -170,3 +208,18 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 	at91_aic_write(AT91_AIC_IDCR, 0xFFFFFFFF);
 	at91_aic_write(AT91_AIC_ICCR, 0xFFFFFFFF);
 }
+
+asmlinkage void __exception_irq_entry at91_handle_irq(struct pt_regs *regs)
+{
+        u32 stat, irq;
+
+	irq = at91_aic_read(AT91_AIC_IVR);
+	stat = at91_aic_read(AT91_AIC_ISR);
+
+	if (stat == 0) {
+		/* No interrupt or spurious interrupt: ACK it now */
+		at91_aic_write(AT91_AIC_EOICR, 0);
+	}
+
+	handle_IRQ(irq_find_mapping(at91_aic_gc->domain, irq), regs);
+}
-- 
1.7.5.4
