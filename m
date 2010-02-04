From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 4 Feb 2010 12:05:28 -0500
Subject: [PATCH] vic: make irq_chip access typesafe
In-Reply-To: <A6D19A13FE030A409EC4362C172E091F0E6ED876@eseldmw101.eemea.ericsson.se>
References: <201002021601.43072.hartleys@visionengravers.com>
	<A6D19A13FE030A409EC4362C172E091F0E6ED876@eseldmw101.eemea.ericsson.se>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902152B8B@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ARM] vic: make irq_chip access typesafe

Currently the base address of the vic is stored as the irq_chip
data. Unfortunately the base address is a void __iomem * but
the irq_chip data is a void *. This ends up producing sparse
warnings about different address spaces.

Since there is already a private struct for the vic pm device
that saves the void __iomem *base address we can reuse this
data and remove all the warnings by storing this struct as the
irq_chip data.

The normal arm vic as well as the modified st vic need to call
vic_pm_register regardless of the CONFIG_PM setting in order
to save the necessary data. Since the AMBA_VENDOR_ST case
does not currently call vic_pm_register:
1) use a break after calling vic_init_st instead of returning.
2) move the normal arm vic code in vic_init to a new __init 
function (vic_init_arm) and call it in the switch.
3) after the switch all vic types call vic_pm_register.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Tested-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Andrea Gallo <andrea.gallo@stericsson.com>
Cc: Ben Dooks <ben-linux@fluff.org>

---

V2 - add missing variable declaration in vic_init_arm (Linus Walleij)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 1cf999a..6031e44 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -29,7 +29,6 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/vic.h>
 
-#if defined(CONFIG_PM)
 /**
  * struct vic_device - VIC PM device
  * @sysdev: The system device which is registered.
@@ -41,6 +40,8 @@
  * @int_enable: Save for VIC_INT_ENABLE.
  * @soft_int: Save for VIC_INT_SOFT.
  * @protect: Save for VIC_PROTECT.
+ *
+ * irq_chip also uses this to get the base address of the VIC
  */
 struct vic_device {
 	struct sys_device sysdev;
@@ -49,10 +50,12 @@ struct vic_device {
 	int		irq;
 	u32		resume_sources;
 	u32		resume_irqs;
+#if defined(CONFIG_PM)
 	u32		int_select;
 	u32		int_enable;
 	u32		soft_int;
 	u32		protect;
+#endif /* CONFIG_PM */
 };
 
 /* we cannot allocate memory when VICs are initially registered */
@@ -60,12 +63,6 @@ static struct vic_device vic_devices[CONFIG_ARM_VIC_NR];
 
 static int vic_id;
 
-static inline struct vic_device *to_vic(struct sys_device *sys)
-{
-	return container_of(sys, struct vic_device, sysdev);
-}
-#endif /* CONFIG_PM */
-
 /**
  * vic_init2 - common initialisation code
  * @base: Base of the VIC.
@@ -86,6 +83,11 @@ static void vic_init2(void __iomem *base)
 }
 
 #if defined(CONFIG_PM)
+static inline struct vic_device *to_vic(struct sys_device *sys)
+{
+	return container_of(sys, struct vic_device, sysdev);
+}
+
 static int vic_class_resume(struct sys_device *dev)
 {
 	struct vic_device *vic = to_vic(dev);
@@ -176,6 +178,8 @@ static int __init vic_pm_init(void)
 }
 late_initcall(vic_pm_init);
 
+#endif /* CONFIG_PM */
+
 /**
  * vic_pm_register - Register a VIC for later power management control
  * @base: The base address of the VIC.
@@ -185,6 +189,9 @@ late_initcall(vic_pm_init);
  * Register the VIC with the system device tree so that it can be notified
  * of suspend and resume requests and ensure that the correct actions are
  * taken to re-instate the settings on resume.
+ *
+ * This is called even with CONFIG_PM disabled since the irq_chip uses the
+ * vic_device structure to hold the base address for the VIC.
  */
 static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 resume_sources)
 {
@@ -200,64 +207,46 @@ static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 res
 		vic_id++;
 	}
 }
-#else
-static inline void vic_pm_register(void __iomem *base, unsigned int irq, u32 arg1) { }
-#endif /* CONFIG_PM */
 
 static void vic_ack_irq(unsigned int irq)
 {
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
-	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
+	struct vic_device *vic = get_irq_chip_data(irq);
+	u32 mask = 1 << (irq & 31);
+
+	writel(mask, vic->base + VIC_INT_ENABLE_CLEAR);
 	/* moreover, clear the soft-triggered, in case it was the reason */
-	writel(1 << irq, base + VIC_INT_SOFT_CLEAR);
+	writel(mask, vic->base + VIC_INT_SOFT_CLEAR);
 }
 
 static void vic_mask_irq(unsigned int irq)
 {
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
-	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
-}
+	struct vic_device *vic = get_irq_chip_data(irq);
+	u32 mask = 1 << (irq & 31);
 
-static void vic_unmask_irq(unsigned int irq)
-{
-	void __iomem *base = get_irq_chip_data(irq);
-	irq &= 31;
-	writel(1 << irq, base + VIC_INT_ENABLE);
+	writel(mask, vic->base + VIC_INT_ENABLE_CLEAR);
 }
 
