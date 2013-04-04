From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 04 Apr 2013 13:52:02 +0100
Subject: [PATCH 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <20130403231544.GF29227@gmail.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-7-git-send-email-marc.zyngier@arm.com>
 <20130403231544.GF29227@gmail.com>
Message-ID: <515D7772.9020106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/13 00:15, Christoffer Dall wrote:
> On Tue, Apr 02, 2013 at 02:25:14PM +0100, Marc Zyngier wrote:
>> Our HYP init code suffers from two major design issues:
>> - it cannot support CPU hotplug, as we tear down the idmap very early
>> - it cannot perform a TLB invalidation when switching from init to
>>   runtime mappings, as pages are manipulated from PL1 exclusively
>>
>> The hotplug problem mandates that we keep two sets of page tables
>> (boot and runtime). The TLB problem mandates that we're able to
>> transition from one PGD to another while in HYP, invalidating the TLBs
>> in the process.
>>
>> To be able to do this, we need to share a page between the two page
>> tables. A page that will have the same VA in both configurations. All we
>> need is a VA that has the following properties:
>> - This VA can't be used to represent a kernel mapping.
>> - This VA will not conflict with the physical address of the kernel text
>>
>> The vectors page seems to satisfy this requirement:
>> - The kernel never maps anything else there
>> - The kernel text being copied at the beginning of the physical memory,
>>   it is unlikely to use the last 64kB (I doubt we'll ever support KVM
>>   on a system with something like 4MB of RAM, but patches are very
>>   welcome).
>>
>> Let's call this VA the trampoline VA.
>>
>> Now, we map our init page at 3 locations:
>> - idmap in the boot pgd
>> - trampoline VA in the boot pgd
>> - trampoline VA in the runtime pgd
>>
>> The init scenario is now the following:
>> - We jump in HYP with four parameters: boot HYP pgd, runtime HYP pgd,
>>   runtime stack, runtime vectors
>> - Enable the MMU with the boot pgd
>> - Jump to a target into the trampoline page (remember, this is the same
>>   physical page!)
>> - Now switch to the runtime pgd (same VA, and still the same physical
>>   page!)
>> - Invalidate TLBs
>> - Set stack and vectors
>> - Profit! (or eret, if you only care about the code).
> 
> So I'm going to do my usual commenting routine. Was it an idea to insert
> this commit text (which I really liked by the way!) into init.S where
> the current comment is a little lacking giving the massive complexity
> this is turning into, madness?

Will do.

[...]

>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>> index 35a463f..b2c6967 100644
>> --- a/arch/arm/kvm/init.S
>> +++ b/arch/arm/kvm/init.S
>> @@ -21,6 +21,7 @@
>>  #include <asm/asm-offsets.h>
>>  #include <asm/kvm_asm.h>
>>  #include <asm/kvm_arm.h>
>> +#include <asm/kvm_mmu.h>
>>
>>  /********************************************************************
>>   * Hypervisor initialization
>> @@ -47,6 +48,9 @@ __kvm_hyp_init:
>>       W(b)    .
>>
>>  __do_hyp_init:
>> +     cmp     r2, #0                  @ We have a SP?
>> +     bne     phase2                  @ Yes, second stage init
>> +
>>       @ Set the HTTBR to point to the hypervisor PGD pointer passed
>>       mcrr    p15, 4, r0, r1, c2
>>
>> @@ -96,14 +100,35 @@ __do_hyp_init:
>>       orr     r0, r0, r1
>>       isb
>>       mcr     p15, 4, r0, c1, c0, 0   @ HSCR
>> -     isb
>>
>> -     @ Set stack pointer and return to the kernel
>> +     eret
> 
> Could you add some comment here to indicate we're done with phase1, it
> seems like this eret should not go unnoticed by casual readers (ok, they
> shouldn't read this code casually, but anyway..., it will make me sleep
> better)

Sure, no problem.

	M.
-- 
Jazz is not dead. It just smells funny...
