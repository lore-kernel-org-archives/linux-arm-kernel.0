From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  9 May 2014 00:08:16 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
Message-ID: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements basic device tree boot support for the RealView
platforms, with a basic device tree for ARM PB1176 as an example.

The implementation is done with a new DT-specific board file
using only pre-existing bindings for the basic IRQ, timer and
serial port drivers. A new compatible type is added to the GIC
for the ARM1176.

This implementation uses the MFD syscon handle from day one to
access the system controller registers, and register the devices
using the SoC bus.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Adjust timer clock names to be the same as the example in the
  device tree binding.
- Remove all memory fixup code - this should be handled by the
  device tree specification of memory areas or by special MM hacks
  for the RealView PBX.
- Fix the documentation around syscon to specify that it can be in
  any node, need not be the root node.
- Switch device tree license to the BSD license, taken from
  arch/powerpc/boot/dts/p1024rdb_32b.dts
- Add a hunk for the new compatible string to
  Documentation/devicetree/bindings/arm/gic.txt
- Move the clocks out of the SoC node, certainly the xtal is not
  sitting on the SoC...
- Sort the selects in Kconfig alphabetically
- Use IS_ENABLED() for the l2x0 code snippet
- Instead of checking the board variant in the reset routine to
  figure out how to tweak the reset controller, have a compatible
  string for each syscon variant, map it to an enum that provides a
  unique type ID and that way figure out how to handle it in a maybe
  more elegant way.
- Open issue: what do to with the l2x0 stuff?
---
 Documentation/devicetree/bindings/arm/arm-boards |  57 ++++++
 Documentation/devicetree/bindings/arm/gic.txt    |   1 +
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts        | 177 ++++++++++++++++++
 arch/arm/mach-realview/Kconfig                   |  10 +
 arch/arm/mach-realview/Makefile                  |   1 +
 arch/arm/mach-realview/realview-dt.c             | 225 +++++++++++++++++++++++
 arch/arm/mm/Kconfig                              |   2 +-
 drivers/irqchip/irq-gic.c                        |   1 +
 9 files changed, 474 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
 create mode 100644 arch/arm/mach-realview/realview-dt.c

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 3509707f9320..86b36f399d1c 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -86,3 +86,60 @@ Interrupt controllers:
 	compatible = "arm,versatile-sic";
 	interrupt-controller;
 	#interrupt-cells = <1>;
+
+
+ARM RealView Boards
+-------------------
+The RealView boards cover tailored evaluation boards that are used to explore
+the ARM11 and Cortex A-8 and Cortex A-9 processors.
+
+Required properties (in root node):
+	/* RealView Emulation Baseboard */
+	compatible = "arm,realview-eb";
+	 /* RealView Platform Baseboard for ARM1176JZF-S */
+	compatible = "arm,realview-pb1176";
+	/* RealView Platform Baseboard for ARM11 MPCore */
+	compatible = "arm,realview-pb11mp";
+	/* RealView Platform Baseboard for Cortex A-8 */
+	compatible = "arm,realview-pba8";
+	/* RealView Platform Baseboard Explore for Cortex A-9 */
+	compatible = "arm,realview-pbx";
+
+Required nodes:
+
+- syscon: some node of the RealView platforms must have a
+  system controller node pointing to the control registers,
+  with the compatible string set to one of these tuples:
+   "arm,realview-eb-syscon", "syscon"
+   "arm,realview-pb1176-syscon", "syscon"
+   "arm,realview-pb11mp-syscon", "syscon"
+   "arm,realview-pba8-syscon", "syscon"
+   "arm,realview-pbx-syscon", "syscon"
+
+  Required properties for the system controller:
+  - regs: the location and size of the system controller registers,
+    one range of 0x1000 bytes.
+
+Example:
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "skeleton.dtsi"
+
+/ {
+	model = "ARM RealView PB1176 with device tree";
+	compatible = "arm,realview-pb1176";
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		syscon: syscon at 10000000 {
+			compatible = "arm,realview-syscon", "syscon";
+			reg = <0x10000000 0x1000>;
+		};
+
+	};
+};
diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 5573c08d3180..539420194efd 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -16,6 +16,7 @@ Main node required properties:
 	"arm,cortex-a9-gic"
 	"arm,cortex-a7-gic"
 	"arm,arm11mp-gic"
+	"arm,arm1176jzf-gic"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source.  The type shall be a <u32> and the value shall be 3.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 377b7c364033..1419a70026da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -294,6 +294,7 @@ dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_QCOM) += qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
 	qcom-apq8074-dragonboard.dtb
