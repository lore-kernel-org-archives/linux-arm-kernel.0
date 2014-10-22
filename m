From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 12:22:23 -0300
Subject: [PATCH 3/4] clocksource: armada-370-xp: Use the reference clock
 on A375 SoC
In-Reply-To: <20141022155410.0cc36e4c@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>	<1413984884-20273-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022155410.0cc36e4c@free-electrons.com>
Message-ID: <5447CBAF.2000602@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 10:54 AM, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Wed, 22 Oct 2014 10:34:43 -0300, Ezequiel Garcia wrote:
> 
>> +static void __init armada_375_timer_init(struct device_node *np)
>> +{
>> +	struct clk *clk;
>> +
>> +	clk = of_clk_get_by_name(np, "fixed");
>> +	if (!IS_ERR(clk)) {
>> +		clk_prepare_enable(clk);
>> +		timer_clk = clk_get_rate(clk);
>> +	} else {
>> +
>> +		/*
>> +		 * This fallback is required in order to retain proper
>> +		 * devicetree backwards compatibility.
>> +		 */
>> +		clk = of_clk_get(np, 0);
>> +
>> +		/* Must have at least a clock */
>> +		BUG_ON(IS_ERR(clk));
>> +		clk_prepare_enable(clk);
>> +		timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
>> +		timer25Mhz = false;
>> +	}
> 
> Maybe we could re-use a bit more existing code, don't know if it makes
> things clearer though:
> 
> 	clk = of_clk_get_by_name(np, "fixed");
> 	if (!IS_ERR(clk))
> 		armada_xp_timer_init(np);
> 	else
> 		armada_370_timer_init(np);
> 

Yeah, I thought about this option, but chosen to implement it explicitly.

The reason is that I wanted to make sure we had a sane backward
compatibility fallback, which is specifically crafted for A375.

By re-using the 370 and XP, we are exposed to someone changing the
armada_xp_timer_init() thinking it will only affect AXP, which might
break things for A375.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
