From: michael@walle.cc (Michael Walle)
Date: Mon,  6 Jun 2011 00:14:24 +0200
Subject: [PATCH] ARM: kirkwood: Add support for Buffalo LS-XHL
Message-ID: <1307312064-7861-1-git-send-email-michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Buffalo Linkstation XHL. This NAS box is based on a
Marvell Kirkwood chip at 1.2 GHz and features 256 MB RAM, 512kb SPI boot
flash, gigabit ethernet and one SATA port.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/configs/kirkwood_defconfig  |    1 +
 arch/arm/mach-kirkwood/Kconfig       |    6 +
 arch/arm/mach-kirkwood/Makefile      |    1 +
 arch/arm/mach-kirkwood/lsxhl-setup.c |  313 ++++++++++++++++++++++++++++++++++
 arch/arm/tools/mach-types            |    1 +
 5 files changed, 322 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/lsxhl-setup.c

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index aeb3af5..9f77811 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -28,6 +28,7 @@ CONFIG_MACH_D2NET_V2=y
 CONFIG_MACH_NET2BIG_V2=y
 CONFIG_MACH_NET5BIG_V2=y
 CONFIG_MACH_T5325=y
+CONFIG_MACH_LSXHL=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7fc603b..307cc99 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -130,6 +130,12 @@ config MACH_T5325
 	  Say 'Y' here if you want your kernel to support the
 	  HP t5325 Thin Client.
 
