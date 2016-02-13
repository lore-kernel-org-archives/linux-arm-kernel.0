From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 13 Feb 2016 14:06:19 +0100
Subject: [PATCH v2 1/3] clocksource/drivers/lpc32xx: Don't use the
 prescaler counter for clockevents
In-Reply-To: <1455069267-4784-2-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1455069267-4784-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1455069267-4784-2-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <CAGhQ9VwuUK5Fx12L6oi1DCC_zx1BA-6vPTwG0HpfkinEoUpOig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 10 February 2016 at 02:54, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> This commit switches the clockevents one-shot current implementation
> to avoid using the prescaler counter. The clockevents timer currently
> uses MR0=1, PR=ticks; and after this commit is uses MR0=ticks, PR=0.
>
> While using the prescaler with PR=1 works fine in one-shot mode,
> it seems it doesn't work as expected in periodic mode.
>
> By using the only match channel register (MR0) for the timer we make
> the periodic mode introduction easier, and consistent with one-shot mode.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  drivers/clocksource/time-lpc32xx.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
> index 1316876b487a..50d1a63cbe1e 100644
> --- a/drivers/clocksource/time-lpc32xx.c
> +++ b/drivers/clocksource/time-lpc32xx.c
> @@ -60,14 +60,13 @@ static int lpc32xx_clkevt_next_event(unsigned long delta,
>                 container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
>
>         /*
> -        * Place timer in reset and program the delta in the prescale
> -        * register (PR). When the prescale counter matches the value
> -        * in PR the counter register is incremented and the compare
> -        * match will trigger. After setup the timer is released from
> -        * reset and enabled.
> +        * Place timer in reset and program the delta in the match
> +        * channel 0 (MR0). When the timer counter matches the value
> +        * in MR0 register the match will trigger an interrupt.
> +        * After setup the timer is released from reset and enabled.
>          */
>         writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
> -       writel_relaxed(delta, ddata->base + LPC32XX_TIMER_PR);
> +       writel_relaxed(delta, ddata->base + LPC32XX_TIMER_MR0);
>         writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
>
>         return 0;
> @@ -210,13 +209,13 @@ static int __init lpc32xx_clockevent_init(struct device_node *np)
>
>         /*
>          * Disable timer and clear any pending interrupt (IR) on match
> -        * channel 0 (MR0). Configure a compare match value of 1 on MR0
> -        * and enable interrupt, reset on match and stop on match (MCR).
> +        * channel 0 (MR0). Clear the prescaler as it's not used.
> +        * Enable interrupt, reset on match and stop on match (MCR).
>          */
>         writel_relaxed(0, base + LPC32XX_TIMER_TCR);
> +       writel_relaxed(0, base + LPC32XX_TIMER_PR);
>         writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
>         writel_relaxed(LPC32XX_TIMER_IR_MR0INT, base + LPC32XX_TIMER_IR);
> -       writel_relaxed(1, base + LPC32XX_TIMER_MR0);
>         writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
>                        LPC32XX_TIMER_MCR_MR0S, base + LPC32XX_TIMER_MCR);
>
> --

There were fewer changes need to switch to MR0 than I thought. Good.

Reviewed-by: Joachim Eastwood <manabian@gmail.com>
Tested-by: Joachim Eastwood <manabian@gmail.com>

Boot tested on EA4357.


regards,
Joachim Eastwood
