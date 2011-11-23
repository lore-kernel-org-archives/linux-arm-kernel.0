From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 23 Nov 2011 15:01:48 +0000
Subject: [PATCH v2 4/4] ARM: vexpress: DT-based support for CoreTiles Express
 A5x2 and A9x4
In-Reply-To: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1322060508-11298-5-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Device Trees for ARM Ltd. CoreTile Express A5x2
and CoreTile Express A9x4 used with V2M motherboard and an initial
implementation of the DT machine support (this code is separate
from the current core tile code).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts |  132 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts  |  146 +++++++++++++++++++++++++++++++
 arch/arm/mach-vexpress/Kconfig          |   21 +++++
 arch/arm/mach-vexpress/Makefile         |    1 +
 arch/arm/mach-vexpress/v2p-ca5s_ca9.c   |  115 ++++++++++++++++++++++++
 5 files changed, 415 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
 create mode 100644 arch/arm/mach-vexpress/v2p-ca5s_ca9.c

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
new file mode 100644
index 0000000..84e05cd
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -0,0 +1,132 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * CoreTile Express A5x2
+ * Cortex-A5 MPCore (V2P-CA5s)
+ *
+ * HBI-0225B
+ */
+
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "V2P-CA5s";
+	arm,hbi = <0x225>;
+	compatible = "arm,vexpress-v2p-ca5s";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &mb_serial0;
+		serial1 = &mb_serial1;
+		serial2 = &mb_serial2;
+		serial3 = &mb_serial3;
+		i2c0 = &mb_i2c_dvi;
+		i2c1 = &mb_i2c_pcie;
+		timer = &mb_timer01;
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	hdlcd at 2a110000 {
+		compatible = "arm,hdlcd";
+		reg = <0x2a110000 0x1000>;
+		interrupts = <0 85 4>;
+	};
+
+	memory-controller at 2a150000 {
+		compatible = "arm,pl341", "arm,primecell";
+		reg = <0x2a150000 0x1000>;
+	};
+
+	memory-controller at 2a190000 {
+		compatible = "arm,pl354", "arm,primecell";
+		reg = <0x2a190000 0x1000>;
+		interrupts = <0 86 4>,
+			     <0 87 4>;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x2c001000 0x1000>,
+		      <0x2c000100 0x100>;
+	};
+
+	L2: cache-controller at 2c0f0000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x2c0f0000 0x1000>;
+		interrupts = <0 84 4>;
+		cache-level = <2>;
+		arm,data-latency = <0>;
+		arm,tag-latency = <0>;
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
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
new file mode 100644
index 0000000..ae6b70c
--- /dev/null
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -0,0 +1,146 @@
+/*
+ * ARM Ltd. Versatile Express
+ *
+ * CoreTile Express A9x4
+ * Cortex-A9 MPCore (V2P-CA9)
+ *
+ * HBI-0191B
+ */
+
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "V2P-CA9";
+	arm,hbi = <0x191>;
+	compatible = "arm,vexpress-v2p-ca9";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &mb_serial0;
+		serial1 = &mb_serial1;
+		serial2 = &mb_serial2;
+		serial3 = &mb_serial3;
+		i2c0 = &mb_i2c_dvi;
+		i2c1 = &mb_i2c_pcie;
+		timer = &mb_timer01;
+	};
+
+	memory at 60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	clcd at 10020000 {
+		compatible = "arm,pl111", "arm,primecell";
+		reg = <0x10020000 0x1000>;
+		interrupts = <0 44 4>;
+	};
+
+	memory-controller at 100e0000 {
+		compatible = "arm,pl341", "arm,primecell";
+		reg = <0x100e0000 0x1000>;
+	};
+
+	memory-controller at 100e1000 {
+		compatible = "arm,pl354", "arm,primecell";
+		reg = <0x100e1000 0x1000>;
+		interrupts = <0 45 4>,
+			     <0 46 4>;
+	};
+
+	timer at 100e4000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0x100e4000 0x1000>;
+		interrupts = <0 48 4>,
+			     <0 49 4>;
+	};
+
+	watchdog at 100e5000 {
+		compatible = "arm,sp805", "arm,primecell";
+		reg = <0x100e5000 0x1000>;
+		interrupts = <0 51 4>;
+	};
+
+	gic: interrupt-controller at 1e001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x1e001000 0x1000>,
+		      <0x1e000100 0x100>;
+	};
+
+	L2: cache-controller at 1e00a000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x1e00a000 0x1000>;
+		interrupts = <0 43 4>;
+		cache-level = <2>;
+		arm,data-latency = <0>;
+		arm,tag-latency = <0>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 60 4>,
+			     <0 61 4>,
+			     <0 62 4>,
+			     <0 63 4>;
+	};
+
+	motherboard {
+		ranges = <0 0 0x40000000 0x04000000>,
+			 <1 0 0x44000000 0x04000000>,
+			 <2 0 0x48000000 0x04000000>,
+			 <3 0 0x4c000000 0x04000000>,
+			 <7 0 0x10000000 0x00020000>;
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
+/include/ "vexpress-v2m.dtsi"
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 2180888..0f31125 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -23,4 +23,25 @@ config ARCH_VEXPRESS_RS1
 	  RS1 VE memory map (i.a. motherboard peripherals at
 	  0x1c000000, RAM at 0x80000000).
 
+config ARCH_VEXPRESS_V2P_CA5S_CA9
+	bool "CoreTile Express A5x2 and A9x4 based platform support"
+	select ARCH_VEXPRESS_RS1
+	select ARCH_VEXPRESS_DT
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_751472
+	select ARM_ERRATA_753970
+	help
+	  This option enables support for systems using any of the following
+	  ARM core tiles on the Versatile Express motherboard:
+
+	  - CoreTile Express A5x2 (V2P-CA5s)
+	  - CoreTile Express A9x4 (V2P-CA9)
+
+	  You must boot using a Flattened Device Tree in order to use these
+	  platforms.  The traditional (ATAGs) boot method is not usable on
+	  these boards with this option.
+
+	  If you want your kernel to run on one of these platforms and your
+	  bootloader supports Flattened Device Tree based booting, say Y.
+
 endmenu
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 90551b9..06e3687 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -4,5 +4,6 @@
 
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
+obj-$(CONFIG_ARCH_VEXPRESS_V2P_CA5S_CA9) += v2p-ca5s_ca9.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/v2p-ca5s_ca9.c b/arch/arm/mach-vexpress/v2p-ca5s_ca9.c
new file mode 100644
index 0000000..5a1e1ea
--- /dev/null
+++ b/arch/arm/mach-vexpress/v2p-ca5s_ca9.c
@@ -0,0 +1,115 @@
+/*
+ * Device Tree based support for ARM Versatile Express platform using:
+ * - CoreTile Express A5x2 (V2P-CA5s)
+ * - CoreTile Express A9x4 (V2P-CA9)
+ */
+
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/smp_scu.h>
+#include <asm/smp_twd.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/motherboard.h>
+
+#include "core.h"
+
+#define A5_A9_MPCORE_SCU	0x0000
+#define A5_A9_MPCORE_TWD	0x0600
+
+static struct map_desc v2p_ca5s_ca9_io_desc[] __initdata = {
+	{
+		.virtual	= V2T_PERIPH,
+		/* .pfn	set in v2p_ca5s_ca9_map_io() */
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	},
+};
+
+#ifdef CONFIG_SMP
+static void __init v2p_ca5s_ca9_init_cpu_map(void)
+{
+	int i, ncores = scu_get_core_count(V2T_PERIPH_P2V(A5_A9_MPCORE_SCU));
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+				ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; ++i)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+static void __init v2p_ca5s_ca9_smp_enable(unsigned int max_cpus)
+{
+	scu_enable(V2T_PERIPH_P2V(A5_A9_MPCORE_SCU));
+}
+
+static struct ct_desc v2p_ca5s_ca9_smp_callbacks __initdata = {
+	.init_cpu_map = v2p_ca5s_ca9_init_cpu_map,
+	.smp_enable = v2p_ca5s_ca9_smp_enable,
+};
+#endif
+
+static void __init v2p_ca5s_ca9_map_io(void)
+{
+	u32 mpcore_periph;
+
+	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (mpcore_periph));
+	v2p_ca5s_ca9_io_desc[0].pfn = __phys_to_pfn(mpcore_periph);
+	iotable_init(v2p_ca5s_ca9_io_desc, ARRAY_SIZE(v2p_ca5s_ca9_io_desc));
+
+	v2m_dt_map_io();
+
+#ifdef CONFIG_SMP
+	ct_desc = &v2p_ca5s_ca9_smp_callbacks;
+#endif
+}
+
+static void __init v2p_ca5s_ca9_init_early(void)
+{
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = V2T_PERIPH_P2V(A5_A9_MPCORE_TWD);
+#endif
+	v2m_dt_init_early();
+}
+
+static  struct of_device_id v2p_ca5s_ca9_irq_match[] __initdata = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{}
+};
+
+static void __init v2p_ca5s_ca9_init_irq(void)
+{
+	of_irq_init(v2p_ca5s_ca9_irq_match);
+}
+
+static void __init v2p_ca5s_ca9_init(void)
+{
+	l2x0_of_init(0x00400000, 0xfe0fffff);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			v2m_dt_get_auxdata(), NULL);
+}
+
+static const char *v2p_ca5s_ca9_dt_match[] __initdata = {
+	"arm,vexpress-v2p-ca5s",
+	"arm,vexpress-v2p-ca9",
+	NULL,
+};
+
+DT_MACHINE_START(VEXPRESS_V2P_CA5S_CA9, "ARM Versatile Express")
+	.map_io		= v2p_ca5s_ca9_map_io,
+	.init_early	= v2p_ca5s_ca9_init_early,
+	.init_irq	= v2p_ca5s_ca9_init_irq,
+	.timer		= &v2m_timer,
+	.init_machine	= v2p_ca5s_ca9_init,
+	.dt_compat	= v2p_ca5s_ca9_dt_match,
+MACHINE_END
-- 
1.6.3.3
