From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun, 02 Sep 2012 19:21:53 +0200
Subject: [PATCH 3/8] i2c: at91: use an id table for SoC dependent
 parameters
In-Reply-To: <20120901091054.GA17540@game.jcrosoft.org>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346404884-18451-4-git-send-email-ludovic.desroches@atmel.com>
 <20120831142944.GA23867@game.jcrosoft.org> <5040CF80.8060201@atmel.com>
 <504122D3.70507@gmail.com> <20120901091054.GA17540@game.jcrosoft.org>
Message-ID: <504395B1.2040203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2012 11:10 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:47 Fri 31 Aug     , Sylwester Nawrocki wrote:
>> On 08/31/2012 04:51 PM, Nicolas Ferre wrote:
>>>>> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
>>>>> index f2112f9..0bc91e5 100644
>>>>> --- a/arch/arm/mach-at91/at91rm9200.c
>>>>> +++ b/arch/arm/mach-at91/at91rm9200.c
>>>>> @@ -187,7 +187,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>>>>>    	CLKDEV_CON_DEV_ID("pclk", "ssc.0",&ssc0_clk),
>>>>>    	CLKDEV_CON_DEV_ID("pclk", "ssc.1",&ssc1_clk),
>>>>>    	CLKDEV_CON_DEV_ID("pclk", "ssc.2",&ssc2_clk),
>>>>> -	CLKDEV_CON_DEV_ID(NULL, "at91_i2c",&twi_clk),
>>>>> +	CLKDEV_CON_DEV_ID(NULL, "at91rm9200_i2c",&twi_clk),
>>>> use i2c-xxx as on other drivers
>>>>
>>>> and I do not like to have platform_device_id
>>>
>>> Me, I like it and find this implementation very elegant.
>>>
>>>> as we need to touch the driver to add a new soc
>>>
>>> So what? We still keep the compatibility if the new SoC has it
>>> compatibility assured with previous revision: there is nothing to modify.
>>
>> I agree. The driver would need to be touched to support new SoC only if
>> the IP there have had some differences, which would have needed to be
>> resolved anyway.
>>
>>>> please use platform data
>>
>> Using platform data for the dt platforms would have been more troublesome,
>> wouldn't it ? I like Ludovic's approach which handles both: dt and non-dt
>> cases in uniform way from the driver's POV.
> no you will describe it via DT as done on all the other drivers

Yeah, makes sense. However there are drivers that deduce some parameters
only from the 'compatible' property, let's take drivers/dma/mxs-dma.c as an
example. I'm just trying to understand if there is a general preference on
how to handle those things. Of course we could have all detail properties
listed in a .dtsi file. But since we can derive these from a single property,
it might be more sensible to avoid parsing ?

>>> No, it does not have to be exposed to the user: these data are highly
>>> dependent on the actual hardware (IP revision in fact). So, no need to
>>> mess with platform data.
> no I really see no point on these list of platform_id it's does not look more
> nice just more huggly to have x names. This is at the end the same as passing
> platform data via soc info (add_xx or dtsi)
> 
> And here you just do the same as cpu_is via names.
> 
> The driver need to read IP revision instead

OK, but wouldn't it be needed to resolve an IP revision at run time, e.g.
with soc_is_*() anyway ? Having it set at each board doesn't look like an 
optimal method either.

--

Regards,
Sylwester
