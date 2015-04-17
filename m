From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 17 Apr 2015 23:16:45 +0200
Subject: [PATCH 1/5] clocksource: st_lpc: Add LPC timer as a clocksource.
In-Reply-To: <1429267823-8879-2-git-send-email-peter.griffin@linaro.org>
References: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
 <1429267823-8879-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <1429305405.16771.114.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-04-17 at 11:50 +0100, Peter Griffin wrote:
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig

> +config CLKSRC_ST_LPC_CLOCK
> +	bool
> +	depends on ARCH_STI
> +	select CLKSRC_OF if OF
> +	help
> +	  Enable this option to use the Low Power controller timer
> +	  as clock source.
> +
> +config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
> +	bool
> +	depends on ST_LPC_CLOCK

It looks like you meant
     depends on CLKSRC_ST_LPC_CLOCK

> +	default y
> +	help
> +	  Use Low Power controller timer clock source as sched_clock

> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile

> +obj-$(CONFIG_CLKSRC_ST_LPC_CLOCK)	+= st_lpc.o

> --- /dev/null
> +++ b/drivers/clocksource/st_lpc.c

> +#ifdef CONFIG_CLKSRC_LPC_TIMER_SCHED_CLOCK

#ifdef CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK here?

> +static u64 notrace st_lpc_sched_clock_read(void)
> +{
> +	return st_lpc_counter_read();
> +}
> +#endif

> +#ifdef CONFIG_CLKSRC_LPC_TIMER_SCHED_CLOCK

Again, #ifdef CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK here?

> +	sched_clock_register(st_lpc_sched_clock_read, 64, rate);
> +#endif

Assuming the above suggestions are correct: checkkconfigsymbols.py, as
shipped in linux-next, helps detect stuff like this. See
    scripts/checkkconfigsymbols.py --help.

Thanks,


Paul Bolle
