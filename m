From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 16 Dec 2013 14:43:12 +0200
Subject: [PATCH 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <52AA65EA.20902@codeaurora.org>
References: <1386784830-15863-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386784830-15863-2-git-send-email-ivan.khoronzhuk@ti.com>
 <52AA65EA.20902@codeaurora.org>
Message-ID: <52AEF560.9010603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2013 03:42 AM, Stephen Boyd wrote:
> On 12/11/13 10:00, Ivan Khoronzhuk wrote:
>> diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
>> new file mode 100644
>> index 0000000..4a8083a
>> --- /dev/null
>> +++ b/drivers/clocksource/timer-keystone.c
> [...]
>> +#include <linux/interrupt.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#define TIMER_NAME			"timer64-event"
> 
> Why not have keystone in the name? Or should this file be renamed?
> 

Ok, I'll rename on "timer-keystone"

>> +
>> +static inline u32 keystone_timer_readl(unsigned long rg)
>> +{
>> +	return readl(timer.base + rg);
>> +}
>> +
>> +static inline void keystone_timer_writel(u32 val, unsigned long rg)
>> +{
>> +	writel(val, timer.base + rg);
>> +}
> 
> It's probably better to use the relaxed variants here to avoid any
> memory barriers that aren't necessary.
>

Yes, but the code has places where I cannot use relaxed variants.

>From timer user guide:
"Writes from the configuration bus to the timer registers are not allowed
when the timer is active, except for stopping or resetting the timers.
Registers that are protected by hardware include CNTLO, CNTHI, PRDLO,
PRDHI, TGCR (except the TIMLORS and TIMHIRS bits), and TCR (except the
ENAMODE bits)."

According to this I have to add keystone readl/write relaxed functions
and use mixed calls of writel/writel_relaxed functions.

For instance, for keystone_timer_config() which is used by
keystone_set_next_event(), I will do following:
-----
tcr = keystone_timer_readl_relaxed(TCR);

/* disable timer */
tcr &= ~(TCR_ENAMODE_MASK);
keystone_timer_writel_relaxed(tcr, TCR);
...
/* reset counter to zero, set new period */
*** here I have to be sure the timer is disabled ***
keystone_timer_writel(0, TIM12);
keystone_timer_writel_relaxed(0, TIM34);
keystone_timer_writel_relaxed(period & 0xffffffff, PRD12);
keystone_timer_writel_relaxed(period >> 32, PRD34);

/* enable timer */
*** here I have to be sure that TIM and PRD registers are written ***
keystone_timer_writel(tcr, TCR);
---

The same for keystone_timer_init().

Will it be better?

>> +
>> +static irqreturn_t keystone_timer_interrupt(int irq, void *dev_id)
>> +{
>> +	struct clock_event_device *evt = &timer.event_dev;
>> +
>> +	evt->event_handler(evt);
>> +	return IRQ_HANDLED;
>> +}
> 
> Why not just pass the evt pointer via dev_id? That would be faster and
> we want this function to be as fast as possible.
> 

Ok, I will pass clock_event_device via dev_id.

>> +
>> +static int keystone_set_next_event(unsigned long cycles,
>> +				  struct clock_event_device *evt)
>> +{
>> +	return keystone_timer_config(cycles, evt->mode);
>> +}
>> +
>> +static void keystone_set_mode(enum clock_event_mode mode,
>> +			     struct clock_event_device *evt)
>> +{
>> +	u64 period;
>> +
>> +	switch (mode) {
>> +	case CLOCK_EVT_MODE_PERIODIC:
>> +		period = timer.clk_rate / (HZ);
> 
> Why not just store the period instead of calculating it here?
> 

Ok, I'll add timer.hz_period and delete timer.clk_rate.


>> +		keystone_timer_config(period, CLOCK_EVT_MODE_PERIODIC);
>> +		break;
>> +	case CLOCK_EVT_MODE_UNUSED:
>> +	case CLOCK_EVT_MODE_SHUTDOWN:
>> +	case CLOCK_EVT_MODE_ONESHOT:
>> +		keystone_timer_config(0, CLOCti,keystone-timerK_EVT_MODE_SHUTDOWN);
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>> +static void __init keystone_timer_init(struct device_node *np)
>> +{
> [...]
>> +
>> +	/* enable timer interrupts */
>> +	keystone_timer_writel(INTCTLSTAT_ENINT_MASK, INTCTLSTAT);
>> +
>> +	keystone_timer_config(0, CLOCK_EVT_MODE_UNUSED);
>> +
>> +	/* init irqaction */
>> +	irqaction->flags = IRQF_TIMER;
>> +	irqaction->handler = keystone_timer_interrupt;
>> +	irqaction->name = TIMER_NAME;
>> +	irqaction->dev_id = (void *)&timer;
>> +	error = setup_irq(irq, irqaction);
>> +	if (error) {
>> +		pr_err("%s: failed to setup irq\n", __func__);
>> +		goto err;
>> +	}
> 
> Why not use request_irq() here? This isn't called really early, is it?
> 

It is called at time_init(), that is after init_IRQ().
Additionally I've checked it. I'll replace.


>> +
>> +	/* setup clockevent */
>> +	event_dev->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> +	event_dev->set_next_event = keystone_set_next_event;
>> +	event_dev->set_mode = keystone_set_mode;
>> +	event_dev->cpumask = cpu_all_mask;
>> +	event_dev->owner = THIS_MODULE;
>> +	event_dev->name = TIMER_NAME;
> 
> Please assign the irq here too.
> 

Ok, event_dev->irq = irq;

>> +
>> +	clockevents_config_and_register(event_dev, rate, 1, ULONG_MAX);
>> +
>> +	pr_info("keystone timer clock @%lu Hz\n", rate);
>> +	return;
>> +err:
>> +	clk_put(clk);
>> +	iounmap(timer.base);
>> +}
>> +
>> +CLOCKSOURCE_OF_DECLARE(keystone_timer, "ti,keystone-timer",
>> +					keystone_timer_init);
> 
> 


-- 
Regards,
Ivan Khoronzhuk
