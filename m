From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 May 2011 14:11:12 +0100
Subject: [PATCH v6 3/8] ARM: Versatile: Use physmap driver instead of
	integrator-flash
In-Reply-To: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1305637877-24436-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 arch/arm/configs/versatile_defconfig |    2 +-
 arch/arm/mach-versatile/core.c       |   31 ++++---------------------------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 0ce710f..cdd4d2b 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -32,7 +32,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_ARM_INTEGRATOR=y
+CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_EEPROM_LEGACY=m
 CONFIG_NETDEVICES=y
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index eb7ffa0..06f406a 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/gfp.h>
 #include <linux/clkdev.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -42,7 +43,6 @@
 #include <asm/mach-types.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
@@ -190,27 +190,7 @@ void __init versatile_map_io(void)
 
 #define VERSATILE_FLASHCTRL    (__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_FLASH_OFFSET)
 
-static int versatile_flash_init(void)
-{
-	u32 val;
-
-	val = __raw_readl(VERSATILE_FLASHCTRL);
-	val &= ~VERSATILE_FLASHPROG_FLVPPEN;
-	__raw_writel(val, VERSATILE_FLASHCTRL);
-
-	return 0;
-}
-
-static void versatile_flash_exit(void)
-{
-	u32 val;
-
-	val = __raw_readl(VERSATILE_FLASHCTRL);
-	val &= ~VERSATILE_FLASHPROG_FLVPPEN;
-	__raw_writel(val, VERSATILE_FLASHCTRL);
-}
-
-static void versatile_flash_set_vpp(int on)
+static void versatile_flash_set_vpp(struct map_info *map, int on)
 {
 	u32 val;
 
@@ -222,11 +202,8 @@ static void versatile_flash_set_vpp(int on)
 	__raw_writel(val, VERSATILE_FLASHCTRL);
 }
 
-static struct flash_platform_data versatile_flash_data = {
-	.map_name		= "cfi_probe",
+static struct physmap_flash_data versatile_flash_data = {
 	.width			= 4,
-	.init			= versatile_flash_init,
-	.exit			= versatile_flash_exit,
 	.set_vpp		= versatile_flash_set_vpp,
 };
 
@@ -237,7 +214,7 @@ static struct resource versatile_flash_resource = {
 };
 
 static struct platform_device versatile_flash_device = {
-	.name			= "armflash",
+	.name			= "physmap-flash",
 	.id			= 0,
 	.dev			= {
 		.platform_data	= &versatile_flash_data,
-- 
1.7.0.4
