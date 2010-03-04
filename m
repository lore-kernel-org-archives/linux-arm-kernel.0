From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Integrator: fix Integrator/CP definitions,
	move to platform.h
References: <git-1267729916-b3f4ccc3dfd1e01b45888a740b2b5638b82e0638@rmk-PC>
Message-ID: <git-1267729916-f385afa654740947343096c73e2389124fe60f54@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/include/mach/platform.h |   14 ++++---
 arch/arm/mach-integrator/integrator_ap.c         |    4 +-
 arch/arm/mach-integrator/integrator_cp.c         |   38 ++++++++++-----------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-integrator/include/mach/platform.h b/arch/arm/mach-integrator/include/mach/platform.h
index f934227..5e6ea5c 100644
--- a/arch/arm/mach-integrator/include/mach/platform.h
+++ b/arch/arm/mach-integrator/include/mach/platform.h
@@ -287,12 +287,14 @@
 #define INTEGRATOR_DBG_LEDS             (INTEGRATOR_DBG_BASE + INTEGRATOR_DBG_LEDS_OFFSET)
 #define INTEGRATOR_DBG_SWITCH           (INTEGRATOR_DBG_BASE + INTEGRATOR_DBG_SWITCH_OFFSET)
 
-
-#if defined(CONFIG_ARCH_INTEGRATOR_AP)
-#define INTEGRATOR_GPIO_BASE            0x1B000000	 /*  GPIO */
-#elif defined(CONFIG_ARCH_INTEGRATOR_CP)
-#define INTEGRATOR_GPIO_BASE            0xC9000000	 /*  GPIO */
-#endif
+#define INTEGRATOR_AP_GPIO_BASE		0x1B000000	/* GPIO */
+
+#define INTEGRATOR_CP_MMC_BASE		0x1C000000	/* MMC */
+#define INTEGRATOR_CP_AACI_BASE		0x1D000000	/* AACI */
+#define INTEGRATOR_CP_ETH_BASE		0xC8000000	/* Ethernet */
+#define INTEGRATOR_CP_GPIO_BASE		0xC9000000	/* GPIO */
+#define INTEGRATOR_CP_SIC_BASE		0xCA000000	/* SIC */
+#define INTEGRATOR_CP_CTL_BASE		0xCB000000	/* CP system control */
 
 /* ------------------------------------------------------------------------
  *  KMI keyboard/mouse definitions
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 93da7d4..45bba04 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -118,8 +118,8 @@ static struct map_desc ap_io_desc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_GPIO_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_GPIO_BASE),
+		.virtual	= IO_ADDRESS(INTEGRATOR_AP_GPIO_BASE),
+		.pfn		= __phys_to_pfn(INTEGRATOR_AP_GPIO_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 108bc48..333c297 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -42,9 +42,6 @@
 
 #include "common.h"
 
-#define INTCP_PA_MMC_BASE		0x1c000000
-#define INTCP_PA_AACI_BASE		0x1d000000
-
 #define INTCP_PA_FLASH_BASE		0x24000000
 #define INTCP_FLASH_SIZE		SZ_32M
 
@@ -52,12 +49,11 @@
 
 #define INTCP_VA_CIC_BASE		IO_ADDRESS(INTEGRATOR_HDR_BASE) + 0x40
 #define INTCP_VA_PIC_BASE		IO_ADDRESS(INTEGRATOR_IC_BASE)
-#define INTCP_VA_SIC_BASE		IO_ADDRESS(0xca000000)
+#define INTCP_VA_SIC_BASE		IO_ADDRESS(INTEGRATOR_CP_SIC_BASE)
 
-#define INTCP_PA_ETH_BASE		0xc8000000
 #define INTCP_ETH_SIZE			0x10
 
-#define INTCP_VA_CTRL_BASE		IO_ADDRESS(0xcb000000)
+#define INTCP_VA_CTRL_BASE		IO_ADDRESS(INTEGRATOR_CP_CTL_BASE)
 #define INTCP_FLASHPROG			0x04
 #define CINTEGRATOR_FLASHPROG_FLVPPEN	(1 << 0)
 #define CINTEGRATOR_FLASHPROG_FLWREN	(1 << 1)
@@ -72,7 +68,9 @@
  * f1600000	16000000	UART 0
  * f1700000	17000000	UART 1
  * f1a00000	1a000000	Debug LEDs
- * f1b00000	1b000000	GPIO
+ * fc900000	c9000000	GPIO
+ * fca00000	ca000000	SIC
+ * fcb00000	cb000000	CP system control
  */
 
 static struct map_desc intcp_io_desc[] __initdata = {
@@ -117,18 +115,18 @@ static struct map_desc intcp_io_desc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(INTEGRATOR_GPIO_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_GPIO_BASE),
+		.virtual	= IO_ADDRESS(INTEGRATOR_CP_GPIO_BASE),
+		.pfn		= __phys_to_pfn(INTEGRATOR_CP_GPIO_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(0xca000000),
-		.pfn		= __phys_to_pfn(0xca000000),
+		.virtual	= IO_ADDRESS(INTEGRATOR_CP_SIC_BASE),
+		.pfn		= __phys_to_pfn(INTEGRATOR_CP_SIC_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
-		.virtual	= IO_ADDRESS(0xcb000000),
-		.pfn		= __phys_to_pfn(0xcb000000),
+		.virtual	= IO_ADDRESS(INTEGRATOR_CP_CTL_BASE),
+		.pfn		= __phys_to_pfn(INTEGRATOR_CP_CTL_BASE),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}
@@ -364,8 +362,8 @@ static struct platform_device intcp_flash_device = {
 
 static struct resource smc91x_resources[] = {
 	[0] = {
-		.start	= INTCP_PA_ETH_BASE,
-		.end	= INTCP_PA_ETH_BASE + INTCP_ETH_SIZE - 1,
+		.start	= INTEGRATOR_CP_ETH_BASE,
+		.end	= INTEGRATOR_CP_ETH_BASE + INTCP_ETH_SIZE - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -396,7 +394,7 @@ static struct platform_device *intcp_devs[] __initdata = {
 static unsigned int mmc_status(struct device *dev)
 {
 	unsigned int status = readl(IO_ADDRESS(0xca000000) + 4);
-	writel(8, IO_ADDRESS(0xcb000000) + 8);
+	writel(8, IO_ADDRESS(INTEGRATOR_CP_CTL_BASE) + 8);
 
 	return status & 8;
 }
@@ -414,8 +412,8 @@ static struct amba_device mmc_device = {
 		.platform_data = &mmc_data,
 	},
 	.res		= {
-		.start	= INTCP_PA_MMC_BASE,
-		.end	= INTCP_PA_MMC_BASE + SZ_4K - 1,
+		.start	= INTEGRATOR_CP_MMC_BASE,
+		.end	= INTEGRATOR_CP_MMC_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	.irq		= { IRQ_CP_MMCIINT0, IRQ_CP_MMCIINT1 },
@@ -427,8 +425,8 @@ static struct amba_device aaci_device = {
 		.init_name = "mb:1d",
 	},
 	.res		= {
-		.start	= INTCP_PA_AACI_BASE,
-		.end	= INTCP_PA_AACI_BASE + SZ_4K - 1,
+		.start	= INTEGRATOR_CP_AACI_BASE,
+		.end	= INTEGRATOR_CP_AACI_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	.irq		= { IRQ_CP_AACIINT, NO_IRQ },
