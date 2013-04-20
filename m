From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 20 Apr 2013 04:10:45 +0400
Subject: [PATCH v2 2/4] ARM: shmobile: r8a7779: add VIN support
In-Reply-To: <201304200232.33731.sergei.shtylyov@cogentembedded.com>
References: <201304200232.33731.sergei.shtylyov@cogentembedded.com>
Message-ID: <5171DD05.6020400@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/20/2013 02:32 AM, Sergei Shtylyov wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>
> Add VIN clocks and platform devices for R8A7779 SoC; add function to register
> the VIN platform devices.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: added 'id' parameter check to r8a7779_add_vin_device(), renamed some
> variables.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

> Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -559,6 +559,33 @@ static struct resource ether_resources[]
>   	},
>   };
>   
> +#define R8A7779_VIN(idx) \
> +static struct resource vin##idx##_resources[] = {		\
> +	DEFINE_RES_MEM(0xffc50000 + 0x1000 * (idx), 0x1000),	\
> +	DEFINE_RES_IRQ(gic_iid(0x5f + (idx))),			\
> +};								\
> +								\
> +static struct platform_device_info vin##idx##_info = {		\

    Hm, probably should have marked this as '__initdata'... maybe
the resources too.

> +	.parent		= &platform_bus,			\
> +	.name		= "rcar_vin",				\
> +	.id		= idx,					\
> +	.res		= vin##idx##_resources,			\
> +	.num_res	= ARRAY_SIZE(vin##idx##_resources),	\
> +	.dma_mask	= DMA_BIT_MASK(32),			\
> +}
>
