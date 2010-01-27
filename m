From: buserror@gmail.com (Michel Pollet)
Date: Wed, 27 Jan 2010 14:18:43 +0000
Subject: [PATCH 2/3] ARM: S3C: Configuration override for UART names
In-Reply-To: <1264601924-18480-1-git-send-email-buserror@gmail.com>
References: <1264601924-18480-1-git-send-email-buserror@gmail.com>
Message-ID: <1264601924-18480-2-git-send-email-buserror@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C UART devices  are named s3c2410_serialX and it is
inconsistent with the kernel at boot time (console=ttySACx)
This patch allows the config file to override this and
use the standard name instead.

Signed-off-by: Michel Pollet <buserror@gmail.com>
---
 drivers/serial/samsung.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

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
