From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  2 Dec 2014 16:58:08 +0000
Subject: [PATCH 07/16] ARM: omap: convert wakeupgen to stacked domains
In-Reply-To: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
References: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417539497-20101-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4/5 has been (ab)using the gic_arch_extn to provide
wakeup from suspend, and it makes a lot of sense to convert
this code to use stacked domains instead.

This patch does just this, updating the DT files to actually
reflect what the HW provides.

BIG FAT WARNING: because the DTs were so far lying by not
exposing the WUGEN HW block, kernels with this patch applied
won't have any suspend-resume facility when booted with old DTs,
and old kernels with updated DTs won't even boot.

On a platform with this patch applied, the system looks like
this:

root at bacon-fat:~# cat /proc/interrupts
            CPU0       CPU1
 16:          0          0     WUGEN  37  gp_timer
 19:       3049       1764       GIC  27  arch_timer
 44:          0          0  4ae10000.gpio  13  DMA
294:          0          0     WUGEN  20  gpmc
297:          0          0     WUGEN  56  48070000.i2c
298:          0          0     WUGEN  57  48072000.i2c
299:          0          0     WUGEN  61  48060000.i2c
300:          0          0     WUGEN  62  4807a000.i2c
301:          0          0     WUGEN  60  4807c000.i2c
308:       1561          0       GIC 106  OMAP UART2
350:          0          0      PRCM  pinctrl, pinctrl
406:       5422         45       GIC 109  ehci_hcd:usb1
IPI0:          0          1  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:       2243       4122  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:        522        611  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
IPI6:          0          0  IRQ work interrupts
IPI7:          0          0  completion interrupts
Err:          0

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/am4372.dtsi        |  11 ++-
 arch/arm/boot/dts/dra7.dtsi          |  12 +++-
 arch/arm/boot/dts/omap4.dtsi         |  12 +++-
 arch/arm/boot/dts/omap5.dtsi         |  12 +++-
 arch/arm/mach-omap2/omap-wakeupgen.c | 125 ++++++++++++++++++++++++++---------
 arch/arm/mach-omap2/omap-wakeupgen.h |   1 -
 arch/arm/mach-omap2/omap4-common.c   |   1 -
 7 files changed, 138 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 46660ff..5a0ea3c 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -15,7 +15,7 @@
 
 / {
 	compatible = "ti,am4372", "ti,am43";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&wakeupgen>;
 
 
 	aliases {
@@ -48,6 +48,15 @@
 		#interrupt-cells = <3>;
 		reg = <0x48241000 0x1000>,
 		      <0x48240100 0x0100>;
+		interrupt-parent = <&gic>;
+	};
+
+	wakeupgen: interrupt-controller at 48281000 {
+		compatible = "ti,omap4-wugen-mpu";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48281000 0x1000>;
+		interrupt-parent = <&gic>;
 	};
 
 	l2-cache-controller at 48242000 {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9cc9843..49ad4b3 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -20,7 +20,7 @@
 	#size-cells = <1>;
 
 	compatible = "ti,dra7xx";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&wakeupgen>;
 
 	aliases {
 		i2c0 = &i2c1;
@@ -42,6 +42,7 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
 	};
 
 	gic: interrupt-controller at 48211000 {
@@ -54,6 +55,15 @@
 		      <0x48214000 0x2000>,
 		      <0x48216000 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
+	};
+
+	wakeupgen: interrupt-controller at 48281000 {
+		compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48281000 0x1000>;
+		interrupt-parent = <&gic>;
 	};
 
 	/*
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 878c979..4c01a19 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -14,7 +14,7 @@
 
 / {
 	compatible = "ti,omap4430", "ti,omap4";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&wakeupgen>;
 
 	aliases {
 		i2c0 = &i2c1;
@@ -56,6 +56,7 @@
 		#interrupt-cells = <3>;
 		reg = <0x48241000 0x1000>,
 		      <0x48240100 0x0100>;
+		interrupt-parent = <&gic>;
 	};
 
 	L2: l2-cache-controller at 48242000 {
@@ -70,6 +71,15 @@
 		clocks = <&mpu_periphclk>;
 		reg = <0x48240600 0x20>;
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
+	};
+
+	wakeupgen: interrupt-controller at 48281000 {
+		compatible = "ti,omap4-wugen-mpu";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48281000 0x1000>;
+		interrupt-parent = <&gic>;
 	};
 
 	/*
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 256b7f6..ae4612a 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -18,7 +18,7 @@
 	#size-cells = <1>;
 
 	compatible = "ti,omap5";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&wakeupgen>;
 
 	aliases {
 		i2c0 = &i2c1;
@@ -79,6 +79,7 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
 	};
 
 	pmu {
@@ -95,6 +96,15 @@
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
 		      <0x48216000 0x2000>;
+		interrupt-parent = <&gic>;
+	};
+
+	wakeupgen: interrupt-controller at 48281000 {
+		compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48281000 0x1000>;
+		interrupt-parent = <&gic>;
 	};
 
 	/*
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index f961c46..fde487d 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -20,11 +20,12 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/cpu_pm.h>
-#include <linux/irqchip/arm-gic.h>
 
 #include "omap-wakeupgen.h"
 #include "omap-secure.h"
@@ -78,29 +79,12 @@ static inline void sar_writel(u32 val, u32 offset, u8 idx)
 
 static inline int _wakeupgen_get_irq_info(u32 irq, u32 *bit_posn, u8 *reg_index)
 {
-	unsigned int spi_irq;
-
-	/*
-	 * PPIs and SGIs are not supported.
-	 */
-	if (irq < OMAP44XX_IRQ_GIC_START)
-		return -EINVAL;
-
-	/*
-	 * Subtract the GIC offset.
-	 */
-	spi_irq = irq - OMAP44XX_IRQ_GIC_START;
-	if (spi_irq > MAX_IRQS) {
-		pr_err("omap wakeupGen: Invalid IRQ%d\n", irq);
-		return -EINVAL;
-	}
-
 	/*
 	 * Each WakeupGen register controls 32 interrupt.
 	 * i.e. 1 bit per SPI IRQ
 	 */
-	*reg_index = spi_irq >> 5;
-	*bit_posn = spi_irq %= 32;
+	*reg_index = irq >> 5;
+	*bit_posn = irq %= 32;
 
 	return 0;
 }
@@ -141,6 +125,7 @@ static void wakeupgen_mask(struct irq_data *d)
 	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
 	_wakeupgen_clear(d->hwirq, irq_target_cpu[d->hwirq]);
 	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
+	irq_chip_mask_parent(d);
 }
 
 /*
@@ -153,6 +138,7 @@ static void wakeupgen_unmask(struct irq_data *d)
 	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
 	_wakeupgen_set(d->hwirq, irq_target_cpu[d->hwirq]);
 	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
+	irq_chip_unmask_parent(d);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -400,15 +386,88 @@ int omap_secure_apis_support(void)
 	return omap_secure_apis;
 }
 
+static struct irq_chip wakeupgen_chip = {
+	.name		= "WUGEN",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_mask	= wakeupgen_mask,
+	.irq_unmask	= wakeupgen_unmask,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int wakeupgen_domain_xlate(struct irq_domain *domain,
+				  struct device_node *controller,
+				  const u32 *intspec,
+				  unsigned int intsize,
+				  unsigned long *out_hwirq,
+				  unsigned int *out_type)
+{
+	if (domain->of_node != controller)
+		return -EINVAL;	/* Shouldn't happen, really... */
+	if (intsize != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (intspec[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	*out_hwirq = intspec[1];
+	*out_type = intspec[2];
+	return 0;
+}
+
+static int wakeupgen_domain_alloc(struct irq_domain *domain,
+				  unsigned int virq,
+				  unsigned int nr_irqs, void *data)
+{
+	struct of_phandle_args *args = data;
+	struct of_phandle_args parent_args;
+	irq_hw_number_t hwirq;
+	int i;
+
+	if (args->args_count != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (args->args[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	hwirq = args->args[1];
+	if (hwirq >= MAX_IRQS)
+		return -EINVAL;	/* Can't deal with this */
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &wakeupgen_chip, NULL);
+
+	parent_args = *args;
+	parent_args.np = domain->parent->of_node;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+}
+
+static struct irq_domain_ops wakeupgen_domain_ops = {
+	.xlate	= wakeupgen_domain_xlate,
+	.alloc	= wakeupgen_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
 /*
  * Initialise the wakeupgen module.
  */
-int __init omap_wakeupgen_init(void)
+static int __init wakeupgen_init(struct device_node *node,
+				 struct device_node *parent)
 {
+	struct irq_domain *parent_domain, *domain;
 	int i;
 	unsigned int boot_cpu = smp_processor_id();
 	u32 val;
 
+	if (!parent) {
+		pr_err("%s: no parent, giving up\n", node->full_name);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		return -ENXIO;
+	}
 	/* Not supported on OMAP4 ES1.0 silicon */
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "WakeupGen: Not supported on OMAP4430 ES1.0\n");
@@ -416,7 +475,7 @@ int __init omap_wakeupgen_init(void)
 	}
 
 	/* Static mapping, never released */
-	wakeupgen_base = ioremap(OMAP_WKUPGEN_BASE, SZ_4K);
+	wakeupgen_base = of_iomap(node, 0);
 	if (WARN_ON(!wakeupgen_base))
 		return -ENOMEM;
 
@@ -429,6 +488,14 @@ int __init omap_wakeupgen_init(void)
 		max_irqs = AM43XX_IRQS;
 	}
 
+	domain = irq_domain_add_hierarchy(parent_domain, 0, max_irqs,
+					  node, &wakeupgen_domain_ops,
+					  NULL);
+	if (!domain) {
+		iounmap(wakeupgen_base);
+		return -ENOMEM;
+	}
+
 	/* Clear all IRQ bitmasks at wakeupGen level */
 	for (i = 0; i < irq_banks; i++) {
 		wakeupgen_writel(0, i, CPU0_ID);
@@ -437,14 +504,6 @@ int __init omap_wakeupgen_init(void)
 	}
 
 	/*
-	 * Override GIC architecture specific functions to add
-	 * OMAP WakeupGen interrupt controller along with GIC
-	 */
-	gic_arch_extn.irq_mask = wakeupgen_mask;
-	gic_arch_extn.irq_unmask = wakeupgen_unmask;
-	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
-
-	/*
 	 * FIXME: Add support to set_smp_affinity() once the core
 	 * GIC code has necessary hooks in place.
 	 */
@@ -474,3 +533,9 @@ int __init omap_wakeupgen_init(void)
 
 	return 0;
 }
+
+/*
+ * We cannot use the IRQCHIP_DECLARE macro that lives in
+ * drivers/irqchip, so we're forced to roll our own. Not very nice.
+ */
+OF_DECLARE_2(irqchip, ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.h b/arch/arm/mach-omap2/omap-wakeupgen.h
index b3c8ecc..a3491ad 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.h
+++ b/arch/arm/mach-omap2/omap-wakeupgen.h
@@ -33,7 +33,6 @@
 #define OMAP_TIMESTAMPCYCLELO			0xc08
 #define OMAP_TIMESTAMPCYCLEHI			0xc0c
 
-extern int __init omap_wakeupgen_init(void);
 extern void __iomem *omap_get_wakeupgen_base(void);
 extern int omap_secure_apis_support(void);
 #endif
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 16b20ce..0465448 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -274,7 +274,6 @@ void __init omap_gic_of_init(void)
 	WARN_ON(!twd_base);
 
 skip_errata_init:
-	omap_wakeupgen_init();
 #ifdef CONFIG_IRQ_CROSSBAR
 	irqcrossbar_init();
 #endif
-- 
2.1.3
