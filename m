From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 04 Aug 2016 11:56:12 +0200
Subject: [PATCH] ARM: S3C24XX: Add dma_mask assignments for DMA devices
Message-ID: <1470304572-14937-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_mask assignments seem to be missed during refactoring
of arch/arm/mach-s3c24xx. Add them to avoid DMA allocation
failures. Without this patch sound is broken on s3c24xx
with errors reported like:

s3c24xx-dma s3c2410-dma.0: coherent DMA mask is unset
ALSA pcmC0D0p,0:: cannot preallocate for size 524288
s3c24xx-iis s3c24xx-iis: Failed to get DMA channel capabilities,
falling back to period counting: -6
s3c24xx-dma s3c2410-dma.0: coherent DMA mask is unset
...
ALSA pcmC0D0c,0:: cannot preallocate for size 524288
s3c24xx-iis s3c24xx-iis: Failed to get DMA channel capabilities,
falling back to period counting: -6

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s3c24xx/common.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index bf50328..fe7485d 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -21,7 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 
-
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -304,6 +304,8 @@ struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
 	},
 };
 
+#define s3c24xx_device_dma_mask (*((u64[]) { DMA_BIT_MASK(32) }))
+
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
 	defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
 static struct resource s3c2410_dma_resource[] = {
@@ -354,7 +356,9 @@ struct platform_device s3c2410_device_dma = {
 	.num_resources	= ARRAY_SIZE(s3c2410_dma_resource),
 	.resource	= s3c2410_dma_resource,
 	.dev	= {
-		.platform_data	= &s3c2410_dma_platdata,
+		.dma_mask = &s3c24xx_device_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s3c2410_dma_platdata,
 	},
 };
 #endif
@@ -395,7 +399,9 @@ struct platform_device s3c2412_device_dma = {
 	.num_resources	= ARRAY_SIZE(s3c2410_dma_resource),
 	.resource	= s3c2410_dma_resource,
 	.dev	= {
-		.platform_data	= &s3c2412_dma_platdata,
+		.dma_mask = &s3c24xx_device_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s3c2412_dma_platdata,
 	},
 };
 #endif
@@ -451,7 +457,9 @@ struct platform_device s3c2440_device_dma = {
 	.num_resources	= ARRAY_SIZE(s3c2410_dma_resource),
 	.resource	= s3c2410_dma_resource,
 	.dev	= {
-		.platform_data	= &s3c2440_dma_platdata,
+		.dma_mask = &s3c24xx_device_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s3c2440_dma_platdata,
 	},
 };
 #endif
@@ -503,7 +511,9 @@ struct platform_device s3c2443_device_dma = {
 	.num_resources	= ARRAY_SIZE(s3c2443_dma_resource),
 	.resource	= s3c2443_dma_resource,
 	.dev	= {
-		.platform_data	= &s3c2443_dma_platdata,
+		.dma_mask = &s3c24xx_device_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data = &s3c2443_dma_platdata,
 	},
 };
 #endif
-- 
1.9.1
