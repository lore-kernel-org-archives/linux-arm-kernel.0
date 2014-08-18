From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Aug 2014 17:27:26 +0100
Subject: [PATCH 3/7] ARM: meson6: clocksource: add Meson6 timer support
In-Reply-To: <1408272594-10814-4-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-4-git-send-email-carlo@caione.org>
Message-ID: <20140818162726.GE3302@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 11:49:50AM +0100, Carlo Caione wrote:
> Meson6 SoCs are equipped with 5 32-bit timers, called TIMER_A, TIMER_B,
> TIMER_C, TIMER_D and TIMER_E.
> 
> The driver is providing clocksource support for the 32-bit counter using
> TIMER_E. Clockevents are also supported using TIMER_A.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  drivers/clocksource/Kconfig        |   3 +
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/meson6_timer.c | 187 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 191 insertions(+)
>  create mode 100644 drivers/clocksource/meson6_timer.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cfd6519..38029ca 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -30,6 +30,9 @@ config ARMADA_370_XP_TIMER
>  	bool
>  	select CLKSRC_OF
>  
> +config MESON6_TIMER
> +	bool
> +
>  config ORION_TIMER
>  	select CLKSRC_OF
>  	select CLKSRC_MMIO
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 7fd9fd1..e4ae987 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
>  obj-$(CONFIG_ARCH_U300)		+= timer-u300.o
>  obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
>  obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
> +obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
>  obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
>  obj-$(CONFIG_ARCH_NSPIRE)	+= zevio-timer.o
> diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
> new file mode 100644
> index 0000000..1ef1095
> --- /dev/null
> +++ b/drivers/clocksource/meson6_timer.c
> @@ -0,0 +1,187 @@
> +/*
> + * Amlogic Meson6 SoCs timer handling.
> + *
> + * Copyright (C) 2014 Carlo Caione
> + *
> + * Carlo Caione <carlo@caione.org>
> + *
> + * Based on code from Amlogic, Inc
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>
> +#include <linux/sched_clock.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +enum {
> +	A = 0,
> +	B,
> +	C,
> +	D,
> +};

That's a very terse set of enum names. I would recomment something a
little longer.

Any reason for missing E?

> +
> +#define TIMER_ISA_MUX		0
> +#define TIMER_ISA_E_VAL		0x14
> +#define TIMER_ISA_t_VAL(t)	((t + 1) << 2)
> +
> +#define TIMER_t_INPUT_BIT(t)	(2 * t)
> +#define TIMER_E_INPUT_BIT	8
> +#define TIMER_t_INPUT_MASK(t)	(3UL << TIMER_t_INPUT_BIT(t))
> +#define TIMER_E_INPUT_MASK	(7UL << TIMER_E_INPUT_BIT)
> +#define TIMER_t_ENABLE_BIT(t)	(16 + t)
> +#define TIMER_E_ENABLE_BIT	20
> +#define TIMER_t_PERIODIC_BIT(t)	(12 + t)

While I don't think it matters for any of these, it's usually good
practice to add parentheses around arguments, e.g.

#define FOO(x)		((x) * 2)

So you can avoid bad expansions in cases like:

FOO(reg + 4)

> +
> +#define TIMER_UNIT_1us		0
> +#define TIMER_E_UNIT_1us	1
> +
> +static void __iomem *timer_base;
> +
> +static cycle_t cycle_read_timer_e(struct clocksource *cs)
> +{
> +	return (cycle_t)readl(timer_base + TIMER_ISA_E_VAL);
> +}
> +
> +static struct clocksource clocksource_timer_e = {
> +	.name	= "meson6_timerE",

Do we really care which specific timer we're using within the block?

Why not just "meson6_clocksource"?

> +	.rating	= 300,
> +	.read	= cycle_read_timer_e,
> +	.mask	= CLOCKSOURCE_MASK(32),
> +	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> +};

[...]

> +static irqreturn_t meson6_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction meson6_timer_irq = {
> +	.name		= "meson6_timerA",

Similarly to the clocksource naming, this might be better as
"meson6_timer", without the 'A'.

Thanks,
Mark.
