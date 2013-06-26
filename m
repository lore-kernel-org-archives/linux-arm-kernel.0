From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Jun 2013 21:15:54 +0200
Subject: [PATCH v2] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1372258383-24524-1-git-send-email-jonas.jensen@gmail.com>
References: <1371549604-7201-1-git-send-email-jonas.jensen@gmail.com>
 <1372258383-24524-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CACRpkdZdmC=ur0FFxoDXAMzieutp2w4HXBDbgbeoSeVXeCgp9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 4:53 PM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> This patch adds an clocksource driver for the main timer(s)
> found on MOXA ART SoCs.
>
> Changes since v2:
>
> 1. use clocksource/clockevents infrastructures
> 2. clock frequency read from system clock
>
> Applies to next-20130619
>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

This is starting to look good :-)

> +/* TIMER_CR flags:
> +   TIMEREG_CR_1_CLOCK  0: PCLK, 1: EXT1CLK
> +   TIMEREG_CR_1_INT    over flow interrupt enable bit */

/*
 * Usually we use this comment style, one star at the beginning
 * of every comment line and a closing star-slash sitting lonley
 * on a single line to close it.
 */

> +       case CLOCK_EVT_MODE_RESUME:
> +       case CLOCK_EVT_MODE_ONESHOT:
> +               u |= TIMEREG_CR_1_ENABLE;
> +               writel(u, timer_base + TIMER_CR);
> +               writel(~0, timer_base + TIMER1_LOAD);

Should you not write the load value *before* enabling the timer?

> +               pr_debug("%s: CLOCK_EVT_MODE_ONESHOT\n", __func__);
> +               break;

This looks like you're enabling a tick far ahead in the future.
For oneshot you should just trigger new events in .next_event(),
I would just disable the timer for oneshot and enable it
for each new event in .next_event() instead.

> +       case CLOCK_EVT_MODE_PERIODIC:
> +               u |= TIMEREG_CR_1_ENABLE;
> +               writel(u, timer_base + TIMER_CR);
> +               writel(clock_frequency / HZ, timer_base + TIMER1_LOAD);

Use DIV_ROUND_CLOSEST(clock_frequency, HZ)

> +               pr_debug("%s: CLOCK_EVT_MODE_PERIODIC\n", __func__);
> +               break;
> +       case CLOCK_EVT_MODE_UNUSED:
> +       case CLOCK_EVT_MODE_SHUTDOWN:
> +       default:
> +               u &= ~TIMEREG_CR_1_ENABLE;

I would do this also for Oneshot. Then enable it in
.next_event().

> +               writel(u, timer_base + TIMER_CR);
> +               break;


> +static int moxart_clkevt_next_event(unsigned long cycles,
> +       struct clock_event_device *unused)
> +{
> +       u32 alarm = readl(timer_base + TIMER1_COUNT) - cycles;
> +       writel(alarm, timer_base + TIMER1_MATCH1);

I would write TIMEREG_CR_1_ENABLE *here*. This way the
timer is only strictly triggered when an event is queued.

> +static struct irqaction moxart_timer_irq = {
> +       .name = "moxart-timer",
> +       .flags = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,

IRQF_DISABLED is pointless, remove it. Nowadays all IRQ handlers
are called with interrupts disabled.

Why do you need IRQF_IRQPOLL? That seems like more
copy/paste luggade.

> +       clock_frequency = APB_CLK;
> +       /* it might be a good idea to have a default other than 0 for
> +          clock_frequency, should any attempt at getting a valid
> +          frequency fail, not that i see how it could, it probably could..
> +          having it APB_CLK can certainly be wrong on some hardware,
> +          why it is set again with the DT specific property: */

Seems overkill.

> +       ret = of_property_read_u32(node, "clock-frequency", &clock_frequency);
> +       if (ret)
> +               pr_err("%s: can't read clock-frequency DT property\n",
> +                       node->full_name);

I don't think it's apropriate to put clock frequencies into the device
tree node as u32:s. Please use the clock framework exclusively.
Now it's like three ways to get this frequency... what if all three
are different :-P

> +       clk = of_clk_get(node, 0);
> +       if (IS_ERR(clk))
> +               pr_err("%s: of_clk_get failed\n", __func__);

bail out here?

> +       else {
> +               clock_frequency = clk_get_rate(clk);
> +               pr_debug("%s: clk_get_rate=%u success\n", __func__,
> +                       clock_frequency);
> +       }

Then you can  remove the else clause and de-indent this.

The rest looks OK...

Yours,
Linus Walleij