+dtb-$(CONFIG_ARCH_REALVIEW) += arm-realview-pb1176.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
 	s3c6410-smdk6410.dtb
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
new file mode 100644
index 000000000000..0eea0f4a7b39
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -0,0 +1,177 @@
+/*
+ * Copyright 2014 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "skeleton.dtsi"
+
+/ {
+	model = "ARM RealView PB1176 with device tree";
+	compatible = "arm,realview-pb1176";
+
+	chosen { };
+
+	aliases {
+		serial0 = &pb1176_serial0;
+		serial1 = &pb1176_serial1;
+		serial2 = &pb1176_serial2;
+		serial3 = &pb1176_serial3;
+	};
+
+	memory {
+		/* 128 MiB memory @ 0x0 */
+		reg = <0x00000000 0x08000000>;
+	};
+
+	xtal24mhz: xtal24mhz at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	timclk: timclk at 1M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <24>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	uartclk: uartclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	/* FIXME: this actually hangs off the PLL clocks */
+	pclk: pclk at 0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		syscon: syscon at 10000000 {
+			compatible = "arm,realview-pb1176-syscon", "syscon";
+			reg = <0x10000000 0x1000>;
+		};
+
+		/* Primary DevChip GIC synthesized with the CPU */
+		intc_dc1176: interrupt-controller at 10120000 {
+			compatible = "arm,arm1176jzf-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10121000 0x1000>,
+			      <0x10120000 0x100>;
+		};
+
+		/* This GIC on the board is cascaded off the DevChip GIC */
+		intc_pb1176: interrupt-controller at 10040000 {
+			compatible = "arm,arm1176jzf-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10041000 0x1000>,
+			      <0x10040000 0x100>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		L2: l2-cache {
+			compatible = "arm,l220-cache";
+			reg = <0x10110000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		pmu {
+			compatible = "arm,arm1176-pmu";
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		timer01: timer at 10104000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10104000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>, <0 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		timer23: timer at 10105000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10105000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+			arm,sp804-has-irq = <1>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		pb1176_serial0: uart at 1010c000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010c000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial1: uart at 1010d000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010d000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial2: uart at 1010e000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010e000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial3: uart at 1010f000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010f000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+	};
+};
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 9db2029aa632..65a07f5b5225 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -1,6 +1,16 @@
 menu "RealView platform type"
 	depends on ARCH_REALVIEW
 
+config REALVIEW_DT
+	bool "Support RealView(R) Device Tree based boot"
+	select ARM_GIC
+	select MFD_SYSCON
+	select SOC_BUS
+	select USE_OF
+	help
+	  Include support for booting the ARM(R) RealView(R) evaluation
+	  boards using a device tree machine description.
+
 config MACH_REALVIEW_EB
 	bool "Support RealView(R) Emulation Baseboard"
 	select ARM_GIC
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index 541fa4c109ef..e07fdf7ae8a7 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y					:= core.o
+obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
 obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
diff --git a/arch/arm/mach-realview/realview-dt.c b/arch/arm/mach-realview/realview-dt.c
new file mode 100644
index 000000000000..4ba7c5303d09
--- /dev/null
+++ b/arch/arm/mach-realview/realview-dt.c
@@ -0,0 +1,225 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/sys_soc.h>
+#include <linux/slab.h>
+#include <asm/mach/map.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <mach/hardware.h>
+#include <mach/platform.h>
+#include <mach/board-eb.h>
+#include <mach/board-pb1176.h>
+#include <mach/board-pb11mp.h>
+#include <mach/board-pbx.h>
+#include "core.h"
+
+/* Pointer to the system controller */
+struct regmap *syscon_regmap;
+u8 syscon_type;
+
+static struct map_desc realview_dt_io_desc[] __initdata = {
+	{
+		/* FIXME: static map needed for LED driver */
+		.virtual	= IO_ADDRESS(REALVIEW_SYS_BASE),
+		.pfn		= __phys_to_pfn(REALVIEW_SYS_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void __init realview_dt_map_io(void)
+{
+	iotable_init(realview_dt_io_desc, ARRAY_SIZE(realview_dt_io_desc));
+}
+
+/*
+ * We detect the different syscon types from the compatible strings.
+ */
+enum realview_syscon {
+	REALVIEW_SYSCON_EB,
+	REALVIEW_SYSCON_PB1176,
+	REALVIEW_SYSCON_PB11MP,
+	REALVIEW_SYSCON_PBA8,
+	REALVIEW_SYSCON_PBX,
+};
+
+static const struct of_device_id realview_syscon_match[] = {
+	{
+		.compatible = "arm,realview-eb-syscon",
+		.data = (void *)REALVIEW_SYSCON_EB,
+	},
+	{
+		.compatible = "arm,realview-pb1176-syscon",
+		.data = (void *)REALVIEW_SYSCON_PB1176,
+	},
+	{
+		.compatible = "arm,realview-pb11mp-syscon",
+		.data = (void *)REALVIEW_SYSCON_PB11MP,
+	},
+	{
+		.compatible = "arm,realview-pba8-syscon",
+		.data = (void *)REALVIEW_SYSCON_PBA8,
+	},
+	{
+		.compatible = "arm,realview-pbx-syscon",
+		.data = (void *)REALVIEW_SYSCON_PBX,
+	},
+};
+
+static void __init realview_dt_init_machine(void)
+{
+	struct device_node *root;
+	struct device_node *syscon;
+	const struct of_device_id *syscon_id;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+	struct device *parent;
+	u32 coreid;
+	int ret;
+
+#if IS_ENABLED(CONFIG_CACHE_L2X0)
+	if (of_machine_is_compatible("arm,realview-eb"))
+		/*
+		 * 1MB (128KB/way), 8-way associativity,
+		 * evmon/parity/share enabled
+		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
+		 */
+		l2x0_of_init(0x00790000, 0xfe000fff);
+	else if (of_machine_is_compatible("arm,realview-pb1176"))
+		/*
+		 * 128Kb (16Kb/way) 8-way associativity.
+		 * evmon/parity/share enabled.
+		 */
+		l2x0_of_init(0x00730000, 0xfe000fff);
+	else if (of_machine_is_compatible("arm,realview-pb11mp"))
+		/*
+		 * 1MB (128KB/way), 8-way associativity,
+		 * evmon/parity/share enabled
+		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
+		 */
+		l2x0_of_init(0x00730000, 0xfe000fff);
+	else if (of_machine_is_compatible("arm,realview-pbx"))
+		/*
+		 * 16KB way size, 8-way associativity, parity disabled
+		 * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... ....
+		 */
+		l2x0_of_init(0x02520000, 0xc0000fff);
+#endif
+
+        /* Here we create an SoC device for the root node */
+	root = of_find_node_by_path("/");
+	if (!root)
+		return;
+	syscon = of_find_matching_node_and_match(root, realview_syscon_match,
+						 &syscon_id);
+	if (!syscon)
+		return;
+	syscon_type = (enum realview_syscon)syscon_id->data;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return;
+	ret = of_property_read_string(root, "compatible",
+				      &soc_dev_attr->soc_id);
+	if (ret)
+		return;
+	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+        if (ret)
+		return;
+	soc_dev_attr->family = "RealView";
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr);
+		return;
+	}
+	parent = soc_device_to_device(soc_dev);
+	ret = of_platform_populate(root, of_default_bus_match_table,
+				   NULL, parent);
+	if (ret) {
+		pr_crit("could not populate device tree\n");
+		return;
+	}
+
+	syscon_regmap = syscon_node_to_regmap(syscon);
+	if (IS_ERR(syscon_regmap)) {
+		pr_crit("could not locate syscon regmap\n");
+		return;
+	}
+	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET, &coreid);
+	if (ret)
+		return;
+	pr_info("RealView Syscon type %02x, Core ID: 0x%08x\n",
+		syscon_type, coreid);
+	/* FIXME: add attributes for SoC to sysfs */
+}
+
+static void realview_dt_restart(enum reboot_mode mode, const char *cmd)
+{
+	if (IS_ERR(syscon_regmap))
+		return;
+
+	/* Unlock the reset register */
+	regmap_write(syscon_regmap, REALVIEW_SYS_LOCK_OFFSET,
+		     REALVIEW_SYS_LOCK_VAL);
+	/* Then hit reset on the different machines */
+	switch (syscon_type) {
+	case REALVIEW_SYSCON_EB:
+		regmap_write(syscon_regmap,
+			     REALVIEW_SYS_RESETCTL_OFFSET, 0x0008);
+		break;
+	case REALVIEW_SYSCON_PB1176:
+		regmap_write(syscon_regmap,
+			     REALVIEW_SYS_RESETCTL_OFFSET, 0x0100);
+		break;
+	case REALVIEW_SYSCON_PB11MP:
+	case REALVIEW_SYSCON_PBA8:
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x0000);
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x0004);
+		break;
+	case REALVIEW_SYSCON_PBX:
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x00f0);
+		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
+			     0x00f4);
+		break;
+	}
+	dsb();
+}
+
+static const char *realview_dt_platform_compat[] __initconst = {
+	"arm,realview-eb",
+	"arm,realview-pb1176",
+	"arm,realview-pb11mp",
+	"arm,realview-pba8",
+	"arm,realview-pbx",
+	NULL,
+};
+
+DT_MACHINE_START(REALVIEW_DT, "ARM RealView Machine (Device Tree Support)")
+	.map_io		= realview_dt_map_io,
+	.init_machine	= realview_dt_init_machine,
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_256M,
+#endif
+	.dt_compat	= realview_dt_platform_compat,
+	.restart	= realview_dt_restart,
+MACHINE_END
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5bf7c3c3b301..5461c4401ed6 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -928,7 +928,7 @@ config ARM_L1_CACHE_SHIFT
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
 	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
-		     MACH_REALVIEW_PB11MP)
+		     MACH_REALVIEW_PB11MP || REALVIEW_DT)
 	default y if CPU_V6 || CPU_V6K || CPU_V7
 	help
 	  Historically, the kernel has used strongly ordered mappings to
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 57d165e026f4..70281b38c73b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1073,6 +1073,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 }
 IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
+IRQCHIP_DECLARE(arm1176jzf_gic, "arm,arm1176jzf-gic", gic_of_init);
 IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 
-- 
1.9.0
