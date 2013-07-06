From: ulrich.prinz@googlemail.com (Ulrich Prinz)
Date: Sat, 06 Jul 2013 22:19:14 +0200
Subject: [PATCH 3/9] clocksource: dw_apb_timer: quirk for variants with
 64bit counter
In-Reply-To: <alpine.DEB.2.02.1307060129340.32106@ionos.tec.linutronix.de>
References: <201307060051.09716.heiko@sntech.de>
 <201307060053.10182.heiko@sntech.de>
 <alpine.DEB.2.02.1307060129340.32106@ionos.tec.linutronix.de>
Message-ID: <51D87BC2.5060507@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

sorry but it is my first release to the kernel and I was trained to take
as less as possible influence on existing code and reuse as much as
possible existing code.

Sometimes just two rules are to simple...

Am 06.07.2013 01:45, schrieb Thomas Gleixner:
> On Sat, 6 Jul 2013, Heiko St?bner wrote:
> 
>> This adds a quirk for IP variants containing two load_count and value
>> registers that are used to provide 64bit accuracy on 32bit systems.
>>
>> The added accuracy is currently not used, the driver is only adapted to
>> handle the different register layout and make it work on affected devices.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  drivers/clocksource/dw_apb_timer.c |   27 +++++++++++++++++++++++++++
>>  include/linux/dw_apb_timer.h       |    6 ++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
>> index f5e7be8..bd45351 100644
>> --- a/drivers/clocksource/dw_apb_timer.c
>> +++ b/drivers/clocksource/dw_apb_timer.c
>> @@ -56,6 +56,17 @@ static void apbt_init_regs(struct dw_apb_timer *timer, int quirks)
>>  	timer->reg_control = APBTMR_N_CONTROL;
>>  	timer->reg_eoi = APBTMR_N_EOI;
>>  	timer->reg_int_status = APBTMR_N_INT_STATUS;
>> +
>> +	/*
>> +	 * On variants with 64bit counters some registers are
>> +	 * moved further down.
>> +	 */
>> +	if (quirks & APBTMR_QUIRK_64BIT_COUNTER) {
>> +		timer->reg_current_value += 0x4;
>> +		timer->reg_control += 0x8;
>> +		timer->reg_eoi += 0x8;
>> +		timer->reg_int_status += 0x8;
>> +	}
>>  }
> 
> Oh, no. this is not how we handle these things.
> 
> 1) We want proper constants for this 64bit IP block 

ACK
> 
> 2) This is not a quirk, it's a property of that particular IP block

Ok, noted and will be reworked.
> 
> You already made the register offsets a part of the timer structure,
> so why don't you supply a proper structure filled with that values to
> the init function?
> 
> That's what we do all over the place. Either we instantiate those
> structs at compile time or runtime fed by device tree or any other
> configuration mechanism.
>   
Lesson learned, will be reworked. But taking the other comments and
remarks into account this leads to an integration into a single new
patch inheriting this new driver path.

>>  static unsigned long apbt_readl(struct dw_apb_timer *timer, unsigned long offs)
>> @@ -145,6 +156,10 @@ static void apbt_set_mode(enum clock_event_mode mode,
>>  		udelay(1);
>>  		pr_debug("Setting clock period %lu for HZ %d\n", period, HZ);
>>  		apbt_writel(timer, period, timer->reg_load_count);
>> +
>> +		if (timer->quirks & APBTMR_QUIRK_64BIT_COUNTER)
>> +			apbt_writel(timer, 0, timer->reg_load_count + 0x4);
>> +
> 
> No. We are not adding such conditional constructs when we can deal
> with them just by providing a proper set of function pointers. And
> definitely not with hardcoded magic 0x4 constants involved.
> 
>      timer->load_count(timer, value);
> 
> Provide a 32 bit and a 64 bit version of that function and be done
> with it.

For the first version, 64bit will not be supported cause of lack of
information and testing. But is it an option to control the load of
functions by dtsi according this way:

dw-apb-timer-osc: will load standard function to load timer
rk3188-dw-apb-timer-osc: will load 32bit variant of 64bit registers
rk3188-dw-apb-timer64-osc: will load 64bit variant of 64bit registers

> 
> 
> Copy and paste is a conveniant thing, right? It just should have a pop
> up window assigned which asks at the second instance of copying the
> same thing whether you really thought about it.

We thought about and tested a lot. But the problem is that if you find a
bug in one copy of it, you (or anyone else inspecting the code) need to
find all the other copies. In such manor a c'n'p solution is always bad.

Regards,
	Ulrich
