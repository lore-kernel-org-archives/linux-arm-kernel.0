From: psanchez@fosstel.com (Pedro I. Sanchez)
Date: Mon, 31 Aug 2009 16:46:18 -0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <4A9C33B2.9060002@bluewatersys.com>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>	<4A9C0136.3080102@gabaedevelopment.com>	<bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>	<20090831233312.2d2a6676@realm>
	<b7beacff65dbf47b5e36c3480ec11085@colcan.ca>
	<4A9C33B2.9060002@bluewatersys.com>
Message-ID: <d8f4730c00156e2fa0e54e5765133b38@colcan.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 01 Sep 2009 08:33:54 +1200, Ryan Mallon <ryan@bluewatersys.com>
wrote:
> Pedro I. Sanchez wrote:
>> On Mon, 31 Aug 2009 23:33:12 +0400, Sergey Matyukevich
>> <geomatsi@gmail.com>
>> wrote:
>>> Hi,
>>>  
>>>> And how do I turn on the PMC clocks for the GPIO?
>>> Assigning gpio pin PC6 to TIOB2 peripheral is only a part of the work.
>>> Timer counters may operate in different modes. Take a look at
>>> the datasheet for at91sam9260, timer counters are covered in chapter
34.
>>>
>>> It looks like 'waveform mode' is what you need (see 34.5.10, 34.5.11).
>>> Before you get desired output on PC6 pin you will have to turn on
>>> waveform operating mode for TIOB2 and to configure its wave shapes.
>>>  
>>> Thanks,
>>> Sergey
>> 
>> Thanks Sergey,
>> 
>> So are the following statements correct?
>> 
>> 1. The pck0 clock I've been playing with has nothing to do with the
clock
>> I
>> want on PC6 (TIOB2).
>> 
>> 2. I have to use instead the "tc2_clk" as defined in
>> arch/arm/mach-at-91/at91sam9260.c.
>> 
>> 3. I have to access the TC_CMR register directly to set things up. I
>> mean,
>> there are no macros already defined to access these structures.
> 
> Attached is a driver for outputting pwm's using the timer counters on
> the at91 (sorry its not a proper patch, but this is just hauled out of
> an old kernel we have). The driver is written for the 2.6.20 and does
> not use the new at91 timer counter library. I think it should be
> reasonably easy to port  to the mainline kernel (if you want to do this
> for mainline inclusion, I'm happy to lend a hand).
> 
> To output a pwm on PC6, add the following code to your board file:
> 
> static struct at91_pwm_data pwm_data[] = {
> 	{
> 		.channel	= 2,
> 		.clock_div	= AT91_TC_SCLK,
> 		.period		= 500000,	/* Milliseconds */
> 		.tiob_duty	= 50,		/* Percentage */
> 		.tio		= AT91_TIOB,
> 	},
> };
> 
> and in your board init function:
> 
> at91_add_device_pwm(pwm_data, ARRAY_SIZE(pwm_data));
> 
> The driver also exports the period, duty and raw ra, rb and rc counter
> values via sysfs.
> 
> HTH,
> ~Ryan

Thank you Ryan! I'll take a look at this as I move into the TC world.

BTW, I found this thread that talks about setting a pulse signal on the TC
pins:

http://www.at91.com/samphpbb/viewtopic.php?f=12&t=18294

This is going to help me as well.


-- 
Pedro
