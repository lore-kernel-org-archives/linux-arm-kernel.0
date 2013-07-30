From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 30 Jul 2013 16:57:06 +0400
Subject: [PATCH 5/5] ARM: shmobile: ape6evm: add SDHI interfaces
In-Reply-To: <f79d68da510bf1b95beff4d556b78d06801f11dc.1375174556.git.horms+renesas@verge.net.au>
References: <cover.1375174556.git.horms+renesas@verge.net.au>
 <f79d68da510bf1b95beff4d556b78d06801f11dc.1375174556.git.horms+renesas@verge.net.au>
Message-ID: <51F7B822.7020404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 30-07-2013 13:00, Simon Horman wrote:

> From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> Add support for SDHI0 and SDHI1 on APE6EVM in PIO mode only.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/board-ape6evm.c | 50 +++++++++++++++++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
> index 8c7529c..ccf8b04 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm.c
[...]
> @@ -75,6 +82,29 @@ static struct resource mmcif0_resources[] = {
>   	DEFINE_RES_IRQ(gic_spi(169)),
>   };
>
> +/* SDHI0 */
> +static struct sh_mobile_sdhi_info sdhi0_pdata = {
> +	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
> +	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
> +};
> +
> +static struct resource sdhi0_resources[] = {
> +	DEFINE_RES_MEM_NAMED(0xee100000, 0x100, "SDHI0"),
> +	DEFINE_RES_IRQ(gic_spi(165)),
> +};
> +
> +/* SDHI1 */
> +static struct sh_mobile_sdhi_info sdhi1_pdata = {
> +	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
> +	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> +			  MMC_CAP_NEEDS_POLL,
> +};
> +
> +static struct resource sdhi1_resources[] = {
> +	DEFINE_RES_MEM_NAMED(0xee120000, 0x100, "SDHI1"),
> +	DEFINE_RES_IRQ(gic_spi(166)),
> +};
> +

    All of the above are lacking '__initdata' annothation (the resources and 
platform data will be kmemdup()'ed when registering the platform devices). Too 
bad I've noticed this too late...

> @@ -124,6 +166,12 @@ static void __init ape6evm_add_standard_devices(void)
>   	platform_device_register_resndata(&platform_bus, "sh_mmcif", 0,
>   					  mmcif0_resources, ARRAY_SIZE(mmcif0_resources),
>   					  &mmcif0_pdata, sizeof(mmcif0_pdata));
> +	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 0,
> +					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
> +					  &sdhi0_pdata, sizeof(sdhi0_pdata));
> +	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 1,
> +					  sdhi1_resources, ARRAY_SIZE(sdhi1_resources),
> +					  &sdhi1_pdata, sizeof(sdhi1_pdata));
>   }

WBR, Sergei
