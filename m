From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Dec 2013 17:35:39 +0100
Subject: [PATCH 1/2] ARM: integrator: delete static core module mappings
Message-ID: <1386174939-5801-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core module base is taken from the device tree
both for platform initialization and cpufreq, let's delete
the static mappings.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c | 8 +-------
 arch/arm/mach-integrator/integrator_cp.c | 8 --------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index d50dc2dbfd89..a762712bc2f2 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -64,6 +64,7 @@
 /* Base address to the AP system controller */
 void __iomem *ap_syscon_base;
 
+
 /*
  * All IO addresses are mapped onto VA 0xFFFx.xxxx, where x.xxxx
  * is the (PA >> 12).
@@ -73,12 +74,10 @@ void __iomem *ap_syscon_base;
  */
 #define VA_IC_BASE	__io_address(INTEGRATOR_IC_BASE)
 #define VA_EBI_BASE	__io_address(INTEGRATOR_EBI_BASE)
-#define VA_CMIC_BASE	__io_address(INTEGRATOR_HDR_IC)
 
 /*
  * Logical      Physical
  * ef000000			Cache flush
- * f1000000	10000000	Core module registers
  * f1100000	11000000	System controller registers
  * f1200000	12000000	EBI registers
  * f1300000	13000000	Counter/Timer
@@ -91,11 +90,6 @@ void __iomem *ap_syscon_base;
 
 static struct map_desc ap_io_desc[] __initdata __maybe_unused = {
 	{
-		.virtual	= IO_ADDRESS(INTEGRATOR_HDR_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_HDR_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_EBI_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_EBI_BASE),
 		.length		= SZ_4K,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 4fc0a195de01..916c0f345a3a 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -64,8 +64,6 @@ static void __iomem *intcp_con_base;
 
 /*
  * Logical      Physical
- * f1000000	10000000	Core module registers
- * f1100000	11000000	System controller registers
  * f1200000	12000000	EBI registers
  * f1300000	13000000	Counter/Timer
  * f1400000	14000000	Interrupt controller
@@ -74,16 +72,10 @@ static void __iomem *intcp_con_base;
  * f1a00000	1a000000	Debug LEDs
  * fc900000	c9000000	GPIO
  * fca00000	ca000000	SIC
- * fcb00000	cb000000	CP system control
  */
 
 static struct map_desc intcp_io_desc[] __initdata __maybe_unused = {
 	{
-		.virtual	= IO_ADDRESS(INTEGRATOR_HDR_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_HDR_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_EBI_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_EBI_BASE),
 		.length		= SZ_4K,
-- 
1.8.3.1
