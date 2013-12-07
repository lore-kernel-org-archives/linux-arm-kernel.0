From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Dec 2013 23:19:58 +0000
Subject: [REGRESSION,BISECTED] DMA mask issue on ReadyNAS 102 w/ 3.13.0-rc3
In-Reply-To: <87haakfene.fsf@natisbad.org>
References: <87haakfene.fsf@natisbad.org>
Message-ID: <20131207231958.GS4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 08, 2013 at 12:02:45AM +0100, Arnaud Ebalard wrote:
> 3.13.0-rc2 worked just fine so I decided to git-bisect the issue and
> ended up on 11a5aa32562e (ARM: dma-mapping: check DMA mask against
> available memory).
> 
> If it has already been reported and fixed, sorry for the noise.

Please try this patch, thanks:

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f6b6bfa88ecf..c143a7bb681b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -185,7 +185,7 @@ static u64 get_coherent_dma_mask(struct device *dev)
 		 */
 		if (sizeof(mask) != sizeof(dma_addr_t) &&
 		    mask > (dma_addr_t)~0 &&
-		    dma_to_pfn(dev, ~0) > max_dma_pfn) {
+		    dma_to_pfn(dev, ~0) < max_dma_pfn) {
 			dev_warn(dev, "Coherent DMA mask %#llx is larger than dma_addr_t allows\n",
 				 mask);
 			dev_warn(dev, "Driver did not use or check the return value from dma_set_coherent_mask()?\n");
@@ -1041,7 +1041,7 @@ int dma_supported(struct device *dev, u64 mask)
 	 */
 	if (sizeof(mask) != sizeof(dma_addr_t) &&
 	    mask > (dma_addr_t)~0 &&
-	    dma_to_pfn(dev, ~0) > arm_dma_pfn_limit)
+	    dma_to_pfn(dev, ~0) < min(max_pfn, arm_dma_pfn_limit))
 		return 0;
 
 	/*
