From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 11 Jan 2017 10:31:52 +0000
Subject: [PATCH v2 1/2] virtio_mmio: Set DMA masks appropriately
In-Reply-To: <85015f1653eb7e36f992708362b75d1f4391b783.1484070340.git.robin.murphy@arm.com>
References: <85015f1653eb7e36f992708362b75d1f4391b783.1484070340.git.robin.murphy@arm.com>
Message-ID: <013a1641-0804-fcfc-923b-a893e461b827@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/17 17:51, Robin Murphy wrote:
> Once DMA API usage is enabled, it becomes apparent that virtio-mmio is
> inadvertently relying on the default 32-bit DMA mask, which leads to
> problems like rapidly exhausting SWIOTLB bounce buffers.
> 
> Ensure that we set the appropriate 64-bit DMA mask whenever possible,
> with the coherent mask suitably limited for the legacy vring as per
> a0be1db4304f ("virtio_pci: Limit DMA mask to 44 bits for legacy virtio
> devices").

Thanks, and for what it's worth:

Tested-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Fixes: b42111382f0e ("virtio_mmio: Use the DMA API if enabled")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/virtio/virtio_mmio.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index d47a2fcef818..c71fde5fe835 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -59,6 +59,7 @@
>  #define pr_fmt(fmt) "virtio-mmio: " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -498,6 +499,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	struct virtio_mmio_device *vm_dev;
>  	struct resource *mem;
>  	unsigned long magic;
> +	int rc;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!mem)
> @@ -547,9 +549,25 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	}
>  	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
>  
> -	if (vm_dev->version == 1)
> +	if (vm_dev->version == 1) {
>  		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>  
> +		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +		/*
> +		 * In the legacy case, ensure our coherently-allocated virtio
> +		 * ring will be at an address expressable as a 32-bit PFN.
> +		 */
> +		if (!rc)
> +			dma_set_coherent_mask(&pdev->dev,
> +					      DMA_BIT_MASK(32 + PAGE_SHIFT));
> +	} else {
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	}
> +	if (rc)
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (rc)
> +		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +
>  	platform_set_drvdata(pdev, vm_dev);
>  
>  	return register_virtio_device(&vm_dev->vdev);
> 
