From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  1 Aug 2013 10:45:30 +0200
Subject: [PATCH 1/9] ARM: kirkwood: convert d2net_v2 to DT
In-Reply-To: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375346738-21596-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-d2net-v2.dts | 204 ++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig          |  13 +-
 arch/arm/mach-kirkwood/Makefile         |   2 +-
 arch/arm/mach-kirkwood/board-d2net_v2.c |  72 ++++++++++
 arch/arm/mach-kirkwood/board-dt.c       |   3 +
 arch/arm/mach-kirkwood/common.h         |   6 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c | 231 --------------------------------
 7 files changed, 293 insertions(+), 238 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-d2net-v2.dts
 create mode 100644 arch/arm/mach-kirkwood/board-d2net_v2.c
 delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c

diff --git a/arch/arm/boot/dts/kirkwood-d2net-v2.dts b/arch/arm/boot/dts/kirkwood-d2net-v2.dts
new file mode 100644
index 0000000..f789ebd
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-d2net-v2.dts
@@ -0,0 +1,204 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "LaCie d2 Network v2";
+	compatible = "lacie,d2net_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; // FIXME
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pinctrl-0 = <&pmx_inhibit_poweroff
+				     &pmx_cpld_leds
+				     &pmx_sysrst>;
+
+			pmx_spi: pmx-spi {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
+				marvell,function = "spi";
+			};
+
+			pmx_i2c: pmx-i2c {
+				marvell,pins = "mpp8", "mpp9";
+				marvell,function = "twsi0";
+			};
+
+			pmx_uart: pmx-uart {
+				marvell,pins = "mpp10", "mpp11";
+				marvell,function = "uart0";
+			};
+
+			pmx_leds: pmx-leds {
+				marvell,pins = "mpp12";
+				marvell,function = "gpo";
+			};
+
+			pmx_keys: pmx-keys {
+				marvell,pins = "mpp13", "mpp15", "mpp34";
+				marvell,function = "gpio";
+			};
+
+			pmx_poweroff: pmx-poweroff {
+				marvell,pins = "mpp7";
+				marvell,function = "gpo";
+			};
+
+			pmx_sata_power: pmx-sata-power {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+
+			pmx_sata: pmx-sata {
+				marvell,pins = "mpp21";
+				marvell,function = "sata0";
+			};
+
+			pmx_sata: pmx-sata {
+				marvell,pins = "mpp14", "mpp24", "mpp26", "mpp28";
+				marvell,function = "gpio";
+			};
+
+			pmx_sysrst: pmx-sysrst {
+				marvell,pins = "mpp6"
+				marvell,function = "sysrst";
+			};
+
+			pmx_inhibit_poweroff: pmx-inhibit-poweroff {
+				marvell,pins = "mpp35"
+				marvell,function = "gpio";
+			};
+
+			pmx_cpld_leds: pmx-cpld-leds {
+				marvell,pins = "mpp29", "mpp30";
+				marvell,function = "gpio";
+			};
+		};
+
+		spi at 10600 {
+			status = "okay";
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
+
+			flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mx25l4005a";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				mode = <0>;
+
+				partition at 0 {
+					reg = <0x0 0x80000>;
+					label = "u-boot";
+				};
+			};
+		};
+
+		i2c at 11000 {
+			status = "okay";
+			pinctrl-0 = <&pmx_i2c>;
+			pinctrl-names = "default";
+
+			eeprom at 50 {
+				compatible = "at,24c04";
+				pagesize = <16>;
+				reg = <0x50>;
+			};
+		};
+
+		serial at 12000 {
+			status = "ok";
+			pinctrl-0 = <&pmx_uart>;
+			pinctrl-names = "default";
+		};
+
+		sata at 80000 {
+			nr-ports = <2>;
+			status = "okay";
+			pinctrl-0 = <&pmx_sata>;
+			pinctrl-names = "default";
+		};
+
+		ehci at 50000 {
+			pinctrl-0 = <&pmx_usb>;
+			pinctrl-names = "default";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_keys>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "Back power switch (on|auto)";
+			linux,code = <1>;
+			linux,input-type = <5>; /* EV_SW */
+			gpios = <&gpio0 13 0>;
+		};
+
+		button at 2 {
+			label = "Back power switch (auto|off)";
+			linux,code = <2>;
+			linux,input-type = <5>; /* EV_SW */
+			gpios = <&gpio0 15 0>;
+		};
+
+		button at 3 {
+			label = "Front Push Button";
+			linux,code = <116>; /* KEY_POWER */
+			gpios = <&gpio1 2 1>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led>;
+		pinctrl-names = "default";
+
+		fail {
+			label = "d2net_v2:red:fail";
+			gpios = <&gpio0 12 0>;
+			default-state = "on";
+		};
+	};
+
+        gpio_poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_poweroff>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 7 0>;
+        };
+
+        regulators {
+                compatible = "simple-bus";
+		pinctrl-0 = <&pmx_sata_power>;
+		pinctrl-names = "default";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                sata0_power: regulator at 1 {
+                        compatible = "regulator-fixed";
+                        reg = <1>;
+                        regulator-name = "SATA0 Power";
+                        regulator-min-microvolt = <5000000>;
+                        regulator-max-microvolt = <5000000>;
+                        enable-active-high;
+                        regulator-always-on;
+                        regulator-boot-on;
+                        gpio = <&gpio0 16 0>;
+                };
+        };
+};
+
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index b634f96..cb0c197 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -2,12 +2,6 @@ if ARCH_KIRKWOOD
 
 menu "Marvell Kirkwood Implementations"
 
