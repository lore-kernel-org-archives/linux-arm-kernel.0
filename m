From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 6 Nov 2016 14:37:11 +0100
Subject: [PATCH v2 1/1] ARM: dmaengine: sun6i: share the dma driver with
 sun50i
In-Reply-To: <20161105080548.GA32546@arx12>
References: <20161105080548.GA32546@arx12>
Message-ID: <20161106133711.np2hm77myfd75sn2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 05, 2016 at 04:05:48PM +0800, Hao Zhang wrote:
> Add soc a64 dma support.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 8346199..00fcfc7 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -1028,11 +1028,23 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>  	.nr_max_vchans   = 34,
>  };
>  
> +/*
> + * The A64 has 8 physical channels, a maximum DRQ port id of 27,
> + * and a total of 38 usable source and destination endpoints.
> + */
> +
> +static struct sun6i_dma_config sun50i_a64_dma_cfg = {
> +	.nr_max_channels = 8,
> +	.nr_max_requests = 27,
> +	.nr_max_vchans   = 38,
> +};
> +
>  static const struct of_device_id sun6i_dma_match[] = {
>  	{ .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
>  	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
>  	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
>  	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
> +	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },

You need to add that compatible to the DT binding documentation.

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
> @@ -1110,6 +1122,13 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>  	sdc->slave.dst_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "allwinner,sun50i-a64-dma")) {
> +		sdc->slave.src_addr_widths	|= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +		sdc->slave.dst_addr_widths	|= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +	}
> +

You'll also need to change convert_buswidth, it will reject any width
higher than 4 bytes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161106/61c65236/attachment.sig>
