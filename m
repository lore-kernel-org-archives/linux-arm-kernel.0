From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jun 2011 14:57:06 +0100
Subject: [PATCH] ARM: automatically select OMAP3_PMU if we try to use
	perf on OMAP3
In-Reply-To: <1309268265-2685-1-git-send-email-bryan.wu@canonical.com>
References: <1309268265-2685-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110628135706.GA28871@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Bryan,

On Tue, Jun 28, 2011 at 02:37:45PM +0100, Bryan Wu wrote:
> For our Ubuntu kernel on OMAP4 machine, we need to enable OMAP3 as well as
> OMAP4. OMAP3_EMU has to be enabled manully to make CPU_HAS_PMU=y, which is
> required by perf.
> 
> So this patch will select the OMAP3_EMU if ARCH_OMAP3 is enabled.
> 
> Cc: Ming Lei <ming.lei@canonical.com>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  arch/arm/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2fd0911..53d0eba 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1084,10 +1084,10 @@ config XSCALE_PMU
>  	default y
>  
>  config CPU_HAS_PMU
> -	depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU) && \
> -		   (!ARCH_OMAP3 || OMAP3_EMU)
> +	depends on CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU
>  	default y
>  	bool
> +	select OMAP3_EMU if ARCH_OMAP3
>  
>  config MULTI_IRQ_HANDLER
>  	bool

This issue has been discussed on the list in the past and I still think that
it would be better for your config to select OMAP3_EMU explicitly. If we do
that here unconditionally then we end up also bringing in OC_ETM which isn't
something that sounds like a good idea (may have implications for power
consumption in production hardware?).

Will
