From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 04 Mar 2015 21:36:46 +0100
Subject: [PATCH v2 5/5] clocksource: sun5i: Add clock notifiers
In-Reply-To: <20150126143541.GG31568@lukather>
References: <1422265856-27631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422265856-27631-6-git-send-email-maxime.ripard@free-electrons.com>
 <54C62368.7050600@linaro.org> <20150126143541.GG31568@lukather>
Message-ID: <54F76CDE.1010602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2015 03:35 PM, Maxime Ripard wrote:
> Hi Daniel,
>
> On Mon, Jan 26, 2015 at 12:22:16PM +0100, Daniel Lezcano wrote:
>> On 01/26/2015 10:50 AM, Maxime Ripard wrote:
>>> The parent clock of the sun5i timer is the AHB clock, which rate might change
>>> because of other devices requirements.
>>>
>>> This is for example the case on the Allwinner A31, where the DMA controller
>>> needs a minimum rate higher than the default, that is enforced after the timer
>>> driver has probed.
>>>
>>> Add clock notifiers to make sure we reflect the clock rate changes in the timer
>>> rates.
>>
>> Mmh, I am wondering if that shouldn't go to the time framework ...
>>
>> Looking at the notifier callbacks that call generic time framework
>> functions.
>
> I don't think the framework currently has a clock handle so far?
>
>> Can you have a look at commit b3e90722 ? and double check your
>> changes ?
>
> I'm exactly in the opposite situation.
>
> The parent clock of this timer is *not* the CPU clock, and it might
> even be in a completely different clock tree.
>
> However, our DMA controller has the same parent clock than the timer,
> and it needs some frequency adjustement. Otherwise, DMA would just not
> work.
>
> So I'm completely fine with any rate change as far as the timer is
> concerned, the driver just need to be notified to be able to reflect
> this rate change.
>
>> A couple of comments below.
>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>   drivers/clocksource/timer-sun5i.c | 72 +++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 70 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
>>> index 377e50450781..5841a956f5f0 100644
>>> --- a/drivers/clocksource/timer-sun5i.c
>>> +++ b/drivers/clocksource/timer-sun5i.c
>>> @@ -41,9 +41,13 @@
>>>   struct sun5i_timer {
>>>   	void __iomem		*base;
>>>   	struct clk		*clk;
>>> +	struct notifier_block	clk_rate_cb;
>>>   	u32			ticks_per_jiffy;
>>>   };
>>>
>>> +#define to_sun5i_timer(x) \
>>> +	container_of(x, struct sun5i_timer, clk_rate_cb)
>>> +
>>>   struct sun5i_timer_clksrc {
>>>   	struct sun5i_timer	timer;
>>>   	struct clocksource	clksrc;
>>> @@ -152,6 +156,30 @@ static cycle_t sun5i_clksrc_read(struct clocksource *clksrc)
>>>   	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
>>>   }
>>>
>>> +static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
>>> +				unsigned long event, void *data)
>>> +{
>>> +	struct clk_notifier_data *ndata = data;
>>> +	struct sun5i_timer *timer = to_sun5i_timer(nb);
>>> +	struct sun5i_timer_clksrc *cs = container_of(timer,
>>> +						     struct sun5i_timer_clksrc, timer);
>>> +
>>> +	switch (event) {
>>> +	case PRE_RATE_CHANGE:
>>> +		clocksource_unregister(&cs->clksrc);
>>> +		break;
>>> +
>>> +	case POST_RATE_CHANGE:
>>> +		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
>>> +		break;
>>
>> Why clocksource_unregister couldn't be in the POST_RATE_CHANGE ?
>
> Wouldn't that leave a (small, I agree) window where the timer would
> run at a rate different to the one it has been registered with?

Mmh, yes, that's correct.

>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>>   static int __init sun5i_setup_clocksource(struct device_node *node,
>>>   					  void __iomem *base,
>>>   					  struct clk *clk, int irq)
>>> @@ -174,6 +202,14 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
>>>
>>>   	cs->timer.base = base;
>>>   	cs->timer.clk = clk;
>>> +	cs->timer.clk_rate_cb.notifier_call = sun5i_rate_cb_clksrc;
>>> +	cs->timer.clk_rate_cb.next = NULL;
>>> +
>>> +	ret = clk_notifier_register(clk, &cs->timer.clk_rate_cb);
>>> +	if (ret) {
>>> +		pr_err("Unable to register clock notifier.\n");
>>> +		goto err_disable_clk;
>>> +	}
>>>
>>>   	writel(~0, base + TIMER_INTVAL_LO_REG(1));
>>>   	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
>>> @@ -188,11 +224,13 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
>>>   	ret = clocksource_register_hz(&cs->clksrc, rate);
>>>   	if (ret) {
>>>   		pr_err("Couldn't register clock source.\n");
>>> -		goto err_disable_clk;
>>> +		goto err_remove_notifier;
>>>   	}
>>>
>>>   	return 0;
>>>
>>> +err_remove_notifier:
>>> +	clk_notifier_unregister(clk, &cs->timer.clk_rate_cb);
>>>   err_disable_clk:
>>>   	clk_disable_unprepare(clk);
>>>   err_free:
>>> @@ -200,6 +238,26 @@ err_free:
>>>   	return ret;
>>>   }
>>>
>>> +static int sun5i_rate_cb_clkevt(struct notifier_block *nb,
>>> +				unsigned long event, void *data)
>>> +{
>>> +	struct clk_notifier_data *ndata = data;
>>> +	struct sun5i_timer *timer = to_sun5i_timer(nb);
>>> +	struct sun5i_timer_clkevt *ce = container_of(timer,
>>> +						     struct sun5i_timer_clkevt, timer);
>>> +	unsigned long flags;
>>> +
>>> +	if (event == POST_RATE_CHANGE) {
>>> +		local_irq_save(flags);
>>> +		clockevents_update_freq(&ce->clkevt, ndata->new_rate);
>>> +		local_irq_restore(flags);
>>
>> local_irq_save and local_irq_restore are already in the
>> clockevents_update_freq function.
>
> Ok.
>
> Thanks!
> Maxime
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