-#if defined(CONFIG_PM)
-static struct vic_device *vic_from_irq(unsigned int irq)
+static void vic_unmask_irq(unsigned int irq)
 {
-        struct vic_device *v = vic_devices;
-	unsigned int base_irq = irq & ~31;
-	int id;
-
-	for (id = 0; id < vic_id; id++, v++) {
-		if (v->irq == base_irq)
-			return v;
-	}
+	struct vic_device *vic = get_irq_chip_data(irq);
+	u32 mask = 1 << (irq & 31);
 
-	return NULL;
+	writel(mask, vic->base + VIC_INT_ENABLE);
 }
 
+#if defined(CONFIG_PM)
 static int vic_set_wake(unsigned int irq, unsigned int on)
 {
-	struct vic_device *v = vic_from_irq(irq);
-	unsigned int off = irq & 31;
-	u32 bit = 1 << off;
-
-	if (!v)
-		return -EINVAL;
+	struct vic_device *vic = get_irq_chip_data(irq);
+	u32 mask = 1 << (irq & 31);
 
-	if (!(bit & v->resume_sources))
+	if (!(mask & vic->resume_sources))
 		return -EINVAL;
 
 	if (on)
-		v->resume_irqs |= bit;
+		vic->resume_irqs |= mask;
 	else
-		v->resume_irqs &= ~bit;
+		vic->resume_irqs &= ~mask;
 
 	return 0;
 }
@@ -266,11 +255,11 @@ static int vic_set_wake(unsigned int irq, unsigned int on)
 #endif /* CONFIG_PM */
 
 static struct irq_chip vic_chip = {
-	.name	= "VIC",
-	.ack	= vic_ack_irq,
-	.mask	= vic_mask_irq,
-	.unmask	= vic_unmask_irq,
-	.set_wake = vic_set_wake,
+	.name		= "VIC",
+	.ack		= vic_ack_irq,
+	.mask		= vic_mask_irq,
+	.unmask		= vic_unmask_irq,
+	.set_wake	= vic_set_wake,
 };
 
 /*
@@ -323,46 +312,17 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 			unsigned int irq = irq_start + i;
 
 			set_irq_chip(irq, &vic_chip);
-			set_irq_chip_data(irq, base);
+			set_irq_chip_data(irq, &vic_devices[vic_id]);
 			set_irq_handler(irq, handle_level_irq);
 			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 		}
 	}
 }
 
-/**
- * vic_init - initialise a vectored interrupt controller
- * @base: iomem base address
- * @irq_start: starting interrupt number, must be muliple of 32
- * @vic_sources: bitmask of interrupt sources to allow
- * @resume_sources: bitmask of interrupt sources to allow for resume
- */
-void __init vic_init(void __iomem *base, unsigned int irq_start,
-		     u32 vic_sources, u32 resume_sources)
+static void __init vic_init_arm(void __iomem *base, unsigned int irq_start,
+				u32 vic_sources)
 {
 	unsigned int i;
-	u32 cellid = 0;
-	enum amba_vendor vendor;
-
-	/* Identify which VIC cell this one is, by reading the ID */
-	for (i = 0; i < 4; i++) {
-		u32 addr = ((u32)base & PAGE_MASK) + 0xfe0 + (i * 4);
-		cellid |= (readl(addr) & 0xff) << (8 * i);
-	}
-	vendor = (cellid >> 12) & 0xff;
-	printk(KERN_INFO "VIC @%p: id 0x%08x, vendor 0x%02x\n",
-	       base, cellid, vendor);
-
-	switch(vendor) {
-	case AMBA_VENDOR_ST:
-		vic_init_st(base, irq_start, vic_sources);
-		return;
-	default:
-		printk(KERN_WARNING "VIC: unknown vendor, continuing anyways\n");
-		/* fall through */
-	case AMBA_VENDOR_ARM:
-		break;
-	}
 
 	/* Disable all interrupts initially. */
 
@@ -391,11 +351,47 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 			unsigned int irq = irq_start + i;
 
 			set_irq_chip(irq, &vic_chip);
-			set_irq_chip_data(irq, base);
+			set_irq_chip_data(irq, &vic_devices[vic_id]);
 			set_irq_handler(irq, handle_level_irq);
 			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 		}
 	}
+}
+
+/**
+ * vic_init - initialise a vectored interrupt controller
+ * @base: iomem base address
+ * @irq_start: starting interrupt number, must be muliple of 32
+ * @vic_sources: bitmask of interrupt sources to allow
+ * @resume_sources: bitmask of interrupt sources to allow for resume
+ */
+void __init vic_init(void __iomem *base, unsigned int irq_start,
+		     u32 vic_sources, u32 resume_sources)
+{
+	unsigned int i;
+	u32 cellid = 0;
+	enum amba_vendor vendor;
+
+	/* Identify which VIC cell this one is, by reading the ID */
+	for (i = 0; i < 4; i++) {
+		u32 addr = ((u32)base & PAGE_MASK) + 0xfe0 + (i * 4);
+		cellid |= (readl(addr) & 0xff) << (8 * i);
+	}
+	vendor = (cellid >> 12) & 0xff;
+	printk(KERN_INFO "VIC @%p: id 0x%08x, vendor 0x%02x\n",
+	       base, cellid, vendor);
+
+	switch(vendor) {
+	case AMBA_VENDOR_ST:
+		vic_init_st(base, irq_start, vic_sources);
+		break;
+	default:
+		printk(KERN_WARNING "VIC: unknown vendor, continuing anyways\n");
+		/* fall through */
+	case AMBA_VENDOR_ARM:
+		vic_init_arm(base, irq_start, vic_sources);
+		break;
+	}
 
 	vic_pm_register(base, irq_start, resume_sources);
 }
