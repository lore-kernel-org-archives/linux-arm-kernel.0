From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 02 Feb 2016 14:06:59 +0000
Subject: [PATCH v2 02/10] clockevents/drivers: add MPS2 Timer driver
In-Reply-To: <alpine.DEB.2.11.1602021351440.25254@nanos>
References: <1454413199-26573-1-git-send-email-vladimir.murzin@arm.com>
 <1454413199-26573-3-git-send-email-vladimir.murzin@arm.com>
 <alpine.DEB.2.11.1602021351440.25254@nanos>
Message-ID: <56B0B803.8010003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/16 13:04, Thomas Gleixner wrote:
> On Tue, 2 Feb 2016, Vladimir Murzin wrote:
>> +static int __init mps2_clockevent_init(struct device_node *np)
>> +{
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	struct clockevent_mps2 *ce;
>> +	u32 rate;
>> +	int irq, ret;
>> +	const char *name = "mps2-clkevt";
>> +
>> +	ret = of_property_read_u32(np, "clock-frequency", &rate);
>> +	if (ret) {
>> +		clk = of_clk_get(np, 0);
>> +		if (IS_ERR(clk)) {
>> +			ret = PTR_ERR(clk);
>> +			pr_err("failed to get clock for clockevent: %d\n", ret);
>> +			goto err_clk_get;
>> +		}
>> +
>> +		ret = clk_prepare_enable(clk);
>> +		if (ret) {
>> +			pr_err("failed to enable clock for clockevent: %d\n", ret);
>> +			clk_put(clk);
>> +			goto err_clk_enable;
>> +		}
>> +
>> +		rate = clk_get_rate(clk);
>> +	}
> 
> So in case that "clock-frequency" is available in DT, what enables and
> configures the clock?

They are fixed-clock, so I ended up this *cough* mess *cough* shortcut.
I'd be glad if you share your thoughts what is preferred way to cope
with it (is it worth to do at all?)

> 
>> +err_ia_alloc:
>> +	kfree(ce);
>> +err_ce_alloc:
>> +err_get_irq:
>> +	iounmap(base);
>> +err_iomap:
>> +	clk_disable_unprepare(clk);
> 
> clk is not initialized when "clock-frequency" is available in DT. The compiler
> should have told you ....

Shame on me, I've completely messed it up :( Thanks for pointing at it,
I'll fix this an other places you pointed at...

> 
>> +err_clk_enable:
>> +	clk_put(clk);
> 
> Put without get ....

or double clk_put() if clk_prepare_enable() failed... shame, shame, shame

> 
>> +static int __init mps2_clocksource_init(struct device_node *np)
>> +{
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	u32 rate;
>> +	int ret;
>> +	const char *name = "mps2-clksrc";
>> +
>> +	ret = of_property_read_u32(np, "clock-frequency", &rate);
>> +	if (ret) {
>> +		clk = of_clk_get(np, 0);
>> +		if (IS_ERR(clk)) {
>> +			ret = PTR_ERR(clk);
>> +			pr_err("failed to get clock for clocksource: %d\n", ret);
>> +			goto err_clk_get;
>> +		}
>> +
>> +		ret = clk_prepare_enable(clk);
>> +		if (ret) {
>> +			pr_err("failed to enable clock for clocksource: %d\n", ret);
>> +			clk_put(clk);
>> +			goto err_clk_enable;
>> +		}
>> +
>> +		rate = clk_get_rate(clk);
>> +	}
> 
> Same problem as above.
> 
>> +err_clocksource_init:
>> +	iounmap(base);
>> +err_iomap:
>> +	clk_disable_unprepare(clk);
> 
> Ditto.
> 
>> +err_clk_enable:
>> +	clk_put(clk);
> 
> Ditto.
> 
>> +err_clk_get:
>> +	return ret;
>> +}
>> +
>> +static void __init mps2_timer_init(struct device_node *np)
>> +{
>> +	static int has_clocksource, has_clockevent;
>> +	int ret;
>> +
>> +	if (!has_clocksource) {
>> +		ret = mps2_clocksource_init(np);
>> +		if (!ret) {
>> +			has_clocksource = 1;
>> +			return;
>> +		}
>> +	}
>> +
>> +	if (!has_clockevent) {
>> +		ret = mps2_clockevent_init(np);
>> +		if (!ret) {
>> +			has_clockevent = 1;
>> +			return;
>> +		}
>> +	}
> 
> You take randomly the first timer as clocksource and the second one as
> clockevent. If clocksource init fails, you try to install it as clockevent.
> 
> Sorry, but I really cannot follow the logic here.
> 

It has been done as a response on Daniel's comment [1]. I'm quite happy
to get known what init sequence is expected here.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/388223.html

Thanks for your time, Thomas!

Vladimir

> Thanks,
> 
> 	tglx
> 
> 
> 
