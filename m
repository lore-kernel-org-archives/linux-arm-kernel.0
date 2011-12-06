From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  6 Dec 2011 15:43:49 +0000
Subject: [PATCH v4 6/6] ARM: vexpress: DT-based support for Cortex-A7 and
 Cortex-A15 based tiles
In-Reply-To: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
References: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1323186229-22054-7-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Flattened Device Trees based support for ARM Ltd.
Versatile Express platforms based on Cortex-A7 and Cortex-A15
processors.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |  138 +++++++++++++++++++++++++++
 arch/arm/mach-vexpress/Kconfig              |   19 ++++
 arch/arm/mach-vexpress/Makefile             |    1 +
 arch/arm/mach-vexpress/Makefile.boot        |    1 +
 arch/arm/mach-vexpress/dt-ca7_ca15.c        |   95 ++++++++++++++++++
 arch/arm/mach-vexpress/include/mach/irqs.h  |    2 +-
 6 files changed, 255 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
 create mode 100644 arch/arm/mach-vexpress/dt-ca7_ca15.c

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
new file mode 100644
index 0000000..b19bb81
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -0,0 +1,138 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * CoreTile Express A15x2 (version with Test Chip 1)
+ * Cortex-A15 MPCore (V2P-CA15)
+ *
+ * HBI-0237A
+ */
+
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "V2P-CA15";
+	arm,hbi = <0x237>;
+	compatible = "arm,vexpress-v2p-ca15-tc1", "arm,vexpress-v2p-ca15", "arm,vexpress-cortex_a15";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &v2m_serial0;
+		serial1 = &v2m_serial1;
+		serial2 = &v2m_serial2;
+		serial3 = &v2m_serial3;
+		i2c0 = &v2m_i2c_dvi;
+		i2c1 = &v2m_i2c_pcie;
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	hdlcd at 2b000000 {
+		compatible = "arm,hdlcd";
+		reg = <0x2b000000 0x1000>;
+		interrupts = <0 85 4>;
+	};
+
+	memory-controller at 2b0a0000 {
+		compatible = "arm,pl341", "arm,primecell";
+		reg = <0x2b0a0000 0x1000>;
+	};
+
+	wdt at 2b060000 {
+		compatible = "arm,sp805", "arm,primecell";
+		reg = <0x2b060000 0x1000>;
+		interrupts = <98>;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x2c001000 0x1000>,
+		      <0x2c002000 0x100>;
+	};
+
+	memory-controller at 7ffd0000 {
+		compatible = "arm,pl354", "arm,primecell";
+		reg = <0x7ffd0000 0x1000>;
+		interrupts = <0 86 4>,
+			     <0 87 4>;
+	};
+
+	dma at 7ffb0000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x7ffb0000 0x1000>;
+		interrupts = <0 92 4>,
+			     <0 88 4>,
+			     <0 89 4>,
+			     <0 90 4>,
+			     <0 91 4>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 68 4>,
+			     <0 69 4>;
+	};
+
+	motherboard {
+		ranges = <0 0 0x08000000 0x04000000>,
+			 <1 0 0x14000000 0x04000000>,
+			 <2 0 0x18000000 0x04000000>,
+			 <3 0 0x1c000000 0x04000000>,
+			 <4 0 0x0c000000 0x04000000>,
+			 <5 0 0x10000000 0x04000000>;
+
+		interrupt-map-mask = <0 0 63>;
+		interrupt-map = <0 0  0 &gic 0  0 4>,
+				<0 0  1 &gic 0  1 4>,
+				<0 0  2 &gic 0  2 4>,
+				<0 0  3 &gic 0  3 4>,
+				<0 0  4 &gic 0  4 4>,
+				<0 0  5 &gic 0  5 4>,
+				<0 0  6 &gic 0  6 4>,
+				<0 0  7 &gic 0  7 4>,
+				<0 0  8 &gic 0  8 4>,
+				<0 0  9 &gic 0  9 4>,
+				<0 0 10 &gic 0 10 4>,
+				<0 0 11 &gic 0 11 4>,
+				<0 0 12 &gic 0 12 4>,
+				<0 0 13 &gic 0 13 4>,
+				<0 0 14 &gic 0 14 4>,
+				<0 0 15 &gic 0 15 4>,
+				<0 0 16 &gic 0 16 4>,
+				<0 0 17 &gic 0 17 4>,
+				<0 0 18 &gic 0 18 4>,
+				<0 0 19 &gic 0 19 4>,
+				<0 0 20 &gic 0 20 4>,
+				<0 0 21 &gic 0 21 4>,
+				<0 0 22 &gic 0 22 4>,
+				<0 0 23 &gic 0 23 4>,
+				<0 0 24 &gic 0 24 4>,
+				<0 0 25 &gic 0 25 4>,
+				<0 0 26 &gic 0 26 4>,
+				<0 0 27 &gic 0 27 4>,
+				<0 0 28 &gic 0 28 4>,
+				<0 0 29 &gic 0 29 4>,
+				<0 0 30 &gic 0 30 4>,
+				<0 0 31 &gic 0 31 4>,
+				<0 0 32 &gic 0 32 4>,
+				<0 0 33 &gic 0 33 4>,
+				<0 0 34 &gic 0 34 4>,
+				<0 0 35 &gic 0 35 4>,
+				<0 0 36 &gic 0 36 4>,
+				<0 0 37 &gic 0 37 4>,
+				<0 0 38 &gic 0 38 4>,
+				<0 0 39 &gic 0 39 4>,
+				<0 0 40 &gic 0 40 4>,
+				<0 0 41 &gic 0 41 4>,
+				<0 0 42 &gic 0 42 4>;
+	};
+};
+
+/include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index c1cd08d..e73c780 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -50,4 +50,23 @@ config ARCH_VEXPRESS_DT_CORTEX_A5_A9
 	  platforms. The traditional (ATAGs) boot method is not usable on
 	  these boards with this option.
 
