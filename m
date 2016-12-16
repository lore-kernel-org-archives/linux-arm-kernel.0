From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 10:08:55 +0100
Subject: [PATCH] omap2: mark omap_init_rng as __init
Message-ID: <20161216090906.2313595-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found this section mismatch when building with an older
compiler release:

WARNING: vmlinux.o(.text+0x3051c): Section mismatch in reference from the function omap_init_rng() to the function .init.text:omap_device_build()

Obviously this one function should be __init as well. Normally
we don't get a warning as the function gets inlined into its
caller.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 3fdb94599184..473951203104 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -121,7 +121,7 @@ static inline void omap_init_mcspi(void) {}
  *
  * Bind the RNG hwmod to the RNG omap_device.  No return value.
  */
-static void omap_init_rng(void)
+static void __init omap_init_rng(void)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
-- 
2.9.0
