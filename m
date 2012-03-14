From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 13:05:01 +0000
Subject: [PATCH 05/10] ARM: ux500: db8500: list most devices in the snowball
 device tree
In-Reply-To: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1331730306-11461-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This adds all devices that are normally present through the
u8500_init_machine function in the device tree as well, which
will duplicate the devices that are visible.

This will not do much by itself because the device from the
device tree are not matched by any device driver until they
are converted as well. The next step is to move over one
device at a time to actually be used from the device tree
instead of the hardcoded device using auxdata to pass the
correct platform_data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi      |  228 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/snowball.dts     |  102 ++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c |   14 +++
 3 files changed, 343 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 50c84b2..0521cea 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -15,7 +15,233 @@
 	soc-u9500 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "simple-bus";
+		compatible = "stericsson,db8500";
 		ranges;
+
+		pmu {
+			compatible = "arm,cortex-a9-pmu";
+			interrupts = <7>;
+		};
+
+		rtc at 80154000 {
+			compatible = "stericsson,db8500-rtc";
+			reg = <0x80154000 0x1000>;
+			interrupts = <18>;
+		};
+
+		gpio0: gpio at 8012e000 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0x8012e000 0x80>;
+			interrupts = <119>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		gpio1: gpio at 8012e080 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0x8012e080 0x80>;
+			interrupts = <120>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		gpio2: gpio at 8000e000 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0x8000e000 0x80>;
+			interrupts = <121>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		gpio3: gpio at 8000e080 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0x8000e080 0x80>;
+			interrupts = <122>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		gpio4: gpio at 8000e100 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0x8000e100 0x80>;
+			interrupts = <123>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		gpio5: gpio at 8000e180 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0x8000e180 0x80>;
+			interrupts = <124>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		gpio6: gpio at 8011e000 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0x8011e000 0x80>;
+			interrupts = <125>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		gpio7: gpio at 8011e080 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0x8011e080 0x80>;
+			interrupts = <126>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		gpio8: gpio at a03fe000 {
+			compatible = "stericsson,db8500-gpio",
+				"stmicroelectronics,nomadik-gpio";
+			reg =  <0xa03fe000 0x80>;
+			interrupts = <127>;
+			supports-sleepmode;
+			gpio-controller;
+		};
+
+		usb at a03e0000 {
+			compatible = "stericsson,db8500-musb",
+				"mentor,musb";
+			reg = <0xa03e0000 0x10000>;
+			interrupts = <23>;
+		};
+
+		dma-controller at 801C0000 {
+			compatible = "stericsson,db8500-dma40",
+					"stericsson,dma40";
+			reg = <0x801C0000 0x1000 0x40010000 0x800>;
+			interrupts = <25>;
+		};
+
+		prcmu at 80157000 {
+			compatible = "stericsson,db8500-prcmu";
+			reg = <0x80157000 0x1000>;
+			interrupts = <46 47>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ab8500 at 5 {
+				compatible = "stericsson,ab8500";
+				reg = <5>; /* mailbox 5 is i2c */
+				interrupts = <40>;
+			};
+		};
+
+		i2c at 80004000 {
+			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			reg = <0x80004000 0x1000>;
+			interrupts = <21>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c at 80122000 {
+			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			reg = <0x80122000 0x1000>;
+			interrupts = <22>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c at 80128000 {
+			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			reg = <0x80128000 0x1000>;
+			interrupts = <55>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c at 80110000 {
+			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			reg = <0x80110000 0x1000>;
+			interrupts = <12>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c at 8012a000 {
+			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			reg = <0x8012a000 0x1000>;
+			interrupts = <51>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		ssp at 80002000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <80002000 0x1000>;
+			interrupts = <14>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+			cs-gpios = <&gpio0 31 &gpio4 14 &gpio4 16 &gpio6 22 &gpio7 0>;
+		};
+
+		uart at 80120000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x80120000 0x1000>;
+			interrupts = <11>;
+			status = "disabled";
+		};
+		uart at 80121000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x80121000 0x1000>;
+			interrupts = <19>;
+			status = "disabled";
+		};
+		uart at 80007000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x80007000 0x1000>;
+			interrupts = <26>;
+			status = "disabled";
+		};
+
+		sdi at 80126000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x80126000 0x1000>;
+			interrupts = <60>;
+			status = "disabled";
+		};
+		sdi at 80118000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x80118000 0x1000>;
+			interrupts = <50>;
+			status = "disabled";
+		};
+		sdi at 80005000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x80005000 0x1000>;
+			interrupts = <41>;
+			status = "disabled";
+		};
+		sdi at 80119000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x80119000 0x1000>;
+			interrupts = <59>;
+			status = "disabled";
+		};
+		sdi at 80114000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x80114000 0x1000>;
+			interrupts = <99>;
+			status = "disabled";
+		};
+		sdi at 80008000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			reg = <0x80114000 0x1000>;
+			interrupts = <100>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 0ea9470..34bfd79 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -20,6 +20,108 @@
 		reg = <0x00000000 0x20000000>;
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			linux,code = <2>;
+			label = "userpb";
+			gpios = <&gpio1 0>;
+		};
+		button at 2 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			linux,code = <3>;
+			label = "userpb";
+			gpios = <&gpio4 23>;
+		};
+		button at 3 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			linux,code = <4>;
+			label = "userpb";
+			gpios = <&gpio4 23>;
+		};
+		button at 4 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			linux,code = <5>;
+			label = "userpb";
+			gpios = <&gpio5 1>;
+		};
+		button at 5 {
+			debounce_interval = <50>;
+			wakeup = <1>;
+			linux,code = <6>;
+			label = "userpb";
+			gpios = <&gpio5 2>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		used-led {
+			label = "user_led";
+			gpios = <&gpio4 14>;
+		};
+	};
+
 	soc-u9500 {
+
+		external-bus at 50000000 {
+			compatible = "simple-bus";
+			reg = <0x50000000 0x10000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			ethernet at 50000000 {
+				compatible = "smsc,9111";
+				reg = <0x50000000 0x10000>;
+				interrupts = <12>;
+				interrupt-parent = <&gpio4>;
+			};
+		};
+
+		sdi at 80126000 {
+			status = "enabled";
+			cd-gpios = <&gpio6 26>;
+		};
+
+		sdi at 80114000 {
+			status = "enabled";
+		};
+
+		i2c at 80004000 {
+			tc3589x at 42 {
+				//compatible = "tc3589x";
+				reg = <0x42>;
+				interrupts = <25>;
+				interrupt-parent = <&gpio6>;
+			};
+			tps61052 at 33 {
+				//compatible = "tps61052";
+				reg = <0x33>;
+			};
+		};
+
+		i2c at 80128000 {
+			lp5521 at 0x33 {
+				// compatible = "lp5521";
+				reg = <0x33>;
+			};
+			lp5521 at 0x34 {
+				// compatible = "lp5521";
+				reg = <0x34>;
+			};
+			bh1780 at 0x29 {
+				// compatible = "rohm,bh1780gli";
+				reg = <0x33>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index e2932fc..482b86e 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -621,6 +621,7 @@ static void __init mop500_init_machine(void)
 
 	mop500_pins_init();
 
+	/* FIXME: parent of ab8500 should be prcmu */
 	for (i = 0; i < ARRAY_SIZE(mop500_platform_devs); i++)
 		mop500_platform_devs[i]->dev.parent = parent;
 
@@ -743,6 +744,17 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 MACHINE_END
 
 #ifdef CONFIG_MACH_UX500_DT
+
+struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
+	{},
+};
+
+static const struct of_device_id u8500_soc_node[] = {
+	/* only create devices below soc node */
+	{ .compatible = "stericsson,db8500", },
+	{ },
+};
+
 static void __init u8500_init_machine(void)
 {
 	struct device *parent = NULL;
@@ -757,6 +769,8 @@ static void __init u8500_init_machine(void)
 	for (i = 0; i < ARRAY_SIZE(snowball_platform_devs); i++)
 		snowball_platform_devs[i]->dev.parent = parent;
 
+	/* automatically probe child nodes of db8500 device */
+	of_platform_populate(NULL, u8500_soc_node, u8500_auxdata_lookup, parent);
 
 	if (of_machine_is_compatible("st-ericsson,mop500")) {
 		mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
-- 
1.7.5.4
