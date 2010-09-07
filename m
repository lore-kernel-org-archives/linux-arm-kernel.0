From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 07 Sep 2010 13:49:15 +0100
Subject: [RFC PATCH 1/3] RealView: Convert the platform code to use the
	physmap flash driver
In-Reply-To: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
References: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100907124915.7188.33622.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform was still using the integrator-flash driver but this
pretty much duplicates the physmap one.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/core.c |   31 ++++---------------------------
 1 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 2fa38df..efeb2b3 100644
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
