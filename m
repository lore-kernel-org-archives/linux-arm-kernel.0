From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 03 Aug 2015 10:55:29 -0700
Subject: [PATCH 1/3] clk: versatile: Switch to assigned clock parents
In-Reply-To: <1438610480.2142.14.camel@arm.com>
References: <55BBB2FC.9030102@codeaurora.org>
 <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
 <1438386285-5070-2-git-send-email-sboyd@codeaurora.org>
 <1438610480.2142.14.camel@arm.com>
Message-ID: <55BFAB11.7080600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2015 07:01 AM, Pawel Moll wrote:
> On Sat, 2015-08-01 at 00:44 +0100, Stephen Boyd wrote:
>> @@ -179,6 +124,15 @@ static void __init clk_sp810_of_setup(struct device_node *node)
>>   		sp810->timerclken[i].channel = i;
>>   		sp810->timerclken[i].hw.init = &init;
>>   
>> +		/*
>> +		 * If DT isn't setting the parent, force it to be
>> +		 * the 1 MHz clock without going through the framework.
>> +		 * We do this before clk_register() so that it can determine
>> +		 * the parent and setup the tree properly.
>> +		 */
>> +		if (deprecated)
>> +			init.ops->set_parent(&sp810->timerclken[i].hw, 1);
>> +
>>   		sp810->timerclken[i].clk = clk_register(NULL,
>>   				&sp810->timerclken[i].hw);
>>   		WARN_ON(IS_ERR(sp810->timerclken[i].clk));
> So that's one thing I've got a (small) problem here...
>
> The above change assumes that SP810 always have 32kHz clock on input 0
> and 1MHz clock on input 1. Yes, this is how it made on VExpress, but it
> doesn't have to be the case. The magic picking up the faster clock was
> added to handle all possible cases.
>
> The bottom line is: if all we care is VExpress than it works, but it's
> still a hack. Personally I don't like it, however I won't nak the patch
> because of this.
>

All current dts files in the kernel tree have 1MHz on input 1, so we 
make this change here to set the parent to input 1 if there isn't an 
assigned-clock-parents property. Presumably new dts files should have 
the new property so that things work properly. I tried to find the 
binding document, but it doesn't look to exist, so I didn't have 
anything to update.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
