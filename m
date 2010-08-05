From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:46 +0200
Subject: [PATCH 12/19] ARM: cam60: don't use __init for
	cam60_spi_{flash_platform_data, partitions}
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-12-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two structs are referenced by cam60_spi_devices.  The latter is
copied at init time to kmalloced memory and so the copy isn't freed after
booting.  So it must not contain references to .init memory.

This isn't noticed by modpost as cam60_spi_devices is in .init.data, too.

Noticed-by: Andrew Victor <avictor.za@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-at91/board-cam60.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 05c7072..44eb9f7 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -75,7 +75,7 @@ static struct at91_usbh_data __initdata cam60_usbh_data = {
  * SPI devices.
  */
 #if defined(CONFIG_MTD_DATAFLASH)
-static struct mtd_partition __initdata cam60_spi_partitions[] = {
+static struct mtd_partition cam60_spi_partitions[] = {
 	{
 		.name	= "BOOT1",
 		.offset	= 0,
@@ -98,7 +98,7 @@ static struct mtd_partition __initdata cam60_spi_partitions[] = {
 	},
 };
 
-static struct flash_platform_data cam60_spi_flash_platform_data __initdata = {
+static struct flash_platform_data cam60_spi_flash_platform_data = {
 	.name		= "spi_flash",
 	.parts		= cam60_spi_partitions,
 	.nr_parts	= ARRAY_SIZE(cam60_spi_partitions)
-- 
1.7.1