-config MACH_D2NET_V2
-	bool "LaCie d2 Network v2 NAS Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  LaCie d2 Network v2 NAS.
-
 config MACH_DOCKSTAR
 	bool "Seagate FreeAgent DockStar"
 	help
@@ -146,6 +140,13 @@ config MACH_CLOUDBOX_DT
 	  Say 'Y' here if you want your kernel to support the LaCie
 	  CloudBox NAS, using Flattened Device Tree.
 
+config MACH_D2NET_V2_DT
+	bool "LaCie d2 Network v2 NAS Board (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie d2 Network v2 NAS, using Flattened Device Tree.
+
 config MACH_DB88F628X_BP_DT
 	bool "Marvell DB-88F628x-BP Development Board (Flattened Device Tree)"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index ac4cd75..d204380 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,6 +1,5 @@
 obj-y				+= common.o irq.o pcie.o mpp.o
 
-obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_DOCKSTAR)		+= dockstar-setup.o
 obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_GURUPLUG)		+= guruplug-setup.o
@@ -20,6 +19,7 @@ obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_CLOUDBOX_DT)		+= board-ns2.o
+obj-$(CONFIG_MACH_D2NET_V2_DT)		+= board-d2net_v2.o
 obj-$(CONFIG_MACH_DB88F628X_BP_DT)	+= board-db88f628x-bp.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_DOCKSTAR_DT)		+= board-dockstar.o
diff --git a/arch/arm/mach-kirkwood/board-d2net_v2.c b/arch/arm/mach-kirkwood/board-d2net_v2.c
new file mode 100644
index 0000000..8e2c52c
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-d2net_v2.c
@@ -0,0 +1,72 @@
+/*
+ * arch/arm/mach-kirkwood/d2net_v2-setup.c
+ *
+ * LaCie d2 Network Space v2 Board Setup
+ *
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mv643xx_eth.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include <linux/platform_data/leds-kirkwood-ns2.h>
+#include "common.h"
+
+/*****************************************************************************
+ * Ethernet
+ ****************************************************************************/
+
+static struct mv643xx_eth_platform_data d2net_v2_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+/*****************************************************************************
+ * Dual-GPIO CPLD LEDs
+ ****************************************************************************/
+
+#define D2NET_V2_GPIO_BLUE_LED_SLOW	29
+#define D2NET_V2_GPIO_BLUE_LED_CMD	30
+
+static struct ns2_led d2net_v2_led_pins[] = {
+	{
+		.name	= "d2net_v2:blue:sata",
+		.cmd	= D2NET_V2_GPIO_BLUE_LED_CMD,
+		.slow	= D2NET_V2_GPIO_BLUE_LED_SLOW,
+	},
+};
+
+static struct ns2_led_platform_data d2net_v2_leds_data = {
+	.num_leds	= ARRAY_SIZE(d2net_v2_led_pins),
+	.leds		= d2net_v2_led_pins,
+};
+
+static struct platform_device d2net_v2_leds = {
+	.name		= "leds-ns2",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &d2net_v2_leds_data,
+	},
+};
+
+void __init d2net_v2_init(void)
+{
+	kirkwood_ge00_init(&d2net_v2_ge00_data);
+	platform_device_register(&d2net_v2_leds);
+}
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 6e122ed..5b410a5 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -146,6 +146,9 @@ static void __init kirkwood_dt_init(void)
 	    of_machine_is_compatible("lacie,netspace_v2"))
 		ns2_init();
 
