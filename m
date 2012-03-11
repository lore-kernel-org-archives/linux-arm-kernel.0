From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 11 Mar 2012 14:33:25 +0000
Subject: [PATCH 1/2] ARM: kirkwood: Basic support for DNS-320 and DNS-325
In-Reply-To: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1331476406-9844-2-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the DNS-320 and DNS-325. Describe as much as currently possible
in the devicetree files, leave everything else in board-dt.c to be patched
later.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dns320.dts |   54 ++++++
 arch/arm/boot/dts/kirkwood-dns325.dts |   40 +++++
 arch/arm/mach-kirkwood/Kconfig        |   18 ++
 arch/arm/mach-kirkwood/Makefile.boot  |    2 +
 arch/arm/mach-kirkwood/board-dt.c     |  294 +++++++++++++++++++++++++++++++++
 5 files changed, 408 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts

diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
new file mode 100644
index 0000000..c039041
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -0,0 +1,54 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "D-Link DNS-320 NAS (Rev A1)";
+	compatible = "dlink,dns-320-a1", "dlink,dns-320", "dlink,dns-kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	wdt at fed20300 {
+		compatible = "mrvl,orion-wdt";
+		reg = <0xfed20300 0x28>;
+		clock-frequency = <166666667>;
+	};
+
+	serial at f1012000 {
+		compatible = "ns16550a";
+		reg = <0xf1012000 0xff>;
+		reg-shift = <2>;
+		interrupts = <33>;
+		clock-frequency = <166666667>;
+	};
+
+	serial at f1012100 {
+		compatible = "ns16550a";
+		reg = <0xf1012100 0xff>;
+		reg-shift = <2>;
+		interrupts = <34>;
+		clock-frequency = <166666667>;
+	};
+
+	sata at f1080000 {
+		compatible = "mrvl,orion-sata";
+		reg = <0xf1080000 0x5000>;
+		interrupts = <21>;
+		nr-ports = <2>;
+	};
+
+	ehci at f1050000 {
+		compatible = "mrvl,orion-ehci";
+		reg = <0xf1050000 0x1000>;
+		interrupts = <19>;
+		dma-mask = <0xffffffff>;
+		phy-version = "";
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
new file mode 100644
index 0000000..a7c2c26
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -0,0 +1,40 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "D-Link DNS-325 NAS (Rev A1)";
+	compatible = "dlink,dns-325-a1", "dlink,dns-325", "dlink,dns-kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	serial at f1012000 {
+		compatible = "ns16550a";
+		reg = <0xf1012000 0xff>;
+		reg-shift = <2>;
+		interrupts = <33>;
+		clock-frequency = <200000000>;
+	};
+
+	sata at f1080000 {
+		compatible = "mrvl,orion-sata";
+		reg = <0xf1080000 0x5000>;
+		interrupts = <21>;
+		nr-ports = <2>;
+	};
+
+	ehci at f1050000 {
+		compatible = "mrvl,orion-ehci";
+		reg = <0xf1050000 0x1000>;
+		interrupts = <19>;
+		dma-mask = <0xffffffff>;
+		phy-version = "";
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 90ceab7..6c76e18 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -58,6 +58,24 @@ config MACH_DREAMPLUG_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DreamPlug (Flattened Device Tree).
 
+config MACH_DNS320_DT
+	bool "D-Link DNS-320 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	select CONFIG_MTD_OF_PARTS
+	select CONFIG_SERIAL_OF_PLATFORM
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  D-Link DNS-320 (Flattened Device Tree).
+
+config MACH_DNS325_DT
+	bool "D-Link DNS-325 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	select CONFIG_MTD_OF_PARTS
+	select CONFIG_SERIAL_OF_PLATFORM
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  D-Link DNS-325 (Flattened Device Tree).
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 16f9385..9c5e45f 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -3,3 +3,5 @@ params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
 dtb-$(CONFIG_MACH_DREAMPLUG_DT) += kirkwood-dreamplug.dtb
+dtb-$(CONFIG_MACH_DNS320_DT) += kirkwood-dns320.dtb
+dtb-$(CONFIG_MACH_DNS325_DT) += kirkwood-dns325.dtb
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 12dec38..0885713 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/irqdomain.h>
 #include <linux/mtd/partitions.h>
+#include <linux/i2c.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/of.h>
@@ -23,6 +24,9 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/gpio-fan.h>
 #include <linux/leds.h>
 #include <linux/mtd/physmap.h>
 #include <linux/spi/flash.h>
@@ -150,6 +154,291 @@ static void __init dreamplug_init(void)
 	platform_device_register(&dreamplug_leds);
 }
 
