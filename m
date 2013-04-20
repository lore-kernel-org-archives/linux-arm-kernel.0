From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:56:47 +0200
Subject: [RESEND PATCH 11/12] ARM: integrator: basic PCIv3 device tree support
Message-ID: <1366466207-15680-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This registers the memory ranges for I/O, non-prefetched and
prefetched memory and configuration space for the PCIv3 bridge
and let us fetch these basic memory resources from the device
tree in the device tree boot path. Remove the stepping stone
platform device. This is an either/or approach - the platform
data path is mutually exclusive to the plain platform data
path and provided addresses from the device tree have to be
correct.

This patch does not add the IRQ mapping - that is to follow
in later patches.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/pci/v3-v360epc-pci.txt     |  15 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/integratorap.dts                 |  17 +++
 arch/arm/mach-integrator/integrator_ap.c           |  11 --
 arch/arm/mach-integrator/pci_v3.c                  | 143 +++++++++++++++++----
 5 files changed, 152 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
new file mode 100644
index 0000000..30b364e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
@@ -0,0 +1,15 @@
+V3 Semiconductor V360 EPC PCI bridge
+
+This bridge is found in the ARM Integrator/AP (Application Platform)
+
+Integrator-specific notes:
+
+- syscon: should contain a link to the syscon device node (since
+  on the Integrator, some registers in the syscon are required to
+  operate the V3).
+
+V360 EPC specific notes:
+
+- reg: should contain the base address of the V3 adapter.
+- interrupts: should contain a reference to the V3 error interrupt
+  as routed on the system.
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 19e1ef7..c51a6d2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -56,6 +56,7 @@ ste	ST-Ericsson
 stericsson	ST-Ericsson
 ti	Texas Instruments
 toshiba	Toshiba Corporation
+v3	V3 Semiconductor
 via	VIA Technologies, Inc.
 wlf	Wolfson Microelectronics
 wm	Wondermedia Technologies, Inc.
diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index c9c3fa3..9c78130 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -39,6 +39,23 @@
 		valid-mask = <0x003fffff>;
 	};
 
+	pci: pciv3 at 62000000 {
+		compatible = "v3,v360epc-pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x62000000 0x10000>;
+		interrupt-parent = <&pic>;
+		interrupts = <17>; /* Bus error IRQ */
+		ranges = <0x00000000 0 0x61000000 /* config space */
+			0x61000000 0 0x00100000 /* 16 MiB @ 61000000 */
+			0x01000000 0 0x60000000 /* I/O space */
+			0x60000000 0 0x00100000 /* 16 MiB @ 60000000 */
+			0x02000000 0 0x40000000 /* non-prefectable memory */
+			0x40000000 0 0x10000000 /* 256 MiB @ 40000000 */
+			0x42000000 0 0x50000000 /* prefetchable memory */
+			0x50000000 0 0x10000000>; /* 256 MiB @ 50000000 */
+	};
+
 	fpga {
 		/*
 		 * The Integator/AP predates the idea to have magic numbers
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index f617489..793c262 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -473,15 +473,6 @@ static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
 	{ /* sentinel */ },
 };
 
