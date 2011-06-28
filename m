From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 28 Jun 2011 14:49:14 +0200
Subject: [PATCH 2/5] mach-qt2410: convert to spi_gpio
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <1309265357-15879-3-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than the deprecated spi_s3c24xx_gpio driver.

Only compile tested. Notice that the board support seems quite broken
as the spi_s3c24xx_gpio platform device name was misspelled and there
is no struct spi_board_info defined, but this atleast didn't make it
any worse.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-s3c2410/mach-qt2410.c |   34 ++++++++--------------------------
 1 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index e8f49fe..f44f775 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -32,7 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
+#include <linux/spi/spi_gpio.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -53,8 +53,6 @@
 #include <mach/fb.h>
 #include <plat/nand.h>
 #include <plat/udc.h>
-#include <mach/spi.h>
-#include <mach/spi-gpio.h>
 #include <plat/iic.h>
 
 #include <plat/common-smdk.h>
@@ -216,32 +214,16 @@ static struct platform_device qt2410_led = {
 
 /* SPI */
 
-static void spi_gpio_cs(struct s3c2410_spigpio_info *spi, int cs)
-{
-	switch (cs) {
-	case BITBANG_CS_ACTIVE:
-		gpio_set_value(S3C2410_GPB(5), 0);
-		break;
-	case BITBANG_CS_INACTIVE:
-		gpio_set_value(S3C2410_GPB(5), 1);
-		break;
-	}
-}
-
-static struct s3c2410_spigpio_info spi_gpio_cfg = {
-	.pin_clk	= S3C2410_GPG(7),
-	.pin_mosi	= S3C2410_GPG(6),
-	.pin_miso	= S3C2410_GPG(5),
-	.chip_select	= &spi_gpio_cs,
+static struct spi_gpio_platform_data spi_gpio_cfg = {
+	.sck		= S3C2410_GPG(7),
+	.mosi		= S3C2410_GPG(6),
+	.miso		= S3C2410_GPG(5),
 };
 
-
 static struct platform_device qt2410_spi = {
-	.name		  = "s3c24xx-spi-gpio",
-	.id		  = 1,
-	.dev = {
-		.platform_data = &spi_gpio_cfg,
-	},
+	.name		= "spi-gpio",
+	.id		= 1,
+	.dev.platform_data = &spi_gpio_cfg,
 };
 
 /* Board devices */
-- 
1.7.5.4
