From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 31 May 2011 17:46:42 -0400
Subject: [PATCH 2/3] [v2] davinci: da850-dm646x: remove the SRAM_VIRT iotable
	entry
In-Reply-To: <cover.1306877621.git.bengardiner@nanometrics.ca>
References: <cover.1306877621.git.bengardiner@nanometrics.ca>
Message-ID: <aaf99394137a8059b7993a72aa8308dff62b43d7.1306877621.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sram regions defined for da850-dm646x in their iotable entries are also
defined in their davinci_soc_info's.

Remove this duplicate information which is now uneccessary since sram
init will ioremap the regions defined by their davinci_soc_info's.

Since this removal completely removes all uses of SRAM_VIRT, also remove
the SRAM_VIRT definition.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: Sergei Shtylyov <sshtylyov@mvista.com>

---
Changes since v1:
 * squashed patches 3-8 in v1 series into this patch (Sergei Shtylyov)

---
 arch/arm/mach-davinci/da850.c               |    6 ------
 arch/arm/mach-davinci/dm355.c               |    6 ------
 arch/arm/mach-davinci/dm365.c               |    6 ------
 arch/arm/mach-davinci/dm644x.c              |    6 ------
 arch/arm/mach-davinci/dm646x.c              |    6 ------
 arch/arm/mach-davinci/include/mach/common.h |    2 --
 6 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 5c2bf3b..904ede9 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -725,12 +725,6 @@ static struct map_desc da850_io_desc[] = {
 		.length		= DA8XX_CP_INTC_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(DA8XX_ARM_RAM_BASE),
-		.length		= SZ_8K,
-		.type		= MT_DEVICE
-	},
 };
 
 static u32 da850_psc_bases[] = { DA8XX_PSC0_BASE, DA8XX_PSC1_BASE };
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9bda687..94f44d3 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -757,12 +757,6 @@ static struct map_desc dm355_io_desc[] = {
 		.length		= IO_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(0x00010000),
-		.length		= SZ_32K,
-		.type		= MT_MEMORY_NONCACHED,
-	},
 };
 
 /* Contents of JTAG ID register used to identify exact cpu type */
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index d306034..58f5b0a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -970,12 +970,6 @@ static struct map_desc dm365_io_desc[] = {
 		.length		= IO_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(0x00010000),
-		.length		= SZ_32K,
-		.type		= MT_MEMORY_NONCACHED,
-	},
 };
 
 static struct resource dm365_ks_resources[] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 3949ed7..11e6481 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -663,12 +663,6 @@ static struct map_desc dm644x_io_desc[] = {
 		.length		= IO_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(0x00008000),
-		.length		= SZ_16K,
-		.type		= MT_MEMORY_NONCACHED,
-	},
 };
 
 /* Contents of JTAG ID register used to identify exact cpu type */
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a4365f7..57d697e 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -747,12 +747,6 @@ static struct map_desc dm646x_io_desc[] = {
 		.length		= IO_SIZE,
 		.type		= MT_DEVICE
 	},
-	{
-		.virtual	= SRAM_VIRT,
-		.pfn		= __phys_to_pfn(0x00010000),
-		.length		= SZ_32K,
-		.type		= MT_MEMORY_NONCACHED,
-	},
 };
 
 /* Contents of JTAG ID register used to identify exact cpu type */
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 665d049..16b5ec5 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -86,8 +86,6 @@ extern struct davinci_soc_info davinci_soc_info;
 extern void davinci_common_init(struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
 
-/* standard place to map on-chip SRAMs; they *may* support DMA */
-#define SRAM_VIRT	0xfffe0000
 #define SRAM_SIZE	SZ_128K
 
 #endif /* __ARCH_ARM_MACH_DAVINCI_COMMON_H */
-- 
1.7.4.1
