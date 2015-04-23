From: eric@anholt.net (Eric Anholt)
Date: Thu, 23 Apr 2015 10:49:11 -0700
Subject: [PATCH] ARM: BCM2835: Skip doing our own iotable_init()
 initialization.
Message-ID: <1429811351-12600-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only thing we were using this 16MB mapping of IO peripherals for
was the uart's early debug mapping.  If we just drop the map_io hook,
the kernel will call debug_ll_io_init() for us, which maps the single
page needed for the device.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/mach-bcm/board_bcm2835.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 70f2f39..9851ee8 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -31,10 +31,6 @@
 #define PM_RSTC_WRCFG_FULL_RESET	0x00000020
 #define PM_RSTS_HADWRH_SET		0x00000040
 
-#define BCM2835_PERIPH_PHYS	0x20000000
-#define BCM2835_PERIPH_VIRT	0xf0000000
-#define BCM2835_PERIPH_SIZE	SZ_16M
-
 static void __iomem *wdt_regs;
 
 /*
@@ -93,18 +89,6 @@ static void bcm2835_power_off(void)
 	bcm2835_restart(REBOOT_HARD, "");
 }
 
-static struct map_desc io_map __initdata = {
-	.virtual = BCM2835_PERIPH_VIRT,
-	.pfn = __phys_to_pfn(BCM2835_PERIPH_PHYS),
-	.length = BCM2835_PERIPH_SIZE,
-	.type = MT_DEVICE
-};
-
-static void __init bcm2835_map_io(void)
-{
-	iotable_init(&io_map, 1);
-}
-
 static void __init bcm2835_init(void)
 {
 	int ret;
@@ -129,7 +113,6 @@ static const char * const bcm2835_compat[] = {
 };
 
 DT_MACHINE_START(BCM2835, "BCM2835")
-	.map_io = bcm2835_map_io,
 	.init_irq = irqchip_init,
 	.init_machine = bcm2835_init,
 	.restart = bcm2835_restart,
-- 
2.1.4
