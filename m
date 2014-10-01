From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed,  1 Oct 2014 22:12:57 +0530
Subject: [PATCH v2 2/2] tty: serial: samsung: Clean-up selection of number of
 available UARTs
In-Reply-To: <1412181777-6388-1-git-send-email-a.kesavan@samsung.com>
References: <1412181777-6388-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1412181777-6388-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove symbols SERIAL_SAMSUNG_UARTS_4 and SERIAL_SAMSUNG_UARTS which
select the number of UART ports available on the SoC. Replace the usage
of SERIAL_SAMSUNG_UARTS in the serial driver with the maximum number of
UART ports possible. Removal of these symbols also helps in Exynos7
serial enablement.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig   |   16 ----------------
 drivers/tty/serial/samsung.c |   11 +++--------
 drivers/tty/serial/samsung.h |    5 ++++-
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 81f6ee7..9fc9092 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -247,22 +247,6 @@ config SERIAL_SAMSUNG
 	  provide all of these ports, depending on how the serial port
 	  pins are configured.
 
-config SERIAL_SAMSUNG_UARTS_4
-	bool
-	depends on PLAT_SAMSUNG
-	default y if !(CPU_S3C2410 || CPU_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
-	help
-	  Internal node for the common case of 4 Samsung compatible UARTs
-
-config SERIAL_SAMSUNG_UARTS
-	int
-	depends on PLAT_SAMSUNG
-	default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
-	default 3
-	help
-	  Select the number of available UART ports for the Samsung S3C
-	  serial driver
-	
 config SERIAL_SAMSUNG_DEBUG
 	bool "Samsung SoC serial debug"
 	depends on SERIAL_SAMSUNG && DEBUG_LL
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c78f43a..ba04c6d 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -962,14 +962,14 @@ static struct uart_ops s3c24xx_serial_ops = {
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "s3c2410_serial",
-	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
+	.nr		= MAX_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.dev_name	= S3C24XX_SERIAL_NAME,
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };
 
-static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
+static struct s3c24xx_uart_port s3c24xx_serial_ports[MAX_SAMSUNG_UARTS] = {
 	[0] = {
 		.port = {
 			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[0].port.lock),
@@ -992,8 +992,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 			.line		= 1,
 		}
 	},
-#if CONFIG_SERIAL_SAMSUNG_UARTS > 2
-
 	[2] = {
 		.port = {
 			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[2].port.lock),
@@ -1005,8 +1003,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 			.line		= 2,
 		}
 	},
-#endif
-#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
 	[3] = {
 		.port = {
 			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[3].port.lock),
@@ -1018,7 +1014,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 			.line		= 3,
 		}
 	}
-#endif
 };
 
 /* s3c24xx_serial_resetport
@@ -1590,7 +1585,7 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 
 	/* is this a valid port */
 
-	if (co->index == -1 || co->index >= CONFIG_SERIAL_SAMSUNG_UARTS)
+	if (co->index == -1 || co->index >= MAX_SAMSUNG_UARTS)
 		co->index = 0;
 
 	port = &s3c24xx_serial_ports[co->index].port;
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index eb071dd..484b49e 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -1,6 +1,9 @@
 #ifndef __SAMSUNG_H
 #define __SAMSUNG_H
 
+/* Maximum UART ports available */
+#define MAX_SAMSUNG_UARTS       4
+
 /*
  * Driver for Samsung SoC onboard UARTs.
  *
@@ -38,7 +41,7 @@ struct s3c24xx_uart_info {
 struct s3c24xx_serial_drv_data {
 	struct s3c24xx_uart_info	*info;
 	struct s3c2410_uartcfg		*def_cfg;
-	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
+	unsigned int			fifosize[MAX_SAMSUNG_UARTS];
 };
 
 struct s3c24xx_uart_port {
-- 
1.7.9.5
