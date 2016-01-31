From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sun, 31 Jan 2016 17:07:06 -0300
Subject: [PATCH 1/2] clocksource/drivers/lpc32xx: Support periodic mode
In-Reply-To: <CAGhQ9VxO7Rsus8Js_oZDBxWzEHuUHnRyoVTVmawbtXmK7tNMcw@mail.gmail.com>
References: <1454136379-7517-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGhQ9VxO7Rsus8Js_oZDBxWzEHuUHnRyoVTVmawbtXmK7tNMcw@mail.gmail.com>
Message-ID: <CAAEAJfAVTJm-PzhjkRmkdNG39sH7eHyEXaSX4q0=TCQ0468Heg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 January 2016 at 16:39, Joachim  Eastwood <manabian@gmail.com> wrote:
> Hi Ezequiel,
>
> On 30 January 2016 at 07:46, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>> This commit adds the support for periodic mode. This is done by not
>> setting the MR0S (Stop on TnMR0) bit on MCR, thus allowing
>> interrupts to be periodically generated on MR0 matches.
>>
>> In order to do this, move the initial configuration that is specific to
>> the one shot mode to clock_event_device.set_state_oneshot.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> ---
>>  drivers/clocksource/time-lpc32xx.c | 48 ++++++++++++++++++++++++++++++++------
>>  1 file changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
>> index 1316876b487a..9b3d4a38c716 100644
>> --- a/drivers/clocksource/time-lpc32xx.c
>> +++ b/drivers/clocksource/time-lpc32xx.c
>> @@ -47,6 +47,8 @@ struct lpc32xx_clock_event_ddata {
>>
>>  /* Needed for the sched clock */
>>  static void __iomem *clocksource_timer_counter;
>> +/* Needed for clockevents periodic mode */
>> +static u32 ticks_per_jiffy;
>
> Could you avoid this global variable by sticking it to the
> lpc32xx_clock_event_ddata struct?
>

Sure.

>
>>  static u64 notrace lpc32xx_read_sched_clock(void)
>>  {
>> @@ -86,11 +88,42 @@ static int lpc32xx_clkevt_shutdown(struct clock_event_device *evtdev)
>>
>>  static int lpc32xx_clkevt_oneshot(struct clock_event_device *evtdev)
>>  {
>> +       struct lpc32xx_clock_event_ddata *ddata =
>> +               container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
>> +
>>         /*
>>          * When using oneshot, we must also disable the timer
>>          * to wait for the first call to set_next_event().
>>          */
>> -       return lpc32xx_clkevt_shutdown(evtdev);
>> +       writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
>> +
>> +       /* Enable interrupt, reset on match and stop on match (MCR). */
>> +       writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
>> +                      LPC32XX_TIMER_MCR_MR0S, ddata->base + LPC32XX_TIMER_MCR);
>> +       /* Configure a compare match value of 1 on MR0. */
>> +       writel_relaxed(1, ddata->base + LPC32XX_TIMER_MR0);
>> +
>> +       return 0;
>> +}
>> +
>> +static int lpc32xx_clkevt_periodic(struct clock_event_device *evtdev)
>> +{
>> +       struct lpc32xx_clock_event_ddata *ddata =
>> +               container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
>> +
>> +       /* Enable interrupt and reset on match. */
>> +       writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R,
>> +                      ddata->base + LPC32XX_TIMER_MCR);
>> +       /*
>> +        * Place timer in reset and set a match value on MR0. An interrupt will
>> +        * be generated each time the counter matches MR0. After setup the
>> +        * timer is released from reset and enabled.
>> +        */
>> +       writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
>> +       writel_relaxed(ticks_per_jiffy, ddata->base + LPC32XX_TIMER_MR0);
>> +       writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
>> +
>> +       return 0;
>>  }
>>
>>  static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
>> @@ -108,11 +141,14 @@ static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
>>  static struct lpc32xx_clock_event_ddata lpc32xx_clk_event_ddata = {
>>         .evtdev = {
>>                 .name                   = "lpc3220 clockevent",
>> -               .features               = CLOCK_EVT_FEAT_ONESHOT,
>> +               .features               = CLOCK_EVT_FEAT_ONESHOT |
>> +                                         CLOCK_EVT_FEAT_PERIODIC,
>>                 .rating                 = 300,
>>                 .set_next_event         = lpc32xx_clkevt_next_event,
>>                 .set_state_shutdown     = lpc32xx_clkevt_shutdown,
>>                 .set_state_oneshot      = lpc32xx_clkevt_oneshot,
>> +               .set_state_periodic     = lpc32xx_clkevt_periodic,
>> +               .tick_resume            = lpc32xx_clkevt_shutdown,
>>         },
>>  };
>>
>> @@ -210,17 +246,15 @@ static int __init lpc32xx_clockevent_init(struct device_node *np)
>>
>>         /*
>>          * Disable timer and clear any pending interrupt (IR) on match
>> -        * channel 0 (MR0). Configure a compare match value of 1 on MR0
>> -        * and enable interrupt, reset on match and stop on match (MCR).
>> +        * channel 0 (MR0). Enable interrupt, reset on match and stop
>> +        * on match (MCR).
>>          */
>>         writel_relaxed(0, base + LPC32XX_TIMER_TCR);
>>         writel_relaxed(0, base + LPC32XX_TIMER_CTCR);
>>         writel_relaxed(LPC32XX_TIMER_IR_MR0INT, base + LPC32XX_TIMER_IR);
>> -       writel_relaxed(1, base + LPC32XX_TIMER_MR0);
>> -       writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
>> -                      LPC32XX_TIMER_MCR_MR0S, base + LPC32XX_TIMER_MCR);
>>
>>         rate = clk_get_rate(clk);
>> +       ticks_per_jiffy = (rate + HZ/2) / HZ;
>
> Use a rounding macro?
>

Done.

>
> I will look more closely at the new timer setup later.
>
> btw, didn't I look through a version of this you sent me privately
> quite some time ago?
> I think I had a comment about using TIMER_PR instead of TIMER_MR0
> then. Unsure if that is still valid, though.
>

Ah, right. It was ages ago, and forgot your previous review. Sorry about that.
Using TIMER_PR looks less invasive so I'll send a v2 using it instead.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