+/*****************************************************************************
+ * DNS-320 & DNS-325 specifics
+ ****************************************************************************/
+
+static struct mtd_partition dnskw_nand_parts[] = {
+	{
+		.name		= "u-boot",
+		.offset		= 0,
+		.size		= SZ_1M,
+		.mask_flags	= MTD_WRITEABLE
+	}, {
+		.name		= "uImage",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= 5 * SZ_1M
+	}, {
+		.name		= "ramdisk",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= 5 * SZ_1M
+	}, {
+		.name		= "image",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= 102 * SZ_1M
+	}, {
+		.name		= "mini firmware",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= 10 * SZ_1M
+	}, {
+		.name		= "config",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= 5 * SZ_1M
+	},
+};
+
+static struct mv643xx_eth_platform_data dnskw_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+static unsigned int dnskw_mpp_config[] __initdata = {
+	MPP13_UART1_TXD,	/* Custom ... */
+	MPP14_UART1_RXD,	/* ... Controller (DNS-320 only) */
+	MPP20_SATA1_ACTn,	/* LED: White Right HDD */
+	MPP21_SATA0_ACTn,	/* LED: White Left HDD */
+	MPP24_GPIO,
+	MPP25_GPIO,
+	MPP26_GPIO,	/* LED: Power */
+	MPP27_GPIO,	/* LED: Red Right HDD */
+	MPP28_GPIO,	/* LED: Red Left HDD */
+	MPP29_GPIO,	/* LED: Red USB (DNS-325 only) */
+	MPP30_GPIO,
+	MPP31_GPIO,
+	MPP32_GPIO,
+	MPP33_GPO,
+	MPP34_GPIO,	/* Button: Front power */
+	MPP35_GPIO,	/* LED: Red USB (DNS-320 only) */
+	MPP36_GPIO,	/* Power: MV88F6281_DEV_ID Board */
+	MPP37_GPIO,	/* Power: Boot when power applied */
+	MPP38_GPIO,
+	MPP39_GPIO,	/* Power: SATA0 */
+	MPP40_GPIO,	/* Power: SATA1 */
+	MPP41_GPIO,
+	MPP42_GPIO,
+	MPP43_GPIO,	/* LED: White USB */
+	MPP44_GPIO,	/* Fan: Tachometer Pin */
+	MPP45_GPIO,	/* Fan: high speed */
+	MPP46_GPIO,	/* Fan: low speed */
+	MPP47_GPIO,	/* Button: Back unmount */
+	MPP48_GPIO,	/* Button: Back reset */
+	MPP49_GPIO,	/* Pin of unused U5 (DNS-320 only) */
+	0
+};
+
+static struct gpio_led dns325_led_pins[] = {
+	{
+		.name	= "dns325:white:power",
+		.gpio	= 26,
+		.active_low = 1,
+		.default_trigger = "default-on",
+	},
+	{
+		.name	= "dns325:white:usb",
+		.gpio	= 43,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns325:red:l_hdd",
+		.gpio	= 28,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns325:red:r_hdd",
+		.gpio	= 27,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns325:red:usb",
+		.gpio	= 29,
+		.active_low = 1,
+	},
+};
+
+static struct gpio_led_platform_data dns325_led_data = {
+	.num_leds	= ARRAY_SIZE(dns325_led_pins),
+	.leds		= dns325_led_pins,
+};
+
+static struct platform_device dns325_led_device = {
+	.name		= "leds-gpio",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &dns325_led_data,
+	},
+};
+
+static struct gpio_led dns320_led_pins[] = {
+	{
+		.name	= "dns320:blue:power",
+		.gpio	= 26,
+		.active_low = 1,
+		.default_trigger = "default-on",
+	},
+	{
+		.name	= "dns320:blue:usb",
+		.gpio	= 43,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns320:orange:l_hdd",
+		.gpio	= 28,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns320:orange:r_hdd",
+		.gpio	= 27,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns320:orange:usb",
+		.gpio	= 35,
+		.active_low = 1,
+	},
+};
+
+static struct gpio_led_platform_data dns320_led_data = {
+	.num_leds	= ARRAY_SIZE(dns320_led_pins),
+	.leds		= dns320_led_pins,
+};
+
+static struct platform_device dns320_led_device = {
+	.name		= "leds-gpio",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &dns320_led_data,
+	},
+};
+
+static struct i2c_board_info dns325_i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("lm75", 0x48),
+	},
+	/* Something at 0x0c also */
+};
+
+static struct gpio_keys_button dnskw_button_pins[] = {
+	{
+		.code		= KEY_POWER,
+		.gpio		= 34,
+		.desc		= "Power button",
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_EJECTCD,
+		.gpio		= 47,
+		.desc		= "USB unmount button",
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_RESTART,
+		.gpio		= 48,
+		.desc		= "Reset button",
+		.active_low	= 1,
+	},
+};
+
+static struct gpio_keys_platform_data dnskw_button_data = {
+	.buttons	= dnskw_button_pins,
+	.nbuttons	= ARRAY_SIZE(dnskw_button_pins),
+};
+
+static struct platform_device dnskw_button_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &dnskw_button_data,
+	}
+};
+
+/* Fan: ADDA AD045HB-G73 40mm 6000rpm at 5v */
+static struct gpio_fan_speed dnskw_fan_speed[] = {
+	{    0,  0 },
+	{ 3000,	 1 },
+	{ 6000,	 2 },
+};
+static unsigned dnskw_fan_pins[] = {46, 45};
+
+static struct gpio_fan_platform_data dnskw_fan_data = {
+	.num_ctrl	= ARRAY_SIZE(dnskw_fan_pins),
+	.ctrl		= dnskw_fan_pins,
+	.num_speed	= ARRAY_SIZE(dnskw_fan_speed),
+	.speed		= dnskw_fan_speed,
+};
+
+static struct platform_device dnskw_fan_device = {
+	.name	= "gpio-fan",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &dnskw_fan_data,
+	},
+};
+
+static void __init dnskw_gpio_register(unsigned gpio, char *name, int def)
+{
+	if (gpio_request(gpio, name) == 0 &&
+	    gpio_direction_output(gpio, 0) == 0) {
+		gpio_set_value(gpio, def);
+		if (gpio_export(gpio, 0) != 0)
+			pr_err("dnskw: Failed to export GPIO %s\n", name);
+	} else
+		pr_err("dnskw: Failed to register %s\n", name);
+}
+
+static void dnskw_power_off(void)
+{
+	gpio_set_value(36, 1);
+}
+
+static void __init dnskw_init(void)
+{
+	u32 dev, rev;
+
+	kirkwood_mpp_conf(dnskw_mpp_config);
+	kirkwood_nand_init(ARRAY_AND_SIZE(dnskw_nand_parts), 25);
+
+	kirkwood_ge00_init(&dnskw_ge00_data);
+	kirkwood_i2c_init();
+
+	platform_device_register(&dnskw_button_device);
+	platform_device_register(&dnskw_fan_device);
+
+	if (of_machine_is_compatible("dlink,dns-325")) {
+		i2c_register_board_info(0, dns325_i2c_board_info,
+					ARRAY_SIZE(dns325_i2c_board_info));
+		platform_device_register(&dns325_led_device);
+
+	} else if (of_machine_is_compatible("dlink,dns-320")) {
+		platform_device_register(&dns320_led_device);
+	}
+
+	/* Register power off routine */
+	kirkwood_pcie_id(&dev, &rev);
+	if (dev == MV88F6281_DEV_ID) {
+		pr_info("PCI-E Device ID: MV88F6281, configuring power-off");
+		if (gpio_request(36, "dnskw:power:off") == 0 &&
+		    gpio_direction_output(36, 0) == 0)
+			pm_power_off = dnskw_power_off;
+		else
+			pr_err("dnskw: failed to configure power-off GPIO\n");
+	} else {
+		/*
+		 * Dlink code also defines 0x6192, and sets LOW_BASE +
+		 * 0x01000000 high. Either cargo-culted code or another model.
+		 */
+		pr_err("Unknown PCI-E Device ID %x, no power-off", dev);
+	}
+
+	/*
+	 * Supply power to HDDs. Bootloader should have turned on sata0 already
+	 */
+	dnskw_gpio_register(39, "dnskw:power:sata0", 1);
+	dnskw_gpio_register(40, "dnskw:power:sata1", 1);
+
+	/* Set NAS to turn back on after a power failure */
+	dnskw_gpio_register(37, "dnskw:power:recover", 1);
+}
+
 static void __init kirkwood_dt_init(void)
 {
 	struct device_node *node;
@@ -186,11 +475,16 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("globalscale,dreamplug"))
 		dreamplug_init();
 
+	if (of_machine_is_compatible("dlink,dns-kirkwood"))
+		dnskw_init();
+
 	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
 }
 
 static const char *kirkwood_dt_board_compat[] = {
 	"globalscale,dreamplug",
+	"dlink,dns-320",
+	"dlink,dns-325",
 	NULL
 };
 
-- 
1.7.9.1
