From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 01 Feb 2011 14:44:03 +0300
Subject: [PATCH 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <1296518716-5004-2-git-send-email-michael.williamson@criticallink.com>
References: <1296518716-5004-1-git-send-email-michael.williamson@criticallink.com>
	<1296518716-5004-2-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4D47F203.5090502@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2011 3:05, Michael Williamson wrote:

> Add SPI registration routines, clocks, and driver resources for
> DA850/OMAP-L138/AM18x and DA830/OMAP-L137/AM17x platforms.

> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
[...]

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index beda8a4..5f8ff96 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -725,3 +725,91 @@ int __init da8xx_register_cpuidle(void)
>
>   	return platform_device_register(&da8xx_cpuidle_device);
>   }
> +
> +static struct resource da8xx_spi0_resources[] = {
> +	[0] = {
> +		.start = 0x01c41000,
> +		.end   = 0x01c41fff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_DA8XX_SPINT0,
> +		.start = IRQ_DA8XX_SPINT0,

    You mean '.end'?

> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[2] = {
> +		.start = EDMA_CTLR_CHAN(0, 14),
> +		.end = EDMA_CTLR_CHAN(0, 14),

    Could you align = uniformly with resource 0 -- preferably with a tab?

> +		.flags = IORESOURCE_DMA,
> +	},
> +	[3] = {
> +		.start = EDMA_CTLR_CHAN(0, 15),
> +		.end = EDMA_CTLR_CHAN(0, 15),

    Same here.

> +		.flags = IORESOURCE_DMA,
> +	},
> +	[4] = {
> +		.start = 0,
> +		.end = 0,

    There's no need to init to 0.

> +		.flags = IORESOURCE_DMA,
> +	},
> +};
> +
> +static struct resource da8xx_spi1_resources[] = {
> +	[0] = {
> +		.start = 0x01f0e000,
> +		.end   = 0x01f0efff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_DA8XX_SPINT1,
> +		.start = IRQ_DA8XX_SPINT1,

    You meand '.end'?

> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[2] = {
> +		.start = EDMA_CTLR_CHAN(0, 18),
> +		.end = EDMA_CTLR_CHAN(0, 18),

    Could you align = uniformly with resource 0 -- preferably with a tab?

> +		.flags = IORESOURCE_DMA,
> +	},
> +	[3] = {
> +		.start = EDMA_CTLR_CHAN(0, 19),
> +		.end = EDMA_CTLR_CHAN(0, 19),

    Same here.

> +		.flags = IORESOURCE_DMA,
> +	},
> +	[4] = {
> +		.start = 0,
> +		.end = 0,

    There's no need to init to 0.

> +		.flags = IORESOURCE_DMA,
> +	},
> +};
> +
> +static struct platform_device da8xx_spi_device[] = {
> +	[0] = {
> +		.name = "spi_davinci",
> +		.id = 0,
> +		.num_resources = ARRAY_SIZE(da8xx_spi0_resources),
> +		.resource = da8xx_spi0_resources,
> +	},
> +	[1] = {
> +		.name = "spi_davinci",
> +		.id = 1,
> +		.num_resources = ARRAY_SIZE(da8xx_spi1_resources),
> +		.resource = da8xx_spi1_resources,
> +	},
> +};
> +
> +int __init da8xx_register_spi(int instance,
> +			      struct davinci_spi_platform_data *pdata)
> +{
> +	struct platform_device *pdev;
> +
> +	if (instance == 0)
> +		pdev =&da8xx_spi_device[0];
> +	else if (instance == 1)
> +		pdev =&da8xx_spi_device[1];

    Why not:

	if (instance == 0 || instance == 1)
		pdev = &da8xx_spi_device[instance];

> +	else
> +		return -EINVAL;
> +
> +	pdev->dev.platform_data = pdata;
> +
> +	return platform_device_register(pdev);
> +}

WBR, Sergei
