From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 8 Dec 2010 13:58:17 +0800
Subject: [PATCH v3 06/15] ARM: mxs: Add timer support
In-Reply-To: <20101207211858.GD14775@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-5-git-send-email-shawn.guo@freescale.com>
	<20101207211858.GD14775@pengutronix.de>
Message-ID: <AANLkTimTqWorHFJOAzpcJU_Z1N9Aw=Pk63xZpRVR4_SV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Wed, Dec 08, 2010 at 12:31:56AM +0800, Shawn Guo wrote:
[...]
>> +static int timrotv2_set_next_event(unsigned long evt,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct clock_event_device *dev)
>> +{
>> + ? ? unsigned long match;
>> +
>> + ? ? /* timrot decrements the count */
>> + ? ? match = __raw_readl(timer_base + HW_TIMROT_RUNNING_COUNTn(0))
>> + ? ? ? ? ? ? ? ? ? ? - evt;
>> + ? ? __raw_writel(match, timer_base + HW_TIMROT_MATCH_COUNTn(0));
>> +
>> + ? ? return (int)(match - __raw_readl(timer_base +
>> + ? ? ? ? ? ? ? ? ? ? HW_TIMROT_RUNNING_COUNTn(0))) > 0 ? -ETIME : 0;
> Wouldn't it be easier to use the same approach as in timrotv1? ?(i.e.
> use two timers and then having a simpler set_next_event.)
>
Using two timrotv1 timers is not to make code look simpler. Instead,
we have to use two, because timrotv1 has no match function.  One most
significant improvement of v2 over v1 is adding match function, so
that one v2 timer can serve clock_event and clocksource without
problem.  I would keep the implementation to utilize v2 capability,
save timer resource and show the difference between v1 and v2.

>> +}
>> +
>> +static irqreturn_t mxs_timer_interrupt(int irq, void *dev_id)
>> +{
>> + ? ? struct clock_event_device *evt = &clockevent_mxs;
> I assume dev_id is &clockevent_mxs
>
The assumption is only true if we assign &clockevent_mxs to dev_id.
So you want to see the following change?

 static irqreturn_t mxs_timer_interrupt(int irq, void *dev_id)
 {
-       struct clock_event_device *evt = &clockevent_mxs;
+       struct clock_event_device *evt = dev_id;

        timrot_irq_acknowledge();
        evt->event_handler(evt);

 static struct irqaction mxs_timer_irq = {
        .name           = "MXS Timer Tick",
+       .dev_id         = &clockevent_mxs,
        .flags          = IRQF_TIMER | IRQF_IRQPOLL,
        .handler        = mxs_timer_interrupt,
 };


-- 
Regards,
Shawn
