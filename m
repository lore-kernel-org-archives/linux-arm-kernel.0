From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 Jan 2017 15:14:14 +0000
Subject: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
In-Reply-To: <20170124132519.13271-1-djkurtz@chromium.org>
References: <20170124132519.13271-1-djkurtz@chromium.org>
Message-ID: <b1180920-8ead-40e8-6155-8510226e719b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On 24/01/17 13:25, Daniel Kurtz wrote:
> Back before commit 1dccb598df54 ("arm64: simplify dma_get_ops"), for arm64,
> devices that do not manually set a dma_ops are automatically configured to
> use swiotlb_dma_ops, since this was hard-coded as the global "dma_ops" in
> arm64_dma_init().
> 
> Now, the global "dma_ops" has been removed, and all devices much have
> their dma_ops explicitly set by a call to arch_setup_dma_ops().  If
> arch_setup_dma_ops() is not called, the device is assigned dummy_dma_ops,
> and thus calls to map_sg for such a device will fail (return 0).
> 
> Mediatek SPI uses DMA but does not use a dma channel.  Support for this
> was added by commit c37f45b5f1cd ("spi: support spi without dma channel to
> use can_dma()"), which uses the master_spi dev to DMA map buffers.
> 
> The master_spi device is not a platform, rather it is created
> in spi_alloc_device(), and its dma_ops are never set.

Ugh, this isn't dwc3-usb all over again, is it?

> Therefore, when the mediatek SPI driver when it does DMA (for large SPI
> transactions > 32 bytes), SPI will use spi_map_buf()->dma_map_sg() to map
> the buffer for use in DMA.  But dma_map_sg()->dma_map_sg_attrs() returns 0,
> because ops->map_sg is dummy_dma_ops->__dummy_map_sg, and hence
> spi_map_buf() returns -ENOMEM (-12).
> 
> The solution in this patch is a bit of a hack.  To install dma_ops for
> its spi_master, we call of_dma_configure() during probe and pass in the
> of_node of the spi-mt65xx platform device.
> 
> However, by default, of_dma_configure() will set the coherent_dma_mask
> to 0xffffffff.  In fact, using a non-zero dma_mask doesn't actually work
> and causes frequent SPI transaction errors.  To work around this, we
> also explicitly set coherent_dma_mask to 0.

That sound like it could do with more investigation before piling hacks
on top of hacks. In theory, that would force dma_alloc_*() to always
fail, whilst allowing dma_map_*() to still work - I imagine the actual
SPI block is just a plain AXI master, meaning there oughtn't to be any
fundamental difference between coherent and streaming DMA, but there can
be differences in whatever functionality those API uses represent in the
driver/SPI code (e.g. data buffers vs. control descriptors).

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> 
> I don't know the right place to configure the dma_ops for spi_master.
> It feels like this should actually be done in the spi core, as this might be
> needed by other drivers.
> 
> Alternatively, perhaps we should be using master->dev.parent to dma map bufs
> in the "no dma channel case".

AFAICS from a quick scan of the driver, that would be the correct thing
to do - in general for a platform device, the guy described in the DT
should be the guy being passed to DMA API calls.

> And I really don't know why we needed to set the coherent_dma_mask to 0 to
> avoid SPI transaction errors.

Following what I mentioned above, "git grep dma_alloc drivers/spi" makes
it seem like coherent DMA isn't used anywhere relevant, which is rather
puzzling. Unless of course somewhere along the line somebody's done the
dev->dma_mask = &dev->dma_coherent_mask hack, with the result that
writing one mask hits both, making *all* DMA fail and big transfers fall
back to PIO.

And as a backup review comment in case any of the above musings go
nowhere; at the very least please use dma_set_coherent_mask() rather
than open-coding it ;)

Robin.

> Any advice is welcome.
> 
>  drivers/spi/spi-mt65xx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 8763eff13d3d..e768835bb67f 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -20,6 +20,7 @@
>  #include <linux/ioport.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/spi-mt65xx.h>
> @@ -575,6 +576,10 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  		goto err_put_master;
>  	}
>  
> +	/* Call of_dma_configure to set up spi_master's dma_ops */
> +	of_dma_configure(&master->dev, master->dev.of_node);
> +	/* But explicitly set the coherent_dma_mask to 0 */
> +	master->dev.coherent_dma_mask = 0;
>  	if (!pdev->dev.dma_mask)
>  		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>  
> 
