From: buserror@gmail.com (Michel Pollet)
Date: Wed, 27 Jan 2010 16:38:09 +0000
Subject: [PATCH 2/2] ARM: S3C: Configuration override for UART names
In-Reply-To: <1264610289-14412-1-git-send-email-buserror@gmail.com>
References: <1264610289-14412-1-git-send-email-buserror@gmail.com>
Message-ID: <1264610289-14412-2-git-send-email-buserror@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C UART devices  are named s3c2410_serialX and it is
inconsistent with the kernel at boot time (console=ttySACx)
This patch allows the config file to override this and
use the standard name instead.

Signed-off-by: Michel Pollet <buserror@gmail.com>
---
 arch/arm/plat-s3c/Kconfig |    9 +++++++++
 drivers/serial/samsung.c  |    9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 9e9d028..158257a 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -113,6 +113,15 @@ config S3C_LOWLEVEL_UART_PORT
 	  this configuration should be between zero and two. The port
 	  must have been initialised by the boot-loader before use.
 
+config S3C_STD_UART_NAMES
+	bool "Name S3C UART device files as ttySACx"
+	default n
+	help
+	  The kernel and most other SoC use the ttySACx naming scheme
+	  for UART device file naming. The default for S3C is to use
+	  s3c2410_serialX, and it confuses a lot of distros; it is also
+	  inconsistent with the console= kernel parameter.
+
 # options for gpiolib support
 
 config S3C_GPIO_SPACE
diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index 52e3df1..e3dd135 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -55,7 +55,14 @@
 
 /* UART name and device definitions */
 
+#ifdef CONFIG_S3C_STD_UART_NAMES
+/* All other SoC use this naming sheme, 
+   including the kernel earlier at boot time */
 #define S3C24XX_SERIAL_NAME	"ttySAC"
+#else
+/* Legacy option */
+#define S3C24XX_SERIAL_NAME	"s3c2410_serial"
+#endif
 #define S3C24XX_SERIAL_MAJOR	204
 #define S3C24XX_SERIAL_MINOR	64
 
@@ -878,7 +885,7 @@ static struct uart_ops s3c24xx_serial_ops = {
 
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
-	.dev_name	= "s3c2410_serial",
+	.dev_name	= S3C24XX_SERIAL_NAME,
 	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.driver_name	= S3C24XX_SERIAL_NAME,
-- 
1.6.6
