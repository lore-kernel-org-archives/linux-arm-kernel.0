From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 31 Jul 2011 16:07:07 +0100
Subject: [PATCH] Add sched_clock to AT91 TCB clocksource driver
In-Reply-To: <1312124593-6088-1-git-send-email-linux@bohmer.net>
References: <1312124593-6088-1-git-send-email-linux@bohmer.net>
Message-ID: <20110731150707.GA2975@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 31, 2011 at 05:03:13PM +0200, Remy Bohmer wrote:
> On AT91 there is no architecture specific sched_clock() implementation,
> so the default fallback is used. This fallback uses the jiffie counter
> as sched_clock().
> There is NO standard clocksource available that is accurate enough,
> except the TC-based clocksource implementation. Therefor this
> implementation is used as base for the sched_clock(). This clocksource
> offers sub-millisecond time-stamping. (< 200 ns)
> 
> Signed-off-by: Remy Bohmer <linux@bohmer.net>
> ---
>  arch/arm/Kconfig                 |    1 +
>  arch/arm/kernel/sched_clock.c    |    7 +++++++
>  drivers/clocksource/tcb_clksrc.c |   23 +++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..e0563a7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -296,6 +296,7 @@ config ARCH_AT91
>  	select HAVE_CLK
>  	select CLKDEV_LOOKUP
>  	select ARM_PATCH_PHYS_VIRT if MMU
> +	select HAVE_SCHED_CLOCK if ATMEL_TCB_CLKSRC
>  	help
>  	  This enables support for systems based on the Atmel AT91RM9200,
>  	  AT91SAM9 and AT91CAP9 processors.
> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
> index 9a46370..f9028e4 100644
> --- a/arch/arm/kernel/sched_clock.c
> +++ b/arch/arm/kernel/sched_clock.c
> @@ -20,6 +20,13 @@ static void (*sched_clock_update_fn)(void);
>  
>  static void sched_clock_poll(unsigned long wrap_ticks)
>  {
> +	/*
> +	 * The sched_clock_update_fn may be initialised AFTER first call to
> +	 * time_init()
> +	 */
> +	if (unlikely(!sched_clock_update_fn))
> +		return;

NAK.  I've said this before - sched_clock _must_ be up and running by the
time this function is called - because shortly after this call is when
the scheduler initializes, and the scheduler wants sched_clock() working
at that point.
