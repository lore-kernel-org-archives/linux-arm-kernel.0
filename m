From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 12:53:14 +0200
Subject: [RFC PATCHv4 4/6] clocksource: TI-Nspire timer support
In-Reply-To: <1369480087-24786-5-git-send-email-dt.tangr@gmail.com>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <1369480087-24786-5-git-send-email-dt.tangr@gmail.com>
Message-ID: <CACRpkda4Qe1e+dkcSgPLf5dcHASvOG=Y=Dvrnv=oGnon+FRzzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 1:08 PM, Daniel Tang <dt.tangr@gmail.com> wrote:

> Add clocksource and clockevent driver for the TI-Nspire.
>
> Signed-off-by: Daniel Tang <dt.tangr@gmail.com>

This is *much* improved :-D

But:

> +++ b/drivers/clocksource/zevio-timer.c

> +static void zevio_timer_set_mode(enum clock_event_mode mode,
> +               struct clock_event_device *dev)
> +{
> +       unsigned long flags;
> +       struct zevio_timer *timer = container_of(dev,
> +                       struct zevio_timer,
> +                       clkevt);
> +
> +       local_irq_save(flags);
> +
> +       switch (mode) {
> +       case CLOCK_EVT_MODE_PERIODIC:
> +               /* Unsupported */
> +               break;
> +       case CLOCK_EVT_MODE_RESUME:
> +       case CLOCK_EVT_MODE_ONESHOT:
> +               /* Enable timer interrupts */
> +               writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_MSK);
> +               writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
> +               dev->mode = mode;
> +               break;
> +       case CLOCK_EVT_MODE_SHUTDOWN:
> +       case CLOCK_EVT_MODE_UNUSED:
> +               /* Disable timer interrupts */
> +               writel(0, timer->interrupt_regs + IO_INTR_MSK);
> +               writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
> +               /* Stop timer */
> +               writel(CNTL_STOP_TIMER, timer->timer1 + IO_CONTROL);
> +               dev->mode = mode;
> +               break;
> +       }

Surely both the compiler and checkpatch is complaining that this
switch does not contain a default: clause?

If you fix this you can add my:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
