From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 26 Apr 2012 02:15:31 -0700 (PDT)
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120426083924.GE17184@pengutronix.de>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <20120426083924.GE17184@pengutronix.de>
Message-ID: <52d6cbc0369c91d6b1464ae17c76ff41.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, April 26, 2012 1:39 am, Sascha Hauer wrote:
> On Wed, Apr 25, 2012 at 10:58:56PM -0700, Saravana Kannan wrote:
>> Create a struct clk_init_data to hold all data that needs to be passed
>> from
>> the platfrom specific driver to the common clock framework during clock
>> registration. Add a pointer to this struct inside clk_hw.
>>
>> This has several advantages:
>> * Completely hides struct clk from many clock platform drivers and
>> static
>>   clock initialization code that don't care for static initialization of
>>   the struct clks.
>> * For platforms that want to do complete static initialization, it
>> removed
>>   the need to directly mess with the struct clk's fields while still
>>   allowing to statically allocate struct clk. This keeps the code more
>>   future proof even if they include clk-private.h.
>> * Simplifies the generic clk_register() function and allows adding
>> optional
>>   fields in the future without modifying the function signature.
>> * Simplifies the static initialization of clocks on all platforms by
>>   removing the need for forward delcarations or convoluted macros.
>
> Can we please stop messing with the function prototypes? So you prefer
> passing a struct to clk_register which is fine and yes, it may have
> advantages. But do we really need to change the prototype? Why can't we
> just add a new function?

I thought you were using functions that are specific to the clock type and
not the clk_register function. That's pretty much the only reason I left
in the other functions. I was trying to reduce the first level of churn
for people where had already started using the common clock framework.

> I am generally open to do these changes, but we have come to the point
> where people actually want to *use* the clock framework instead of
> rebasing their stuff onto the latest patches.

This is pretty early on in the life of the common clock framework. So, I
don't think this clean up is unjustified. Again, I left the other
functions as is because people might be using it.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
