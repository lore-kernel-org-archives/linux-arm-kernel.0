From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Jan 2011 14:06:34 +0000
Subject: [PATCH 2/8] ARM: Realview: Use physmap driver instead of
	integrator-flash
In-Reply-To: <1294236400-22477-1-git-send-email-marc.zyngier@arm.com>
References: <1294236400-22477-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1294236400-22477-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on a PB11-MPCore.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/configs/realview-smp_defconfig |    2 +-
 arch/arm/configs/realview_defconfig     |    2 +-
 arch/arm/mach-realview/core.c           |   31 ++++---------------------------
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/arm/configs/realview-smp_defconfig b/arch/arm/configs/realview-smp_defconfig
index 5ca7a61..abe61bf 100644
--- a/arch/arm/configs/realview-smp_defconfig
+++ b/arch/arm/configs/realview-smp_defconfig
@@ -38,7 +38,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_ARM_INTEGRATOR=y
+CONFIG_MTD_PHYSMAP=y
 CONFIG_ARM_CHARLCD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index fcaa603..7079cbe 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -37,7 +37,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_ARM_INTEGRATOR=y
+CONFIG_MTD_PHYSMAP=y
 CONFIG_ARM_CHARLCD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 07c0815..e33096e 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -30,6 +30,7 @@
 #include <linux/ata_platform.h>
 #include <linux/amba/mmci.h>
 #include <linux/gfp.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/clkdev.h>
 #include <asm/system.h>
@@ -41,7 +42,6 @@
 #include <asm/hardware/icst.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
@@ -78,27 +78,7 @@ void __init realview_adjust_zones(unsigned long *size, unsigned long *hole)
 
 #define REALVIEW_FLASHCTRL    (__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_FLASH_OFFSET)
 
-static int realview_flash_init(void)
-{
-	u32 val;
-
-	val = __raw_readl(REALVIEW_FLASHCTRL);
-	val &= ~REALVIEW_FLASHPROG_FLVPPEN;
-	__raw_writel(val, REALVIEW_FLASHCTRL);
-
-	return 0;
-}
-
-static void realview_flash_exit(void)
-{
-	u32 val;
-
-	val = __raw_readl(REALVIEW_FLASHCTRL);
-	val &= ~REALVIEW_FLASHPROG_FLVPPEN;
-	__raw_writel(val, REALVIEW_FLASHCTRL);
-}
-
-static void realview_flash_set_vpp(int on)
+static void realview_flash_set_vpp(struct map_info *map, int on)
 {
 	u32 val;
 
@@ -110,16 +90,13 @@ static void realview_flash_set_vpp(int on)
 	__raw_writel(val, REALVIEW_FLASHCTRL);
 }
 
-static struct flash_platform_data realview_flash_data = {
-	.map_name		= "cfi_probe",
+static struct physmap_flash_data realview_flash_data = {
 	.width			= 4,
-	.init			= realview_flash_init,
-	.exit			= realview_flash_exit,
 	.set_vpp		= realview_flash_set_vpp,
 };
 
 struct platform_device realview_flash_device = {
-	.name			= "armflash",
+	.name			= "physmap-flash",
 	.id			= 0,
 	.dev			= {
 		.platform_data	= &realview_flash_data,
-- 
1.7.0.4
