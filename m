From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 12 Feb 2012 14:32:28 +0000 (GMT)
Subject: [PATCH] mach-kirkwood: Support for DLink DNS-320 & DNS-325 NAS
Message-ID: <alpine.DEB.2.02.1202121424080.16803@bunsen.wrottesley.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the D-Link DNS-320 & DNS-325 NAS. Kirkwood-based
successors to the DNS-323.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
My previous patch supported just the DNS-325, the DNS-320 is a very similar
device and so I've combined the support for both devices into one board support
file. The main difference with the DNS-320 is that the temperature sensor
is accessed via ttyS1 instead of I2C (I have a userland script to do this).

I appreciate board support files like this are old hat and should be using
device tree instead. If I should be focusing on that instead of getting this
merged, some pointers would be very useful.

Cheers,

  arch/arm/mach-kirkwood/Kconfig       |   17 ++
  arch/arm/mach-kirkwood/Makefile      |    1 +
  arch/arm/mach-kirkwood/dnskw-setup.c |  431 ++++++++++++++++++++++++++++++++++
  3 files changed, 449 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7fc603b..1755a9a 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -130,6 +130,23 @@ config MACH_T5325
  	  Say 'Y' here if you want your kernel to support the
  	  HP t5325 Thin Client.

+config MACH_DNSKW
+	bool
+
+config MACH_DNS320
+	bool "D-Link DNS-320"
+	select MACH_DNSKW
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  D-Link DNS-320 NAS.
+
+config MACH_DNS325
+	bool "D-Link DNS-325"
+	select MACH_DNSKW
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  D-Link DNS-325 NAS.
+
  endmenu

  endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 5dcaa81..6f65aeb 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
  obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
  obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
  obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
+obj-$(CONFIG_MACH_DNSKW)		+= dnskw-setup.o

  obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm/mach-kirkwood/dnskw-setup.c b/arch/arm/mach-kirkwood/dnskw-setup.c
