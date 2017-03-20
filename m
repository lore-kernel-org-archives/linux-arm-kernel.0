From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Mar 2017 16:59:19 +0000
Subject: [PATCH 06/17] arm64: arch_timer: Get rid of
 erratum_workaround_set_sne
In-Reply-To: <20170320140618.GF31213@leverpostej>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170306112622.13853-7-marc.zyngier@arm.com>
 <20170320140618.GF31213@leverpostej>
Message-ID: <035fc83b-cd2c-ed00-ccb7-5dc9686c70b4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 14:06, Mark Rutland wrote:
> On Mon, Mar 06, 2017 at 11:26:11AM +0000, Marc Zyngier wrote:
>> Let's move the handling of workarounds affecting set_next_event
>> to the affected function, instead of overwriding the pointers
> 
> Nit: overriding
> 
>> as an afterthough. Yes, this is an extra indirection on the
>> erratum handling path, but the HW is busted anyway.
> 
> [...]
> 
>> +#define erratum_set_next_event_tval_virt(...)		({BUG_ON(1); 0;})
>> +#define erratum_set_next_event_tval_phys(...)		({BUG_ON(1); 0;})
> 
> Nit: BUG()
> 
> [...]
> 
>>  {
>> +	if (needs_unstable_timer_counter_workaround())
>> +		return erratum_set_next_event_tval_virt(evt, clk);
>> +
>>  	set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
>>  	return 0;
>>  }
>> @@ -487,6 +490,9 @@ static int arch_timer_set_next_event_virt(unsigned long evt,
>>  static int arch_timer_set_next_event_phys(unsigned long evt,
>>  					  struct clock_event_device *clk)
>>  {
>> +	if (needs_unstable_timer_counter_workaround())
>> +		return erratum_set_next_event_tval_phys(evt, clk);
>> +
>>  	set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
>>  	return 0;
>>  }
> 
> I take it that the new conditionals are NOPs in the !erratum case, so
> this doesn't adversely affect the usual case.

Indeed, we only get an extra NOP on the normal path. The erratum path
triggers the insertion of a jump targeting the end of the function,
where the workaround gets handled.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
