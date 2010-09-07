From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 07 Sep 2010 13:49:21 +0100
Subject: [RFC PATCH 2/3] Versatile: Convert the platform code to use the
	physmap flash driver
In-Reply-To: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
References: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100907124921.7188.50829.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform was still using the integrator-flash driver but this
pretty much duplicates the physmap one.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-versatile/core.c |   31 ++++---------------------------
 1 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e38acb0..9cb37a9 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -31,6 +31,7 @@
 #include <linux/amba/pl022.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/clkdev.h>
 #include <asm/system.h>
@@ -42,7 +43,6 @@
 #include <asm/mach-types.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
@@ -231,27 +231,7 @@ void __init versatile_map_io(void)
 
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
 
@@ -263,11 +243,8 @@ static void versatile_flash_set_vpp(int on)
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
 
@@ -278,7 +255,7 @@ static struct resource versatile_flash_resource = {
 };
 
 static struct platform_device versatile_flash_device = {
-	.name			= "armflash",
+	.name			= "physmap-flash",
 	.id			= 0,
 	.dev			= {
 		.platform_data	= &versatile_flash_data,
