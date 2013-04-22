From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:52:20 +0200
Subject: [PATCH 06/23] ARM: u300: basic device tree support
Message-ID: <1366624340-6293-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This register the most basic peripherals and makes the
U300 boot to prompt from a device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/ste-u300.txt |  9 +++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/ste-u300.dts                     | 86 ++++++++++++++++++++++
 arch/arm/mach-u300/core.c                          | 80 ++++++++++++++++++++
 4 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ste-u300.txt
 create mode 100644 arch/arm/boot/dts/ste-u300.dts

diff --git a/Documentation/devicetree/bindings/arm/ste-u300.txt b/Documentation/devicetree/bindings/arm/ste-u300.txt
new file mode 100644
index 0000000..222dca5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ste-u300.txt
@@ -0,0 +1,9 @@
+ST-Ericsson U300 Device Tree Bindings
+
+For various board the "board" node may contain specific properties
+that pertain to this particular board, such as board-specific GPIOs
+or board power regulator supplies.
+
+Required root node property:
+
+compatible="stericsson,u300";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..369fba7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -165,6 +165,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra30-cardhu-a04.dtb \
 	tegra114-dalmore.dtb \
 	tegra114-pluto.dtb
+dtb-$(CONFIG_ARCH_U300) += ste-u300.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
 	vexpress-v2p-ca9.dtb \
 	vexpress-v2p-ca15-tc1.dtb \
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
new file mode 100644
index 0000000..80f963c
--- /dev/null
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -0,0 +1,86 @@
+/*
+ * Device Tree for the ST-Ericsson U300 Machine and SoC
+ */
+
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "ST-Ericsson U300";
+	compatible = "stericsson,u300";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+		bootargs = "root=/dev/ram0 console=ttyAMA0,115200n8 earlyprintk";
+	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+        };
+
+	memory {
+		reg = <0x48000000 0x03c00000>;
+	};
+
+	timer: timer0 at c0014000 {
+		compatible = "stericsson,u300-apptimer";
+		reg = <0xc0014000 0x1000>;
+		interrupt-parent = <&vica>;
+		interrupts = <24 25 26 27>;
+	};
+
+	gpio: gpio0 at c0016000 {
+		compatible = "stericsson,gpio-coh901";
+		reg = <0xc0016000 0x1000>;
+		interrupt-parent = <&vicb>;
+		interrupts = <0 1 2 18 21 22 23>;
+		interrupt-names = "gpio0", "gpio1", "gpio2", "gpio3",
+				"gpio4", "gpio5", "gpio6";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pinctrl: pinctrl0 at c0011000 {
+		compatible = "stericsson,pinctrl-u300";
+		reg = <0xc0011000 0x1000>;
+	};
+
+	amba {
+		compatible = "arm,amba-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vica: intc at 0xa0001000 {
+			compatible = "arm,versatile-vic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0xa0001000 0x20>;
+		};
+
+		vicb: intc at 0xa0002000 {
+			compatible = "arm,versatile-vic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0xa0002000 0x20>;
+		};
+
+		uart0: uart at c0013000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xc0013000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <22>;
+		};
+
+		uart1: uart at c0007000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xc0007000 0x1000>;
+			interrupt-parent = <&vicb>;
+			interrupts = <20>;
+		};
+	};
+};
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index a683d17..5b42983 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -33,6 +33,8 @@
 #include <linux/platform_data/pinctrl-coh901.h>
 #include <linux/platform_data/dma-coh901318.h>
 #include <linux/irqchip/arm-vic.h>
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -698,3 +700,81 @@ MACHINE_START(U300, "Ericsson AB U335 S335/B335 Prototype Board")
 	.init_machine	= u300_init_machine,
 	.restart	= u300_restart,
 MACHINE_END
+
+#ifdef CONFIG_OF
+
+/* These are mostly to get the right device names for the clock lookups */
+static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("stericsson,pinctrl-u300", U300_SYSCON_BASE,
+		"pinctrl-u300", NULL),
+	OF_DEV_AUXDATA("stericsson,gpio-coh901", U300_GPIO_BASE,
+		"u300-gpio", &u300_gpio_plat),
+	OF_DEV_AUXDATA("arm,primecell", U300_UART0_BASE,
+		"uart0", &uart0_plat_data),
+	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
+		"uart1", &uart1_plat_data),
+	OF_DEV_AUXDATA("arm,primecell", U300_MMCSD_BASE,
+		"mmci", &mmcsd_platform_data),
+	{ /* sentinel */ },
+};
+
+static void __init u300_init_irq_dt(void)
+{
+	struct clk *clk;
+
+	/* initialize clocking early, we want to clock the INTCON */
+	u300_clk_init(U300_SYSCON_VBASE);
+
+	/* Bootstrap EMIF and SEMI clocks */
+	clk = clk_get_sys("pl172", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
+	clk = clk_get_sys("semi", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
+
+	/* Clock the interrupt controller */
+	clk = clk_get_sys("intcon", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
+
+	irqchip_init();
+}
+
+static void __init u300_init_machine_dt(void)
+{
+	u16 val;
+
+	/* Check what platform we run and print some status information */
+	u300_init_check_chip();
+
+	u300_assign_physmem();
+
+	/* Initialize pinmuxing */
+	pinctrl_register_mappings(u300_pinmux_map,
+				  ARRAY_SIZE(u300_pinmux_map));
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			u300_auxdata_lookup, NULL);
+
+	/* Enable SEMI self refresh */
+	val = readw(U300_SYSCON_VBASE + U300_SYSCON_SMCR) |
+		U300_SYSCON_SMCR_SEMI_SREFREQ_ENABLE;
+	writew(val, U300_SYSCON_VBASE + U300_SYSCON_SMCR);
+}
+
+static const char * u300_board_compat[] = {
+	"stericsson,u300",
+	NULL,
+};
+
+DT_MACHINE_START(U300_DT, "U300 S335/B335 (Device Tree)")
+	.map_io		= u300_map_io,
+	.init_irq	= u300_init_irq_dt,
+	.init_time	= u300_timer_init,
+	.init_machine	= u300_init_machine_dt,
+	.restart	= u300_restart,
+	.dt_compat      = u300_board_compat,
+MACHINE_END
+
+#endif /* CONFIG_OF */
-- 
1.7.11.3
