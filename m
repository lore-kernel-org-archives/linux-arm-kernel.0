From: slash.tmp@free.fr (Mason)
Date: Fri, 5 Feb 2016 17:01:57 +0100
Subject: Common/typical fractional divider HW API
In-Reply-To: <1454684758.31169.77.camel@linux.intel.com>
References: <56B4B67D.2080707@free.fr>
 <1454684758.31169.77.camel@linux.intel.com>
Message-ID: <56B4C775.50808@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2016 16:05, Andy Shevchenko wrote:

> On Fri, 2016-02-05 at 15:49 +0100, Mason wrote:
>
>> AFAICT, the clk-fractional-divider driver implements the following
>> hardware API:
>>
>>   M and N are two fields in the same register.
>>   DIV = M / N
>>
>> Is this HW API common/typical in the embedded world?
>> in the PC world?
> 
> At least all new Intel SoCs have it, besides that there is one more
> user of the struct clk_fractional_divider, but I have no idea if they
> have something similar to this.
> 
>> My hardware uses a slightly weird (to me) API:
>>
>>   I = 0-255 (8 bits)
>>   F = 0-15  (4 bits)
> 
> This part is okay.
> 
>>   I = 0 => DIV = +INF
> 
> On Intel we recognize this as an absence of the divider.
> 
>>   I = 1 => DIV = 1 + F/(32-F)
> 
> Weird part, indeed. But seems it doubles a precision in a range
> [1 .. 1 + 1/2]
> 
>>   I > 1 => DIV = I + F/16
> 
> This just normal operation.
> 
>> Is this HW API common/typical in the embedded world?
>> (Perhaps just the linear part for I > 1)
> 
> I saw similar approach in few UART drivers, but they do not use CLK
> framework.
> 
> So, I could consider this one is more popular / wider, than what we
> have in Intel SoCs.
> 
>> I see two downsides to this API:
>>
>> 1) I = 1 is a special case
>> 
>> 2) A lot of the value space is wasted on large values.
>>
>> For example, when I = 250, we don't really care about 250.0625,
>> 250.125,
>> etc, or even nearby integer values, for that matter.
>>
>> I think it's better to have a distribution with high density in small
>> values, and low density in high values (sort of like floating point).
>>
>> For example:
>>
>>   I = 0-15  (4 bits)
>>   F = 0-255 (8 bits)
>>   DIV = 2^I * (1 + F/256)
>>
>> (We could probably even shave 2-4 bits on F.)
>>
>> Are there downsides to this HW API?
>> Is this HW API common/typical in the embedded world?
> 
> So, what is your intention? If you would like to use CLK framework you
> might consider existing providers and users and might implement a
> specific one for similar cases.

Right now, I'm using the clk-divider driver (integer divider).
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-tango4.c

I was trying to avoid writing any code, but it looks like I would
need a specific driver if I want to support the hardware's fractional
divider logic.

Once I started looking at the HW API, I was thinking that it
could be improved (and perhaps the HW engineers would agree
to make the change) but I wanted to get feedback from seasoned
devs with respect to the proposed HW API.

So, do you agree that

  DIV = 2^I * (1 + F/256)

gives a more useful DIV distribution than

  DIV = I + F/16

> Also it's possible to convert clock providers for, e.g., UARTs to use
> this kind of divider.

I'm not sure how to parse that. I'm using the divider driver
for a CPU clock, to do D(V)FS in cpufreq.

Regards.
