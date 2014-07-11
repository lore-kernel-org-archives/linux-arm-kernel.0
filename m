From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 11 Jul 2014 13:00:36 +0200
Subject: [PATCH v4 1/4] ARM: pxa: Don't hardcode addresses and size in
 map_desc tables
In-Reply-To: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1405076439-22038-2-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The virtual address, physical address and size of all regions for which
we create static mappings are defined in PXA headers. Replaced the
hardcoded values with macros.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-pxa/generic.c               | 10 +++++-----
 arch/arm/mach-pxa/include/mach/hardware.h |  2 +-
 arch/arm/mach-pxa/pxa25x.c                |  2 +-
 arch/arm/mach-pxa/pxa27x.c                |  8 ++++----
 arch/arm/mach-pxa/pxa3xx.c                |  2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 4225417..4bc0a2c 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -79,14 +79,14 @@ EXPORT_SYMBOL(get_clk_frequency_khz);
  */
 static struct map_desc common_io_desc[] __initdata = {
   	{	/* Devs */
-		.virtual	=  0xf2000000,
-		.pfn		= __phys_to_pfn(0x40000000),
-		.length		= 0x02000000,
+		.virtual	= (unsigned long)PERIPH_VIRT,
+		.pfn		= __phys_to_pfn(PERIPH_PHYS),
+		.length		= PERIPH_SIZE,
 		.type		= MT_DEVICE
 	}, {	/* UNCACHED_PHYS_0 */
-		.virtual	= 0xff000000,
+		.virtual	= UNCACHED_PHYS_0,
 		.pfn		= __phys_to_pfn(0x00000000),
-		.length		= 0x00100000,
+		.length		= UNCACHED_PHYS_0_SIZE,
 		.type		= MT_DEVICE
 	}
 };
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index ccb06e4..efb3965 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -20,7 +20,7 @@
  * The mapping is set in mach-pxa/generic.c.
  */
 #define UNCACHED_PHYS_0		0xff000000
-#define UNCACHED_ADDR		UNCACHED_PHYS_0
+#define UNCACHED_PHYS_0_SIZE	0x00100000
 
 /*
  * Intel PXA2xx internal register mapping:
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index f2c2897..926c506 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -331,7 +331,7 @@ static struct map_desc pxa25x_io_desc[] __initdata = {
 	{	/* Mem Ctl */
 		.virtual	= (unsigned long)SMEMC_VIRT,
 		.pfn		= __phys_to_pfn(PXA2XX_SMEMC_BASE),
-		.length		= 0x00200000,
+		.length		= SMEMC_SIZE,
 		.type		= MT_DEVICE
 	},
 };
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 301471a..4405644 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -402,12 +402,12 @@ static struct map_desc pxa27x_io_desc[] __initdata = {
 	{	/* Mem Ctl */
 		.virtual	= (unsigned long)SMEMC_VIRT,
 		.pfn		= __phys_to_pfn(PXA2XX_SMEMC_BASE),
-		.length		= 0x00200000,
+		.length		= SMEMC_SIZE,
 		.type		= MT_DEVICE
 	}, {	/* IMem ctl */
-		.virtual	=  0xfe000000,
-		.pfn		= __phys_to_pfn(0x58000000),
-		.length		= 0x00100000,
+		.virtual	= (unsigned long)IMEMC_VIRT,
+		.pfn		= __phys_to_pfn(IMEMC_PHYS),
+		.length		= IMEMC_SIZE,
 		.type		= MT_DEVICE
 	},
 };
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 87011f3..593ccd35 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -416,7 +416,7 @@ static struct map_desc pxa3xx_io_desc[] __initdata = {
 	{	/* Mem Ctl */
 		.virtual	= (unsigned long)SMEMC_VIRT,
 		.pfn		= __phys_to_pfn(PXA3XX_SMEMC_BASE),
-		.length		= 0x00200000,
+		.length		= SMEMC_SIZE,
 		.type		= MT_DEVICE
 	}
 };
-- 
1.8.5.5
