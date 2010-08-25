From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Wed, 25 Aug 2010 11:57:19 +0530
Subject: [PATCH v6] OpenRD: Enable SD/UART selection for serial port 1
Message-ID: <1282717639-7996-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables user to use serial port 1 of the OpenRD device for SDIO
or UART(RS232/RS485). The selection can be done through kernel parameter.

By default the port would be used for SDIO. To select RS232 or RS485 mode,
pass string "kw_openrd_init_uart1=232" or "kw_openrd_init_uart1=485"
respectively in the kernel parameters. "kw_openrd_init_uart1=485" is
ignored on OpenRD-Base as it doesn't have RS485 port.

v2 - use gpio* functions instead of read/write to set/reset GPIO
v3 - notify user when wrong kernel paramter is passed
v4 - use linux/gpio.h instead of mach/gpio.h
v5 - changed uart1_mpp_config to be static, global & __initdata
v6 - changed kernel parameter to 'kw_openrd_init_uart1=...' from 'uart=...'

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-kirkwood/openrd-setup.c |  101 ++++++++++++++++++++++++++++++++-
 1 files changed, 100 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index fd06be6..a9476d8 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -16,6 +16,7 @@
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
@@ -57,7 +58,22 @@ static struct mvsdio_platform_data openrd_mvsdio_data = {
 };
 
 static unsigned int openrd_mpp_config[] __initdata = {
+	MPP12_SD_CLK,
+	MPP13_SD_CMD,
+	MPP14_SD_D0,
+	MPP15_SD_D1,
+	MPP16_SD_D2,
+	MPP17_SD_D3,
+	MPP28_GPIO,
 	MPP29_GPIO,
+	MPP34_GPIO,
+	0
+};
+
+/* Configure MPP for UART1 */
+static unsigned int uart1_mpp_config[] __initdata = {
+	MPP13_UART1_TXD,
+	MPP14_UART1_RXD,
 	0
 };
 
@@ -67,6 +83,68 @@ static struct i2c_board_info i2c_board_info[] __initdata = {
 	},
 };
 
+static int __initdata uart1;
+
+static int __init sd_uart_selection(char *str)
+{
+	uart1 = -EINVAL;
+
+	/* Default is SD. Change if required, for UART */
+	if (!str)
+		return 0;
+
+	if (!strncmp(str, "232", 3)) {
+		uart1 = 232;
+	} else if (!strncmp(str, "485", 3)) {
+		/* OpenRD-Base doesn't have RS485. Treat is as an
+		 * unknown argument & just have default setting -
+		 * which is SD */
+		if (machine_is_openrd_base()) {
+			uart1 = -ENODEV;
+			return 1;
+		}
+
+		uart1 = 485;
+	}
+	return 1;
+}
+/* Parse boot_command_line string kw_openrd_init_uart1=232/485 */
+__setup("kw_openrd_init_uart1=", sd_uart_selection);
+
+static int __init uart1_mpp_config(void)
+{
+	kirkwood_mpp_conf(uart1_mpp_config);
+
+	if (gpio_request(34, "SD_UART1_SEL")) {
+		printk(KERN_ERR "GPIO request failed for SD/UART1 selection"
+				", gpio: 34\n");
+		return -EIO;
+	}
+
+	if (gpio_request(28, "RS232_RS485_SEL")) {
+		printk(KERN_ERR "GPIO request failed for RS232/RS485 selection"
+				", gpio# 28\n");
+		gpio_free(34);
+		return -EIO;
+	}
+
+	/* Select UART1
+	 * Pin # 34: 0 => UART1, 1 => SD */
+	gpio_direction_output(34, 0);
+
+	/* Select RS232 OR RS485
+	 * Pin # 28: 0 => RS232, 1 => RS485 */
+	if (uart1 == 232)
+		gpio_direction_output(28, 0);
+	else
+		gpio_direction_output(28, 1);
+
+	gpio_free(34);
+	gpio_free(28);
+
+	return 0;
+}
+
 static void __init openrd_init(void)
 {
 	/*
@@ -90,7 +168,6 @@ static void __init openrd_init(void)
 		kirkwood_ge01_init(&openrd_ge01_data);
 
 	kirkwood_sata_init(&openrd_sata_data);
-	kirkwood_sdio_init(&openrd_mvsdio_data);
 
 	kirkwood_i2c_init();
 
@@ -99,6 +176,28 @@ static void __init openrd_init(void)
 			ARRAY_SIZE(i2c_board_info));
 		kirkwood_audio_init();
 	}
+
+	if (uart1 <= 0) {
+		if (uart1 < 0)
+			printk(KERN_ERR "Invalid kernel parameter to select "
+				"UART1. Defaulting to SD. ERROR CODE: %d\n",
+				uart1);
+
+		/* Select SD
+		 * Pin # 34: 0 => UART1, 1 => SD */
+		if (gpio_request(34, "SD_UART1_SEL")) {
+			printk(KERN_ERR "GPIO request failed for SD/UART1 "
+					"selection, gpio: 34\n");
+		} else {
+
+			gpio_direction_output(34, 1);
+			gpio_free(34);
+			kirkwood_sdio_init(&openrd_mvsdio_data);
+		}
+	} else {
+		if (!uart1_mpp_config())
+			kirkwood_uart1_init();
+	}
 }
 
 static int __init openrd_pci_init(void)
-- 
1.6.6.1
