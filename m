From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 16 Sep 2009 20:32:57 -0400
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901CBF46D@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reorganizes the vic.c code in anticipation of a future patch
to use struct vic_device as the data stored in set_irq_chip_data().

The new code has the following flow:

1) struct vic_device definition, static variables, and to_vic()
   moved to the start of the code.
2) vic power management callbacks
3) vic power management initialization/registration
4) irq_chip callbacks
5) vendor specific vic initialization
6) vic initialization

In addition the typo vik_init_st is fixed (vic_init_st).

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Alessandro Rubini <rubini-list@gnudd.com>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>

---

I originally sent this to the wrong list...

V2 - rebased to current git tree


diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 920ced0..f9e0016 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -27,48 +27,6 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/vic.h>
 
-static void vic_ack_irq(unsigned int irq)
-{
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
-	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
-	/* moreover, clear the soft-triggered, in case it was the reason */
-	writel(1 << irq, base + VIC_INT_SOFT_CLEAR);
-}
-
-static void vic_mask_irq(unsigned int irq)
-{
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
-	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
-}
-
-static void vic_unmask_irq(unsigned int irq)
-{
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
-	writel(1 << irq, base + VIC_INT_ENABLE);
-}
-
-/**
- * vic_init2 - common initialisation code
- * @base: Base of the VIC.
- *
- * Common initialisation code for registeration
- * and resume.
-*/
-static void vic_init2(void __iomem *base)
-{
-	int i;
-
-	for (i = 0; i < 16; i++) {
-		void __iomem *reg = base + VIC_VECT_CNTL0 + (i * 4);
-		writel(VIC_VECT_CNTL_ENABLE | i, reg);
-	}
-
-	writel(32, base + VIC_PL190_DEF_VECT_ADDR);
-}
-
 #if defined(CONFIG_PM)
 /**
  * struct vic_device - VIC PM device
@@ -98,13 +56,34 @@ struct vic_device {
 /* we cannot allocate memory when VICs are initially registered */
 static struct vic_device vic_devices[CONFIG_ARM_VIC_NR];
 
+static int vic_id;
+
 static inline struct vic_device *to_vic(struct sys_device *sys)
 {
 	return container_of(sys, struct vic_device, sysdev);
 }
+#endif /* CONFIG_PM */
 
-static int vic_id;
+/**
+ * vic_init2 - common initialisation code
+ * @base: Base of the VIC.
+ *
+ * Common initialisation code for registeration
+ * and resume.
+*/
+static void vic_init2(void __iomem *base)
+{
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		void __iomem *reg = base + VIC_VECT_CNTL0 + (i * 4);
+		writel(VIC_VECT_CNTL_ENABLE | i, reg);
+	}
 
+	writel(32, base + VIC_PL190_DEF_VECT_ADDR);
+}
+
+#if defined(CONFIG_PM)
 static int vic_class_resume(struct sys_device *dev)
 {
 	struct vic_device *vic = to_vic(dev);
@@ -158,31 +137,6 @@ struct sysdev_class vic_class = {
 };
 
 /**
- * vic_pm_register - Register a VIC for later power management control
- * @base: The base address of the VIC.
- * @irq: The base IRQ for the VIC.
- * @resume_sources: bitmask of interrupts allowed for resume sources.
- *
- * Register the VIC with the system device tree so that it can be notified
- * of suspend and resume requests and ensure that the correct actions are
- * taken to re-instate the settings on resume.
- */
-static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 resume_sources)
-{
-	struct vic_device *v;
-
-	if (vic_id >= ARRAY_SIZE(vic_devices))
-		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
-	else {
-		v = &vic_devices[vic_id];
-		v->base = base;
-		v->resume_sources = resume_sources;
-		v->irq = irq;
-		vic_id++;
-	}
-}
-
-/**
  * vic_pm_init - initicall to register VIC pm
  *
  * This is called via late_initcall() to register
@@ -218,9 +172,60 @@ static int __init vic_pm_init(void)
 
 	return 0;
 }
-
 late_initcall(vic_pm_init);
 
+/**
+ * vic_pm_register - Register a VIC for later power management control
+ * @base: The base address of the VIC.
+ * @irq: The base IRQ for the VIC.
+ * @resume_sources: bitmask of interrupts allowed for resume sources.
+ *
+ * Register the VIC with the system device tree so that it can be notified
+ * of suspend and resume requests and ensure that the correct actions are
+ * taken to re-instate the settings on resume.
+ */
+static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 resume_sources)
+{
+	struct vic_device *v;
+
+	if (vic_id >= ARRAY_SIZE(vic_devices))
+		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
+	else {
+		v = &vic_devices[vic_id];
+		v->base = base;
+		v->resume_sources = resume_sources;
+		v->irq = irq;
+		vic_id++;
+	}
+}
+#else
+static inline void vic_pm_register(void __iomem *base, unsigned int irq, u32 arg1) { }
+#endif /* CONFIG_PM */
+
+static void vic_ack_irq(unsigned int irq)
+{
+	void __iomem *base = get_irq_chip_data(irq);
+	irq &= 31;
+	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
+	/* moreover, clear the soft-triggered, in case it was the reason */
+	writel(1 << irq, base + VIC_INT_SOFT_CLEAR);
+}
+
+static void vic_mask_irq(unsigned int irq)
+{
+	void __iomem *base = get_irq_chip_data(irq);
+	irq &= 31;
+	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
+}
+
+static void vic_unmask_irq(unsigned int irq)
+{
+	void __iomem *base = get_irq_chip_data(irq);
+	irq &= 31;
+	writel(1 << irq, base + VIC_INT_ENABLE);
+}
+
+#if defined(CONFIG_PM)
 static struct vic_device *vic_from_irq(unsigned int irq)
 {
         struct vic_device *v = vic_devices;
@@ -254,10 +259,7 @@ static int vic_set_wake(unsigned int irq, unsigned int on)
 
 	return 0;
 }
