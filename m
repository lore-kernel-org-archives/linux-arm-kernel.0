From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 14 Oct 2011 17:08:09 +0100
Subject: [PATCH] mach-kirkwood: Add support for D-Link DNS-325
Message-ID: <op.v3cm3vmp4cuzmg@gonzo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the D-Link DNS-325 NAS. A kirkwood-based successor
to the DNS-323.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
The code is largely based on either other kirkwood devices or the DNS-323, so
there shouldn't be anything too weird. A few points though:-

* There are still unexplored sections of the hardware, a reset button and D-link
have an option to for "power-off recovery". Will continue to search the D-Link
code for them, but the NAS is pretty functional without for now.

* I'm not entirely convinced by permanently stealing the SATA power GPIOs,
however it seems safer than them possibly getting switched off accidentally.

* There's a high chance that the DNS-320 (a cheaper device released at the same
time, with ~identical specs) could be supported by the same setup file. This is
just speculation though, I've not got one of these.

* It'd be nice to expose the SATA activity LEDs as LEDs, and allow the mapping
to happen in software, but there doesn't seem to be a LED trigger for that yet
(unless I've missed something).

Cheers,

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7fc603b..9759cae 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -130,6 +130,12 @@ config MACH_T5325
   	  Say 'Y' here if you want your kernel to support the
   	  HP t5325 Thin Client.

+config MACH_DNS325
+	bool "D-Link DNS-325"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  D-Link DNS-325 NAS.
+
   endmenu

   endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 5dcaa81..9b5d4ac 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
   obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
   obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
   obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
+obj-$(CONFIG_MACH_DNS325)		+= dns325-setup.o

   obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm/mach-kirkwood/dns325-setup.c b/arch/arm/mach-kirkwood/dns325-setup.c
new file mode 100644
index 0000000..4e7d16a
--- /dev/null
+++ b/arch/arm/mach-kirkwood/dns325-setup.c
@@ -0,0 +1,315 @@
+/*
+ * arch/arm/mach-kirkwood/dns325-setup.c
+ *
+ * D-Link DNS-325 Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
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
+static struct mtd_partition dns325_nand_parts[] = {
+	{
+		.name = "u-boot",
+		.offset = 0,
+		.size = SZ_1M,
+		.mask_flags = MTD_WRITEABLE
+	}, {
+		.name = "uImage",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = 5 * SZ_1M
+	}, {
+		.name = "ramdisk",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = 5 * SZ_1M
+	}, {
+		.name = "image",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = 102 * SZ_1M
+	}, {
+		.name = "mini firmware",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = 10 * SZ_1M
+	}, {
+		.name = "config",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = 5 * SZ_1M
+	},
+};
+
+static struct mv643xx_eth_platform_data dns325_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+static struct mv_sata_platform_data dns325_sata_data = {
+	.n_ports	= 2,
+};
+
+/*
+ *  I2C-based devices
+ *
+ *  i2c addr | chip        | description
+ *  0x48     | GMT G751-2f | temp. sensor and therm. watchdog (LM75 compatible)
+ *  0x0c     | ?
+ *  0x64     | ?
+ */
+
+static struct i2c_board_info i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("lm75", 0x48),
+	},
+};
+
+
+/*
+ * GPIO-based devices
+ */
+
+static unsigned int dns325_mpp_config[] __initdata = {
+	MPP20_SATA1_ACTn,	/* LED: White Right HDD */
+	MPP21_SATA0_ACTn,	/* LED: White Left HDD */
+	MPP24_GPIO,
+	MPP25_GPIO,
+	MPP26_GPIO,	/* LED: Power */
+	MPP27_GPIO,	/* LED: Red Right HDD */
+	MPP28_GPIO,	/* LED: Red Left HDD */
+	MPP29_GPIO,	/* LED: Red USB */
+	MPP30_GPIO,
+	MPP31_GPIO,
+	MPP32_GPIO,
+	MPP33_GPO,
+	MPP34_GPIO,	/* Button: Front power */
+	MPP35_GPIO,
+	MPP36_GPIO,	/* Power: MV88F6281_DEV_ID Board */
+	MPP37_GPIO,
+	MPP38_GPIO,
+	MPP39_GPIO,	/* Power: SATA0 */
+	MPP40_GPIO,	/* Power: SATA1 */
+	MPP41_GPIO,
+	MPP42_GPIO,
+	MPP43_GPIO,	/* LED: White USB */
+	MPP44_GPIO,	/* Fan: Alarm */
+	MPP45_GPIO,	/* Fan: high speed */
+	MPP46_GPIO,	/* Fan: low speed */
+	MPP47_GPIO,	/* Button: Back unmount */
+	MPP48_GPIO,
+	MPP49_GPIO,
+	0
+};
+
+#define DNS325_GPIO_LED_POWER	26
+#define DNS325_GPIO_LED_RED_R	27
+#define DNS325_GPIO_LED_RED_L	28
+#define DNS325_GPIO_LED_RED_USB	29
+#define DNS325_GPIO_LED_WHITE_R	20
+#define DNS325_GPIO_LED_WHITE_L	21
+#define DNS325_GPIO_LED_WHITE_USB	43
+#define DNS325_GPIO_FAN_ALARM	44
+#define DNS325_GPIO_FAN_HIGH	45
+#define DNS325_GPIO_FAN_LOW	46
+#define DNS325_GPIO_BTN_POWER	34
+#define DNS325_GPIO_BTN_UNMOUNT	47
+#define DNS325_GPIO_POWER_6281	36
+#define DNS325_GPIO_POWER_SATA0	39
+#define DNS325_GPIO_POWER_SATA1	40
+
+static void dns325_6281_power_off(void)
+{
+	gpio_set_value(DNS325_GPIO_POWER_6281, 1);
+}
+
+/* Buttons */
+
+static struct gpio_keys_button dns325_button_pins[] = {
+	{
+		.code		= KEY_POWER,
+		.gpio		= DNS325_GPIO_BTN_POWER,
+		.desc		= "Power button",
+		.active_low	= 1,
+	},
+	{
+		.code		= KEY_EJECTCD,
+		.gpio		= DNS325_GPIO_BTN_UNMOUNT,
+		.desc		= "USB unmount button",
+		.active_low	= 1,
+	},
+};
+
+static struct gpio_keys_platform_data dns325_button_data = {
+	.buttons	= dns325_button_pins,
+	.nbuttons	= ARRAY_SIZE(dns325_button_pins),
+};
+
+static struct platform_device dns325_button_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &dns325_button_data,
+	}
+};
+
+/*
+ * LEDs
+ *
+ * In theory these can blink in hardware too, but it's really annoying.
+ */
+
+static struct gpio_led dns325_led_pins[] = {
+	{
+		.name	= "dns325:white:power",
+		.gpio	= DNS325_GPIO_LED_POWER,
+		.active_low = 1,
+		.default_trigger = "default-on",
+	},
+	{
+		.name	= "dns325:white:usb",
+		.gpio	= DNS325_GPIO_LED_WHITE_USB,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns325:red:l_hdd",
+		.gpio	= DNS325_GPIO_LED_RED_L,
+		.active_low = 1,
+	},
+	{
+		.name	= "dns325:red:r_hdd",
+		.gpio	= DNS325_GPIO_LED_RED_R,
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
+
+/* Fan */
+
+/* DNS-325 Fan: ADDA AD045HB-G73 40mm 6000rpm at 5v */
+static struct gpio_fan_speed dns325_fan_speed[] = {
+	{    0,  0 },
+	{ 3000,	 1 },
+	{ 6000,	 2 },
+};
+
+static unsigned dns325_fan_pins[] = {
+	DNS325_GPIO_FAN_LOW,
+	DNS325_GPIO_FAN_HIGH,
+};
+
+static struct gpio_fan_alarm dns325_fan_alarm = {
+	.gpio       = DNS325_GPIO_FAN_ALARM,
+	.active_low = 1,
+};
+
+static struct gpio_fan_platform_data dns325_fan_data = {
+	.num_ctrl	= ARRAY_SIZE(dns325_fan_pins),
+	.ctrl		= dns325_fan_pins,
+	.num_speed	= ARRAY_SIZE(dns325_fan_speed),
+	.speed		= dns325_fan_speed,
+	.alarm		= &dns325_fan_alarm,
+};
+
+static struct platform_device dns325_fan_device = {
+	.name	= "gpio-fan",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &dns325_fan_data,
+	},
+};
+
+
+static void __init dns325_init(void)
+{
+	u32 dev, rev;
+
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
+	kirkwood_mpp_conf(dns325_mpp_config);
+
+	kirkwood_uart0_init();
+	kirkwood_nand_init(ARRAY_AND_SIZE(dns325_nand_parts), 25);
+	kirkwood_ehci_init();
+	kirkwood_i2c_init();
+	kirkwood_ge00_init(&dns325_ge00_data);
+
+	/* Turn on power to harddrives, then enable SATA */
+	if (gpio_request(DNS325_GPIO_POWER_SATA0, "sata0-power") == 0
+	  && gpio_direction_output(DNS325_GPIO_POWER_SATA0, 0) == 0)
+		gpio_set_value(DNS325_GPIO_POWER_SATA0, 1);
+	else
+		pr_err("dns325: Failed to turn on SATA port 0\n");
+	if (gpio_request(DNS325_GPIO_POWER_SATA1, "sata1-power") == 0
+	  && gpio_direction_output(DNS325_GPIO_POWER_SATA1, 0) == 0)
+		gpio_set_value(DNS325_GPIO_POWER_SATA1, 1);
+	else
+		pr_err("dns325: Failed to turn on SATA port 1\n");
+	kirkwood_sata_init(&dns325_sata_data);
+
+	platform_device_register(&dns325_led_device);
+	platform_device_register(&dns325_button_device);
+	platform_device_register(&dns325_fan_device);
+	i2c_register_board_info(0, i2c_board_info, ARRAY_SIZE(i2c_board_info));
+
+	kirkwood_pcie_id(&dev, &rev);
+	if (dev == MV88F6281_DEV_ID) {
+		pr_info("PCI-E Device ID: MV88F6281, configuring power-off");
+		if (gpio_request(DNS325_GPIO_POWER_6281, "power-off") == 0 &&
+		    gpio_direction_output(DNS325_GPIO_POWER_6281, 0) == 0)
+			pm_power_off = dns325_6281_power_off;
+		else
+			pr_err("dns325: failed to configure power-off GPIO\n");
+	} else {
+		/*
+		 * Dlink code also defines 0x6192, and sets LOW_BASE +
+		 * 0x01000000 high. Either cargo-culted code or another model,
+		 * e.g. the cheaper DNS-320.
+		 */
+		pr_err("Unknown PCI-E Device ID %x, no power-off", dev);
+	}
+}
+
+MACHINE_START(DNS325, "D-Link DNS-325")
+	/* Maintainer: Jamie Lentin <jm@lentin.co.uk> */
+	.boot_params	= 0x00000100,
+	.init_machine	= dns325_init,
+	.map_io		= kirkwood_map_io,
+	.init_early	= kirkwood_init_early,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
