From: daniel@zonque.org (Daniel Mack)
Date: Sat, 07 Feb 2015 23:32:00 +0100
Subject: [PATCH] ARM: pxa: pxa27x skip default device initialization with
 DT
In-Reply-To: <1423343914-32342-1-git-send-email-robert.jarzmik@free.fr>
References: <1423343914-32342-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <54D69260.3020204@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2015 10:18 PM, Robert Jarzmik wrote:
> When booting via DT, the default PXA devices must not have been probed
> before, otherwise the augmented information from the device tree is
> ignored.
> 
> This is the twin commit of commit 82ce44d104dc ("ARM: pxa3xx: skip
> default device initialization when booting via DT").
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Looks good to me - thanks!

Acked-by: Daniel Mack <daniel@zonque.org>

> ---
>  arch/arm/mach-pxa/pxa27x.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 0485248..b5abdeb 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -307,8 +307,12 @@ static int __init pxa27x_init(void)
>  		register_syscore_ops(&pxa_irq_syscore_ops);
>  		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
>  
> -		pxa_register_device(&pxa27x_device_gpio, &pxa27x_gpio_info);
> -		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
> +		if (!of_have_populated_dt()) {
> +			pxa_register_device(&pxa27x_device_gpio,
> +					    &pxa27x_gpio_info);
> +			ret = platform_add_devices(devices,
> +						   ARRAY_SIZE(devices));
> +		}
>  	}
>  
>  	return ret;
> 
