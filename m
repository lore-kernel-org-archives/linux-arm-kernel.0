From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Jan 2013 17:17:36 +0530
Subject: [PATCH v4 7/9] ARM: davinci: da850 board: Added .reserve function
 and rproc platform registration
In-Reply-To: <1355967254-16726-8-git-send-email-rtivy@ti.com>
References: <1355967254-16726-1-git-send-email-rtivy@ti.com>
 <1355967254-16726-8-git-send-email-rtivy@ti.com>
Message-ID: <50E6C158.7020702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 7:04 AM, Robert Tivy wrote:
> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c     |    8 ++++++++
>  arch/arm/mach-davinci/board-omapl138-hawk.c |    8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index b7cfb3e..0c959e9 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1550,6 +1550,11 @@ static __init void da850_evm_init(void)
>  		pr_warn("%s: SATA registration failed: %d\n", __func__, ret);
>  
>  	da850_evm_setup_mac_addr();
> +
> +	ret = da8xx_register_rproc();
> +	if (ret)
> +		pr_warn("%s: dsp/rproc registration failed: %d\n",
> +			__func__, ret);
>  }
>  
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
> @@ -1577,4 +1582,7 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
>  	.init_late	= davinci_init_late,
>  	.dma_zone_size	= SZ_128M,
>  	.restart	= da8xx_restart,
> +#ifdef CONFIG_CMA
> +	.reserve	= da8xx_rproc_reserve_cma,
> +#endif

Please get rid of this ifdef as well. You can have an empty function if
remote proc is not enabled in the build.

Thanks,
Sekhar
