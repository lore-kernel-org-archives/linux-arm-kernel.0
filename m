From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 09:56:52 +0200
Subject: [RFC PATCH v2 4/5] ARM: hisi: enable devicetree support for hi3520
In-Reply-To: <20160915210505.21878-5-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
 <20160915210505.21878-5-netz.kernel@gmail.com>
Message-ID: <2438843.7Op0NuNt2B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 4:05:04 PM CEST Marty Plummer wrote:
> @@ -24,17 +31,19 @@ config ARCH_HI3620
>  	  Support for Hisilicon Hi36xx SoC family
>  
>  config ARCH_HIP01
> -       bool "Hisilicon HIP01 family"
> -       depends on ARCH_MULTI_V7
> -       select HAVE_ARM_SCU if SMP
> -       select HAVE_ARM_TWD if SMP
> -       select ARM_GLOBAL_TIMER
> -       help
> -         Support for Hisilicon HIP01 SoC family
> +	bool "Hisilicon HIP01 family"
> +	depends on ARCH_MULTI_V7
> +	select ARM_GIC
> +	select HAVE_ARM_SCU if SMP
> +	select HAVE_ARM_TWD if SMP
> +	select ARM_GLOBAL_TIMER
> +	help
> +	  Support for Hisilicon HIP01 SoC family
>  

This change doesn't belong in here.

> @@ -28,6 +30,16 @@
>   * spaces wasted since ioremap() may be called multi times for the same
>   * IO space.
>   */
> +static struct map_desc hi3520_1176_io_desc[] __initdata = {
> +	{
> +		/* sysctrl */
> +		.virtual	= HI3520_1176_SYSCTRL_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(HI3520_1176_SYSCTRL_PHYS_BASE),
> +		.length		= 0x10000,
> +		.type		= MT_DEVICE,
> +	},
> +};
> +
>  static struct map_desc hi3620_io_desc[] __initdata = {
>  	{
>  		/* sysctrl */


What do you need this for? I think it would be better to map the
device manually from whichever code uses itby looking it up 
in the DT.

	Arnd
