From: clg@fr.ibm.com (Cedric Le Goater)
Date: Fri, 15 Nov 2013 17:16:55 +0100
Subject: [PATCH 16/51] DMA-API: ppc: vio.c: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <E1VMly8-0007gy-Ru@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMly8-0007gy-Ru@rmk-PC.arm.linux.org.uk>
Message-ID: <528648F7.20900@fr.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

On 09/19/2013 11:41 PM, Russell King wrote:
> Replace the following sequence:
> 
> 	dma_set_mask(dev, mask);
> 	dma_set_coherent_mask(dev, mask);
> 
> with a call to the new helper dma_set_mask_and_coherent().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/powerpc/kernel/vio.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 78a3506..96b6c97 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1413,8 +1413,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
> 
>  		/* needed to ensure proper operation of coherent allocations
>  		 * later, in case driver doesn't set it explicitly */
> -		dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
> -		dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
> +		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
>  	}
> 
>  	/* register with generic device framework */
> 

The new helper routine dma_set_mask_and_coherent() breaks the 
initialization of the pseries vio devices which do not have an 
initial dev->dma_mask. I think we need to use dma_coerce_mask_and_coherent()
instead.

Signed-off-by: C?dric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/kernel/vio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index e7d0c88f..76a6482 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1419,7 +1419,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 
 		/* needed to ensure proper operation of coherent allocations
 		 * later, in case driver doesn't set it explicitly */
-		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
+		dma_coerce_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
 	}
 
 	/* register with generic device framework */
-- 
1.7.10.4
