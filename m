From: jm@lentin.co.uk (Jamie Lentin)
Date: Tue, 27 Mar 2012 22:54:11 +0100
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and DNS-325
In-Reply-To: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1332885255-8304-2-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the DNS-320 and DNS-325. Describe as much as currently possible
in the devicetree files, create a board-dnskw.c for everything else.

Use IEEE-compliant "okay", rather than "ok"

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dns320.dts |   29 +++
 arch/arm/boot/dts/kirkwood-dns325.dts |   24 +++
 arch/arm/mach-kirkwood/Kconfig        |   23 +++
 arch/arm/mach-kirkwood/Makefile       |    1 +
 arch/arm/mach-kirkwood/Makefile.boot  |    2 +
 arch/arm/mach-kirkwood/board-dnskw.c  |  306 +++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c     |    5 +
 arch/arm/mach-kirkwood/common.h       |    6 +
 8 files changed, 396 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts
 create mode 100644 arch/arm/mach-kirkwood/board-dnskw.c

diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
new file mode 100644
index 0000000..78c834f
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -0,0 +1,29 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "D-Link DNS-320 NAS (Rev A1)";
+	compatible = "dlink,dns-320-a1", "dlink,dns-320", "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
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
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <166666667>;
+			status = "okay";
+		};
+
+		serial at 12100 {
+			clock-frequency = <166666667>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
new file mode 100644
index 0000000..23241ab
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -0,0 +1,24 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "D-Link DNS-325 NAS (Rev A1)";
+	compatible = "dlink,dns-325-a1", "dlink,dns-325", "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
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
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 90ceab7..d594b6e 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -58,6 +58,29 @@ config MACH_DREAMPLUG_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DreamPlug (Flattened Device Tree).
 
+config MACH_DNSKW_DT
+        bool
+
+config MACH_DNS320_DT
+	bool "D-Link DNS-320 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	select MACH_DNSKW_DT
+	select CONFIG_MTD_OF_PARTS
+	select CONFIG_SERIAL_OF_PLATFORM
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  D-Link DNS-320 NAS, using Flattened Device Tree.
+
+config MACH_DNS325_DT
+	bool "D-Link DNS-325 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	select MACH_DNSKW_DT
+	select CONFIG_MTD_OF_PARTS
+	select CONFIG_SERIAL_OF_PLATFORM
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  D-Link DNS-325 NAS, using Flattened Device Tree.
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index e299a95..b092af5 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
+obj-$(CONFIG_MACH_DNSKW_DT)		+= board-dnskw.o
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 16f9385..9c5e45f 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -3,3 +3,5 @@ params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
 dtb-$(CONFIG_MACH_DREAMPLUG_DT) += kirkwood-dreamplug.dtb
+dtb-$(CONFIG_MACH_DNS320_DT) += kirkwood-dns320.dtb
+dtb-$(CONFIG_MACH_DNS325_DT) += kirkwood-dns325.dtb
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
new file mode 100644
index 0000000..7cb7f6a
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -0,0 +1,306 @@
+/*
+ * Copyright 2012 (C), Jamie Lentin <jm@lentin.co.uk>
+ *
+ * arch/arm/mach-kirkwood/board-dnskw.c
+ *
+ * D-link DNS-320 & DNS-325 NAS Init for drivers not converted to
+ * flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/of.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/gpio-fan.h>
+#include <linux/leds.h>
+#include <linux/mtd/physmap.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/kirkwood.h>
+#include <mach/bridge-regs.h>
+#include "common.h"
+#include "mpp.h"
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
+static struct mv_sata_platform_data dnskw_sata_data = {
+	.n_ports	= 2,
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
+	MPP36_GPIO,	/* Power: Turn off board */
+	MPP37_GPIO,	/* Power: Turn back on after power failure */
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
+static void dnskw_power_off(void)
+{
+	gpio_set_value(36, 1);
+}
+
+/* Register any GPIO for output and set the value */
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
+void __init dnskw_init(void)
+{
+	kirkwood_mpp_conf(dnskw_mpp_config);
+	kirkwood_nand_init(ARRAY_AND_SIZE(dnskw_nand_parts), 25);
+
+	kirkwood_ehci_init();
+	kirkwood_ge00_init(&dnskw_ge00_data);
+	kirkwood_sata_init(&dnskw_sata_data);
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
+	} else if (of_machine_is_compatible("dlink,dns-320"))
+		platform_device_register(&dns320_led_device);
+
+	/* Register power-off GPIO. */
+	if (gpio_request(36, "dnskw:power:off") == 0
+	    && gpio_direction_output(36, 0) == 0)
+		pm_power_off = dnskw_power_off;
+	else
+		pr_err("dnskw: failed to configure power-off GPIO\n");
+
+	/* Ensure power is supplied to both HDDs */
+	dnskw_gpio_register(39, "dnskw:power:sata0", 1);
+	dnskw_gpio_register(40, "dnskw:power:sata1", 1);
+
+	/* Set NAS to turn back on after a power failure */
+	dnskw_gpio_register(37, "dnskw:power:recover", 1);
+}
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 1c672d9..eadc4d7 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -55,11 +55,16 @@ static void __init kirkwood_dt_init(void)
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
 
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index fa8e768..8c8c733 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -58,6 +58,12 @@ void dreamplug_init(void);
 static inline void dreamplug_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_DNSKW_DT
+void dnskw_init(void);
+#else
+static inline void dnskw_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-- 
1.7.9.1