new file mode 100644
index 0000000..25ea0fa
--- /dev/null
+++ b/arch/arm/mach-kirkwood/dnskw-setup.c
@@ -0,0 +1,431 @@
+/*
+ * arch/arm/mach-kirkwood/dnskw-setup.c
+ *
+ * D-Link kirkwood-based NAS (DNS-320, DNS-325) Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/i2c.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/gpio-fan.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
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
+/*****************************************************************************
+ *  I2C-based devices
+ *
+ *  i2c addr | chip        | description
+ *  0x48     | GMT G751-2f | LM75-compatible temp. sensor (DNS-325 only)
+ *  0x0c     | ?           | (DNS-325 only)
+ *  0x64     | ?           |
+ ****************************************************************************/
+
+#ifdef CONFIG_MACH_DNS325
+static struct i2c_board_info dns325_i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("lm75", 0x48),
+	},
+};
+#endif
+
+
+/*****************************************************************************
+ * MPP / GPIO setup
+ ****************************************************************************/
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
+#define DNSKW_GPIO_LED_POWER		26
+#define DNSKW_GPIO_LED_RED_R		27
+#define DNSKW_GPIO_LED_RED_L		28
+#define DNS325_GPIO_LED_RED_USB		29
+#define DNS320_GPIO_LED_RED_USB		35
+#define DNSKW_GPIO_LED_WHITE_R		20
+#define DNSKW_GPIO_LED_WHITE_L		21
+#define DNSKW_GPIO_LED_WHITE_USB	43
+#define DNSKW_GPIO_FAN_ALARM		44
+#define DNSKW_GPIO_FAN_HIGH		45
+#define DNSKW_GPIO_FAN_LOW		46
+#define DNSKW_GPIO_BTN_POWER		34
+#define DNSKW_GPIO_BTN_UNMOUNT		47
+#define DNSKW_GPIO_BTN_RESET		48
+#define DNSKW_GPIO_POWER		36
+#define DNSKW_GPIO_POWER_RECOVER	37
+#define DNSKW_GPIO_POWER_SATA0		39
+#define DNSKW_GPIO_POWER_SATA1		40
+
+/*****************************************************************************
+ * Power controls
+ ****************************************************************************/
+
+static void dnskw_power_off(void)
+{
+	gpio_set_value(DNSKW_GPIO_POWER, 1);
+}
+
+static int __initdata power_recover_value = 1;
+static int __init dnskw_power_recover(char *str)
+{
+	power_recover_value = 0;
+	return 1;
+}
+__setup("kw_dnskw_no_power_recover", dnskw_power_recover);
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
+/*****************************************************************************
+ * Buttons
+ ****************************************************************************/
+
+static struct gpio_keys_button dnskw_button_pins[] = {
+	{
+		.code		= KEY_POWER,
+		.gpio		= DNSKW_GPIO_BTN_POWER,
+		.desc		= "Power button",
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_EJECTCD,
+		.gpio		= DNSKW_GPIO_BTN_UNMOUNT,
+		.desc		= "USB unmount button",
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_RESTART,
+		.gpio		= DNSKW_GPIO_BTN_RESET,
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
+/*****************************************************************************
+ * LEDs
+ ****************************************************************************/
+
+#ifdef CONFIG_MACH_DNS325
+static struct gpio_led dns325_led_pins[] = {
+	{
+		.name	= "dns325:white:power",
+		.gpio	= DNSKW_GPIO_LED_POWER,
+		.active_low = 1,
+		.default_trigger = "default-on",
+	},
+	{
+		.name	= "dns325:white:usb",
+		.gpio	= DNSKW_GPIO_LED_WHITE_USB,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns325:red:l_hdd",
+		.gpio	= DNSKW_GPIO_LED_RED_L,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns325:red:r_hdd",
+		.gpio	= DNSKW_GPIO_LED_RED_R,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns325:red:usb",
+		.gpio	= DNS325_GPIO_LED_RED_USB,
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
+#endif
+
+#ifdef CONFIG_MACH_DNS320
+static struct gpio_led dns320_led_pins[] = {
+	{
+		.name	= "dns320:blue:power",
+		.gpio	= DNSKW_GPIO_LED_POWER,
+		.active_low = 1,
+		.default_trigger = "default-on",
+	},
+	{
+		.name	= "dns320:blue:usb",
+		.gpio	= DNSKW_GPIO_LED_WHITE_USB,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns320:orange:l_hdd",
+		.gpio	= DNSKW_GPIO_LED_RED_L,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns320:orange:r_hdd",
+		.gpio	= DNSKW_GPIO_LED_RED_R,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns320:orange:usb",
+		.gpio	= DNS320_GPIO_LED_RED_USB,
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
+#endif
+
+/*****************************************************************************
+ * Fan
+ ****************************************************************************/
+
+/* Fan: ADDA AD045HB-G73 40mm 6000rpm at 5v */
+static struct gpio_fan_speed dnskw_fan_speed[] = {
+	{    0,  0 },
+	{ 3000,	 1 },
+	{ 6000,	 2 },
+};
+
+static unsigned dnskw_fan_pins[] = {
+	DNSKW_GPIO_FAN_LOW,
+	DNSKW_GPIO_FAN_HIGH,
+};
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
+/*****************************************************************************
+ * Main init
+ ****************************************************************************/
+
+static void __init dnskw_init(void)
+{
+	u32 dev, rev;
+
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
+	kirkwood_mpp_conf(dnskw_mpp_config);
+
+	kirkwood_uart0_init();
+	kirkwood_uart1_init();
+	kirkwood_nand_init(ARRAY_AND_SIZE(dnskw_nand_parts), 25);
+	kirkwood_ehci_init();
+	kirkwood_i2c_init();
+	kirkwood_ge00_init(&dnskw_ge00_data);
+
+#ifdef CONFIG_MACH_DNS320
+	if (machine_is_dns320())
+		platform_device_register(&dns320_led_device);
+#endif
+#ifdef CONFIG_MACH_DNS325
+	if (machine_is_dns325()) {
+		platform_device_register(&dns325_led_device);
+
+		i2c_register_board_info(0, dns325_i2c_board_info,
+					ARRAY_SIZE(dns325_i2c_board_info));
+	}
+#endif
+
+	/*
+	 * Turn on power to harddrives, then enable SATA.
+	 * NB: Bootloader should have turned sata0 on already, kernel needs
+	 * to turn on sata1. The idea is to stagger spin-up of HDDs.
+	 */
+	dnskw_gpio_register(DNSKW_GPIO_POWER_SATA0, "dnskw:power:sata0", 1);
+	dnskw_gpio_register(DNSKW_GPIO_POWER_SATA1, "dnskw:power:sata1", 1);
+	kirkwood_sata_init(&dnskw_sata_data);
+
+	platform_device_register(&dnskw_button_device);
+	platform_device_register(&dnskw_fan_device);
+
+	/* Register power off routine */
+	kirkwood_pcie_id(&dev, &rev);
+	if (dev == MV88F6281_DEV_ID) {
+		pr_info("PCI-E Device ID: MV88F6281, configuring power-off");
+		if (gpio_request(DNSKW_GPIO_POWER, "dnskw:power:off") == 0 &&
+		    gpio_direction_output(DNSKW_GPIO_POWER, 0) == 0)
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
+	/* Set state of power_recover pin */
+	if (gpio_request(DNSKW_GPIO_POWER_RECOVER, "dnskw:power:recover") == 0
+	 && gpio_direction_output(DNSKW_GPIO_POWER_RECOVER, 0) == 0) {
+		pr_info("dnskw: Setting power-recover %s\n",
+			power_recover_value ? "on" : "off");
+		gpio_set_value(DNSKW_GPIO_POWER_RECOVER, power_recover_value);
+	} else
+		pr_err("dnskw: Failed to register power-recover GPIO\n");
+}
+
+#ifdef CONFIG_MACH_DNS320
+MACHINE_START(DNS320, "D-Link DNS-320")
+	/* Maintainer: Jamie Lentin <jm@lentin.co.uk> */
+	.atag_offset	= 0x100,
+	.init_machine	= dnskw_init,
+	.map_io		= kirkwood_map_io,
+	.init_early	= kirkwood_init_early,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_DNS325
+MACHINE_START(DNS325, "D-Link DNS-325")
+	/* Maintainer: Jamie Lentin <jm@lentin.co.uk> */
+	.atag_offset	= 0x100,
+	.init_machine	= dnskw_init,
+	.map_io		= kirkwood_map_io,
+	.init_early	= kirkwood_init_early,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+	.restart	= kirkwood_restart,
+MACHINE_END
+#endif
