From: simon@sequanux.org (Simon Guinot)
Date: Sun, 19 Sep 2010 15:33:59 +0200
Subject: [PATCH 2/2] [ARM] Kirkwood: remove duplicated code in LaCie setup
	files
In-Reply-To: <1284903239-25318-1-git-send-email-simon@sequanux.org>
References: <1284903239-25318-1-git-send-email-simon@sequanux.org>
Message-ID: <1284903239-25318-2-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/Kconfig             |   11 +++
 arch/arm/mach-kirkwood/Makefile            |    1 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c    |  102 +---------------------
 arch/arm/mach-kirkwood/lacie_v2-common.c   |  127 ++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/lacie_v2-common.h   |   18 ++++
 arch/arm/mach-kirkwood/netspace_v2-setup.c |  122 ++------------------------
 arch/arm/mach-kirkwood/netxbig_v2-setup.c  |  119 ++------------------------
 7 files changed, 181 insertions(+), 319 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
 create mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 3410633..ce21806 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -90,40 +90,51 @@ config MACH_OPENRD_ULTIMATE
 
 config MACH_NETSPACE_V2
 	bool "LaCie Network Space v2 NAS Board"
+	select LACIE_V2_COMMON
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie Network Space v2 NAS.
 
 config MACH_INETSPACE_V2
 	bool "LaCie Internet Space v2 NAS Board"
+	select LACIE_V2_COMMON
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie Internet Space v2 NAS.
 
 config MACH_NETSPACE_MAX_V2
 	bool "LaCie Network Space Max v2 NAS Board"
+	select LACIE_V2_COMMON
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie Network Space Max v2 NAS.
 
 config MACH_D2NET_V2
 	bool "LaCie d2 Network v2 NAS Board"
+	select LACIE_V2_COMMON
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie d2 Network v2 NAS.
 
 config MACH_NET2BIG_V2
 	bool "LaCie 2Big Network v2 NAS Board"
+	select LACIE_V2_COMMON
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie 2Big Network v2 NAS.
 
 config MACH_NET5BIG_V2
 	bool "LaCie 5Big Network v2 NAS Board"
+	select LACIE_V2_COMMON
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie 5Big Network v2 NAS.
 
+config LACIE_V2_COMMON
+        bool
+        help
+          Common machine code for LaCie v2 Boards.
+
 config MACH_T5325
 	bool "HP t5325 Thin Client"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 81d4f1b..452ebc5 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_MACH_NETSPACE_MAX_V2)	+= netspace_v2-setup.o
 obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o
 obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o
 obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o
+obj-$(CONFIG_LACIE_V2_COMMON)		+= lacie_v2-common.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
index 310c6a0..cd62d0f 100644
--- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
+++ b/arch/arm/mach-kirkwood/d2net_v2-setup.c
@@ -23,56 +23,19 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/i2c.h>
-#include <linux/i2c/at24.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/leds-ns2.h>
-#include <plat/time.h>
 #include "common.h"
 #include "mpp.h"
-
-/*****************************************************************************
- * 512KB SPI Flash on Boot Device
- ****************************************************************************/
-
-static struct mtd_partition d2net_v2_flash_parts[] = {
-	{
-		.name = "u-boot",
-		.size = MTDPART_SIZ_FULL,
-		.offset = 0,
-		.mask_flags = MTD_WRITEABLE,
-	},
-};
-
-static const struct flash_platform_data d2net_v2_flash = {
-	.type		= "mx25l4005a",
-	.name		= "spi_flash",
-	.parts		= d2net_v2_flash_parts,
-	.nr_parts	= ARRAY_SIZE(d2net_v2_flash_parts),
-};
-
-static struct spi_board_info __initdata d2net_v2_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &d2net_v2_flash,
-		.irq		= -1,
-		.max_speed_hz	= 20000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
+#include "lacie_v2-common.h"
 
 /*****************************************************************************
  * Ethernet
@@ -83,27 +46,6 @@ static struct mv643xx_eth_platform_data d2net_v2_ge00_data = {
 };
 
 /*****************************************************************************
- * I2C devices
- ****************************************************************************/
-
-static struct at24_platform_data at24c04 = {
-	.byte_len	= SZ_4K / 8,
-	.page_size	= 16,
-};
-
-/*
- * i2c addr | chip         | description
- * 0x50     | HT24LC04     | eeprom (512B)
- */
-
-static struct i2c_board_info __initdata d2net_v2_i2c_info[] = {
-	{
-		I2C_BOARD_INFO("24c04", 0x50),
-		.platform_data  = &at24c04,
-	}
-};
-
-/*****************************************************************************
  * SATA
  ****************************************************************************/
 
