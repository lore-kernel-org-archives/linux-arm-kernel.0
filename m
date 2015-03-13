From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Mar 2015 13:31:09 +0800
Subject: [PATCH v2 3/7] ARM: mx25: Remove static memory mapping
In-Reply-To: <1426083694-6624-3-git-send-email-festevam@gmail.com>
References: <1426083694-6624-1-git-send-email-festevam@gmail.com>
 <1426083694-6624-3-git-send-email-festevam@gmail.com>
Message-ID: <20150313053107.GS20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 11:21:30AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We use dynamic memory mapping when using dt, so remove all the static mappings.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - None
> 
>  arch/arm/mach-imx/mach-imx25.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx25.c b/arch/arm/mach-imx/mach-imx25.c
> index 7cad96d..1a2c5de 100644
> --- a/arch/arm/mach-imx/mach-imx25.c
> +++ b/arch/arm/mach-imx/mach-imx25.c
> @@ -20,26 +20,6 @@
>  #include "common.h"
>  #include "hardware.h"
>  
> -/*
> - * This table defines static virtual address mappings for I/O regions.
> - * These are the mappings common across all MX25 boards.
> - */
> -static struct map_desc mx25_io_desc[] __initdata = {
> -	imx_map_entry(MX25, AVIC, MT_DEVICE_NONSHARED),
> -	imx_map_entry(MX25, AIPS1, MT_DEVICE_NONSHARED),
> -	imx_map_entry(MX25, AIPS2, MT_DEVICE_NONSHARED),
> -};
> -
> -/*
> - * This function initializes the memory map. It is called during the
> - * system startup to create static physical to virtual memory mappings
> - * for the IO modules.
> - */
> -void static __init mx25_map_io(void)
> -{
> -	iotable_init(mx25_io_desc, ARRAY_SIZE(mx25_io_desc));
> -}
> -

With these code removed, the include of <asm/mach/map.h> added by
patch #2 becomes zombie?

Shawn

>  void static __init imx25_init_early(void)
>  {
>  	mxc_set_cpu_type(MXC_CPU_MX25);
> @@ -62,7 +42,6 @@ static const char * const imx25_dt_board_compat[] __initconst = {
>  };
>  
>  DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
> -	.map_io		= mx25_map_io,
>  	.init_early	= imx25_init_early,
>  	.init_irq	= mx25_init_irq,
>  	.dt_compat	= imx25_dt_board_compat,
> -- 
> 1.9.1
> 
