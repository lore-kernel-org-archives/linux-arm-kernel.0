From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 10 Mar 2010 06:40:24 +0100
Subject: [PATCH 04/11] ST SPEAr: Added basic header files for SPEAr
	platform
In-Reply-To: <1267592861-26911-5-git-send-email-viresh.kumar@st.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>
Message-ID: <63386a3d1003092140o67a6c943rdee3a6c905cea7ef@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/3 Viresh KUMAR <viresh.kumar@st.com>:

> ?arch/arm/plat-spear/include/plat/gpt.h | ?108 ++++++++++++++++++++++++++++++++

If this file is only supposed to be used from plat-spear/time.c, move it down
into plat-spear/gpt.h and #include "gpt.h" so noone else will
accidentally use it.

> (...)
>
> +#ifndef __ASM_PLAT_GPT_H
> +#define __ASM_PLAT_GPT_H

This file to macro match i.e. __PLAT_GPT_H again I think...
(But see below.)

> +
> +/* register offsets */
> +#define GPT_CTRL_OFF ? ? ? ? ? 0x80 /* Control Register */
> +#define GPT_INT_OFF ? ? ? ? ? ?0x84 /* Interrupt Regiset */
> +#define GPT_LOAD_OFF ? ? ? ? ? 0x88 /* Load Register */
> +#define GPT_COUNT_OFF ? ? ? ? ?0x8C /* Current Count Register */

Some people want you to do all the indentation e.g. between
GPT_CTRL_OFF -> 0x80 with TABs only, and I tend to do that
to keep everybody happy. (This would go for all .h files with
register definitions.

> +
> +/* CTRL Reg Bit Values */
> +#define GPT_CTRL_MATCH_INT ? ? 0x0100
> +#define GPT_CTRL_ENABLE ? ? ? ? ? ? ? ?0x0020
> +#define GPT_CTRL_MODE_AR ? ? ? 0x0010
> +
> +#define GPT_CTRL_PRESCALER1 ? ?0x0
> +#define GPT_CTRL_PRESCALER2 ? ?0x1
> +#define GPT_CTRL_PRESCALER4 ? ?0x2
> +#define GPT_CTRL_PRESCALER8 ? ?0x3
> +#define GPT_CTRL_PRESCALER16 ? 0x4
> +#define GPT_CTRL_PRESCALER32 ? 0x5
> +#define GPT_CTRL_PRESCALER64 ? 0x6
> +#define GPT_CTRL_PRESCALER128 ?0x7
> +#define GPT_CTRL_PRESCALER256 ?0x8
> +
> +/* INT Reg Bit Values */
> +#define GPT_STATUS_MATCH ? ? ? 0x0001
> +
> +/* clock sources */
> +#define SPEAR_TIMER_SRC_PLL3_CLK ? ? ? 0x00
> +#define SPEAR_TIMER_SRC_SYS_CLK ? ? ? ? ? ? ? ?0x01
> +
> +/**
> + * struct spear_timer - spear general purpose timer representation
> + * @id: timer identifier 0 onwards
> + * @phys_base: physical base address of timer
> + * @irq: irq to which this gpt is attached
> + * @prescaler: the prescaler for input freq at which timer is working
> + * @fclk: gpt functional clock
> + * @io_base: virtual base address of timer
> + * @reserved: indication that gpt is reserved now
> + * @enabled: indication that gpt is enabled
> + *
> + * The timer structure represent the timer channel available in SPEAr. Each
> + * timer unit in SPEAr contains two individual timer channels with different
> + * set of configuration registers * and irq. But the point to remember is
> + * this that the fclk is common for each channels withing a timer unit.
> + */
> +
> +struct spear_timer {
> + ? ? ? unsigned int id;
> + ? ? ? unsigned long phys_base;
> + ? ? ? int irq;
> + ? ? ? int prescaler;
> + ? ? ? struct clk *fclk;
> + ? ? ? void __iomem *io_base;
> + ? ? ? unsigned reserved:1;
> + ? ? ? unsigned enabled:1;
> +};
> +
> +/*
> + * Following functions are exported by gpt.c which can be used by other
> + * kernel entities
> + */
> +int spear_timer_init(struct spear_timer *, int);
> +
> +struct spear_timer *spear_timer_request(void);
> +struct spear_timer *spear_timer_request_specific(int id);
> +
> +int spear_timer_free(struct spear_timer *timer);
> +int spear_timer_enable(struct spear_timer *timer);
> +int spear_timer_disable(struct spear_timer *timer);
> +
> +int spear_timer_get_irq(struct spear_timer *timer);
> +
> +struct clk *spear_timer_get_fclk(struct spear_timer *timer);
> +
> +int spear_timer_start(struct spear_timer *timer);
> +int spear_timer_stop(struct spear_timer *timer);
> +
> +int spear_timer_set_source(struct spear_timer *timer, int source);
> +int spear_timer_set_load(struct spear_timer *timer, int autoreload,
> + ? ? ? ? ? ? ? u16 value);
> +int spear_timer_set_load_start(struct spear_timer *timer, int autoreload,
> + ? ? ? ? ? ? ? u16 value);
> +int spear_timer_match_irq(struct spear_timer *timer, int enable);
> +int spear_timer_set_prescaler(struct spear_timer *timer, int prescaler);
> +
> +int spear_timer_read_status(struct spear_timer *timer);
> +int spear_timer_clear_status(struct spear_timer *timer, u16 value);
> +
> +int spear_timer_read_counter(struct spear_timer *timer);
> +
> +int spear_timer_active(struct spear_timer *);

Am I right in assuming that this will only ever be used from the plat/timer.c
file?

I would contemplate moving away the abstraction API altogether and put
everything into timer.c, and just hardcode in the timers you're using as
clocksource and clock event, and put the register definitions and
offsets from base there as well. This will get down the number of files
and reduce the forest of files in a nice way.

If you have some other use of timers that you're planning, the API may
be justified, please detail the uses you have in mind in that case.

I know writing APIs is great fun, but sometimes it's easier to read the
code if you just get rid of them and keep things simple...

Yours,
Linus Walleij