@@ -111,22 +53,6 @@ static struct mv_sata_platform_data d2net_v2_sata_data = {
 	.n_ports	= 2,
 };
 
-#define D2NET_V2_GPIO_SATA0_POWER	16
-
-static void __init d2net_v2_sata_power_init(void)
-{
-	int err;
-
-	err = gpio_request(D2NET_V2_GPIO_SATA0_POWER, "SATA0 power");
-	if (err == 0) {
-		err = gpio_direction_output(D2NET_V2_GPIO_SATA0_POWER, 1);
-		if (err)
-			gpio_free(D2NET_V2_GPIO_SATA0_POWER);
-	}
-	if (err)
-		pr_err("d2net_v2: failed to configure SATA0 power GPIO\n");
-}
-
 /*****************************************************************************
  * GPIO keys
  ****************************************************************************/
@@ -229,20 +155,6 @@ static struct platform_device d2net_v2_leds = {
 };
 
 /*****************************************************************************
- * Timer
- ****************************************************************************/
-
-static void d2net_v2_timer_init(void)
-{
-	kirkwood_tclk = 166666667;
-	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
-}
-
-struct sys_timer d2net_v2_timer = {
-	.init = d2net_v2_timer_init,
-};
-
-/*****************************************************************************
  * General Setup
  ****************************************************************************/
 
@@ -288,18 +200,14 @@ static void __init d2net_v2_init(void)
 	kirkwood_init();
 	kirkwood_mpp_conf(d2net_v2_mpp_config);
 
-	d2net_v2_sata_power_init();
+	lacie_v2_hdd_power_init(1);
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&d2net_v2_ge00_data);
 	kirkwood_sata_init(&d2net_v2_sata_data);
 	kirkwood_uart0_init();
-	spi_register_board_info(d2net_v2_spi_slave_info,
-				ARRAY_SIZE(d2net_v2_spi_slave_info));
-	kirkwood_spi_init();
-	kirkwood_i2c_init();
-	i2c_register_board_info(0, d2net_v2_i2c_info,
-				ARRAY_SIZE(d2net_v2_i2c_info));
+	lacie_v2_register_flash();
+	lacie_v2_register_i2c_devices();
 
 	platform_device_register(&d2net_v2_leds);
 	platform_device_register(&d2net_v2_gpio_leds);
@@ -319,5 +227,5 @@ MACHINE_START(D2NET_V2, "LaCie d2 Network v2")
 	.init_machine	= d2net_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &d2net_v2_timer,
