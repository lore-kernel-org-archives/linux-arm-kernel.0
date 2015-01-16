From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 16 Jan 2015 11:39:13 +0100
Subject: [RFC 1/2] clocksource: track usage
In-Reply-To: <1421399874-29119-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421399874-29119-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421399874-29119-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150116113913.13ece0f6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Fri, 16 Jan 2015 10:17:53 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Track whether the clocksource is enabled or disabled.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  include/linux/clocksource.h |  4 ++++
>  kernel/time/clocksource.c   | 26 ++++++++++++++++++++++++++
>  kernel/time/timekeeping.c   |  8 +++-----
>  3 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index abcafaa20b86..7735902fc5f6 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -210,6 +210,8 @@ struct clocksource {
>  #define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
>  #define CLOCK_SOURCE_RESELECT			0x100
>  
> +#define CLOCK_SOURCE_USED			0x200
> +
>  /* simplify initialization of mask field */
>  #define CLOCKSOURCE_MASK(bits) (cycle_t)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
>  
> @@ -282,6 +284,8 @@ static inline s64 clocksource_cyc2ns(cycle_t cycles, u32 mult, u32 shift)
>  
>  extern int clocksource_register(struct clocksource*);
>  extern int clocksource_unregister(struct clocksource*);
> +extern int clocksource_enable(struct clocksource *);
> +extern void clocksource_disable(struct clocksource *);
>  extern void clocksource_touch_watchdog(void);
>  extern struct clocksource* clocksource_get_next(void);
>  extern void clocksource_change_rating(struct clocksource *cs, int rating);
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index b79f39bda7e1..920a4da58eb0 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -889,6 +889,32 @@ int clocksource_unregister(struct clocksource *cs)
>  }
>  EXPORT_SYMBOL(clocksource_unregister);
>  
> +/**
> + * clocksource_enable - enable a registered clocksource
> + * @cs:	clocksource to enable
> + */
> +int clocksource_enable(struct clocksource *cs)
> +{
> +	cs->flags |= CLOCK_SOURCE_USED;
> +	if (cs->enable)
> +		return cs->enable(cs);

I guess you should check cs->enable() return code before setting the
CLOCK_SOURCE_USED flag.




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
