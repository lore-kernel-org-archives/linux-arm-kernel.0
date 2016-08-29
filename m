From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 29 Aug 2016 12:30:00 +0200
Subject: [PATCH] ARM: ixp4xx: use IS_ENABLED() instead of checking for
 built-in or module
Message-ID: <1472466600-7682-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Using the macro makes the code more readable by helping abstract away some
of the Kconfig built-in and module enable details.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/mach-ixp4xx/ixdp425-setup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 508c2d7786e2..35582b1a5ffc 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -58,8 +58,7 @@ static struct platform_device ixdp425_flash = {
 	.resource	= &ixdp425_flash_resource,
 };
 
-#if defined(CONFIG_MTD_NAND_PLATFORM) || \
-    defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+#if IS_ENABLED(CONFIG_MTD_NAND_PLATFORM)
 
 static struct mtd_partition ixdp425_partitions[] = {
 	{
@@ -206,8 +205,7 @@ static struct platform_device ixdp425_eth[] = {
 static struct platform_device *ixdp425_devices[] __initdata = {
 	&ixdp425_i2c_gpio,
 	&ixdp425_flash,
-#if defined(CONFIG_MTD_NAND_PLATFORM) || \
-    defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+#if IS_ENABLED(CONFIG_MTD_NAND_PLATFORM)
 	&ixdp425_flash_nand,
 #endif
 	&ixdp425_uart,
@@ -223,8 +221,7 @@ static void __init ixdp425_init(void)
 	ixdp425_flash_resource.end =
 		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
 
-#if defined(CONFIG_MTD_NAND_PLATFORM) || \
-    defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+#if defined(CONFIG_MTD_NAND_PLATFORM)
 	ixdp425_flash_nand_resource.start = IXP4XX_EXP_BUS_BASE(3),
 	ixdp425_flash_nand_resource.end   = IXP4XX_EXP_BUS_BASE(3) + 0x10 - 1;
 
-- 
2.7.4
