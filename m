From: horms@verge.net.au (Simon Horman)
Date: Sat, 15 Dec 2012 17:05:43 +0900
Subject: [PATCH 5/7] ARM: sh7372: allow boards supporting booting with or
 without DT
In-Reply-To: <1355503531-7276-6-git-send-email-g.liakhovetski@gmx.de>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-6-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20121215080542.GF9073@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 05:45:29PM +0100, Guennadi Liakhovetski wrote:
> For boards booting without DT no changes should be caused by this patch.
> When booting with DT, devices, whose drivers support DT probing, will not
> be registered.

This relates in part to my comment on "ARM: sh7372: support mixed DT and
board code interrupt controller init".

It is my understanding that sh7372_add_standard_devices_dt() already
exists in setup-sh7372.c and that it is appropriate to use for bring
up boards with DT.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  arch/arm/mach-shmobile/setup-sh7372.c |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
> index bbe6e2a..3e6bf3d 100644
> --- a/arch/arm/mach-shmobile/setup-sh7372.c
> +++ b/arch/arm/mach-shmobile/setup-sh7372.c
> @@ -981,9 +981,12 @@ static struct platform_device *sh7372_early_devices[] __initdata = {
>  	&tmu01_device,
>  };
>  
> -static struct platform_device *sh7372_late_devices[] __initdata = {
> +static struct platform_device *sh7372_late_devices_dt[] __initdata = {
>  	&iic0_device,
>  	&iic1_device,
> +};
> +
> +static struct platform_device *sh7372_late_devices[] __initdata = {
>  	&dma0_device,
>  	&dma1_device,
>  	&dma2_device,
> @@ -1012,13 +1015,11 @@ void __init sh7372_add_standard_devices(void)
>  		{ "A3SP", &scif4_device, },
>  		{ "A3SP", &scif5_device, },
>  		{ "A3SP", &scif6_device, },
> -		{ "A3SP", &iic1_device, },
>  		{ "A3SP", &dma0_device, },
>  		{ "A3SP", &dma1_device, },
>  		{ "A3SP", &dma2_device, },
>  		{ "A3SP", &usb_dma0_device, },
>  		{ "A3SP", &usb_dma1_device, },
> -		{ "A4R", &iic0_device, },
>  		{ "A4R", &veu0_device, },
>  		{ "A4R", &veu1_device, },
>  		{ "A4R", &veu2_device, },
> @@ -1027,6 +1028,10 @@ void __init sh7372_add_standard_devices(void)
>  		{ "A4R", &tmu00_device, },
>  		{ "A4R", &tmu01_device, },
>  	};
> +	struct pm_domain_device domain_devices_dt[] = {
> +		{ "A3SP", &iic1_device, },
> +		{ "A4R", &iic0_device, },
> +	};
>  
>  	sh7372_init_pm_domains();
>  
> @@ -1035,9 +1040,15 @@ void __init sh7372_add_standard_devices(void)
>  
>  	platform_add_devices(sh7372_late_devices,
>  			    ARRAY_SIZE(sh7372_late_devices));
> +	if (!of_have_populated_dt())
> +		platform_add_devices(sh7372_late_devices_dt,
> +				     ARRAY_SIZE(sh7372_late_devices_dt));
>  
>  	rmobile_add_devices_to_domains(domain_devices,
>  				       ARRAY_SIZE(domain_devices));
> +	if (!of_have_populated_dt())
> +		rmobile_add_devices_to_domains(domain_devices_dt,
> +					       ARRAY_SIZE(domain_devices_dt));
>  }
>  
>  static void __init sh7372_earlytimer_init(void)
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
