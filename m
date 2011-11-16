From: cvubrugier@lacie.com (Christophe Vu-Brugier)
Date: Wed, 16 Nov 2011 09:52:53 +0100
Subject: [PATCH v2] ARM: kirkwood: add LaCie Network Space Lite v2 support
Message-ID: <1321433573-3851-1-git-send-email-cvubrugier@lacie.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LaCie Network Space Lite v2 shares most of its characteristics
with the LaCie Network Space v2.

Hardware:
 * CPU: Marvell 88F6192 800Mhz
 * SDRAM memory: 128 MiB DDR2
 * Gigabit ethernet: PHY Marvell 88E1318
 * Flash memory: Macronix MX25L4005A 512 KiB
 * i2c EEPROM: 512 bytes
 * 2 USB2 ports: host and host/device
 * 1 push button
 * 2 LEDs (red and blue)

Signed-off-by: Christophe Vu-Brugier <cvubrugier@lacie.com>
---
The patch has been rebased on top of the 'reset' branch. It depends on
the following commit:

  2f82cc8 ARM: restart: kirkwood: use new restart hook

Changes since v1:
 * reorder machine_desc initializers
 * use the leds-gpio driver to manage the blue LED

 arch/arm/mach-kirkwood/Kconfig             |    6 +++
 arch/arm/mach-kirkwood/Makefile            |    1 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c |   61 +++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7fc603b..3f64872 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -94,6 +94,12 @@ config MACH_NETSPACE_V2
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie Network Space v2 NAS.
 
+config MACH_NETSPACE_LITE_V2
+	bool "LaCie Network Space Lite v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie Network Space Lite v2 NAS.
+
 config MACH_INETSPACE_V2
 	bool "LaCie Internet Space v2 NAS Board"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 5dcaa81..6e408df 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
 obj-$(CONFIG_MACH_NETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
+obj-$(CONFIG_MACH_NETSPACE_LITE_V2)	+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_NETSPACE_MAX_V2)	+= netspace_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index e6bba01..a0342ee 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -109,6 +109,44 @@ static struct platform_device netspace_v2_gpio_leds = {
 	},
 };
 
+/*
+ * On the Network Space Lite v2, the blue LED is a GPIO LED too.
+ * It blinks when there is some SATA activity.
+ *
+ *   cmd | SATA active | LED state
+ *       |             |
+ *    1  |      x      |   off
+ *    0  |      0      |   on
+ *    0  |      1      |   blink
+ */
+#define NETSPACE_LITE_V2_GPIO_BLUE_LED	30
+
+static struct gpio_led netspace_lite_v2_gpio_led_pins[] = {
+	{
+		.name		= "ns_v2:red:fail",
+		.gpio		= NETSPACE_V2_GPIO_RED_LED,
+	},
+	{
+		.name		= "ns_v2:blue:sata",
+		.gpio		= NETSPACE_LITE_V2_GPIO_BLUE_LED,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+};
+
+static struct gpio_led_platform_data netspace_lite_v2_gpio_leds_data = {
+	.num_leds	= ARRAY_SIZE(netspace_lite_v2_gpio_led_pins),
+	.leds		= netspace_lite_v2_gpio_led_pins,
+};
+
+static struct platform_device netspace_lite_v2_gpio_leds = {
+	.name		= "leds-gpio",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &netspace_lite_v2_gpio_leds_data,
+	},
+};
+
 /*****************************************************************************
  * Dual-GPIO CPLD LEDs
  ****************************************************************************/
@@ -237,14 +275,21 @@ static void __init netspace_v2_init(void)
 		lacie_v2_hdd_power_init(1);
 
 	kirkwood_ehci_init();
+	if (machine_is_netspace_lite_v2())
+		netspace_v2_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
 	kirkwood_ge00_init(&netspace_v2_ge00_data);
 	kirkwood_sata_init(&netspace_v2_sata_data);
 	kirkwood_uart0_init();
 	lacie_v2_register_flash();
 	lacie_v2_register_i2c_devices();
 
-	platform_device_register(&netspace_v2_leds);
-	platform_device_register(&netspace_v2_gpio_leds);
+	if (machine_is_netspace_lite_v2())
+		platform_device_register(&netspace_lite_v2_gpio_leds);
+	else {
+		platform_device_register(&netspace_v2_leds);
+		platform_device_register(&netspace_v2_gpio_leds);
+	}
+
 	platform_device_register(&netspace_v2_gpio_buttons);
 	if (machine_is_netspace_max_v2())
 		platform_device_register(&netspace_max_v2_gpio_fan);
@@ -268,6 +313,18 @@ MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
 MACHINE_END
 #endif
 
+#ifdef CONFIG_MACH_NETSPACE_LITE_V2
+MACHINE_START(NETSPACE_LITE_V2, "LaCie Network Space Lite v2")
+	.atag_offset	= 0x100,
+	.map_io		= kirkwood_map_io,
+	.init_early	= kirkwood_init_early,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+	.init_machine	= netspace_v2_init,
+	.restart	= kirkwood_restart,
+MACHINE_END
+#endif
+
 #ifdef CONFIG_MACH_INETSPACE_V2
 MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
 	.atag_offset	= 0x100,
-- 
1.7.7.1
