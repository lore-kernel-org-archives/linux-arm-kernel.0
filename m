From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:39 +0200
Subject: [PATCH 11/24] ARM: lpc32xx: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: Roland Stigge <stigge@antcom.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-lpc32xx/common.c                |    8 ++++----
 arch/arm/mach-lpc32xx/include/mach/hardware.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index a48dc2d..0d4db8c 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -177,25 +177,25 @@ u32 clk_get_pclk_div(void)
 
 static struct map_desc lpc32xx_io_desc[] __initdata = {
 	{
-		.virtual	= IO_ADDRESS(LPC32XX_AHB0_START),
+		.virtual	= (unsigned long)IO_ADDRESS(LPC32XX_AHB0_START),
 		.pfn		= __phys_to_pfn(LPC32XX_AHB0_START),
 		.length		= LPC32XX_AHB0_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= IO_ADDRESS(LPC32XX_AHB1_START),
+		.virtual	= (unsigned long)IO_ADDRESS(LPC32XX_AHB1_START),
 		.pfn		= __phys_to_pfn(LPC32XX_AHB1_START),
 		.length		= LPC32XX_AHB1_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= IO_ADDRESS(LPC32XX_FABAPB_START),
+		.virtual	= (unsigned long)IO_ADDRESS(LPC32XX_FABAPB_START),
 		.pfn		= __phys_to_pfn(LPC32XX_FABAPB_START),
 		.length		= LPC32XX_FABAPB_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= IO_ADDRESS(LPC32XX_IRAM_BASE),
+		.virtual	= (unsigned long)IO_ADDRESS(LPC32XX_IRAM_BASE),
 		.pfn		= __phys_to_pfn(LPC32XX_IRAM_BASE),
 		.length		= (LPC32XX_IRAM_BANK_SIZE * 2),
 		.type		= MT_DEVICE
diff --git a/arch/arm/mach-lpc32xx/include/mach/hardware.h b/arch/arm/mach-lpc32xx/include/mach/hardware.h
index 33e1dde..69065de 100644
--- a/arch/arm/mach-lpc32xx/include/mach/hardware.h
+++ b/arch/arm/mach-lpc32xx/include/mach/hardware.h
@@ -25,7 +25,7 @@
 /*
  * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
  */
-#define IO_ADDRESS(x)	(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
+#define IO_ADDRESS(x)	IOMEM(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
 			 IO_BASE)
 
 #define io_p2v(x)	((void __iomem *) (unsigned long) IO_ADDRESS(x))
-- 
1.7.10
