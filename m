From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 18 Jun 2014 19:13:27 -0400
Subject: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
In-Reply-To: <alpine.LFD.2.11.1406181704240.16842@knanqh.ubzr>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
 <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
 <20140618173648.GB31573@e102568-lin.cambridge.arm.com>
 <53A1E818.6030400@ti.com> <alpine.LFD.2.11.1406181641290.16842@knanqh.ubzr>
 <53A1FCD1.8070703@ti.com> <alpine.LFD.2.11.1406181704240.16842@knanqh.ubzr>
Message-ID: <53A21D17.10206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 05:09 PM, Nicolas Pitre wrote:
> On Wed, 18 Jun 2014, Santosh Shilimkar wrote:
> 
>> On Wednesday 18 June 2014 04:51 PM, Nicolas Pitre wrote:
>>> On Wed, 18 Jun 2014, Santosh Shilimkar wrote:
>>>
>>>> On Wednesday 18 June 2014 01:36 PM, Lorenzo Pieralisi wrote:
>>>> [..]
>>>>> +	To correctly specify idle states timing and energy related properties,
>>>>> +	the following definitions identify the different execution phases
>>>>> +	a CPU goes through to enter and exit idle states and the implied
>>>>> +	energy metrics:
>>>>> +
>>>>> +	..__[EXEC]__|__[PREP]__|__[ENTRY]__|__[IDLE]__|__[EXIT]__|__[EXEC]__..
>>>>> +		    |          |           |          |          |
>>>>> +
>>>>> +		    |<------ entry ------->|
>>>>> +		    |       latency        |
>>>>> +						      |<- exit ->|
>>>>> +						      |  latency |
>>>>> +		    |<-------- min-residency -------->|
>>>>> +			       |<-------  wakeup-latency ------->|
>>>>> +
>>>> I don't know the wakeup latency makes much sense and also correct.
>>>> Hardware wakeup latency is actually exit latency. Is it for failed
>>>> or abort-able ilde case ? We are adding this as a new parameter
>>>> at least from idle states perspective. I think we should just
>>>> avoid it.
>>>
>>> I explained the rationale for this parameter in a previous email but 
>>> Lorenzo didn't carry it over. To be clearer, this should be "worst case 
>>> wake-up latency".  It is of interest for PMQOS.  This is the maximum 
>>> delay that can be expected from the moment a wake-up event is signaled 
>>> and the moment the CPU is back operational.  This is more than just exit 
>>> latency.  By default this is entry_latency + exit_latency but when there 
>>> is an abortable PREP phase then it may be shorter than that.
>>>
>> PMQOS angle is right. It is just that the idle code is not
>> going to do anything with this value. But I see a value adding it
>> instead of some one doing calculation.
> 
> The idle code should take it into account when a PMQOS restriction is in 
> effect i.e. avoid using those modes whose worst case wake-up latency is 
> too large.
> 
> And cpuidle is being migrated into the scheduler as we speak.  So some 
> of the values there, namely entry_latency and exit_latency (taken 
> separately for timing purposes) will be directly used by the scheduler 
> to decide which CPU to wake up for example.
> 
> So there is fundamentally 4 parameters if we want to comprehensively 
> support all pertinent use cases.
> 
Fair enough.

regards,
Santosh