+config ARCH_VEXPRESS_DT_CORTEX_A7_A15
+	bool "Support for tiles based on Cortex-A7 and Cortex-A15 processors"
+	depends on ARCH_VEXPRESS_DT
+	select ARM_GIC
+	select CPU_V7
+	help
+	  This option enables support for systems using Cortex-A5 and Cortex-A9
+	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
+	  for example:
+
+	  - CoreTile Express A15x2 (V2P-CA15)
+	  - LogicTile Express 13MG (V2F-2XV6) with A15 SMM (Soft Macrocell Model)
+	  - LogicTile Express 13MG (V2F-2XV6) with A7 SMM (Soft Macrocell Model)
+	  - VE Cortex-A15 RTSM (Model)
+
+	  You must boot using a Flattened Device Tree in order to use these
+	  platforms. The traditional (ATAGs) boot method is not usable on
+	  these boards with this option.
+
 endmenu
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 322e42d..70a5692 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -5,5 +5,6 @@
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
 obj-$(CONFIG_ARCH_VEXPRESS_DT_CORTEX_A5_A9)	+= dt-ca5_ca9.o
+obj-$(CONFIG_ARCH_VEXPRESS_DT_CORTEX_A7_A15)	+= dt-ca7_ca15.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index f0b0e60..376403c 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -6,3 +6,4 @@ initrd_phys-y	:= 0x60800000
 
 dtb-$(CONFIG_ARCH_VEXPRESS_DT_CORTEX_A5_A9)	+= vexpress-v2p-ca5s.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS_DT_CORTEX_A5_A9)	+= vexpress-v2p-ca9.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS_DT_CORTEX_A7_A15)	+= vexpress-v2p-ca15-tc1.dtb
diff --git a/arch/arm/mach-vexpress/dt-ca7_ca15.c b/arch/arm/mach-vexpress/dt-ca7_ca15.c
new file mode 100644
index 0000000..155628f
--- /dev/null
+++ b/arch/arm/mach-vexpress/dt-ca7_ca15.c
@@ -0,0 +1,95 @@
+/*
+ * Device Tree based support for ARM Versatile Express platforms
+ * using Cortex-A7 and Cortex-A15 processors.
+ */
+
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/smp_scu.h>
+#include <asm/smp_twd.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/motherboard.h>
+
+#include "core.h"
+
+#ifdef CONFIG_SMP
+static void __init dt_ca7_ca15_init_cpu_map(void)
+{
+	int i, ncores;
+
+	asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (ncores));
+	ncores = ((ncores >> 24) & 3) + 1;
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+				ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; ++i)
+		set_cpu_possible(i, true);
+}
+
+static void __init dt_ca7_ca15_smp_enable(unsigned int max_cpus)
+{
+	int i;
+
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+}
+
+static struct ct_desc dt_ca7_ca15_smp_callbacks __initdata = {
+	.init_cpu_map = dt_ca7_ca15_init_cpu_map,
+	.smp_enable = dt_ca7_ca15_smp_enable,
+};
+#endif
+
+static void __init dt_ca7_ca15_map_io(void)
+{
+	v2m_dt_map_io();
+
+#ifdef CONFIG_SMP
+	ct_desc = &dt_ca7_ca15_smp_callbacks;
+#endif
+}
+
+static void __init dt_ca7_ca15_init_early(void)
+{
+	v2m_dt_init_early();
+}
+
+static  struct of_device_id dt_ca7_ca15_irq_match[] __initdata = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{}
+};
+
+static void __init dt_ca7_ca15_init_irq(void)
+{
+	of_irq_init(dt_ca7_ca15_irq_match);
+}
+
+static void __init dt_ca7_ca15_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			v2m_dt_get_auxdata(), NULL);
+}
+
+static const char *dt_ca7_ca15_dt_match[] __initdata = {
+	"arm,vexpress-cortex_a7",
+	"arm,vexpress-cortex_a15",
+	NULL,
+};
+
+DT_MACHINE_START(VEXPRESS_CORTEX_A7_A15, "ARM Versatile Express")
+	.map_io		= dt_ca7_ca15_map_io,
+	.init_early	= dt_ca7_ca15_init_early,
+	.init_irq	= dt_ca7_ca15_init_irq,
+	.timer		= &v2m_dt_timer,
+	.init_machine	= dt_ca7_ca15_init,
+	.dt_compat	= dt_ca7_ca15_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-vexpress/include/mach/irqs.h b/arch/arm/mach-vexpress/include/mach/irqs.h
index 7054cbf..4b10ee7 100644
--- a/arch/arm/mach-vexpress/include/mach/irqs.h
+++ b/arch/arm/mach-vexpress/include/mach/irqs.h
@@ -1,4 +1,4 @@
 #define IRQ_LOCALTIMER		29
 #define IRQ_LOCALWDOG		30
 
-#define NR_IRQS	128
+#define NR_IRQS	256
-- 
1.6.3.3
