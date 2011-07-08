From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Jul 2011 18:20:28 +0800
Subject: [PATCH] ARM: mmp: add DTS file
In-Reply-To: <1310120428-22700-11-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-9-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-10-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-11-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1310120428-22700-12-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DTS file to support brownstone & ttc-dkb.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/boot/dts/mmp2-brownstone.dts |  319 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ttc-dkb.dts         |  176 ++++++++++++++++++
 arch/arm/mach-mmp/brownstone.c        |   66 ++-----
 arch/arm/mach-mmp/ttc_dkb.c           |   21 ++-
 4 files changed, 530 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/boot/dts/mmp2-brownstone.dts
 create mode 100644 arch/arm/boot/dts/ttc-dkb.dts

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
new file mode 100644
index 0000000..5fdabc3
--- /dev/null
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -0,0 +1,319 @@
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Marvell MMP2 Brownstone";
+	compatible = "mrvl,mmp2-brownstone", "mrvl,armada610-brownstone";
+	interrupt-parent = <&mmp_intc>;
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:192.168.1.101::255.255.255.0::eth0:on";
+		linux,stdout-path = &uart2;
+	};
+
+	soc at d4000000 {
+		compatible = "mrvl,mmp2", "mrvl,armada610", "simple-bus";
+		device_type = "soc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mmp_intc: interrupt-controller at d4282000 {
+			compatible = "mrvl,mmp-intc";
+			/*device_type = "intc";*/
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			/*
+			 * interrupts: irq index of parent's irq domain
+			 */
+			interrupts = <0>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <64>;
+
+			/* enable bits in conf register */
+			enable_mask = <0x20>;
+
+			/* reg: <offset & size> */
+			reg = <0xd4282000 0x400>;
+		};
+
+		mux_intc4: interrupt-controller at d4282150 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <4>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <2>;
+			reg = <0xd4282150 0>;
+			status-mask = <0x150 0x168>;
+			/* mfp register & interrupt index */
+			mfp-edge-interrupt = <0xd401e2c4 1>;
+		};
+
+		mux_intc5: interrupt-controller at d4282154 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <5>;
+			sub-interrupts = <2>;
+			interrupt-parent = <&mmp_intc>;
+			reg = <0xd4282154 0>;
+			status-mask = <0x154 0x16c>;
+		};
+
+		mux_intc9: interrupt-controller at d4282180 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <9>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <3>;
+			reg = <0xd4282180 0>;
+			status-mask = <0x180 0x17c>;
+		};
+
+		mux_intc17: interrupt-controller at d4282158 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <17>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <5>;
+			reg = <0xd4282158 0>;
+			status-mask = <0x158 0x170>;
+		};
+
+		mux_intc35: interrupt-controller at d428215c {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <35>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <15>;
+			reg = <0xd428215c 0>;
+			status-mask = <0x15c 0x174>;
+		};
+
+		mux_intc51: interrupt-controller at d4282160 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <51>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <2>;
+			reg = <0xd4282160 0>;
+			status-mask = <0x160 0x178>;
+		};
+
+		mux_intc55: interrupt-controller at d4282188 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <55>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <2>;
+			reg = <0xd4282188 0>;
+			status-mask = <0x188 0x184>;
+		};
+
+		gpio: gpio-controller {
+			compatible = "pxa,gpio";
+			gpio-controller;
+			reg = <
+				0xd4019000 0xb0
+				0xd4019004 0xb0
+				0xd4019008 0xb0
+				0xd4019100 0xb0
+				0xd4019104 0xb0
+				0xd4019108 0xb0>;
+
+			/* gpio-clk-value: <offset & value> */
+			gpio-clk-value = <0xd4015038 0x3>;
+
+			/* gpio-mask: <offset & value> */
+			gpio-mask = <
+				0xd401909c 0xffffffff
+				0xd40190a0 0xffffffff
+				0xd40190a4 0xffffffff
+				0xd401919c 0xffffffff
+				0xd40191a0 0xffffffff
+				0xd40191a4 0xffffffff>;
+			gpio-pins = <0 192>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts = <49>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <192>;
+		};
+
+		i2c0: i2c at d4011000 {
+			compatible = "pxa2xx-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xd4011000 0x60>;
+			cell-index = <0>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <7>;
+			interrupt-parent = <&mmp_intc>;
+
+			max8649: pmic at 60 {
+				compatible = "maxim,max8649";
+				reg = <0x60>;
+				max8649-mode = <2>;	/* VID1 = 1, VID0 = 0 */
+				/* <Ramp Timing, Active Ramp-Down Control > */
+				max8649-ramp = <0 0>;	/* 32mV/us, Deactive */
+
+				device_type = "regulator";
+				voltages = <750000 1380000>;
+				boot-on;
+				always-on;
+				ops-mask = "voltage", "status";
+				supply-name = "vcore";
+			};
+
+			max8925: pmic at 3c {
+				compatible = "maxim,max8925";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupt-controller;
+				interrupts = <1>;
+				interrupt-parent = <&mux_intc4>;
+				sub-interrupts = <32>;
+				reg = <0x3c>;
+
+				bk: backlight at 0 {
+					compatible = "backlight";
+					reg = <0>;
+				};
+
+				v_mipi: regulator at ldo3 {
+					compatible = "LDO3";
+					device_type = "regulator";
+					voltages = <1000000 1500000>;
+					boot-on;
+					always-on;
+					ops-mask = "voltage", "status";
+					supply-name = "mipi_1.2v";
+					reg = <0>;
+				};
+
+				touch: touch at 0 {
+					compatible = "touch";
+					interrupts = <101>;
+					interrupt-parent = <&gpio>;
+					reg = <0>;
+				};
+			};
+		};
+
+		i2c1: i2c at d4031000 {
+			compatible = "pxa2xx-i2c";
+			reg = <0xd4031000 0x60>;
+			cell-index = <1>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <0>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		i2c2: i2c at d4032000 {
+			compatible = "pxa2xx-i2c";
+			reg = <0xd4032000 0x60>;
+			cell-index = <2>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <1>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		i2c3: i2c at d4033000 {
+			compatible = "pxa2xx-i2c";
+			reg = <0xd4033000 0x60>;
+			cell-index = <3>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <2>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		i2c4: i2c at d4033800 {
+			compatible = "pxa2xx-i2c";
+			reg = <0xd4033800 0x60>;
+			cell-index = <4>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <3>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		i2c5: i2c at d4034000 {
+			compatible = "pxa2xx-i2c";
+			reg = <0xd4034000 0x60>;
+			cell-index = <5>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <4>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		uart0: uart at d4030000 {
+			compatible = "pxa,serial";
+			reg = <0xd4030000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <27>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <26000000>;
+			current-speed = <115200>;
+		};
+
+		uart1: uart at d4017000 {
+			compatible = "pxa,serial";
+			reg = <0xd4017000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <28>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <26000000>;
+			current-speed = <115200>;
+		};
+
+		uart2: uart at d4018000 {
+			compatible = "pxa,serial";
+			reg = <0xd4018000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <24>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <26000000>;
+			current-speed = <38400>;
+		};
+
+		uart3: uart at d4016000 {
+			compatible = "pxa,serial";
+			reg = <0xd4016000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <46>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <26000000>;
+			current-speed = <115200>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ttc-dkb.dts b/arch/arm/boot/dts/ttc-dkb.dts
new file mode 100644
index 0000000..9d50d12
--- /dev/null
+++ b/arch/arm/boot/dts/ttc-dkb.dts
@@ -0,0 +1,176 @@
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Marvell TTC DKB";
+	compatible = "mrvl,ttc-dkb", "mrvl,pxa910-dkb";
+	interrupt-parent = <&mmp_intc>;
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:192.168.1.101::255.255.255.0::eth0:on";
+		linux,stdout-path = &uart0;
+	};
+
+	soc at d4000000 {
+		compatible = "mrvl,pxa910", "simple-bus";
+		device_type = "soc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0xd4000000 0xd4000000 0x00200000	/* APB */
+			0xd4200000 0xd4200000 0x00200000>;	/* AXI */
+
+		mmp_intc: interrupt-controller at d4282000 {
+			compatible = "mrvl,mmp-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <0>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <64>;
+
+			/* enable bits in conf register */
+			enable_mask = <0x51>;
+
+			/* reg: <offset & size> */
+			reg = <0xd4282000 0x400>;
+		};
+
+		gpio: gpio-controller {
+			compatible = "pxa,gpio";
+			gpio-controller;
+			reg = <
+				0xd4019000 0xb0
+				0xd4019004 0xb0
+				0xd4019008 0xb0
+				0xd4019100 0xb0>;
+
+			/* gpio-clk-value: <offset & value> */
+			gpio-clk-value = <0xd4015008 0x3>;
+
+			/* gpio-mask: <offset & value> */
+			gpio-mask = <
+				0xd401909c 0xffffffff
+				0xd40190a0 0xffffffff
+				0xd40190a4 0xffffffff
+				0xd401919c 0xffffffff>;
+			gpio-pins = <0 128>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <49>;
+			interrupt-parent = <&mmp_intc>;
+			sub-interrupts = <128>;
+		};
+
+		i2c0: i2c at d4011000 {
+			compatible = "pxa2xx-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xd4011000 0x60>;
+			cell-index = <0>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <7>;
+			interrupt-parent = <&mmp_intc>;
+
+			pm860x: pmic at 34 {
+				compatible = "88PM860x";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupt-controller;
+				interrupts = <4>;
+				interrupt-parent = <&mmp_intc>;
+				sub-interrupts = <24>;
+				reg = <0x34>;
+				i2c-port = <0>;
+				irq-mode = <0>;
+				companion-addr = <0x11>;
+
+				bk: backlight at 0 {
+					compatible = "backlight";
+					cell-index = <0>;
+					iset = <8>;
+					reg = <0>;
+				};
+
+				led0: led at 0 {
+					compatible = "led";
+					cell-index = <0>;
+					iset = <8>;
+					reg = <0>;
+				};
+
+				led1: led at 1 {
+					compatible = "led";
+					cell-index = <1>;
+					iset = <8>;
+					reg = <0>;
+				};
+
+				led2: led at 2 {
+					compatible = "led";
+					cell-index = <2>;
+					iset = <8>;
+					reg = <0>;
+				};
+
+				touch: touch at 0 {
+					compatible = "touch";
+					interrupts = <15>;
+					interrupt-parent = <&pm860x>;
+					/* prebias: gpadc & ti & pen */
+					prebias = <1 6 16>;
+					slot-cycle = <1>;
+					pen-prechg = <2>;
+					resistor-xplate = <300>;
+					reg = <0>;
+				};
+
+				v_core: regulator at buck1 {
+					compatible = "BUCK1";
+					device_type = "regulator";
+					voltages = <900000 1400000>;
+					boot-on;
+					always-on;
+					ops-mask = "voltage";
+					constraint-name = "BUCK1";
+					supply-name = "vcc_core";
+					reg = <0>;
+				};
+			};
+		};
+
+		i2c1: i2c at d4037000 {
+			compatible = "pxa2xx-i2c";
+			reg = <0xd4037000 0x60>;
+			cell-index = <1>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <54>;
+			interrupt-parent = <&mmp_intc>;
+		};
+
+		uart0: uart at d4017000 {
+			compatible = "pxa,serial";
+			reg = <0xd4017000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <27>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <14745600>;
+			current-speed = <115200>;
+		};
+
+		uart1: uart at d4018000 {
+			compatible = "pxa,serial";
+			reg = <0xd4018000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <28>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <14745600>;
+			current-speed = <115200>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 7bb78fd..c9848ad 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -12,6 +12,9 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
@@ -105,30 +108,6 @@ static unsigned long brownstone_pin_config[] __initdata = {
 	GPIO89_GPIO,
 };
 
-static struct regulator_consumer_supply max8649_supply[] = {
-	REGULATOR_SUPPLY("vcc_core", NULL),
-};
-
-static struct regulator_init_data max8649_init_data = {
-	.constraints	= {
-		.name		= "vcc_core range",
-		.min_uV		= 1150000,
-		.max_uV		= 1280000,
-		.always_on	= 1,
-		.boot_on	= 1,
-		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
-	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &max8649_supply[0],
-};
-
-static struct max8649_platform_data brownstone_max8649_info = {
-	.mode		= 2,	/* VID1 = 1, VID0 = 0 */
-	.extclk		= 0,
-	.ramp_timing	= MAX8649_RAMP_32MV,
-	.regulator	= &max8649_init_data,
-};
-
 static struct regulator_consumer_supply brownstone_v_5vp_supplies[] = {
 	REGULATOR_SUPPLY("v_5vp", NULL),
 };
@@ -158,47 +137,38 @@ static struct platform_device brownstone_v_5vp_device = {
 	},
 };
 
-static struct max8925_platform_data brownstone_max8925_info = {
-	.irq_base		= IRQ_BOARD_START,
-};
-
-static struct i2c_board_info brownstone_twsi1_info[] = {
-	[0] = {
-		.type		= "max8649",
-		.addr		= 0x60,
-		.platform_data	= &brownstone_max8649_info,
-	},
-	[1] = {
-		.type		= "max8925",
-		.addr		= 0x3c,
-		.irq		= IRQ_MMP2_PMIC,
-		.platform_data	= &brownstone_max8925_info,
-	},
-};
-
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
 	.max_speed	= 25000000,
 };
 
+static __initdata struct of_device_id of_bus_ids[] = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
 static void __init brownstone_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
 
-	/* on-chip devices */
-	mmp2_add_uart(1);
-	mmp2_add_uart(3);
-	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
+	if (of_platform_bus_probe(NULL, of_bus_ids, NULL) < 0)
+		BUG();
+
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
 }
 
+static const char *brownstone_dt_match[] __initdata = {
+	"mrvl,mmp2-brownstone",
+	NULL,
+};
+
 MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
 	/* Maintainer: Haojian Zhuang <haojian.zhuang@marvell.com> */
 	.map_io		= mmp_map_io,
-	.nr_irqs	= BROWNSTONE_NR_IRQS,
-	.init_irq	= mmp2_init_irq,
+	.init_irq	= mmp_init_intc,
 	.timer		= &mmp2_timer,
 	.init_machine	= brownstone_init,
+	.dt_compat	= brownstone_dt_match,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index e411039..c19b4dc 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -10,6 +10,9 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -113,21 +116,31 @@ static struct platform_device *ttc_dkb_devices[] = {
 	&ttc_dkb_device_onenand,
 };
 
+static __initdata struct of_device_id of_bus_ids[] = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
 static void __init ttc_dkb_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
 
-	/* on-chip devices */
-	pxa910_add_uart(1);
+	if (of_platform_bus_probe(NULL, of_bus_ids, NULL) < 0)
+		BUG();
 
 	/* off-chip devices */
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 }
 
+static const char *ttc_dkb_dt_match[] __initdata = {
+	"mrvl,ttc-dkb",
+	NULL,
+};
+
 MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
 	.map_io		= mmp_map_io,
-	.nr_irqs	= TTCDKB_NR_IRQS,
-	.init_irq       = pxa910_init_irq,
+	.init_irq       = mmp_init_intc,
 	.timer          = &pxa910_timer,
 	.init_machine   = ttc_dkb_init,
+	.dt_compat	= ttc_dkb_dt_match,
 MACHINE_END
-- 
1.5.6.5
