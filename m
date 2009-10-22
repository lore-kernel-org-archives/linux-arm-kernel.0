From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Oct 2009 10:15:31 +0200
Subject: [PATCH] ARM: NX3: do not reference mxc_iomux_v3_init() for
	!CONFIG_ARCH_MX35
In-Reply-To: <1256149783-16789-1-git-send-email-daniel@caiaq.de>
References: <1256149783-16789-1-git-send-email-daniel@caiaq.de>
Message-ID: <20091022081531.GB8818@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2009 at 08:29:43PM +0200, Daniel Mack wrote:
> Recent kernels for mx31 fail to link due to an undefined reference to
> mxc_iomux_v3_init().

There is already a fix for this from Guennadi included in my last pull
Request. I find this in rmks master branch, so I suspect Linus hasn't
pulled from him yet.

Sascha

> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/mm.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
> index ad5a112..c8acd60 100644
> --- a/arch/arm/mach-mx3/mm.c
> +++ b/arch/arm/mach-mx3/mm.c
> @@ -81,6 +81,12 @@ void __init mx31_map_io(void)
>  	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
>  }
>  
> +void __init mx31_init_irq(void)
> +{
> +	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
> +}
> +
> +#ifdef CONFIG_ARCH_MX35
>  void __init mx35_map_io(void)
>  {
>  	mxc_set_cpu_type(MXC_CPU_MX35);
> @@ -90,15 +96,11 @@ void __init mx35_map_io(void)
>  	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
>  }
>  
> -void __init mx31_init_irq(void)
> -{
> -	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
> -}
> -
>  void __init mx35_init_irq(void)
>  {
>  	mx31_init_irq();
>  }
> +#endif
>  
>  #ifdef CONFIG_CACHE_L2X0
>  static int mxc_init_l2x0(void)
> -- 
> 1.6.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
