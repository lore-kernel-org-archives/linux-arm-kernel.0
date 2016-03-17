From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 17 Mar 2016 09:19:05 +0200
Subject: [PATCH 2/7] dmaengine: xilinx_vdma: Add quirks support to
 differentiate differnet IP cores
In-Reply-To: <1458062592-27981-3-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <1458062592-27981-3-git-send-email-appanad@xilinx.com>
Message-ID: <1640685.GKdbz0bkAP@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday 15 March 2016 22:53:07 Kedareswara rao Appana wrote:
> This patch adds quirks support in the driver to differentiate differnet IP

s/differnet/different/

(and in the subject line too)

With this series applied the driver will not be vdma-specific anymore. The 
xilinx_vdma_ prefix will thus be confusing. I'd bite the bullet and apply a 
global rename to functions that are not shared between the three DMA IP core 
types before patch 2/7.

> cores.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_vdma.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_vdma.c
> b/drivers/dma/xilinx/xilinx_vdma.c index 7ab6793..f682bef 100644
> --- a/drivers/dma/xilinx/xilinx_vdma.c
> +++ b/drivers/dma/xilinx/xilinx_vdma.c
> @@ -139,6 +139,8 @@
>  /* Delay loop counter to prevent hardware failure */
>  #define XILINX_VDMA_LOOP_COUNT		1000000
> 
> +#define AXIVDMA_SUPPORT		BIT(0)
> +
>  /**
>   * struct xilinx_vdma_desc_hw - Hardware Descriptor
>   * @next_desc: Next Descriptor Pointer @0x00
> @@ -240,6 +242,7 @@ struct xilinx_vdma_chan {
>   * @chan: Driver specific VDMA channel
>   * @has_sg: Specifies whether Scatter-Gather is present or not
>   * @flush_on_fsync: Flush on frame sync
> + * @quirks: Needed for different IP cores
>   */
>  struct xilinx_vdma_device {
>  	void __iomem *regs;
> @@ -248,6 +251,15 @@ struct xilinx_vdma_device {
>  	struct xilinx_vdma_chan *chan[XILINX_VDMA_MAX_CHANS_PER_DEVICE];
>  	bool has_sg;
>  	u32 flush_on_fsync;
> +	u32 quirks;
> +};
> +
> +/**
> + * struct xdma_platform_data - DMA platform structure
> + * @quirks: quirks for platform specific data.
> + */
> +struct xdma_platform_data {

This isn't platform data but device information, I'd rename the structure to 
xdma_device_info (and update the description accordingly).

> +	u32 quirks;

I don't think you should call this field quirks as it stores the IP core type. 
Quirks usually refer to non-standard behaviour that requires specific handling 
in the driver, possibly in the form of work-arounds. I would thus call the 
field type and document it as "DMA IP core type". Similarly I'd rename 
AXIVDMA_SUPPORT to XDMA_TYPE_VDMA.

>  };
> 
>  /* Macros */
> @@ -1239,6 +1251,16 @@ static struct dma_chan *of_dma_xilinx_xlate(struct
> of_phandle_args *dma_spec, return
> dma_get_slave_channel(&xdev->chan[chan_id]->common);
>  }
> 
> +static const struct xdma_platform_data xvdma_def = {
> +	.quirks = AXIVDMA_SUPPORT,
> +};
> +
> +static const struct of_device_id xilinx_vdma_of_ids[] = {
> +	{ .compatible = "xlnx,axi-vdma-1.00.a", .data = &xvdma_def},

Missing space before }, did you run checkpatch ?

As the xdma_platform_data structure contains a single integer, you could store 
it in the .data field directly.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_vdma_of_ids);
> +
>  /**
>   * xilinx_vdma_probe - Driver probe function
>   * @pdev: Pointer to the platform_device structure
> @@ -1251,6 +1273,7 @@ static int xilinx_vdma_probe(struct platform_device
> *pdev) struct xilinx_vdma_device *xdev;
>  	struct device_node *child;
>  	struct resource *io;
> +	const struct of_device_id *match;
>  	u32 num_frames;
>  	int i, err;
> 
> @@ -1259,6 +1282,13 @@ static int xilinx_vdma_probe(struct platform_device
> *pdev) if (!xdev)
>  		return -ENOMEM;
> 
> +	match = of_match_node(xilinx_vdma_of_ids, pdev->dev.of_node);

You can use of_device_get_match_data() to get the data directly.

> +	if (match && match->data) {

I don't think this condition can ever be false.

> +		const struct xdma_platform_data *data = match->data;
> +
> +		xdev->quirks = data->quirks;
> +	}
> +
>  	xdev->dev = &pdev->dev;
> 
>  	/* Request and map I/O memory */
> @@ -1356,12 +1386,6 @@ static int xilinx_vdma_remove(struct platform_device
> *pdev) return 0;
>  }
> 
> -static const struct of_device_id xilinx_vdma_of_ids[] = {
> -	{ .compatible = "xlnx,axi-vdma-1.00.a",},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, xilinx_vdma_of_ids);
> -
>  static struct platform_driver xilinx_vdma_driver = {
>  	.driver = {
>  		.name = "xilinx-vdma",

-- 
Regards,

Laurent Pinchart
