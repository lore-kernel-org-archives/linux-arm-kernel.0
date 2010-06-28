From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 28 Jun 2010 16:39:15 +1200
Subject: [PATCH 3/3] at91: Add support for Bluewater Systems Snapper 9260/9G20
	modules
In-Reply-To: <1277699955-9931-1-git-send-email-ryan@bluewatersys.com>
References: <1277699955-9931-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1277699955-9931-4-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Bluewater Systems Snapper 9260/9G20 modules

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/Kconfig             |   11 ++
 arch/arm/mach-at91/Makefile            |    3 +
 arch/arm/mach-at91/board-snapper9260.c |  189 ++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-snapper9260.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 841eaf8..939bccd 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -366,6 +366,17 @@ config MACH_STAMP9G20
 
 endif
 
+if (ARCH_AT91SAM9260 || ARCH_AT91SAM9G20)
+comment "AT91SAM9260/AT91SAM9G20 boards"
+
+config MACH_SNAPPER_9260
+        bool "Bluewater Systems Snapper 9260/9G20 module"
+        help
+          Select this if you are using the Bluewater Systems Snapper 9260 or
+          Snapper 9G20 modules.
+          <http://www.bluewatersys.com/>
+endif
+
 # ----------------------------------------------------------
 
 if ARCH_AT91SAM9G45
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index c1f821e..ca2ac00 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -66,6 +66,9 @@ obj-$(CONFIG_MACH_CPU9G20)	+= board-cpu9krea.o
 obj-$(CONFIG_MACH_STAMP9G20)	+= board-stamp9g20.o
 obj-$(CONFIG_MACH_PORTUXG20)	+= board-stamp9g20.o
 
+# AT91SAM9260/AT91SAM9G20 board-specific support
+obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
+
 # AT91SAM9G45 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9G45EKES) += board-sam9m10g45ek.o
 
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
new file mode 100644
index 0000000..91ed809
--- /dev/null
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -0,0 +1,189 @@
+/*
+ * linux/arch/arm/mach-at91/board-snapper9260.c
+ *
+ *  Copyright (C) 2010 Bluewater System Ltd
+ *
+ * Author: Andre Renaud <andre@bluewatersys.com>
+ * Author: Ryan Mallon  <ryan@bluewatersys.com>
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
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/i2c/pca953x.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/hardware.h>
+#include <mach/board.h>
+#include <mach/at91sam9_smc.h>
+
+#include "sam9_smc.h"
+#include "generic.h"
+
+#define SNAPPER9260_IO_EXP_GPIO(x)	(NR_BUILTIN_GPIO + (x))
+
+static void __init snapper9260_map_io(void)
+{
+	at91sam9260_initialize(18432000);
+
+	/* Debug on ttyS0 */
+	at91_register_uart(0, 0, 0);
+	at91_set_serial_console(0);
+
+	at91_register_uart(AT91SAM9260_ID_US0, 1, 
+			   ATMEL_UART_CTS | ATMEL_UART_RTS);
+	at91_register_uart(AT91SAM9260_ID_US1, 2,
+			   ATMEL_UART_CTS | ATMEL_UART_RTS);	
+	at91_register_uart(AT91SAM9260_ID_US2, 3, 0);	
+}
+
+static void __init snapper9260_init_irq(void)
+{
+	at91sam9260_init_interrupts(NULL);
+}
+
+static struct at91_usbh_data __initdata snapper9260_usbh_data = {
+	.ports		= 2,
+};
+
+static struct at91_udc_data __initdata snapper9260_udc_data = {
+	.vbus_pin		= SNAPPER9260_IO_EXP_GPIO(5),
+	.vbus_active_low	= 1,
+	.vbus_polled		= 1,
+};
+
+static struct at91_eth_data snapper9260_macb_data = {
+	.is_rmii	= 1,
+};
+
+static struct mtd_partition __initdata snapper9260_nand_partitions[] = {
+	{
+		.name	= "Preboot",
+		.offset	= 0,
+		.size	= SZ_128K,
+	},
+	{
+		.name	= "Bootloader",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= SZ_256K,
+	},
+	{
+		.name	= "Environment",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= SZ_128K,
+	},
+	{
+		.name	= "Kernel",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= SZ_4M,
+	},
+	{
+		.name	= "Filesystem",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct mtd_partition * __init 
+snapper9260_nand_partition_info(int size, int *num_partitions)
+{
+	*num_partitions = ARRAY_SIZE(snapper9260_nand_partitions);
+	return snapper9260_nand_partitions;
+}
+
+static struct atmel_nand_data __initdata snapper9260_nand_data = {
+	.ale		= 21,
+	.cle		= 22,
+	.rdy_pin	= AT91_PIN_PC13,
+	.partition_info	= snapper9260_nand_partition_info,
+	.bus_width_16	= 0,
+};
+
+static struct sam9_smc_config __initdata snapper9260_nand_smc_config = {
+	.ncs_read_setup		= 0,
+	.nrd_setup		= 0,
+	.ncs_write_setup	= 0,
+	.nwe_setup		= 0,
+
+	.ncs_read_pulse		= 5,
+	.nrd_pulse		= 2,
+	.ncs_write_pulse	= 5,
+	.nwe_pulse		= 2,
+	
+	.read_cycle		= 7,
+	.write_cycle		= 7,
+
+	.mode			= (AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
+				   AT91_SMC_EXNWMODE_DISABLE),
+	.tdf_cycles		= 1,
+};
+
+static struct pca953x_platform_data snapper9260_io_expander_data = {
+	.gpio_base		= SNAPPER9260_IO_EXP_GPIO(0),
+};
+
+static struct i2c_board_info __initdata snapper9260_i2c_devices[] = {
+	{
+		/* IO expander */
+		I2C_BOARD_INFO("max7312", 0x28),
+		.platform_data = &snapper9260_io_expander_data,
+	},
+	{
+		/* Audio codec */
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
+	},
+	{
+		/* RTC */
+		I2C_BOARD_INFO("isl1208", 0x6f),
+	},
+};
+
+static void __init snapper9260_add_device_nand(void)
+{
+	at91_set_A_periph(AT91_PIN_PC14, 0);
+	sam9_smc_configure(3, &snapper9260_nand_smc_config);
+	at91_add_device_nand(&snapper9260_nand_data);
+}
+
+static void __init snapper9260_board_init(void)
+{
+	at91_add_device_i2c(snapper9260_i2c_devices,
+			    ARRAY_SIZE(snapper9260_i2c_devices));
+	at91_add_device_serial();
+	at91_add_device_usbh(&snapper9260_usbh_data);
+	at91_add_device_udc(&snapper9260_udc_data);
+	at91_add_device_eth(&snapper9260_macb_data);
+	at91_add_device_ssc(AT91SAM9260_ID_SSC, (ATMEL_SSC_TF | ATMEL_SSC_TK |
+						 ATMEL_SSC_TD | ATMEL_SSC_RD));
+	snapper9260_add_device_nand();
+}
+
+MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
+	.phys_io	= AT91_BASE_SYS,
+	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= snapper9260_map_io,
+	.init_irq	= snapper9260_init_irq,
+	.init_machine	= snapper9260_board_init,
+MACHINE_END
+
+
-- 
1.5.5.1
