From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Sep 2012 10:32:53 +0900
Subject: [PATCH] ARM: shmobile: r8a7740: Enable PMU
In-Reply-To: <1347596833-19064-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1347596833-19064-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <20120918013253.GC28305@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Add CC linux-arm-kernel at lists.infradead.org,
  patches need to go there before I can forward them to arm-soc ]

On Fri, Sep 14, 2012 at 01:27:13PM +0900, Nobuhiro Iwamatsu wrote:
> This patch enables PMU for r8a7740.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  arch/arm/configs/armadillo800eva_defconfig |    1 +
>  arch/arm/mach-shmobile/setup-r8a7740.c     |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> index 62861bd..d952f62 100644
> --- a/arch/arm/configs/armadillo800eva_defconfig
> +++ b/arch/arm/configs/armadillo800eva_defconfig
> @@ -7,6 +7,7 @@ CONFIG_LOG_BUF_SHIFT=16
>  # CONFIG_IPC_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_PERF_EVENTS=y
>  CONFIG_SLAB=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 78948a9..d3d6295 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -590,6 +590,21 @@ static struct platform_device i2c1_device = {
>  	.num_resources	= ARRAY_SIZE(i2c1_resources),
>  };
>  
> +static struct resource pmu_resources[] = {
> +	[0] = {
> +		.start	= evt2irq(0x19a0),
> +		.end	= evt2irq(0x19a0),
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device pmu_device = {
> +	.name	= "arm-pmu",
> +	.id		= -1,
> +	.num_resources = ARRAY_SIZE(pmu_resources),
> +	.resource = pmu_resources,
> +};
> +
>  static struct platform_device *r8a7740_late_devices[] __initdata = {
>  	&i2c0_device,
>  	&i2c1_device,
> @@ -597,6 +612,7 @@ static struct platform_device *r8a7740_late_devices[] __initdata = {
>  	&dma1_device,
>  	&dma2_device,
>  	&usb_dma_device,
> +	&pmu_device,
>  };
>  
>  /*
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
