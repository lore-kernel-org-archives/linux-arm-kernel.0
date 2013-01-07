From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:56:28 +0100
Subject: [PATCH 06/11] ARM: nomadik: move GPIO and pinctrl to device tree
Message-ID: <1357599388-7523-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the instances of the Nomadik pin controller and the
Nomadik GPIO blocks (also handled by the GPIO driver) over to
the device tree. A new compatible string is added to the
pin control driver in the process.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 52 ++++++++++++++++++++++++++++++
 arch/arm/mach-nomadik/cpu-8815.c           | 21 +++++++++---
 drivers/pinctrl/pinctrl-nomadik.c          |  4 +++
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 8369eb0..df60e08 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -32,6 +32,58 @@
 		interrupts = <5>;
 	};
 
+	gpio0: gpio at 101e4000 {
+		compatible = "st,nomadik-gpio";
+		reg =  <0x101e4000 0x80>;
+		interrupt-parent = <&vica>;
+		interrupts = <6>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-bank = <0>;
+	};
+
+	gpio1: gpio at 101e5000 {
+		compatible = "st,nomadik-gpio";
+		reg =  <0x101e5000 0x80>;
+		interrupt-parent = <&vica>;
+		interrupts = <7>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-bank = <1>;
+	};
+
+	gpio2: gpio at 101e6000 {
+		compatible = "st,nomadik-gpio";
+		reg =  <0x101e6000 0x80>;
+		interrupt-parent = <&vica>;
+		interrupts = <8>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-bank = <2>;
+	};
+
+	gpio3: gpio at 101e7000 {
+		compatible = "st,nomadik-gpio";
+		reg =  <0x101e7000 0x80>;
+		interrupt-parent = <&vica>;
+		interrupts = <9>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-bank = <3>;
+	};
+
+	pinctrl {
+		compatible = "stericsson,nmk-pinctrl-stn8815";
+	};
+
 	/* A NAND flash of 128 MiB */
 	fsmc: flash at 40000000 {
 		compatible = "stericsson,fsmc-nand";
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 6bec72f..543e2c0 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -153,13 +153,15 @@ static int __init cpu8815_init(void)
 		/* No custom data yet */
 	};
 
+	/* For e.g. device tree boots */
+	if (!machine_is_nomadik())
+		return 0;
+
 	cpu8815_add_gpios(cpu8815_gpio_base, ARRAY_SIZE(cpu8815_gpio_base),
 			  IRQ_GPIO0, &pdata);
 	cpu8815_add_pinctrl(NULL, "pinctrl-stn8815");
-	if (machine_is_nomadik()) {
-		amba_apb_device_add(NULL, "rng", NOMADIK_RNG_BASE, SZ_4K, 0, 0, NULL, 0);
-		amba_apb_device_add(NULL, "rtc-pl031", NOMADIK_RTC_BASE, SZ_4K, IRQ_RTC_RTT, 0, NULL, 0);
-	}
+	amba_apb_device_add(NULL, "rng", NOMADIK_RNG_BASE, SZ_4K, 0, 0, NULL, 0);
+	amba_apb_device_add(NULL, "rtc-pl031", NOMADIK_RTC_BASE, SZ_4K, IRQ_RTC_RTT, 0, NULL, 0);
 	return 0;
 }
 arch_initcall(cpu8815_init);
@@ -276,6 +278,16 @@ static struct fsmc_nand_platform_data cpu8815_nand_data = {
 
 /* These are mostly to get the right device names for the clock lookups */
 static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO0_BASE,
+		"gpio.0", NULL),
+	OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO1_BASE,
+		"gpio.1", NULL),
+	OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO2_BASE,
+		"gpio.2", NULL),
+	OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO3_BASE,
+		"gpio.3", NULL),
+	OF_DEV_AUXDATA("stericsson,nmk-pinctrl-stn8815", 0,
+		"pinctrl-stn8815", NULL),
 	OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART0_BASE,
 		"uart0", NULL),
 	OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART1_BASE,
@@ -296,6 +308,7 @@ static void __init cpu8815_init_of(void)
 	/* At full speed latency must be >=2, so 0x249 in low bits */
 	l2x0_of_init(0x00730249, 0xfe000fff);
 #endif
+	pinctrl_register_mappings(nhk8815_pinmap, ARRAY_SIZE(nhk8815_pinmap));
 	of_platform_populate(NULL, of_default_bus_match_table,
 			cpu8815_auxdata_lookup, NULL);
 }
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index ef66f98..2c30849 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1840,6 +1840,10 @@ static struct pinctrl_desc nmk_pinctrl_desc = {
 
 static const struct of_device_id nmk_pinctrl_match[] = {
 	{
+		.compatible = "stericsson,nmk-pinctrl-stn8815",
+		.data = (void *)PINCTRL_NMK_STN8815,
+	},
+	{
 		.compatible = "stericsson,nmk_pinctrl",
 		.data = (void *)PINCTRL_NMK_DB8500,
 	},
-- 
1.7.11.7
