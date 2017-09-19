From: afd@ti.com (Andrew F. Davis)
Date: Tue, 19 Sep 2017 10:07:39 -0500
Subject: [PATCH 1/2] ARM: smccc-call: Use r12 to route secure monitor
 calls on TI platforms
In-Reply-To: <20170919141953.GH30715@leverpostej>
References: <20170918205005.30235-1-afd@ti.com>
 <20170919141953.GH30715@leverpostej>
Message-ID: <7390d268-5c72-b263-f153-fbf0d728e05e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2017 09:19 AM, Mark Rutland wrote:
> On Mon, Sep 18, 2017 at 03:50:04PM -0500, Andrew F. Davis wrote:
>> Our ROM Secure Monitor(SM) uses the value in r12 to determine which
>> service is being requested by an SMC call. This inline with the ARM
>> recommended SMC Calling Convention(SMCCC), which partitions the values
>> in R0 for this task, OP-TEE's SM follows the ARM recommended convention.
> 
> I can't parse this last sentence. What exactly is inline with the SMCCC?
> 

My bad, I meant "This 'is not' inline with the ARM..."

> AFAICT, the SMCCC says r12 is "The Intra-Procedure-call scratch
> register", which is not a paramter, service ID, etc.
> 

Right, which is why our old secure monitor is not inline with the SMCCC,
it uses r12 and not r0.

>> We need a way to signal that a call is for the OP-TEE SM and not for
>> the ROM SM in a way that is safe for the ROM SM, in case it is still
>> present. We do this by putting a value of 0x200 in r12 when the call
>> is for OP-TEE or any other ARM by modifying the SMCCC caller function.
> 
> So IIUC, you have a secure monitor which is not SMCCC compliant, but you
> want to use it at the same time as OP-TEE, which is SMCCC compliant.
> 

Not at the same time, our old secure monitor is in ROM, it will be
present anytime OP-TEE is not installed. OP-TEE is not mandatory, and so
any call to the secure side must be safe for both secure monitors.

> It would be much better to have a new version of that monitor that was
> SMCCC compliant, and have to update the code for that, than to have to
> move OP-TEE away from standards compliance.
> 

The current monitor is part of ROM and dates back to OMAP3 days, so
looks to pre-date ARM standardizing the SMCCC by several years, so I
hope our lack of compliance here can be forgiven here..

Luckily, OP-TEE does not have to move away from compliance to support
our platforms, it only needs to check for this sentinel value in r12,
which it already has support upstream for:

https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-ti/sm_platform_handler_a15.c#L34

>> There are four combinations of events:
>>
>> If the ROM SM is present and we make a legacy style SMC call, as we
>> do in early boot, the call will not have r12 set to 0x200 as these
>> calls go through existing mach-omap2/ SMC handlers, so all is well.
>>
>> If the ROM SM is present and we make an SMCCC style call, r12 will be
>> set to 0x200 and ROM SM will see this as an invalid service call and
>> safely return to the normal world.
> 
> So you're going to describe OP-TEE as present even when it's not!?
> 
> That's simply wrong.
> 

This particular case should never happen as we only add the OP-TEE DT
node after having installed OP-TEE during boot. It is listed here only
for completeness and to show that it is safe even if it did occur.

>> If OP-TEE is present and we make a legacy style SMC call, r12 will
>> not be set to 0x200, and OP-TEE will emulate the functionality that
>> the call is requesting.
> 
> AFAICT this means that OP-TEE completely replaces your existing monitor.
> 

Correct.

> Please fix this properly. Implement SMCCC-compliant versions of those
> calls you wish to retain, and come up with a new binding for those.
> Describe that in the DT for systems which have OP-TEE providing these
> services.
> 

This might not be possible, these old SMCs are made very early and are
used all over our existing platform code:

git grep "smc" -- arch/arm/mach-omap2

> Systems with the old monitor should have that descrbied in their DT, and
> not OP-TEE.
> 

All systems have the old monitor by default, OP-TEE is the new and
optional case, I think its node should be the entity modified when
adding something OP-TEE specific like this.

> That completely removes the need to come up with a new OP-TEE binding
> extension, and aligns your FW for forward compatibility with future
> services.
> 

I agree this would be nice, but due to the above this may simply not be
reasonably possible.

Thanks,
Andrew

> Thanks,
> Mark