+	.timer		= &lacie_v2_timer,
 MACHINE_END
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.c b/arch/arm/mach-kirkwood/lacie_v2-common.c
new file mode 100644
index 0000000..d3ea1b6
--- /dev/null
+++ b/arch/arm/mach-kirkwood/lacie_v2-common.c
@@ -0,0 +1,127 @@
+/*
+ * arch/arm/mach-kirkwood/lacie_v2-common.c
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mtd/physmap.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/i2c.h>
+#include <linux/i2c/at24.h>
+#include <linux/gpio.h>
+#include <asm/mach/time.h>
+#include <mach/kirkwood.h>
+#include <mach/irqs.h>
+#include <plat/time.h>
+#include "common.h"
+
+/*****************************************************************************
+ * 512KB SPI Flash on Boot Device (MACRONIX MX25L4005)
+ ****************************************************************************/
+
+static struct mtd_partition lacie_v2_flash_parts[] = {
+	{
+		.name = "u-boot",
+		.size = MTDPART_SIZ_FULL,
+		.offset = 0,
+		.mask_flags = MTD_WRITEABLE, /* force read-only */
+	},
+};
+
+static const struct flash_platform_data lacie_v2_flash = {
+	.type		= "mx25l4005a",
+	.name		= "spi_flash",
+	.parts		= lacie_v2_flash_parts,
+	.nr_parts	= ARRAY_SIZE(lacie_v2_flash_parts),
+};
+
+static struct spi_board_info __initdata lacie_v2_spi_slave_info[] = {
+	{
+		.modalias	= "m25p80",
+		.platform_data	= &lacie_v2_flash,
+		.irq		= -1,
+		.max_speed_hz	= 20000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+	},
+};
+
+void __init lacie_v2_register_flash(void)
+{
+	spi_register_board_info(lacie_v2_spi_slave_info,
+				ARRAY_SIZE(lacie_v2_spi_slave_info));
+	kirkwood_spi_init();
+}
+
+/*****************************************************************************
+ * I2C devices
+ ****************************************************************************/
+
+static struct at24_platform_data at24c04 = {
+	.byte_len	= SZ_4K / 8,
+	.page_size	= 16,
+};
+
+/*
+ * i2c addr | chip         | description
+ * 0x50     | HT24LC04     | eeprom (512B)
+ */
+
+static struct i2c_board_info __initdata lacie_v2_i2c_info[] = {
+	{
+		I2C_BOARD_INFO("24c04", 0x50),
+		.platform_data  = &at24c04,
+	}
+};
+
+void __init lacie_v2_register_i2c_devices(void)
+{
+	kirkwood_i2c_init();
+	i2c_register_board_info(0, lacie_v2_i2c_info,
+				ARRAY_SIZE(lacie_v2_i2c_info));
+}
+
+/*****************************************************************************
+ * Hard Disk power
+ ****************************************************************************/
+
+static int __initdata lacie_v2_gpio_hdd_power[] = { 16, 17, 41, 42, 43 };
+
+void __init lacie_v2_hdd_power_init(int hdd_num)
+{
+	int i;
+	int err;
+
+	/* Power up all hard disks. */
+	for (i = 0; i < hdd_num; i++) {
+		err = gpio_request(lacie_v2_gpio_hdd_power[i], NULL);
+		if (err == 0) {
+			err = gpio_direction_output(
+					lacie_v2_gpio_hdd_power[i], 1);
+			/* Free the HDD power GPIOs. This allow user-space to
+			 * configure them via the gpiolib sysfs interface. */
+			gpio_free(lacie_v2_gpio_hdd_power[i]);
+		}
+		if (err)
+			pr_err("Failed to power up HDD%d\n", i + 1);
+	}
+}
+
+/*****************************************************************************
+ * Timer
+ ****************************************************************************/
+
+static void lacie_v2_timer_init(void)
+{
+	kirkwood_tclk = 166666667;
+	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
+}
+
+struct sys_timer lacie_v2_timer = {
+	.init = lacie_v2_timer_init,
+};
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.h b/arch/arm/mach-kirkwood/lacie_v2-common.h
new file mode 100644
index 0000000..af52131
--- /dev/null
+++ b/arch/arm/mach-kirkwood/lacie_v2-common.h
@@ -0,0 +1,18 @@
+/*
+ * arch/arm/mach-kirkwood/lacie_v2-common.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ARCH_KIRKWOOD_LACIE_V2_COMMON_H
+#define __ARCH_KIRKWOOD_LACIE_V2_COMMON_H
+
+void lacie_v2_register_flash(void);
+void lacie_v2_register_i2c_devices(void);
+void lacie_v2_hdd_power_init(int hdd_num);
+
+extern struct sys_timer lacie_v2_timer;
+
+#endif
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index d26bf32..fed264d 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -24,56 +24,19 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/i2c.h>
-#include <linux/i2c/at24.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/leds-ns2.h>
-#include <plat/time.h>
 #include "common.h"
 #include "mpp.h"
-
-/*****************************************************************************
- * 512KB SPI Flash on Boot Device (MACRONIX MX25L4005)
- ****************************************************************************/
-
-static struct mtd_partition netspace_v2_flash_parts[] = {
-	{
-		.name = "u-boot",
-		.size = MTDPART_SIZ_FULL,
-		.offset = 0,
-		.mask_flags = MTD_WRITEABLE, /* force read-only */
-	},
-};
-
-static const struct flash_platform_data netspace_v2_flash = {
-	.type		= "mx25l4005a",
-	.name		= "spi_flash",
-	.parts		= netspace_v2_flash_parts,
-	.nr_parts	= ARRAY_SIZE(netspace_v2_flash_parts),
-};
-
-static struct spi_board_info __initdata netspace_v2_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &netspace_v2_flash,
-		.irq		= -1,
-		.max_speed_hz	= 20000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
+#include "lacie_v2-common.h"
 
 /*****************************************************************************
  * Ethernet
@@ -84,27 +47,6 @@ static struct mv643xx_eth_platform_data netspace_v2_ge00_data = {
 };
 
 /*****************************************************************************
- * I2C devices
- ****************************************************************************/
-
-static struct at24_platform_data at24c04 = {
-	.byte_len	= SZ_4K / 8,
-	.page_size	= 16,
-};
-
-/*
- * i2c addr | chip         | description
- * 0x50     | HT24LC04     | eeprom (512B)
- */
-
-static struct i2c_board_info __initdata netspace_v2_i2c_info[] = {
-	{
-		I2C_BOARD_INFO("24c04", 0x50),
-		.platform_data  = &at24c04,
-	}
-};
-
-/*****************************************************************************
  * SATA
  ****************************************************************************/
 
