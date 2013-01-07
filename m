From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:55:59 +0100
Subject: [PATCH 02/11] ARM: nomadik: initial devicetree support
Message-ID: <1357599359-7385-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support basic device tree boot on the Nomadik. Implement the
support in the cpu file with the intent of deleting the board
files later. At this stage IRQ controllers, system timer,
l2x0 cache, UARTs and thus console boot is fully functional.
Patch out the code adding devices by initcalls for now so
as not to disturb the boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 18 ++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 77 +++++++++++++++++++++++++
 arch/arm/mach-nomadik/board-nhk8815.c      |  4 ++
 arch/arm/mach-nomadik/cpu-8815.c           | 90 ++++++++++++++++++++++++++++++
 arch/arm/mach-nomadik/cpu-8815.h           |  1 +
 arch/arm/mach-nomadik/i2c-8815nhk.c        |  5 ++
 7 files changed, 196 insertions(+)
 create mode 100644 arch/arm/boot/dts/ste-nomadik-s8815.dts
 create mode 100644 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e44da40..7bc5ba73 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
 	imx28-tx28.dtb
+dtb-$(CONFIG_ARCH_NOMADIK) += ste-nomadik-s8815.dtb
 dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-beagle.dtb \
 	omap3-beagle-xm.dtb \
diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
new file mode 100644
index 0000000..b698bc2
--- /dev/null
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -0,0 +1,18 @@
+/*
+ * Device Tree for the ST-Ericsson Nomadik S8815 board
+ * Produced by Calao Systems
+ */
+
+/dts-v1/;
+/include/ "ste-nomadik-stn8815.dtsi"
+
+/ {
+	model = "ST-Ericsson Nomadik S8815";
+	compatible = "stericsson,nomadik";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
+	};
+};
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
new file mode 100644
index 0000000..81284c5
--- /dev/null
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -0,0 +1,77 @@
+/*
+ * Device Tree for the ST-Ericsson Nomadik 8815 STn8815 SoC
+ */
+/include/ "skeleton.dtsi"
+
+/ {
+	memory {
+	       reg = <0x00000000 0x04000000>;
+	       reg = <0x08000000 0x04000000>;
+	};
+
+	L2: l2-cache {
+		compatible = "arm,l210-cache";
+		reg = <0x10210000 0x1000>;
+		interrupt-parent = <&vica>;
+		interrupts = <30>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	mtu0 {
+		/* Nomadik system timer */
+		reg = <0x101e2000 0x1000>;
+		interrupt-parent = <&vica>;
+		interrupts = <4>;
+	};
+
+	mtu1 {
+		/* Secondary timer */
+		reg = <0x101e3000 0x1000>;
+		interrupt-parent = <&vica>;
+		interrupts = <5>;
+	};
+
+	amba {
+		compatible = "arm,amba-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vica: intc at 0x10140000 {
+			compatible = "arm,versatile-vic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x10140000 0x20>;
+		};
+
+		vicb: intc at 0x10140020 {
+			compatible = "arm,versatile-vic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x10140020 0x20>;
+		};
+
+		uart0: uart at 101fd000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x101fd000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <12>;
+		};
+
+		uart1: uart at 101fb000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x101fb000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <17>;
+		};
+
+		uart2: uart at 101f2000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x101f2000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <28>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 75075ab..754bf8a 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -205,6 +205,10 @@ static int __init nhk8815_mmcsd_init(void)
 {
 	int ret;
 
+	/* For e.g. devicetree boot */
+	if (!machine_is_nomadik())
+		return 0;
+
 	ret = gpio_request(112, "card detect bias");
 	if (ret)
 		return ret;
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 1273931..f595b04 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -27,10 +27,16 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/clk-nomadik.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
+#include <linux/platform_data/clocksource-nomadik-mtu.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach/time.h>
 #include <asm/hardware/vic.h>
 
 #include <asm/cacheflush.h>
@@ -160,3 +166,87 @@ void cpu8815_restart(char mode, const char *cmd)
 	/* Write anything to Reset status register */
 	writel(1, src_rstsr);
 }
