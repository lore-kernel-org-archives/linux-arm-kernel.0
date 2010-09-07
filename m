From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 07 Sep 2010 13:49:26 +0100
Subject: [RFC PATCH 3/3] VExpress: Convert the platform code to use the
	physmap flash driver
In-Reply-To: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
References: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100907124926.7188.54919.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform was still using the integrator-flash driver but this
pretty much duplicates the physmap one.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-vexpress/v2m.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 817f0ad..5768e26 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -11,10 +11,10 @@
 #include <linux/spinlock.h>
 #include <linux/sysdev.h>
 #include <linux/usb/isp1760.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/clkdev.h>
 #include <asm/sizes.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/arm_timer.h>
@@ -194,27 +194,13 @@ static struct platform_device v2m_usb_device = {
 	.dev.platform_data = &v2m_usb_config,
 };
 
-static int v2m_flash_init(void)
-{
-	writel(0, MMIO_P2V(V2M_SYS_FLASH));
-	return 0;
-}
-
-static void v2m_flash_exit(void)
-{
-	writel(0, MMIO_P2V(V2M_SYS_FLASH));
-}
-
-static void v2m_flash_set_vpp(int on)
+static void v2m_flash_set_vpp(struct map_info *map, int on)
 {
 	writel(on != 0, MMIO_P2V(V2M_SYS_FLASH));
 }
 
-static struct flash_platform_data v2m_flash_data = {
-	.map_name	= "cfi_probe",
+static struct physmap_flash_data v2m_flash_data = {
 	.width		= 4,
-	.init		= v2m_flash_init,
-	.exit		= v2m_flash_exit,
 	.set_vpp	= v2m_flash_set_vpp,
 };
 
@@ -231,7 +217,7 @@ static struct resource v2m_flash_resources[] = {
 };
 
 static struct platform_device v2m_flash_device = {
-	.name		= "armflash",
+	.name		= "physmap-flash",
 	.id		= -1,
 	.resource	= v2m_flash_resources,
 	.num_resources	= ARRAY_SIZE(v2m_flash_resources),
