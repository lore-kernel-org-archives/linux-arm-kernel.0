From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 03 May 2012 18:11:56 -0700
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120503230308.GA13016@glitch>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <20120503230308.GA13016@glitch>
Message-ID: <4FA32CDC.3070005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2012 04:03 PM, Domenico Andreoli wrote:
> On Wed, Apr 25, 2012 at 10:58:56PM -0700, Saravana Kannan wrote:
>>
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index 90627e4..8ea11b4 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -167,6 +167,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>>   {
>>   	struct clk_divider *div;
>>   	struct clk *clk;
>> +	struct clk_init_data init;
>>
>>   	/* allocate the divider */
>>   	div = kzalloc(sizeof(struct clk_divider), GFP_KERNEL);
>> @@ -175,19 +176,22 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>>   		return ERR_PTR(-ENOMEM);
>>   	}
>>
>> +	init.name = name;
>> +	init.ops =&clk_divider_ops;
>> +	init.flags = flags;
>> +	init.parent_names = (parent_name ?&parent_name: NULL);
>> +	init.num_parents = (parent_name ? 1 : 0);
>> +
>>   	/* struct clk_divider assignments */
>>   	div->reg = reg;
>>   	div->shift = shift;
>>   	div->width = width;
>>   	div->flags = clk_divider_flags;
>>   	div->lock = lock;
>> +	div->hw.init =&init;
>>
>>   	/* register the clock */
>> -	clk = clk_register(dev, name,
>> -			&clk_divider_ops,&div->hw,
>> -			(parent_name ?&parent_name: NULL),
>> -			(parent_name ? 1 : 0),
>> -			flags);
>> +	clk = clk_register(dev,&div->hw);
>>
>>   	if (IS_ERR(clk))
>>   		kfree(div);
>
> I would prefer to rip the parent _settings_ configuration out of
> clk_register(). It's optional right? And passing a single parent is a
> common case.
>
> Three cases:
>
>    1) one parent:
>       __clk_register_parent(clk, parent_name);
>       clk_register(dev, name,&ops, flags);
>
>    2) many parents:
>       __clk_register_parents(clk, parent_names, num_parents);
>       clk_register(dev, name,&ops, flags);
>
>    3) no parents:
>       clk_register(dev, name,&ops, flags);
>
> You may also want to move the whole parent initialization into
> __clk_register_parents() and call it after clk_register(), it would
> simplify some error paths.
>
> This pattern could be used also with other common clocks registration
> functions (fixed rate, divider, mux, etc) that may have complex
> initializations and/or optional parameters that cannot go all on the
> same function call.

Please no. If anything, make those other register functions go in the 
direction of clk_register(). Have a long list of params to a function 
and then having it fill up a structure just makes the code less 
readable. Why would that be any better than having the whole structure 
statically declared or the whole structure dynamically populated (by 
device tree) and then calling clk_register()?

Take about 50 clocks with 3 parents each and try to register them in the 
way you suggested and in a way how clk_register() in this patch will 
need you to declare them statically. Compare the two and see which would 
be more readable.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
