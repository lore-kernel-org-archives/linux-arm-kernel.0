From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 7 Sep 2012 22:31:49 +0530
Subject: [PATCH v2 1/2] ARM: da850/omap-l138: Add SoC related definitions
 for VPIF
In-Reply-To: <1345471731-31678-2-git-send-email-prabhakar.lad@ti.com>
References: <1345471731-31678-1-git-send-email-prabhakar.lad@ti.com>
 <1345471731-31678-2-git-send-email-prabhakar.lad@ti.com>
Message-ID: <504A287D.20408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar,

On 8/20/2012 7:38 PM, Prabhakar Lad wrote:
> From: Manjunath Hadli <manjunath.hadli@ti.com>
> 
> Add clock, pin mux definitions and registration function for
> VPIF capture and display driver on DA850/OMAP-L138 SoC.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> ---

> +/* VPIF resource, platform data */
> +static u64 da850_vpif_dma_mask = DMA_BIT_MASK(32);
> +
> +static struct resource da850_vpif_resource[] = {
> +	{
> +		.start = DA8XX_VPIF_BASE,
> +		.end   = DA8XX_VPIF_BASE + 0xfff,
> +		.flags = IORESOURCE_MEM,
> +	}
> +};
> +
> +static struct platform_device da850_vpif_dev = {
> +	.name		= "vpif",
> +	.id		= -1,
> +	.dev		= {
> +		.dma_mask		= &da850_vpif_dma_mask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +	},
> +	.resource	= da850_vpif_resource,
> +	.num_resources	= ARRAY_SIZE(da850_vpif_resource),
> +};
> +
> +static struct platform_device da850_vpif_display_dev = {
> +	.name		= "vpif_display",
> +	.id		= -1,
> +	.dev		= {
> +		.dma_mask		= &da850_vpif_dma_mask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +	},
> +};
> +
> +static struct platform_device da850_vpif_capture_dev = {
> +	.name		= "vpif_capture",
> +	.id		= -1,
> +	.dev		= {
> +		.dma_mask		= &da850_vpif_dma_mask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +	},
> +};
> +
> +int __init da850_register_vpif(void)
> +{
> +	return platform_device_register(&da850_vpif_dev);
> +}
> +
> +int __init da850_register_vpif_display(struct vpif_display_config
> +						*display_config)
> +{
> +	struct resource da850_vpif_display_resource[] = {
> +		{
> +			.start = IRQ_DA850_VPIFINT,
> +			.end   = IRQ_DA850_VPIFINT,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	};
> +	int ret;
> +
> +	ret = platform_device_add_resources(&da850_vpif_display_dev,
> +				da850_vpif_display_resource,
> +				ARRAY_SIZE(da850_vpif_display_resource));

Its not obvious to me why you need to add the resources here instead of
just statically defining them as is usually done.

Thanks,
Sekhar