+config MACH_LSXHL
+	bool "Buffalo LS-XHL Series"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Buffalo LS-XHL Series.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 5dcaa81..221980b 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
+obj-$(CONFIG_MACH_LSXHL)		+= lsxhl-setup.o
 
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm/mach-kirkwood/lsxhl-setup.c b/arch/arm/mach-kirkwood/lsxhl-setup.c
new file mode 100644
index 0000000..47318ef
--- /dev/null
+++ b/arch/arm/mach-kirkwood/lsxhl-setup.c
@@ -0,0 +1,313 @@
+/*
+ * arch/arm/mach-kirkwood/lsxhl-setup.c
+ *
+ * Buffalo LS-XHL Series Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/ata_platform.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/gpio-fan.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include <plat/mvsdio.h>
+#include "common.h"
+#include "mpp.h"
+
+/*****************************************************************************
+ * 512KB SPI Flash on BOOT Device
+ ****************************************************************************/
+static struct mtd_partition lsxhl_partitions[] = {
+	{
+		.name		= "u-boot",
+		.size		= 0x70000,
+		.offset		= 0x00000,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	{
+		.name		= "u-boot env",
+		.size		= 0x10000,
+		.offset		= 0x70000,
+	}
+};
+
+static struct flash_platform_data lsxhl_spi_slave_data = {
+	.type		= "m25p40",
+	.parts		= lsxhl_partitions,
+	.nr_parts	= ARRAY_SIZE(lsxhl_partitions),
+};
+
+static struct spi_board_info __initdata lsxhl_spi_slave_info[] = {
+	{
+		.modalias	= "m25p80",
+		.platform_data	= &lsxhl_spi_slave_data,
+		.irq		= -1,
+		.max_speed_hz	= 20000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+	}
+};
+
+/*****************************************************************************
+ * Ethernet
+ ****************************************************************************/
+static struct mv643xx_eth_platform_data lsxhl_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct mv643xx_eth_platform_data lsxhl_ge01_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+/*****************************************************************************
+ * SATA
+ ****************************************************************************/
+static struct mv_sata_platform_data lsxhl_sata_data = {
+	.n_ports	= 1,
+};
+
+/*****************************************************************************
+ * LEDs attached to GPIO
+ ****************************************************************************/
+#define LSXHL_GPIO_LED_ALARM		37
+#define LSXHL_GPIO_LED_INFO		38
+#define LSXHL_GPIO_LED_PWR		39
+#define LSXHL_GPIO_LED_FUNC_BLUE	36
+#define LSXHL_GPIO_LED_FUNC_RED		48
+
+static struct gpio_led lsxhl_led_pins[] = {
+	{
+		.name			= "alarm:red",
+		.gpio			= LSXHL_GPIO_LED_ALARM,
+		.active_low		= 1,
+	},
+	{
+		.name			= "info:amber",
+		.gpio			= LSXHL_GPIO_LED_INFO,
+		.active_low		= 1,
+	},
+	{
+		.name			= "power:blue",
+		.default_trigger	= "default-on",
+		.gpio			= LSXHL_GPIO_LED_PWR,
+		.active_low		= 1,
+	},
+	{
+		.name			= "func:blue:bottom",
+		.gpio			= LSXHL_GPIO_LED_FUNC_BLUE,
+		.active_low		= 1,
+	},
+	{
+		.name			= "func:red:bottom",
+		.gpio			= LSXHL_GPIO_LED_FUNC_RED,
+		.active_low		= 1,
+	},
+};
+
+static struct gpio_led_platform_data lsxhl_led_data = {
+	.leds		= lsxhl_led_pins,
+	.num_leds	= ARRAY_SIZE(lsxhl_led_pins),
+};
+
+static struct platform_device lsxhl_leds = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &lsxhl_led_data,
+	}
+};
+
+/*****************************************************************************
+ * General Setup
+ ****************************************************************************/
+#define LSXHL_GPIO_HDD_POWER 10
+#define LSXHL_GPIO_USB_POWER 11
+
+/*****************************************************************************
+ * GPIO Attached Keys
+ ****************************************************************************/
+#define LSXHL_GPIO_KEY_FUNC		41
+#define LSXHL_GPIO_KEY_AUTOPOWER	42
+#define LSXHL_GPIO_KEY_POWER		43
+#define LSXHL_SW_POWER		0x00
+#define LSXHL_SW_AUTOPOWER	0x01
+#define LSXHL_SW_FUNC		0x02
+
+static struct gpio_keys_button lsxhl_buttons[] = {
+	{
+		.type = EV_SW,
+		.code = LSXHL_SW_POWER,
+		.gpio = LSXHL_GPIO_KEY_POWER,
+		.desc = "Power-on Switch",
+		.active_low = 1,
+	}, {
+		.type = EV_SW,
+		.code = LSXHL_SW_AUTOPOWER,
+		.gpio = LSXHL_GPIO_KEY_AUTOPOWER,
+		.desc = "Power-auto Switch",
+		.active_low = 1,
+	}, {
+		.type = EV_SW,
+		.code = LSXHL_SW_POWER,
+		.gpio = LSXHL_GPIO_KEY_FUNC,
+		.desc = "Function Button",
+		.active_low = 1,
+	},
+};
+
+static struct gpio_keys_platform_data lsxhl_button_data = {
+	.buttons = lsxhl_buttons,
+	.nbuttons = ARRAY_SIZE(lsxhl_buttons),
+};
+
+static struct platform_device lsxhl_button_device = {
+	.name = "gpio-keys",
+	.id = -1,
+	.num_resources = 0,
+	.dev = {
+		.platform_data = &lsxhl_button_data,
+	},
+};
+
+/*****************************************************************************
+ * GPIO Fan
+ ****************************************************************************/
+#define LSXHL_GPIO_FAN_HIGH	18
+#define LSXHL_GPIO_FAN_LOW	19
+#define LSXHL_GPIO_FAN_LOCK	40
+
+static struct gpio_fan_alarm lsxhl_alarm = {
+	.gpio = LSXHL_GPIO_FAN_LOCK,
+};
+
+static struct gpio_fan_speed lsxhl_speeds[] = {
+	{
+		.rpm = 0,
+		.ctrl_val = 3,
+	}, {
+		.rpm = 1500,
+		.ctrl_val = 2,
+	}, {
+		.rpm = 3250,
+		.ctrl_val = 1,
+	}, {
+		.rpm = 5000,
+		.ctrl_val = 0,
+	}
+};
+
+static int lsxhl_gpio_list[] = {
+	LSXHL_GPIO_FAN_HIGH, LSXHL_GPIO_FAN_LOW,
+};
+
+static struct gpio_fan_platform_data lsxhl_fan_data = {
+	.num_ctrl = ARRAY_SIZE(lsxhl_gpio_list),
+	.ctrl = lsxhl_gpio_list,
+	.alarm = &lsxhl_alarm,
+	.num_speed = ARRAY_SIZE(lsxhl_speeds),
+	.speed = lsxhl_speeds,
+};
+
+static struct platform_device lsxhl_fan_device = {
+	.name = "gpio-fan",
+	.id = -1,
+	.num_resources = 0,
+	.dev = {
+		.platform_data = &lsxhl_fan_data,
+	},
+};
+
+/*****************************************************************************
+ * GPIO Data
+ ****************************************************************************/
+
+static unsigned int lsxhl_mpp_config[] __initdata = {
+	MPP10_GPO,	/* HDD Power Enable */
+	MPP11_GPIO,	/* USB Vbus Enable */
+	MPP18_GPO,	/* FAN High Enable# */
+	MPP19_GPO,	/* FAN Low Enable# */
+	MPP36_GPIO,	/* Function Blue LED */
+	MPP37_GPIO,	/* Alarm LED */
+	MPP38_GPIO,	/* Info LED */
+	MPP39_GPIO,	/* Power LED */
+	MPP40_GPIO,	/* Fan Lock */
+	MPP41_GPIO,	/* Function Button */
+	MPP42_GPIO,	/* Power Switch */
+	MPP43_GPIO,	/* Power Auto Switch */
+	MPP48_GPIO,	/* Function Red LED */
+	0
+};
+
+/*****************************************************************************
+ * LS-XHL specific power off method: reboot
+ ****************************************************************************/
+/*
+ * On the LS-XHL, the shutdown process is following:
+ * - Userland monitors key events until the power switch goes to off position
+ * - The board reboots
+ * - U-boot starts and goes into an idle mode waiting for the user
+ *   to move the switch to ON position
+ *
+ */
+
+static void lsxhl_power_off(void)
+{
+	arm_machine_restart('h', NULL);
+}
+
+static void __init lsxhl_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
+	kirkwood_mpp_conf(lsxhl_mpp_config);
+
+	/*
+	 * Configure peripherals.
+	 */
+	kirkwood_uart0_init();
+	kirkwood_ehci_init();
+	kirkwood_ge00_init(&lsxhl_ge00_data);
+	kirkwood_ge01_init(&lsxhl_ge01_data);
+	kirkwood_sata_init(&lsxhl_sata_data);
+	kirkwood_spi_init();
+
+	platform_device_register(&lsxhl_leds);
+	platform_device_register(&lsxhl_button_device);
+	platform_device_register(&lsxhl_fan_device);
+
+	spi_register_board_info(lsxhl_spi_slave_info,
+				ARRAY_SIZE(lsxhl_spi_slave_info));
+
+	/* usb power on */
+	gpio_set_value(LSXHL_GPIO_USB_POWER, 1);
+
+	/* register power-off method */
+	pm_power_off = lsxhl_power_off;
+
+	pr_info("%s: finished\n", __func__);
+}
+
+MACHINE_START(LSXHL, "Buffalo LS-XHL Series")
+	.boot_params	= 0x00000100,
+	.init_machine	= lsxhl_init,
+	.map_io		= kirkwood_map_io,
+	.init_early	= kirkwood_init_early,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 3b3776d..8acc587 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -448,6 +448,7 @@ mityomapl138		MACH_MITYOMAPL138	MITYOMAPL138		2650
 guruplug		MACH_GURUPLUG		GURUPLUG		2659
 spear310		MACH_SPEAR310		SPEAR310		2660
 spear320		MACH_SPEAR320		SPEAR320		2661
+lsxhl			MACH_LSXHL		LSXHL			2663
 aquila			MACH_AQUILA		AQUILA			2676
 sheeva_esata		MACH_ESATA_SHEEVAPLUG	ESATA_SHEEVAPLUG	2678
 msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679
-- 
1.7.2.3
