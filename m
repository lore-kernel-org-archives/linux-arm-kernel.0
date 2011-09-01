From: robherring2@gmail.com (Rob Herring)
Date: Thu, 01 Sep 2011 07:14:27 -0500
Subject: [PATCH v2 4/6] DMA: PL330: Add device tree support
In-Reply-To: <1314867882-11755-5-git-send-email-thomas.abraham@linaro.org>
References: <1314867882-11755-1-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-2-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-3-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-4-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4E5F7723.8090909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2011 04:04 AM, Thomas Abraham wrote:
> For PL330 dma controllers instantiated from device tree, the channel
> lookup is based on phandle of the dma controller and dma request id
> specified by the client node. During probe, the private data of each
> channel of the controller is set to point to the device node of the
> dma controller. The 'chan_id' of the each channel is used as the
> dma request id.
> 
> Client driver requesting dma channels specify the phandle of the
> dma controller and the request id. The pl330 filter function
> converts the phandle to the device node pointer and matches that
> with channel's private data. If a match is found, the request id
> from the client node and the 'chan_id' of the channel is matched.
> A channel is found if both the values match.
> 
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Looks good.

Reviewed-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  .../devicetree/bindings/dma/arm-pl330.txt          |   29 ++++++++++++++++
>  drivers/dma/pl330.c                                |   35 +++++++++++++++++---
>  2 files changed, 59 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> new file mode 100644
> index 0000000..69e6c02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> @@ -0,0 +1,29 @@
> +* ARM PrimeCell PL330 DMA Controller
> +
> +The ARM PrimeCell PL330 DMA controller can move blocks of memory contents
> +between memory and peripherals or memory to memory.
> +
> +Required properties:
> +  - compatible: should include both "arm,pl330" and "arm,primecell".
> +  - reg: physical base address of the controller and length of memory mapped
> +    region.
> +  - interrupts: interrupt number to the cpu.
> +
> +Example: (from Samsung's Exynos4 processor dtsi file)
> +
> +	pdma0: pdma at 12680000 {
> +		compatible = "arm,pl330", "arm,primecell";
> +		reg = <0x12680000 0x1000>;
> +		interrupts = <99>;
> +	};
> +
> +Client drivers (device nodes requiring dma transfers from dev-to-mem or
> +mem-to-dev) should specify the DMA channel numbers using a two-value pair
> +as shown below.
> +
> +  [property name]  = <[phandle of the dma controller] [dma request id]>;
> +
> +      where 'dma request id' is the dma request number which is connected
> +      to the client controller.
> +
> +  Example:  tx-dma-channel = <&pdma0 12>;
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 9732995..0c55de4 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -19,6 +19,7 @@
>  #include <linux/amba/pl330.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
> +#include <linux/of.h>
>  
>  #define NR_DEFAULT_DESC	16
>  
> @@ -277,6 +278,20 @@ bool pl330_filter(struct dma_chan *chan, void *param)
>  	if (chan->device->dev->driver != &pl330_driver.drv)
>  		return false;
>  
> +#ifdef CONFIG_OF
> +	if (chan->device->dev->of_node) {
> +		const __be32 *prop_value;
> +		phandle phandle;
> +		struct device_node *node;
> +
> +		prop_value = ((struct property *)param)->value;
> +		phandle = be32_to_cpup(prop_value++);
> +		node = of_find_node_by_phandle(phandle);
> +		return ((chan->private == node) &&
> +				(chan->chan_id == be32_to_cpup(prop_value)));
> +	}
> +#endif
> +
>  	peri_id = chan->private;
>  	return *peri_id == (unsigned)param;
>  }
> @@ -857,12 +872,17 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  	INIT_LIST_HEAD(&pd->channels);
>  
>  	/* Initialize channel parameters */
> -	num_chan = max(pdat ? pdat->nr_valid_peri : 0, (u8)pi->pcfg.num_chan);
> +	num_chan = max(pdat ? pdat->nr_valid_peri : (u8)pi->pcfg.num_peri,
> +			(u8)pi->pcfg.num_chan);
>  	pdmac->peripherals = kzalloc(num_chan * sizeof(*pch), GFP_KERNEL);
>  
>  	for (i = 0; i < num_chan; i++) {
>  		pch = &pdmac->peripherals[i];
> -		pch->chan.private = pdat ? &pdat->peri_id[i] : NULL;
> +		if (!adev->dev.of_node)
> +			pch->chan.private = pdat ? &pdat->peri_id[i] : NULL;
> +		else
> +			pch->chan.private = adev->dev.of_node;
> +
>  		INIT_LIST_HEAD(&pch->work_list);
>  		spin_lock_init(&pch->lock);
>  		pch->pl330_chid = NULL;
> @@ -876,11 +896,16 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	pd->dev = &adev->dev;
> -	if (pdat)
> +	if (pdat) {
>  		pd->cap_mask = pdat->cap_mask;
> -	else
> +	} else {
>  		dma_cap_set(DMA_MEMCPY, pd->cap_mask);
> -
> +		if (pi->pcfg.num_peri) {
> +			dma_cap_set(DMA_SLAVE, pd->cap_mask);
> +			dma_cap_set(DMA_CYCLIC, pd->cap_mask);
> +		}
> +	}
> +
>  	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
>  	pd->device_free_chan_resources = pl330_free_chan_resources;
>  	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