-/*
- * This is a placeholder that will get deleted when we move the PCI
- * device over to the device tree.
- */
-static struct platform_device pci_v3_device_of = {
-	.name		= "pci-v3",
-	.id		= 0,
-};
-
 static void __init ap_init_of(void)
 {
 	unsigned long sc_dec;
@@ -538,8 +529,6 @@ static void __init ap_init_of(void)
 	of_platform_populate(root, of_default_bus_match_table,
 			ap_auxdata_lookup, parent);
 
-	platform_device_register(&pci_v3_device_of);
-
 	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
 		struct lm_device *lmdev;
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index a3cefde..8932eb3 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -28,6 +28,9 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
 #include <video/vga.h>
 
 #include <mach/hardware.h>
@@ -279,7 +282,12 @@
  * the mappings into PCI memory.
  */
 
+/* Filled in by probe */
 static void __iomem *pci_v3_base;
+static struct resource conf_mem; /* FIXME: remap this instead of static map */
+static struct resource io_mem;
+static struct resource non_mem;
+static struct resource pre_mem;
 
 // V3 access routines
 #define v3_writeb(o,v) __raw_writeb(v, pci_v3_base + (unsigned int)(o))
@@ -423,13 +431,13 @@ static void __iomem *v3_open_config_window(struct pci_bus *bus,
 	 * prefetchable), this frees up base1 for re-use by
 	 * configuration memory
 	 */
-	v3_writel(V3_LB_BASE0, v3_addr_to_lb_base(PHYS_PCI_MEM_BASE) |
+	v3_writel(V3_LB_BASE0, v3_addr_to_lb_base(non_mem.start) |
 			V3_LB_BASE_ADR_SIZE_512MB | V3_LB_BASE_ENABLE);
 
 	/*
 	 * Set up base1/map1 to point into configuration space.
 	 */
-	v3_writel(V3_LB_BASE1, v3_addr_to_lb_base(PHYS_PCI_CONFIG_BASE) |
+	v3_writel(V3_LB_BASE1, v3_addr_to_lb_base(conf_mem.start) |
 			V3_LB_BASE_ADR_SIZE_16MB | V3_LB_BASE_ENABLE);
 	v3_writew(V3_LB_MAP1, mapaddress);
 
@@ -441,7 +449,7 @@ static void v3_close_config_window(void)
 	/*
 	 * Reassign base1 for use by prefetchable PCI memory
 	 */
-	v3_writel(V3_LB_BASE1, v3_addr_to_lb_base(PHYS_PCI_MEM_BASE + SZ_256M) |
+	v3_writel(V3_LB_BASE1, v3_addr_to_lb_base(pre_mem.start) |
 			V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_PREFETCH |
 			V3_LB_BASE_ENABLE);
 	v3_writew(V3_LB_MAP1, v3_addr_to_lb_map(PCI_BUS_PREMEM_START) |
@@ -450,7 +458,7 @@ static void v3_close_config_window(void)
 	/*
 	 * And shrink base0 back to a 256M window (NOTE: MAP0 already correct)
 	 */
-	v3_writel(V3_LB_BASE0, v3_addr_to_lb_base(PHYS_PCI_MEM_BASE) |
+	v3_writel(V3_LB_BASE0, v3_addr_to_lb_base(non_mem.start) |
 			V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_ENABLE);
 }
 
@@ -522,20 +530,6 @@ static struct pci_ops pci_v3_ops = {
 	.write	= v3_write_config,
 };
 
-static struct resource non_mem = {
-	.name	= "PCI non-prefetchable",
-	.start	= PHYS_PCI_MEM_BASE + PCI_BUS_NONMEM_START,
-	.end	= PHYS_PCI_MEM_BASE + PCI_BUS_NONMEM_START + PCI_BUS_NONMEM_SIZE - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct resource pre_mem = {
-	.name	= "PCI prefetchable",
-	.start	= PHYS_PCI_MEM_BASE + PCI_BUS_PREMEM_START,
-	.end	= PHYS_PCI_MEM_BASE + PCI_BUS_PREMEM_START + PCI_BUS_PREMEM_SIZE - 1,
-	.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
-};
-
 static int __init pci_v3_setup_resources(struct pci_sys_data *sys)
 {
 	if (request_resource(&iomem_resource, &non_mem)) {
@@ -659,7 +653,7 @@ static int __init pci_v3_setup(int nr, struct pci_sys_data *sys)
 		return -EINVAL;
 
 	if (nr == 0) {
-		sys->mem_offset = PHYS_PCI_MEM_BASE;
+		sys->mem_offset = non_mem.start;
 		ret = pci_v3_setup_resources(sys);
 	}
 
@@ -697,7 +691,7 @@ static void __init pci_v3_preinit(void)
 	 * Setup window 0 - PCI non-prefetchable memory
 	 *  Local: 0x40000000 Bus: 0x00000000 Size: 256MB
 	 */
-	v3_writel(V3_LB_BASE0, v3_addr_to_lb_base(PHYS_PCI_MEM_BASE) |
+	v3_writel(V3_LB_BASE0, v3_addr_to_lb_base(non_mem.start) |
 			V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_ENABLE);
 	v3_writew(V3_LB_MAP0, v3_addr_to_lb_map(PCI_BUS_NONMEM_START) |
 			V3_LB_MAP_TYPE_MEM);
@@ -706,7 +700,7 @@ static void __init pci_v3_preinit(void)
 	 * Setup window 1 - PCI prefetchable memory
 	 *  Local: 0x50000000 Bus: 0x10000000 Size: 256MB
 	 */
-	v3_writel(V3_LB_BASE1, v3_addr_to_lb_base(PHYS_PCI_MEM_BASE + SZ_256M) |
+	v3_writel(V3_LB_BASE1, v3_addr_to_lb_base(pre_mem.start) |
 			V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_PREFETCH |
 			V3_LB_BASE_ENABLE);
 	v3_writew(V3_LB_MAP1, v3_addr_to_lb_map(PCI_BUS_PREMEM_START) |
@@ -715,7 +709,7 @@ static void __init pci_v3_preinit(void)
 	/*
 	 * Setup window 2 - PCI IO
 	 */
-	v3_writel(V3_LB_BASE2, v3_addr_to_lb_base2(PHYS_PCI_IO_BASE) |
+	v3_writel(V3_LB_BASE2, v3_addr_to_lb_base2(io_mem.start) |
 			V3_LB_BASE_ENABLE);
 	v3_writew(V3_LB_MAP2, v3_addr_to_lb_map2(0));
 
@@ -772,7 +766,7 @@ static void __init pci_v3_postinit(void)
 		       "interrupt: %d\n", ret);
 #endif
 
-	register_isa_ports(PHYS_PCI_MEM_BASE, PHYS_PCI_IO_BASE, 0);
+	register_isa_ports(non_mem.start, io_mem.start, 0);
 }
 
 /*
@@ -845,8 +839,77 @@ static struct hw_pci pci_v3 __initdata = {
 	.postinit		= pci_v3_postinit,
 };
 
+static int __init pci_v3_dtprobe(struct platform_device *pdev,
+				struct device_node *np)
+{
+	struct of_pci_range_parser parser;
+	struct of_pci_range range;
+	struct resource *res;
+	int irq, ret;
+
+	if (of_pci_range_parser(&parser, np))
+		return -EINVAL;
+
+	/* Get base for bridge registers */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "unable to obtain PCIv3 base\n");
+		return -ENODEV;
+	}
+	pci_v3_base = devm_ioremap(&pdev->dev, res->start,
+				   resource_size(res));
+	if (!pci_v3_base) {
+		dev_err(&pdev->dev, "unable to remap PCIv3 base\n");
+		return -ENODEV;
+	}
+
+	/* Get and request error IRQ resource */
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "unable to obtain PCIv3 error IRQ\n");
+		return -ENODEV;
+	}
+	ret = devm_request_irq(&pdev->dev, irq, v3_irq, 0,
+			"PCIv3 error", NULL);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to request PCIv3 error IRQ %d (%d)\n", irq, ret);
+		return ret;
+	}
+
+	for_each_of_pci_range(&parser, &range) {
+		if (!range.flags) {
+			of_pci_range_to_resource(&range, np, &conf_mem);
+			conf_mem.name = "PCIv3 config";
+		}
+		if (range.flags & IORESOURCE_IO) {
+			of_pci_range_to_resource(&range, np, &io_mem);
+			io_mem.name = "PCIv3 I/O";
+		}
+		if ((range.flags & IORESOURCE_MEM) &&
+			!(range.flags & IORESOURCE_PREFETCH)) {
+			of_pci_range_to_resource(&range, np, &non_mem);
+			non_mem.name = "PCIv3 non-prefetched mem";
+		}
+		if ((range.flags & IORESOURCE_MEM) &&
+			(range.flags & IORESOURCE_PREFETCH)) {
+			of_pci_range_to_resource(&range, np, &pre_mem);
+			pre_mem.name = "PCIv3 prefetched mem";
+		}
+	}
+
+	if (!conf_mem.start || !io_mem.start ||
+	    !non_mem.start || !pre_mem.start) {
+		dev_err(&pdev->dev, "missing ranges in device node\n");
+		return -EINVAL;
+	}
+
+	pci_common_init(&pdev->dev, &pci_v3);
+	return 0;
+}
+
 static int __init pci_v3_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
 	/* Remap the Integrator system controller */
@@ -856,6 +919,10 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* Device tree probe path */
+	if (np)
+		return pci_v3_dtprobe(pdev, np);
+
 	pci_v3_base = devm_ioremap(&pdev->dev, PHYS_PCI_V3_BASE, SZ_64K);
 	if (!pci_v3_base) {
 		dev_err(&pdev->dev, "unable to remap PCIv3 base\n");
@@ -869,14 +936,42 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	pci_common_init(&pci_v3);
+	conf_mem.name = "PCIv3 config";
+	conf_mem.start = PHYS_PCI_CONFIG_BASE;
+	conf_mem.end = PHYS_PCI_CONFIG_BASE + SZ_16M - 1;
+	conf_mem.flags = IORESOURCE_MEM;
+
+	io_mem.name = "PCIv3 I/O";
+	io_mem.start = PHYS_PCI_IO_BASE;
+	io_mem.end = PHYS_PCI_IO_BASE + SZ_16M - 1;
+	io_mem.flags = IORESOURCE_MEM;
+
+	non_mem.name = "PCIv3 non-prefetched mem";
+	non_mem.start = PHYS_PCI_MEM_BASE + PCI_BUS_NONMEM_START;
+	non_mem.end = PHYS_PCI_MEM_BASE + PCI_BUS_NONMEM_START +
+		PCI_BUS_NONMEM_SIZE - 1;
+	non_mem.flags = IORESOURCE_MEM;
+
+	pre_mem.name = "PCIv3 prefetched mem";
+	pre_mem.start = PHYS_PCI_MEM_BASE + PCI_BUS_PREMEM_START;
+	pre_mem.end = PHYS_PCI_MEM_BASE + PCI_BUS_PREMEM_START +
+		PCI_BUS_PREMEM_SIZE - 1;
+	pre_mem.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
+	pci_common_init_dev(&pdev->dev, &pci_v3);
 
 	return 0;
 }
 
+static const struct of_device_id pci_ids[] = {
+	{ .compatible = "v3,v360epc-pci", },
+	{},
+};
+
 static struct platform_driver pci_v3_driver = {
 	.driver = {
 		.name = "pci-v3",
+		.of_match_table = pci_ids,
 	},
 };
 
-- 
1.8.1.4
