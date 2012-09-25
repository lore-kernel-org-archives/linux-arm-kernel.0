From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 24 Sep 2012 17:43:21 -0700
Subject: [PATCH V2] ARM: OMAP: counter: add locking to
 read_persistent_clock
In-Reply-To: <1347434081-11469-1-git-send-email-r.sricharan@ti.com>
 (R. Sricharan's message of "Wed, 12 Sep 2012 12:44:41 +0530")
References: <1347434081-11469-1-git-send-email-r.sricharan@ti.com>
Message-ID: <87d31bj5jq.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R Sricharan <r.sricharan@ti.com> writes:

> From: Colin Cross <ccross@android.com>
>
> read_persistent_clock uses a global variable, use a spinlock to
> ensure non-atomic updates to the variable don't overlap and cause
> time to move backwards.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, this should probably be queued up for v3.7-rc and flagged for stable.

Thanks,

Kevin

> ---
>  [V2] Added signed-off-by and looped in "linux-arm-kernel" list
>
>  arch/arm/plat-omap/counter_32k.c |   21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> index dbf1e03..2bc51fb 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -55,22 +55,29 @@ static u32 notrace omap_32k_read_sched_clock(void)
>   * nsecs and adds to a monotonically increasing timespec.
>   */
>  static struct timespec persistent_ts;
> -static cycles_t cycles, last_cycles;
> +static cycles_t cycles;
>  static unsigned int persistent_mult, persistent_shift;
> +static DEFINE_SPINLOCK(read_persistent_clock_lock);
> +
>  static void omap_read_persistent_clock(struct timespec *ts)
>  {
>  	unsigned long long nsecs;
> -	cycles_t delta;
> -	struct timespec *tsp = &persistent_ts;
> +	cycles_t last_cycles;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&read_persistent_clock_lock, flags);
>  
>  	last_cycles = cycles;
>  	cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
> -	delta = cycles - last_cycles;
>  
> -	nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
> +	nsecs = clocksource_cyc2ns(cycles - last_cycles,
> +					persistent_mult, persistent_shift);
> +
> +	timespec_add_ns(&persistent_ts, nsecs);
> +
> +	*ts = persistent_ts;
>  
> -	timespec_add_ns(tsp, nsecs);
> -	*ts = *tsp;
> +	spin_unlock_irqrestore(&read_persistent_clock_lock, flags);
>  }
>  
>  /**
