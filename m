From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Oct 2009 14:20:41 +0200
Subject: [PATCH] fix compilation of i.MX31 platforms
In-Reply-To: <Pine.LNX.4.64.0910050945480.4337@axis700.grange>
References: <Pine.LNX.4.64.0910050945480.4337@axis700.grange>
Message-ID: <20091005122041.GE23986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2009 at 10:00:58AM +0200, Guennadi Liakhovetski wrote:
> mxc_iomux_v3_init() is defined in arch/arm/plat-mxc/iomux-v3.c, which is 
> not linked for i.MX31 and produces an undefined reference error. Fix this 
> by building the offending code only for i.MX35.

Ok for -rc.

> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> 2.6.32-rc1 (and, AFAICS, all current trees) don't build for i.MX31.

At least not when i.MX35 is disabled.

Sascha

> Disliking #ifdef's as much as you do, this is not the best fix. A nicer 
> one would be defining a dummy mxc_iomux_v3_init() inline in 
> arch/arm/plat-mxc/include/mach/iomux-v3.h, but this would waste a couple 
> of bytes in arch/arm/mach-mx3/mm.o for the unneeded mx35_map_io(). Either 
> way is fine with me, shoose whichever you prefer.
> 
> diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
> index ad5a112..bedf5b8 100644
> --- a/arch/arm/mach-mx3/mm.c
> +++ b/arch/arm/mach-mx3/mm.c
> @@ -81,6 +81,7 @@ void __init mx31_map_io(void)
>  	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
>  }
>  
> +#ifdef CONFIG_ARCH_MX35
>  void __init mx35_map_io(void)
>  {
>  	mxc_set_cpu_type(MXC_CPU_MX35);
> @@ -89,6 +90,7 @@ void __init mx35_map_io(void)
>  
>  	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
>  }
> +#endif
>  
>  void __init mx31_init_irq(void)
>  {
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
