From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 07 May 2014 19:12:30 +0200
Subject: [PATCH 5/7] clk: sunxi: add PRCM (Power/Reset/Clock Management)
 clks support
In-Reply-To: <20140428234039.GT3134@lukather>
References: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
 <1398697130-8338-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140428234039.GT3134@lukather>
Message-ID: <536A697E.5000107@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 29/04/2014 01:40, Maxime Ripard wrote:
> On Mon, Apr 28, 2014 at 04:58:48PM +0200, Boris BREZILLON wrote:
>> The PRCM (Power/Reset/Clock Management) unit provides several clock
>> devices:
>> - AR100 clk: used to clock the Power Management co-processor
>> - AHB0 clk: used to clock the AHB0 bus
>> - APB0 clk and gates: used to clk
> Used to clk?
"Used to clk peripherals connected on the APB0 bus"

I'll add the missing words in the next version :-).

>
[...]
> Ditto.
>
> And you'll probably want to use devm_ioremap_resource when you'll have
> a single clock for the AR100.

Absolutely.

>
>> +
>> +	clk_parent = of_clk_get_parent_name(np, 0);
>> +	if (!clk_parent)
>> +		return -EINVAL;
[...]
>> +
>> +static struct platform_driver sun6i_a31_prcm_clk_driver = {
>> +	.driver = {
>> +		.name = "sun6i-a31-prcm-clk",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = sun6i_a31_prcm_clk_dt_ids,
>> +	},
>> +	.probe = sun6i_a31_prcm_clk_probe,
> You're not calling the of_clk_del_provider, and you should probably
> unregister your clocks too.

This driver cannot be compiled as a module, and as a result the probed
clks will never be removed.

Do you really want to support clk removal for this HW block ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