-
 #else
-static inline void vic_pm_register(void __iomem *base, unsigned int irq, u32 arg1) { }
-
 #define vic_set_wake NULL
 #endif /* CONFIG_PM */
 
@@ -269,9 +271,62 @@ static struct irq_chip vic_chip = {
 	.set_wake = vic_set_wake,
 };
 
-/* The PL190 cell from ARM has been modified by ST, so handle both here */
-static void vik_init_st(void __iomem *base, unsigned int irq_start,
-			 u32 vic_sources);
+/*
+ * The PL190 cell from ARM has been modified by ST to handle 64 interrupts.
+ * The original cell has 32 interrupts, while the modified one has 64,
+ * replocating two blocks 0x00..0x1f in 0x20..0x3f. In that case
+ * the probe function is called twice, with base set to offset 000
+ *  and 020 within the page. We call this "second block".
+ */
+static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
+				u32 vic_sources)
+{
+	unsigned int i;
+	int vic_2nd_block = ((unsigned long)base & ~PAGE_MASK) != 0;
+
+	/* Disable all interrupts initially. */
+
+	writel(0, base + VIC_INT_SELECT);
+	writel(0, base + VIC_INT_ENABLE);
+	writel(~0, base + VIC_INT_ENABLE_CLEAR);
+	writel(0, base + VIC_IRQ_STATUS);
+	writel(0, base + VIC_ITCR);
+	writel(~0, base + VIC_INT_SOFT_CLEAR);
+
+	/*
+	 * Make sure we clear all existing interrupts. The vector registers
+	 * in this cell are after the second block of general registers,
+	 * so we can address them using standard offsets, but only from
+	 * the second base address, which is 0x20 in the page
+	 */
+	if (vic_2nd_block) {
+		writel(0, base + VIC_PL190_VECT_ADDR);
+		for (i = 0; i < 19; i++) {
+			unsigned int value;
+
+			value = readl(base + VIC_PL190_VECT_ADDR);
+			writel(value, base + VIC_PL190_VECT_ADDR);
+		}
+		/* ST has 16 vectors as well, but we don't enable them by now */
+		for (i = 0; i < 16; i++) {
+			void __iomem *reg = base + VIC_VECT_CNTL0 + (i * 4);
+			writel(0, reg);
+		}
+
+		writel(32, base + VIC_PL190_DEF_VECT_ADDR);
+	}
+
+	for (i = 0; i < 32; i++) {
+		if (vic_sources & (1 << i)) {
+			unsigned int irq = irq_start + i;
+
+			set_irq_chip(irq, &vic_chip);
+			set_irq_chip_data(irq, base);
+			set_irq_handler(irq, handle_level_irq);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		}
+	}
+}
 
 /**
  * vic_init - initialise a vectored interrupt controller
@@ -298,7 +353,7 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 
 	switch(vendor) {
 	case AMBA_VENDOR_ST:
-		vik_init_st(base, irq_start, vic_sources);
+		vic_init_st(base, irq_start, vic_sources);
 		return;
 	default:
 		printk(KERN_WARNING "VIC: unknown vendor, continuing anyways\n");
@@ -342,60 +397,3 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 
 	vic_pm_register(base, irq_start, resume_sources);
 }
-
-/*
- * The PL190 cell from ARM has been modified by ST to handle 64 interrupts.
- * The original cell has 32 interrupts, while the modified one has 64,
- * replocating two blocks 0x00..0x1f in 0x20..0x3f. In that case
- * the probe function is called twice, with base set to offset 000
- *  and 020 within the page. We call this "second block".
- */
-static void __init vik_init_st(void __iomem *base, unsigned int irq_start,
-				u32 vic_sources)
-{
-	unsigned int i;
-	int vic_2nd_block = ((unsigned long)base & ~PAGE_MASK) != 0;
-
-	/* Disable all interrupts initially. */
-
-	writel(0, base + VIC_INT_SELECT);
-	writel(0, base + VIC_INT_ENABLE);
-	writel(~0, base + VIC_INT_ENABLE_CLEAR);
-	writel(0, base + VIC_IRQ_STATUS);
-	writel(0, base + VIC_ITCR);
-	writel(~0, base + VIC_INT_SOFT_CLEAR);
-
-	/*
-	 * Make sure we clear all existing interrupts. The vector registers
-	 * in this cell are after the second block of general registers,
-	 * so we can address them using standard offsets, but only from
-	 * the second base address, which is 0x20 in the page
-	 */
-	if (vic_2nd_block) {
-		writel(0, base + VIC_PL190_VECT_ADDR);
-		for (i = 0; i < 19; i++) {
-			unsigned int value;
-
-			value = readl(base + VIC_PL190_VECT_ADDR);
-			writel(value, base + VIC_PL190_VECT_ADDR);
-		}
-		/* ST has 16 vectors as well, but we don't enable them by now */
-		for (i = 0; i < 16; i++) {
-			void __iomem *reg = base + VIC_VECT_CNTL0 + (i * 4);
-			writel(0, reg);
-		}
-
-		writel(32, base + VIC_PL190_DEF_VECT_ADDR);
-	}
-
-	for (i = 0; i < 32; i++) {
-		if (vic_sources & (1 << i)) {
-			unsigned int irq = irq_start + i;
-
-			set_irq_chip(irq, &vic_chip);
-			set_irq_chip_data(irq, base);
-			set_irq_handler(irq, handle_level_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-		}
-	}
-} 