@@ -112,35 +54,6 @@ static struct mv_sata_platform_data netspace_v2_sata_data = {
 	.n_ports	= 2,
 };
 
-#define NETSPACE_V2_GPIO_SATA0_POWER	16
-#define NETSPACE_V2_GPIO_SATA1_POWER	17
-
-static void __init netspace_v2_sata_power_init(void)
-{
-	int err;
-
-	err = gpio_request(NETSPACE_V2_GPIO_SATA0_POWER, "SATA0 power");
-	if (err == 0) {
-		err = gpio_direction_output(NETSPACE_V2_GPIO_SATA0_POWER, 1);
-		if (err)
-			gpio_free(NETSPACE_V2_GPIO_SATA0_POWER);
-	}
-	if (err)
-		pr_err("netspace_v2: failed to setup SATA0 power\n");
-
-	if (machine_is_netspace_max_v2()) {
-		err = gpio_request(NETSPACE_V2_GPIO_SATA1_POWER, "SATA1 power");
-		if (err == 0) {
-			err = gpio_direction_output(
-					NETSPACE_V2_GPIO_SATA1_POWER, 1);
-			if (err)
-				gpio_free(NETSPACE_V2_GPIO_SATA1_POWER);
-		}
-		if (err)
-			pr_err("netspace_v2: failed to setup SATA1 power\n");
-	}
-}
-
 /*****************************************************************************
  * GPIO keys
  ****************************************************************************/
@@ -224,20 +137,6 @@ static struct platform_device netspace_v2_leds = {
 };
 
 /*****************************************************************************
- * Timer
- ****************************************************************************/
-
-static void netspace_v2_timer_init(void)
-{
-	kirkwood_tclk = 166666667;
-	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
-}
-
-struct sys_timer netspace_v2_timer = {
-	.init = netspace_v2_timer_init,
-};
-
-/*****************************************************************************
  * General Setup
  ****************************************************************************/
 
@@ -291,18 +190,17 @@ static void __init netspace_v2_init(void)
 	kirkwood_init();
 	kirkwood_mpp_conf(netspace_v2_mpp_config);
 
-	netspace_v2_sata_power_init();
+	if (machine_is_netspace_max_v2())
+		lacie_v2_hdd_power_init(2);
+	else
+		lacie_v2_hdd_power_init(1);
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&netspace_v2_ge00_data);
 	kirkwood_sata_init(&netspace_v2_sata_data);
 	kirkwood_uart0_init();
-	spi_register_board_info(netspace_v2_spi_slave_info,
-				ARRAY_SIZE(netspace_v2_spi_slave_info));
-	kirkwood_spi_init();
-	kirkwood_i2c_init();
-	i2c_register_board_info(0, netspace_v2_i2c_info,
-				ARRAY_SIZE(netspace_v2_i2c_info));
+	lacie_v2_register_flash();
+	lacie_v2_register_i2c_devices();
 
 	platform_device_register(&netspace_v2_leds);
 	platform_device_register(&netspace_v2_gpio_leds);
@@ -323,7 +221,7 @@ MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &netspace_v2_timer,
+	.timer		= &lacie_v2_timer,
 MACHINE_END
 #endif
 
@@ -335,7 +233,7 @@ MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &netspace_v2_timer,
+	.timer		= &lacie_v2_timer,
 MACHINE_END
 #endif
 
@@ -347,6 +245,6 @@ MACHINE_START(NETSPACE_MAX_V2, "LaCie Network Space Max v2")
 	.init_machine	= netspace_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &netspace_v2_timer,
+	.timer		= &lacie_v2_timer,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index 2bd14c5..aec528d 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -23,55 +23,18 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/i2c.h>
-#include <linux/i2c/at24.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <mach/kirkwood.h>
-#include <plat/time.h>
 #include "common.h"
 #include "mpp.h"
