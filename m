From: magnus.damm@gmail.com (Magnus Damm)
Date: Sat, 12 May 2012 04:42:49 +0900
Subject: [PATCH 06/06] mach-shmobile: Emma Mobile EV2 DT support V2
In-Reply-To: <20120511194151.6567.53888.sendpatchset@w520>
References: <20120511194151.6567.53888.sendpatchset@w520>
Message-ID: <20120511194249.6567.21685.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This is EMEV2 DT support V2. The support is limited to
whatever devices that are complied in the kernel. At this
point we have UARTs handled by "em-uart" and a timer
handled by "em-sti". Clocks and SMP are not supported.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - cleaned up the command line in the dts file
 - removed call to clock setup code - this should be done through DT
 - removed map io callback
 - removed Makefile hacks, people will have to add them by themselves

 arch/arm/boot/dts/emev2-kzm9d.dts    |   66 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-emev2.c |    5 ++
 arch/arm/mach-shmobile/setup-emev2.c |   47 +++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 1 deletion(-)

--- /dev/null
+++ work/arch/arm/boot/dts/emev2-kzm9d.dts	2012-05-12 03:59:57.000000000 +0900
@@ -0,0 +1,66 @@
+/dts-v1/;
+
+/ {
+	model = "EMEV2 KZM9D Board";
+	compatible = "renesas,emev2";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+		};
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
+	gic: interrupt-controller at e0020000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0xe0028000 0x1000>,
+		      <0xe0020000 0x0100>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS1,115200n81";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0x8000000>; /* 128 MB */
+	};
+
+	sti at e0180000 {
+		compatible = "renesas,em-sti";
+		reg = <0xe0180000 0x54>;
+		interrupts = <0 125 0>;
+       };
+
+	uart at e1020000 {
+		compatible = "renesas,em-uart";
+		reg = <0xe1020000 0x38>;
+		interrupts = <0 8 0>;
+       };
+
+	uart at e1030000 {
+		compatible = "renesas,em-uart";
+		reg = <0xe1030000 0x38>;
+		interrupts = <0 9 0>;
+       };
+
+	uart at e1040000 {
+		compatible = "renesas,em-uart";
+		reg = <0xe1040000 0x38>;
+		interrupts = <0 10 0>;
+       };
+
+	uart at e1050000 {
+		compatible = "renesas,em-uart";
+		reg = <0xe1050000 0x38>;
+		interrupts = <0 11 0>;
+       };
+};
--- 0009/arch/arm/mach-shmobile/clock-emev2.c
+++ work/arch/arm/mach-shmobile/clock-emev2.c	2012-05-12 03:53:42.000000000 +0900
@@ -191,10 +191,15 @@ static int __init emev2_sclkdiv_register
 
 static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("serial8250-em.0", &gclk_clks[GCLK_USIAU0_SCLK]),
+	CLKDEV_DEV_ID("e1020000.uart", &gclk_clks[GCLK_USIAU0_SCLK]),
 	CLKDEV_DEV_ID("serial8250-em.1", &gclk_clks[GCLK_USIBU1_SCLK]),
+	CLKDEV_DEV_ID("e1030000.uart", &gclk_clks[GCLK_USIBU1_SCLK]),
 	CLKDEV_DEV_ID("serial8250-em.2", &gclk_clks[GCLK_USIBU2_SCLK]),
+	CLKDEV_DEV_ID("e1040000.uart", &gclk_clks[GCLK_USIBU2_SCLK]),
 	CLKDEV_DEV_ID("serial8250-em.3", &gclk_clks[GCLK_USIBU3_SCLK]),
+	CLKDEV_DEV_ID("e1050000.uart", &gclk_clks[GCLK_USIBU3_SCLK]),
 	CLKDEV_DEV_ID("em_sti.0", &gclk_clks[GCLK_STI_SCLK]),
+	CLKDEV_DEV_ID("e0180000.sti", &gclk_clks[GCLK_STI_SCLK]),
 };
 
 void __init emev2_clock_init(void)
--- 0010/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2012-05-12 03:54:56.000000000 +0900
@@ -22,9 +22,11 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-em.h>
+#include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
+#include <linux/of_irq.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/emev2.h>
@@ -381,9 +383,14 @@ void __init emev2_add_standard_devices(v
 			     ARRAY_SIZE(emev2_late_devices));
 }
 
-void __init emev2_add_early_devices(void)
+void __init emev2_init_delay(void)
 {
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
+}
+
+void __init emev2_add_early_devices(void)
+{
+	emev2_init_delay();
 
 	early_platform_add_devices(emev2_early_devices,
 				   ARRAY_SIZE(emev2_early_devices));
@@ -405,3 +412,41 @@ void __init emev2_init_irq(void)
 	/* Use GIC to handle interrupts */
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 }
+
+#ifdef CONFIG_USE_OF
+static const struct of_dev_auxdata emev2_auxdata_lookup[] __initconst = {
+	{ }
+};
+
+void __init emev2_add_standard_devices_dt(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     emev2_auxdata_lookup, NULL);
+}
+
+static const struct of_device_id emev2_dt_irq_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{},
+};
+
+static const char *emev2_boards_compat_dt[] __initdata = {
+	"renesas,emev2",
+	NULL,
+};
+
+void __init emev2_init_irq_dt(void)
+{
+	of_irq_init(emev2_dt_irq_match);
+}
+
+DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
+	.init_early	= emev2_init_delay,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= emev2_init_irq_dt,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= emev2_add_standard_devices_dt,
+	.timer		= &shmobile_timer,
+	.dt_compat	= emev2_boards_compat_dt,
+MACHINE_END
+
+#endif /* CONFIG_USE_OF */