+
+#ifdef CONFIG_OF
+
+/* Lookup table for finding a DT node that represents the vic instance */
+static const struct of_device_id cpu8815_vic_of_match[] __initconst = {
+	{ .compatible = "arm,versatile-vic", .data = vic_of_init, },
+	{}
+};
+
+static void __init cpu8815_init_irq_of(void)
+{
+	of_irq_init(cpu8815_vic_of_match);
+	nomadik_clk_init();
+}
+
+/* Initial value for SRC control register: all timers use MXTAL/8 source */
+#define SRC_CR_INIT_MASK	0x00007fff
+#define SRC_CR_INIT_VAL		0x2aaa8000
+
+static void __init cpu8815_timer_init_of(void)
+{
+	struct device_node *mtu;
+	void __iomem *base;
+	int irq;
+	u32 src_cr;
+
+	mtu = of_find_node_by_path("/mtu0");
+	if (!mtu)
+		return;
+	base = of_iomap(mtu, 0);
+	if (WARN_ON(!base))
+		return;
+	irq = irq_of_parse_and_map(mtu, 0);
+
+	pr_info("Remapped MTU @ %p, irq: %d\n", base, irq);
+
+	/* Configure timer sources in "system reset controller" ctrl reg */
+	src_cr = readl(base);
+	src_cr &= SRC_CR_INIT_MASK;
+	src_cr |= SRC_CR_INIT_VAL;
+	writel(src_cr, base);
+
+	nmdk_timer_init(base, irq);
+}
+
+struct sys_timer cpu8815_of_timer = {
+	.init	= cpu8815_timer_init_of,
+};
+
+/* These are mostly to get the right device names for the clock lookups */
+static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART0_BASE,
+		"uart0", NULL),
+	OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART1_BASE,
+		"uart1", NULL),
+	{ /* sentinel */ },
+};
+
+static void __init cpu8815_init_of(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	/* At full speed latency must be >=2, so 0x249 in low bits */
+	l2x0_of_init(0x00730249, 0xfe000fff);
+#endif
+	of_platform_populate(NULL, of_default_bus_match_table,
+			cpu8815_auxdata_lookup, NULL);
+}
+
+static const char * cpu8815_board_compat[] = {
+	"stericsson,nomadik",
+	NULL,
+};
+
+DT_MACHINE_START(NOMADIK_DT, "ST-Ericsson Nomadik 8815")
+	.map_io		= cpu8815_map_io,
+	.init_irq	= cpu8815_init_irq_of,
+	.handle_irq	= vic_handle_irq,
+	.timer		= &cpu8815_of_timer,
+	.init_machine	= cpu8815_init_of,
+	.restart	= cpu8815_restart,
+	.dt_compat      = cpu8815_board_compat,
+MACHINE_END
+
+#endif
diff --git a/arch/arm/mach-nomadik/cpu-8815.h b/arch/arm/mach-nomadik/cpu-8815.h
index 71c21e8..d6c7830 100644
--- a/arch/arm/mach-nomadik/cpu-8815.h
+++ b/arch/arm/mach-nomadik/cpu-8815.h
@@ -2,3 +2,4 @@ extern void cpu8815_map_io(void);
 extern void cpu8815_platform_init(void);
 extern void cpu8815_init_irq(void);
 extern void cpu8815_restart(char, const char *);
+extern struct sys_timer cpu8815_timer;
diff --git a/arch/arm/mach-nomadik/i2c-8815nhk.c b/arch/arm/mach-nomadik/i2c-8815nhk.c
index f0e9e64..299ff5a 100644
--- a/arch/arm/mach-nomadik/i2c-8815nhk.c
+++ b/arch/arm/mach-nomadik/i2c-8815nhk.c
@@ -4,6 +4,7 @@
 #include <linux/i2c-algo-bit.h>
 #include <linux/i2c-gpio.h>
 #include <linux/platform_device.h>
+#include <asm/mach-types.h>
 
 /*
  * There are two busses in the 8815NHK.
@@ -58,6 +59,10 @@ static struct platform_device nhk8815_i2c_dev2 = {
 
 static int __init nhk8815_i2c_init(void)
 {
+	/* For e.g. devicetree boot */
+	if (!machine_is_nomadik())
+		return 0;
+
 	platform_device_register(&nhk8815_i2c_dev0);
 	platform_device_register(&nhk8815_i2c_dev1);
 	platform_device_register(&nhk8815_i2c_dev2);
-- 
1.7.11.7
