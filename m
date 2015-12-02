From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Dec 2015 22:27:03 +0100
Subject: [PATCH 1/7] ARM: orion: move watchdog setup to mach-orion5x
In-Reply-To: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
References: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
Message-ID: <1449091629-2155735-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog device node is created in plat-orion/common.c
but depends on the bridge address that is platform specific,
so as a preparation for orion multiplatform support, we
move it out of the common code into orion5x and dove.

At the moment, dove does not use the watchdog, so I'm marking
the function as __maybe_unused for the moment. The compiler
will be able to compile out the device definition this way,
and we can easily add it later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/common.c               | 17 +++++++++++++++++
 arch/arm/mach-orion5x/common.c            | 14 +++++++++++++-
 arch/arm/plat-orion/common.c              | 21 ---------------------
 arch/arm/plat-orion/include/plat/common.h |  2 --
 4 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 0d1a89298ece..25a682fd444f 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -375,6 +375,23 @@ void __init dove_setup_cpu_wins(void)
 				    DOVE_SCRATCHPAD_SIZE);
 }
 
+static struct resource orion_wdt_resource[] = {
+		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x04),
+		DEFINE_RES_MEM(RSTOUTn_MASK_PHYS, 0x04),
+};
+
+static struct platform_device orion_wdt_device = {
+	.name		= "orion_wdt",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(orion_wdt_resource),
+	.resource	= orion_wdt_resource,
+};
+
+static void __init __maybe_unused orion_wdt_init(void)
+{
+	platform_device_register(&orion_wdt_device);
+}
+
 void __init dove_init(void)
 {
 	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 6bbb7b55c6d1..2b7889e3b7bc 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -184,9 +184,21 @@ static void __init orion5x_crypto_init(void)
 /*****************************************************************************
  * Watchdog
  ****************************************************************************/
+static struct resource orion_wdt_resource[] = {
+		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x04),
+		DEFINE_RES_MEM(RSTOUTn_MASK_PHYS, 0x04),
+};
+
+static struct platform_device orion_wdt_device = {
+	.name		= "orion_wdt",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(orion_wdt_resource),
+	.resource	= orion_wdt_resource,
+};
+
 static void __init orion5x_wdt_init(void)
 {
-	orion_wdt_init();
+	platform_device_register(&orion_wdt_device);
 }
 
 
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 8861c367d061..78c8bf4043c0 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -21,7 +21,6 @@
 #include <net/dsa.h>
 #include <linux/platform_data/dma-mv_xor.h>
 #include <linux/platform_data/usb-ehci-orion.h>
-#include <mach/bridge-regs.h>
 #include <plat/common.h>
 
 /* Create a clkdev entry for a given device/clk */
@@ -589,26 +588,6 @@ void __init orion_spi_1_init(unsigned long mapbase)
 }
 
 /*****************************************************************************
- * Watchdog
- ****************************************************************************/
-static struct resource orion_wdt_resource[] = {
-		DEFINE_RES_MEM(TIMER_PHYS_BASE, 0x04),
-		DEFINE_RES_MEM(RSTOUTn_MASK_PHYS, 0x04),
-};
-
-static struct platform_device orion_wdt_device = {
-	.name		= "orion_wdt",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(orion_wdt_resource),
-	.resource	= orion_wdt_resource,
-};
-
-void __init orion_wdt_init(void)
-{
-	platform_device_register(&orion_wdt_device);
-}
-
-/*****************************************************************************
  * XOR
  ****************************************************************************/
 static u64 orion_xor_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index d9a24f605a2b..9e6d76ad48a9 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -75,8 +75,6 @@ void __init orion_spi_init(unsigned long mapbase);
 
 void __init orion_spi_1_init(unsigned long mapbase);
 
-void __init orion_wdt_init(void);
-
 void __init orion_xor0_init(unsigned long mapbase_low,
 			    unsigned long mapbase_high,
 			    unsigned long irq_0,
-- 
2.1.0.rc2
