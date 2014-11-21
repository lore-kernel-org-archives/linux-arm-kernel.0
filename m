From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Fri, 21 Nov 2014 10:23:42 -0700
Subject: [PATCH] arm: ep93xx: add dma_masks for the M2P and M2M DMA controllers
Message-ID: <1416590622-7765-1-git-send-email-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_mask and coherent_dma_mask need to be set or DMA memory allocations
will fail with error messages like this:

  ep93xx-dma ep93xx-dma-m2p: coherent DMA mask is unset

  ep93xx-dma ep93xx-dma-m2m: coherent DMA mask is unset

Add the missing information to the ep93xx-dma-m2p and ep93xx-dma-m2m
devices.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Reported-by: Jeremy Moles <cubicool@gmail.com>
Tested-by: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Ryan Mallon <rmallon@gmail.com>
---
This fixes a problem with the sound/soc/cirrus/edb93xx.c driver not loading
and fixes the sound on these tested boards:

  EDB9315A (like)  - tested by Jeremy Moles
  EDB9302 (like)   - tested by Alexander Sverdlin
  EDB9307A (stock) - tested by H Hartley Sweeten

 arch/arm/mach-ep93xx/dma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/dma.c b/arch/arm/mach-ep93xx/dma.c
index d8bfd02..88a4c9b 100644
--- a/arch/arm/mach-ep93xx/dma.c
+++ b/arch/arm/mach-ep93xx/dma.c
@@ -66,11 +66,15 @@ static struct ep93xx_dma_platform_data ep93xx_dma_m2p_data = {
 	.num_channels		= ARRAY_SIZE(ep93xx_dma_m2p_channels),
 };
 
+static u64 ep93xx_dma_m2p_mask = DMA_BIT_MASK(32);
+
 static struct platform_device ep93xx_dma_m2p_device = {
 	.name			= "ep93xx-dma-m2p",
 	.id			= -1,
 	.dev			= {
-		.platform_data	= &ep93xx_dma_m2p_data,
+		.platform_data		= &ep93xx_dma_m2p_data,
+		.dma_mask		= &ep93xx_dma_m2p_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
 
@@ -93,11 +97,15 @@ static struct ep93xx_dma_platform_data ep93xx_dma_m2m_data = {
 	.num_channels		= ARRAY_SIZE(ep93xx_dma_m2m_channels),
 };
 
+static u64 ep93xx_dma_m2m_mask = DMA_BIT_MASK(32);
+
 static struct platform_device ep93xx_dma_m2m_device = {
 	.name			= "ep93xx-dma-m2m",
 	.id			= -1,
 	.dev			= {
-		.platform_data	= &ep93xx_dma_m2m_data,
+		.platform_data		= &ep93xx_dma_m2m_data,
+		.dma_mask		= &ep93xx_dma_m2m_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
 
-- 
2.0.3
