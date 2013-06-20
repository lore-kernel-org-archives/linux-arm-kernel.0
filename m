From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Jun 2013 09:29:30 +0100
Subject: [PATCH 4/5] ARM: KVM: clear exclusive monitor on all exception
 returns
In-Reply-To: <20130620002736.GK7870@lvm>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
 <1371648006-8036-5-git-send-email-marc.zyngier@arm.com>
 <20130620002736.GK7870@lvm>
Message-ID: <51C2BD6A.1080308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/13 01:27, Christoffer Dall wrote:
> On Wed, Jun 19, 2013 at 02:20:05PM +0100, Marc Zyngier wrote:
>> Make sure we clear the exclusive movitor on all exception returns,
>> which otherwise could lead to lock corruptions.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kvm/interrupts.S | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index 3124e0f..750f051 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -301,6 +301,7 @@ THUMB(	orr	r2, r2, #PSR_T_BIT	)
>>  	ldr	r2, =BSYM(panic)
>>  	msr	ELR_hyp, r2
>>  	ldr	r0, =\panic_str
>> +	clrex				@ Clear exclusive monitor
> 
> on a panic? sure, why not ;)

These days, you can have a lot of things going on after a panic: kexec,
for example. You really want to return to the host with a clean state if
at all possible.

>>  	eret
>>  .endm
>>  
>> @@ -450,6 +451,7 @@ guest_trap:
>>  
>>  4:	pop	{r0, r1}		@ Failed translation, return to guest
>>  	mcrr	p15, 0, r0, r1, c7	@ PAR
>> +	clrex
> 
> I gather this is because any store can potentially leave the system with
> an exclusive monitor taken?

My scenario was the following:
ldrex -> translation fault, page mapped in Stage-2, read-only
strex -> permission fault

On another vcpu, the page is unmapped (swapped out, for example).

Translation then fails on the permission fault path, and we return to
the guest. But we must make sure that the exclusive monitor is
effectively cleared. Linux wouldn't be affected (me think), but that's
always worth doing.

That's probably one of the thing I like the most about ARMv8: eret
always implies clrex. No questions asked.

> patch looks fine.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
