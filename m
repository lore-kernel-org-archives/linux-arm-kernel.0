From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jul 2010 21:58:24 +0200
Subject: [PATCH 01/11] ARM: cam60: move cam60_spi_devices to .init.data
Message-ID: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cam60_spi_devices is passed to at91_add_device_spi which calls
spi_register_board_info.  The latter makes a copy of it, so living in
.init.data is OK.

This fixes the following warning in cam60_defconfig:
	WARNING: vmlinux.o(.data+0x2a00): Section mismatch in reference from the variable cam60_spi_devices to the (unknown reference) .init.data:(unknown)
	The variable cam60_spi_devices references
	the (unknown reference) __initdata (unknown)
	If the reference is valid then annotate the
	variable with __init* or __refdata (see linux/init.h) or name the variable:
	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-at91/board-cam60.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 02138af..05c7072 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -98,14 +98,14 @@ static struct mtd_partition __initdata cam60_spi_partitions[] = {
 	},
 };
 
-static struct flash_platform_data __initdata cam60_spi_flash_platform_data = {
+static struct flash_platform_data cam60_spi_flash_platform_data __initdata = {
 	.name		= "spi_flash",
 	.parts		= cam60_spi_partitions,
 	.nr_parts	= ARRAY_SIZE(cam60_spi_partitions)
 };
 #endif
 
-static struct spi_board_info cam60_spi_devices[] = {
+static struct spi_board_info cam60_spi_devices[] __initdata = {
 #if defined(CONFIG_MTD_DATAFLASH)
 	{	/* DataFlash chip */
 		.modalias	= "mtd_dataflash",
-- 
1.7.1