-
-/*****************************************************************************
- * 512KB SPI Flash on Boot Device (MACRONIX MX25L4005)
- ****************************************************************************/
-
-static struct mtd_partition netxbig_v2_flash_parts[] = {
-	{
-		.name = "u-boot",
-		.size = MTDPART_SIZ_FULL,
-		.offset = 0,
-		.mask_flags = MTD_WRITEABLE, /* force read-only */
-	},
-};
-
-static const struct flash_platform_data netxbig_v2_flash = {
-	.type		= "mx25l4005a",
-	.name		= "spi_flash",
-	.parts		= netxbig_v2_flash_parts,
-	.nr_parts	= ARRAY_SIZE(netxbig_v2_flash_parts),
-};
-
-static struct spi_board_info __initdata netxbig_v2_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &netxbig_v2_flash,
-		.irq		= -1,
-		.max_speed_hz	= 20000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
+#include "lacie_v2-common.h"
 
 /*****************************************************************************
  * Ethernet
@@ -86,27 +49,6 @@ static struct mv643xx_eth_platform_data netxbig_v2_ge01_data = {
 };
 
 /*****************************************************************************
- * I2C devices
- ****************************************************************************/
-
-static struct at24_platform_data at24c04 = {
-	.byte_len	= SZ_4K / 8,
-	.page_size	= 16,
-};
-
-/*
- * i2c addr | chip         | description
- * 0x50     | HT24LC04     | eeprom (512B)
- */
-
-static struct i2c_board_info __initdata netxbig_v2_i2c_info[] = {
-	{
-		I2C_BOARD_INFO("24c04", 0x50),
-		.platform_data  = &at24c04,
-	}
-};
-
-/*****************************************************************************
  * SATA
  ****************************************************************************/
 
@@ -114,34 +56,6 @@ static struct mv_sata_platform_data netxbig_v2_sata_data = {
 	.n_ports	= 2,
 };
 
-static int __initdata netxbig_v2_gpio_hdd_power[] = { 16, 17, 41, 42, 43 };
-
-static void __init netxbig_v2_sata_power_init(void)
-{
-	int i;
-	int err;
-	int hdd_nb;
-
-	if (machine_is_net2big_v2())
-		hdd_nb = 2;
-	else
-		hdd_nb = 5;
-
-	/* Power up all hard disks. */
-	for (i = 0; i < hdd_nb; i++) {
-		err = gpio_request(netxbig_v2_gpio_hdd_power[i], NULL);
-		if (err == 0) {
-			err = gpio_direction_output(
-					netxbig_v2_gpio_hdd_power[i], 1);
-			/* Free the HDD power GPIOs. This allow user-space to
-			 * configure them via the gpiolib sysfs interface. */
-			gpio_free(netxbig_v2_gpio_hdd_power[i]);
-		}
-		if (err)
-			pr_err("netxbig_v2: failed to power up HDD%d\n", i + 1);
-	}
-}
-
 /*****************************************************************************
  * GPIO keys
  ****************************************************************************/
@@ -246,20 +160,6 @@ static struct platform_device netxbig_v2_gpio_buttons = {
  */
 
 /*****************************************************************************
- * Timer
- ****************************************************************************/
-
-static void netxbig_v2_timer_init(void)
-{
-	kirkwood_tclk = 166666667;
-	orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
-}
-
-struct sys_timer netxbig_v2_timer = {
-	.init = netxbig_v2_timer_init,
-};
-
-/*****************************************************************************
  * General Setup
  ****************************************************************************/
 
@@ -366,7 +266,10 @@ static void __init netxbig_v2_init(void)
 	else
 		kirkwood_mpp_conf(net5big_v2_mpp_config);
 
-	netxbig_v2_sata_power_init();
+	if (machine_is_net2big_v2())
+		lacie_v2_hdd_power_init(2);
+	else
+		lacie_v2_hdd_power_init(5);
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&netxbig_v2_ge00_data);
@@ -374,12 +277,8 @@ static void __init netxbig_v2_init(void)
 		kirkwood_ge01_init(&netxbig_v2_ge01_data);
 	kirkwood_sata_init(&netxbig_v2_sata_data);
 	kirkwood_uart0_init();
-	spi_register_board_info(netxbig_v2_spi_slave_info,
-				ARRAY_SIZE(netxbig_v2_spi_slave_info));
-	kirkwood_spi_init();
-	kirkwood_i2c_init();
-	i2c_register_board_info(0, netxbig_v2_i2c_info,
-				ARRAY_SIZE(netxbig_v2_i2c_info));
+	lacie_v2_register_flash();
+	lacie_v2_register_i2c_devices();
 
 	platform_device_register(&netxbig_v2_gpio_buttons);
 
@@ -398,7 +297,7 @@ MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
 	.init_machine	= netxbig_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &netxbig_v2_timer,
+	.timer		= &lacie_v2_timer,
 MACHINE_END
 #endif
 
@@ -410,6 +309,6 @@ MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
 	.init_machine	= netxbig_v2_init,
 	.map_io		= kirkwood_map_io,
 	.init_irq	= kirkwood_init_irq,
-	.timer		= &netxbig_v2_timer,
+	.timer		= &lacie_v2_timer,
 MACHINE_END
 #endif
-- 
1.6.3.1
