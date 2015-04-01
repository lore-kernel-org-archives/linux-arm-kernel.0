From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Apr 2015 15:56:47 +0100
Subject: Reading twd_base at run-time
In-Reply-To: <551C0325.7090500@free.fr>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
 <5515BEA5.6040307@free.fr> <20150327205301.GD4019@n2100.arm.linux.org.uk>
 <551BDF69.4020205@free.fr> <551BE476.2060102@arm.com>
 <551BEC33.1090702@free.fr> <551BEF44.8020808@arm.com>
 <551C0325.7090500@free.fr>
Message-ID: <551C072F.4090800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/15 15:39, Mason wrote:
> On 01/04/2015 15:14, Marc Zyngier wrote:
>> On 01/04/15 14:01, Mason wrote:
>>> On 01/04/2015 14:28, Marc Zyngier wrote:
>>>
>>>> It is worth mentioning that PERIPH_BASE is *not* an architected
>>>> register, so an implementation is perfectly allowed not to implement it.
>>>> Even on Cortex A9, a UP implementation will report PERIPH_BASE as zero.
>>>> It is still likely to have a TWD though.
>>>
>>> It is interesting that you would mention TWD and UP implementations,
>>> because "config HAVE_ARM_TWD" depends on SMP, as I mentioned in a
>>> separate thread ("Dropping "depends on SMP" for HAVE_ARM_TWD").
>>>
>>> Would it make sense to drop the dependency?
>>>
>>> I have a single-core Cortex A9 MPcore system where I want to use
>>> the local timers. If it's too much trouble changing the build
>>> options, I suppose I can just run an SMP kernel?
>>
>> There used to be a time where the TWD was completely tied to the SMP
>> code, but I think we now deal with per-cpu timers in a way similar to
>> the global timers (more or less...).
>>
>> Worth trying, and see what breaks. On the other hand, SMP on UP should
>> give you the same result.
> 
> And now that you mention SMP_ON_UP and TI, I remembered just where
> I got the crazy idea to get PERIPH_BASE from CP15 ;-)
> 
> commit bc41b8724 ("Update SMP_ON_UP code to detect A9MPCore with
> 1 CPU devices")
> 
> arch/arm/kernel/head.S | 21 ++++++++++++++++++++-
> 
> 	@ If a future SoC *does* use 0x0 as the PERIPH_BASE, then the
> 	@ below address check will need to be #ifdef'd or equivalent
> 	@ for the Aegis platform.
> 	mrc	p15, 4, r0, c15, c0	@ get SCU base address
> 	teq	r0, #0x0		@ '0' on actual UP A9 hardware
> 	beq	__fixup_smp_on_up	@ So its an A9 UP
> 
> 
> Isn't this as problematic here as doing it later in the boot.

The problem is that this is the only known way to detect this horrible
piece of junk. Otherwise, we're going to treat it as a proper SMP
platform, and things will break (the HW advertises itself as MPx1, but
has no SCU).

> Is the DT data already available in head.S?

It is available in the sense that it is in memory, but at that stage,
we're not in a position to use it. We're at a point where we're barely
finding out what sort of CPU we have.

DT will only be really available much later in the boot process.

	M.
-- 
Jazz is not dead. It just smells funny...
