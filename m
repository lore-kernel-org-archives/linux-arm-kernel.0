From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 25 Sep 2014 15:50:15 +0800
Subject: [PATCH 2/2] ARM: vf610: Use ARM Global Timer as clocksource
In-Reply-To: <1410437175-6636-2-git-send-email-stefan@agner.ch>
References: <1410437175-6636-1-git-send-email-stefan@agner.ch>
 <1410437175-6636-2-git-send-email-stefan@agner.ch>
Message-ID: <20140925075013.GD6405@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 02:06:15PM +0200, Stefan Agner wrote:
> Use ARM Global Timer as clocksource instead of the PIT timer. This
> leaves the PIT timer for other users e.g. the secondary Cortex-M4
> core. Also, the Global Timer has double the precission (running at
> pheripheral clock compared to IPG clock) and a 64-bit incrementing
> counter register.

I just think of one thing.  Will this change cause a problem of the low
power idle support in case we want to power down ARM core in there?

Shawn

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Theoretically we could remove the PIT driver now. But we could also
> enable both drivers, but is having two clock source useful for the
> Kernel at all?
> 
>  arch/arm/mach-imx/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 64161aa..adc77180 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -656,7 +656,8 @@ config SOC_VF610
>  	bool "Vybrid Family VF610 support"
>  	select ARM_GIC
>  	select PINCTRL_VF610
> -	select VF_PIT_TIMER
> +	select ARM_GLOBAL_TIMER
> +	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>  	select PL310_ERRATA_769419 if CACHE_L2X0
>  
>  	help
> -- 
> 2.1.0
> 