+	if (of_machine_is_compatible("lacie,d2net_v2"))
+		d2net_v2_init();
+
 	if (of_machine_is_compatible("marvell,db-88f6281-bp") ||
 	    of_machine_is_compatible("marvell,db-88f6282-bp"))
 		db88f628x_init();
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index fcf3ba6..c306ca3 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -80,6 +80,12 @@ void qnap_dt_ts219_init(void);
 static inline void qnap_dt_ts219_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_D2NET_V2_DT
+void d2net_v2_init(void);
+#else
+static inline void d2net_v2_init(void) {};
+#endif
+
 #ifdef CONFIG_MACH_DLINK_KIRKWOOD_DT
 void dnskw_init(void);
 #else
diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
deleted file mode 100644
index 4534180..0000000
--- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/d2net_v2-setup.c
- *
- * LaCie d2 Network Space v2 Board Setup
- *
- * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <linux/input.h>
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/leds.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
-#include <linux/platform_data/leds-kirkwood-ns2.h>
-#include "common.h"
-#include "mpp.h"
-#include "lacie_v2-common.h"
-
-/*****************************************************************************
- * Ethernet
- ****************************************************************************/
-
-static struct mv643xx_eth_platform_data d2net_v2_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-/*****************************************************************************
- * SATA
- ****************************************************************************/
-
-static struct mv_sata_platform_data d2net_v2_sata_data = {
-	.n_ports	= 2,
-};
-
-/*****************************************************************************
- * GPIO keys
- ****************************************************************************/
-
-#define D2NET_V2_GPIO_PUSH_BUTTON          34
-#define D2NET_V2_GPIO_POWER_SWITCH_ON      13
-#define D2NET_V2_GPIO_POWER_SWITCH_OFF     15
-
-#define D2NET_V2_SWITCH_POWER_ON           0x1
-#define D2NET_V2_SWITCH_POWER_OFF          0x2
-
-static struct gpio_keys_button d2net_v2_buttons[] = {
-	[0] = {
-		.type           = EV_SW,
-		.code           = D2NET_V2_SWITCH_POWER_ON,
-		.gpio           = D2NET_V2_GPIO_POWER_SWITCH_ON,
-		.desc           = "Back power switch (on|auto)",
-		.active_low     = 0,
-	},
-	[1] = {
-		.type           = EV_SW,
-		.code           = D2NET_V2_SWITCH_POWER_OFF,
-		.gpio           = D2NET_V2_GPIO_POWER_SWITCH_OFF,
-		.desc           = "Back power switch (auto|off)",
-		.active_low     = 0,
-	},
-	[2] = {
-		.code           = KEY_POWER,
-		.gpio           = D2NET_V2_GPIO_PUSH_BUTTON,
-		.desc           = "Front Push Button",
-		.active_low     = 1,
-	},
-};
-
-static struct gpio_keys_platform_data d2net_v2_button_data = {
-	.buttons	= d2net_v2_buttons,
-	.nbuttons	= ARRAY_SIZE(d2net_v2_buttons),
-};
-
-static struct platform_device d2net_v2_gpio_buttons = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &d2net_v2_button_data,
-	},
-};
-
-/*****************************************************************************
- * GPIO LEDs
- ****************************************************************************/
-
-#define D2NET_V2_GPIO_RED_LED		12
-
-static struct gpio_led d2net_v2_gpio_led_pins[] = {
-	{
-		.name	= "d2net_v2:red:fail",
-		.gpio	= D2NET_V2_GPIO_RED_LED,
-	},
-};
-
-static struct gpio_led_platform_data d2net_v2_gpio_leds_data = {
-	.num_leds	= ARRAY_SIZE(d2net_v2_gpio_led_pins),
-	.leds		= d2net_v2_gpio_led_pins,
-};
-
-static struct platform_device d2net_v2_gpio_leds = {
-	.name		= "leds-gpio",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &d2net_v2_gpio_leds_data,
-	},
-};
-
-/*****************************************************************************
- * Dual-GPIO CPLD LEDs
- ****************************************************************************/
-
-#define D2NET_V2_GPIO_BLUE_LED_SLOW	29
-#define D2NET_V2_GPIO_BLUE_LED_CMD	30
-
-static struct ns2_led d2net_v2_led_pins[] = {
-	{
-		.name	= "d2net_v2:blue:sata",
-		.cmd	= D2NET_V2_GPIO_BLUE_LED_CMD,
-		.slow	= D2NET_V2_GPIO_BLUE_LED_SLOW,
-	},
-};
-
-static struct ns2_led_platform_data d2net_v2_leds_data = {
-	.num_leds	= ARRAY_SIZE(d2net_v2_led_pins),
-	.leds		= d2net_v2_led_pins,
-};
-
-static struct platform_device d2net_v2_leds = {
-	.name		= "leds-ns2",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &d2net_v2_leds_data,
-	},
-};
-
-/*****************************************************************************
- * General Setup
- ****************************************************************************/
-
-static unsigned int d2net_v2_mpp_config[] __initdata = {
-	MPP0_SPI_SCn,
-	MPP1_SPI_MOSI,
-	MPP2_SPI_SCK,
-	MPP3_SPI_MISO,
-	MPP6_SYSRST_OUTn,
-	MPP7_GPO,		/* Request power-off */
-	MPP8_TW0_SDA,
-	MPP9_TW0_SCK,
-	MPP10_UART0_TXD,
-	MPP11_UART0_RXD,
-	MPP12_GPO,		/* Red led */
-	MPP13_GPIO,		/* Rear power switch (on|auto) */
-	MPP14_GPIO,		/* USB fuse */
-	MPP15_GPIO,		/* Rear power switch (auto|off) */
-	MPP16_GPIO,		/* SATA 0 power */
-	MPP21_SATA0_ACTn,
-	MPP24_GPIO,		/* USB mode select */
-	MPP26_GPIO,		/* USB device vbus */
-	MPP28_GPIO,		/* USB enable host vbus */
-	MPP29_GPIO,		/* Blue led (slow register) */
-	MPP30_GPIO,		/* Blue led (command register) */
-	MPP34_GPIO,		/* Power button (1 = Released, 0 = Pushed) */
-	MPP35_GPIO,		/* Inhibit power-off */
-	0
-};
-
-#define D2NET_V2_GPIO_POWER_OFF		7
-
-static void d2net_v2_power_off(void)
-{
-	gpio_set_value(D2NET_V2_GPIO_POWER_OFF, 1);
-}
-
-static void __init d2net_v2_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-	kirkwood_mpp_conf(d2net_v2_mpp_config);
-
-	lacie_v2_hdd_power_init(1);
-
-	kirkwood_ehci_init();
-	kirkwood_ge00_init(&d2net_v2_ge00_data);
-	kirkwood_sata_init(&d2net_v2_sata_data);
-	kirkwood_uart0_init();
-	lacie_v2_register_flash();
-	lacie_v2_register_i2c_devices();
-
-	platform_device_register(&d2net_v2_leds);
-	platform_device_register(&d2net_v2_gpio_leds);
-	platform_device_register(&d2net_v2_gpio_buttons);
-
-	if (gpio_request(D2NET_V2_GPIO_POWER_OFF, "power-off") == 0 &&
-	    gpio_direction_output(D2NET_V2_GPIO_POWER_OFF, 0) == 0)
-		pm_power_off = d2net_v2_power_off;
-	else
-		pr_err("d2net_v2: failed to configure power-off GPIO\n");
-}
-
-MACHINE_START(D2NET_V2, "LaCie d2 Network v2")
-	.atag_offset	= 0x100,
-	.init_machine	= d2net_v2_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-- 
1.8.1.2
