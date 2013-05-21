From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 May 2013 15:49:08 +0100
Subject: [PATCH v4 15/32] arm64: KVM: hypervisor initialization code
In-Reply-To: <20130521144005.GG27002@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-16-git-send-email-marc.zyngier@arm.com>
 <20130521144005.GG27002@arm.com>
Message-ID: <519B8964.3050802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/13 15:40, Catalin Marinas wrote:
> On Tue, May 14, 2013 at 03:13:43PM +0100, Marc Zyngier wrote:
>> --- /dev/null
>> +++ b/arch/arm64/kvm/hyp-init.S
> ...
>> +	.text
>> +	.pushsection	.hyp.idmap.text, "ax"
>> +
>> +	.align	11
>> +
>> +__kvm_hyp_init:
>> +	.global	__kvm_hyp_init
>> +
>> +ENTRY(__kvm_hyp_init_vector)
> 
> Why do you need both __kvm_hyp_init and __kvm_hyp_init_vector? You could
> drop the former.

Actually, __kvm_hyp_init is refered to by the 32/64 shared code, so I
can't get rid of it right now.

I'll remove __kvm_hyp_init_vector for the time being, as it isn't used
anywhere.

>> +__do_hyp_init:
>> +
>> +	msr	ttbr0_el2, x0
>> +
>> +	mrs	x4, tcr_el1
>> +	ldr	x5, =TCR_EL2_MASK
>> +	and	x4, x4, x5
>> +	ldr	x5, =TCR_EL2_FLAGS
>> +	orr	x4, x4, x5
>> +	msr	tcr_el2, x4
>> +
>> +	ldr	x4, =VTCR_EL2_FLAGS
>> +	msr	vtcr_el2, x4
>> +
>> +	mrs	x4, mair_el1
>> +	msr	mair_el2, x4
>> +	isb
>> +
>> +	mov	x4, #SCTLR_EL2_FLAGS
>> +	msr	sctlr_el2, x4
>> +	isb
>> +
>> +	/* MMU is now enabled. Get ready for the trampoline dance */
>> +	ldr	x4, =TRAMPOLINE_VA
>> +	adr	x5, target
>> +	bfi	x4, x5, #0, #PAGE_SHIFT
>> +	br	x4
>> +
>> +	nop
> 
> What is this nop for?

Nothing. I thought I had it removed already. Will get rid of it for good
this time.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
