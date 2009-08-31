From: psanchez@fosstel.com (Pedro I. Sanchez)
Date: Mon, 31 Aug 2009 17:09:03 -0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <4A9C3637.9000802@gabaedevelopment.com>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>	<4A9C0136.3080102@gabaedevelopment.com>	<bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
	<20090831233312.2d2a6676@realm>
	<4A9C2B7A.7070306@gabaedevelopment.com>
	<af2c0bf49afa409b64cb313bb77bae9e@colcan.ca>
	<4A9C3637.9000802@gabaedevelopment.com>
Message-ID: <909511f89deea5c6700d7d51d6e96d34@colcan.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Aug 2009 16:44:39 -0400, Stephen Munnings
<smunnings@gabaedevelopment.com> wrote:
> Pedro I. Sanchez wrote:
>> On Mon, 31 Aug 2009 15:58:50 -0400, Stephen Munnings
>> <smunnings@gabaedevelopment.com> wrote:
>>   
>>> Sergey Matyukevich wrote:
>>>     
>>>> Hi,
>>>>  
>>>>   
>>>>       
>>>>> And how do I turn on the PMC clocks for the GPIO?
>>>>>     
>>>>>         
>>>> Assigning gpio pin PC6 to TIOB2 peripheral is only a part of the work.
>>>> Timer counters may operate in different modes. Take a look at
>>>> the datasheet for at91sam9260, timer counters are covered in chapter
>>>> 34.
>>>>       
>>
>>   
>>>> It looks like 'waveform mode' is what you need (see 34.5.10, 34.5.11).
>>>> Before you get desired output on PC6 pin you will have to turn on
>>>> waveform operating mode for TIOB2 and to configure its wave shapes.
>>>>  
>>>> Thanks,
>>>> Sergey
>>>>   
>>>>       
>>> hmmmm....
>>>
>>> PCK0 is *not*  a TC pin - it is a clock output from the Power
Management
>>>
>>> Controller.
>>> (Section 25.6)
>>> It should be as easy as dividing down one of the primary clock sources 
>>> and then enabling
>>> the appropriate GPIO pin as the appropriate peripheral.
>>>
>>> Ahah - there is the problem.....  PCK0 is not available on PC6 - it
must
>>>
>>> be set as peripheral B
>>> on pin PC1 or PB30 as Peripheral A - no other choices available...
>>>
>>> PC6 is indeed TIOB2 (one of the counter timers)
>>>     
>>
>> OK, I see this thread unfolding, thank you!
>>
>> This is what I have now to test pck0 on PC1:
>>
>> at91_set_B_periph(AT91_PIN_PC1, 0);
>> pck0=clk_get(NULL, "pck0");
>> pll=clk_get(NULL, "plla");
>> clk_set_parent(pck0, pll);
>> clk_set_rate(pck0, 50000000);
>> clk_enable(pck0);
>>
>> But I don't get a clean clock on PC1. In the end I will still need to
get
>> the TC clock on PC6 but I for the time being I want to be able to
>> generate
>> any clock out first!
>>
>> Is there something else to do?
>>
>>   
> The code here will try to give you a 50Mhz signal.
> That might not be feasible on a 9260.
> This might be the source of not getting a "clean" clock on PC1.
> Try adjusting it for something that your chip (9260) can reasonably 
> generate.
> Also, at 50Mhz, there can be all kinds of termination, ringing, and 
> other problems.
> To get "just any clean signal", try a frequency much lower.
> Depending on which pll you use as parent, and what frequency it is 
> already running at,
> try for around 1Mhz to get a "nice clean signal".
> The signal of PCK will try to be a "square wave".
> You will find that the PCK signal programming is easier (but much more 
> limited) than
> programming the TC signals.
> The TC signals are much more flexible in their range, etc., but take 
> more work to set up.
> This is a pretty common trade off.

Well, good news! I got the clean clock on PC1 (3.014 MHz), not at the rate
I requested (1 MHz), but very clean. I'll have to figure out the clock
divider thing now to get the right values.

Anyway, this is a big step for me. Thanks once more!

-- 
Pedro
