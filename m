From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 5 May 2010 22:25:29 +0200
Subject: [at91] Save power by disabling the processor clock when CPU is
	idle
In-Reply-To: <1271156732l.25331l.7l@i-dmzi_al.realan.de>
References: <1271156732l.25331l.7l@i-dmzi_al.realan.de>
Message-ID: <20100505202529.GB25037@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Apr 13, 2010 at 01:05:32PM +0200, Anders Larsen wrote:
> Disable the processor clock when the CPU is idle.
> 
> This saves much more power than merely entering 'Wait for Interrupt' mode.
> Since JTAG-debugging doesn't work when the processor clock is switched off,
> make it conditional on CONFIG_DEBUG_KERNEL.
> 
> Signed-off-by: Anders Larsen <al@alarsen.net>
> Cc: Andrew Victor <avictor.za@gmail.com>
> ---
> KernelVersion: 2.6.33
> 
>  arch/arm/mach-at91/include/mach/system.h |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> 
> Index: b/arch/arm/mach-at91/include/mach/system.h
> ===================================================================
> --- a/arch/arm/mach-at91/include/mach/system.h
> +++ b/arch/arm/mach-at91/include/mach/system.h
> @@ -24,21 +24,24 @@
>  #include <mach/hardware.h>
>  #include <mach/at91_st.h>
>  #include <mach/at91_dbgu.h>
> +#include <mach/at91_pmc.h>
>  
>  static inline void arch_idle(void)
>  {
> +#ifndef CONFIG_DEBUG_KERNEL
>  	/*
>  	 * Disable the processor clock.  The processor will be automatically
>  	 * re-enabled by an interrupt or by a reset.
>  	 */
> -//	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
> -
> +	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
> +#else
>  	/*
>  	 * Set the processor (CP15) into 'Wait for Interrupt' mode.
>  	 * Unlike disabling the processor clock via the PMC (above)
>  	 *  this allows the processor to be woken via JTAG.
>  	 */
>  	cpu_do_idle();
> +#endif

There is a kernel parameter (IIRC "nohlt") that should take care of
this?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
