From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 13 Mar 2013 15:59:18 -0400
Subject: [PATCH 16/29] arm64: KVM: HYP mode world switch implementation
In-Reply-To: <1362455265-24165-17-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-17-git-send-email-marc.zyngier@arm.com>
Message-ID: <5140DA96.3070403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I like how you were able to use a common fpsimd_(save|restore) macro, and
wonder if you can't do the same sort of thing for the general purpose
registers and system registers. In the end, both guest and host are EL1
software, and while they may differ in terms of things like VTTBR settings and
physical timer access, my intuition is that which general purpose and system
registers need to be saved and restored on context switches is shared.

On 03/04/2013 10:47 PM, Marc Zyngier wrote:
> The HYP mode world switch in all its glory.
> 
> Implements save/restore of host/guest registers, EL2 trapping,
> IPA resolution, and additional services (tlb invalidation).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kernel/asm-offsets.c |  33 ++
>  arch/arm64/kvm/hyp.S            | 756 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 789 insertions(+)
>  create mode 100644 arch/arm64/kvm/hyp.S

[...]

> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S

[...]

> +.macro save_host_regs
> +	push	x19, x20
> +	push	x21, x22
> +	push	x23, x24
> +	push	x25, x26
> +	push	x27, x28
> +	push	x29, lr
> +
> +	mrs	x19, sp_el0
> +	mrs	x20, sp_el1
> +	mrs	x21, elr_el1
> +	mrs	x22, spsr_el1
> +	mrs	x23, elr_el2
> +	mrs	x24, spsr_el2
> +
> +	push	x19, x20
> +	push	x21, x22
> +	push	x23, x24
> +.endm

[...]

> +.macro save_guest_regs
> +	// x0 is the vcpu address.
> +	// x1 is the return code, do not corrupt!
> +	// Guest's x0-x3 are on the stack
> +
> +	// Compute base to save registers
> +	add	x2, x0, #REG_OFFSET(4)
> +	mrs	x3, sp_el0
> +	stp	x4, x5, [x2], #16
> +	stp	x6, x7, [x2], #16
> +	stp	x8, x9, [x2], #16
> +	stp	x10, x11, [x2], #16
> +	stp	x12, x13, [x2], #16
> +	stp	x14, x15, [x2], #16
> +	stp	x16, x17, [x2], #16
> +	stp	x18, x19, [x2], #16
> +	stp	x20, x21, [x2], #16
> +	stp	x22, x23, [x2], #16
> +	stp	x24, x25, [x2], #16
> +	stp	x26, x27, [x2], #16
> +	stp	x28, x29, [x2], #16
> +	stp	lr, x3, [x2], #16	// LR, SP_EL0
> +
> +	mrs	x4, elr_el2		// PC
> +	mrs	x5, spsr_el2		// CPSR
> +	stp	x4, x5, [x2], #16
> +
> +	pop	x6, x7			// x2, x3
> +	pop	x4, x5			// x0, x1
> +
> +	add	x2, x0, #REG_OFFSET(0)
> +	stp	x4, x5, [x2], #16
> +	stp	x6, x7, [x2], #16
> +
> +	// EL1 state
> +	mrs	x4, sp_el1
> +	mrs	x5, elr_el1
> +	mrs	x6, spsr_el1
> +	str	x4, [x0, #VCPU_SP_EL1]
> +	str	x5, [x0, #VCPU_ELR_EL1]
> +	str	x6, [x0, #SPSR_OFFSET(KVM_SPSR_EL1)]
> +.endm

There are two relatively easily reconciled differences in my mind that tend to
obscure the similarity between these pieces of code. The first is the use of
push and pop macros standing in for the underlying stp and ldp instructions
and the second is the order in which the registers are stored. I may be
missing something, but my impression is that the order doesn't really matter,
as long as there is universal agreement on what the order will be.

It seems to me then that the fundamental differences are the base address of
the load and store operations and which registers have already been saved by
other code.

What if the base address for the loads and stores, sp versus x2, was made a
macro argument? If it's not straightforward to make the direction of the guest
and host stores the same then the increment value or its sign could also be
made an argument. Alternatively, you could consider storing the host registers
in a slimmed-down vcpu structure for hosts, rather than on the stack.

I need to study the call graph to better understand the asymmetry in which
registers are already saved off by the time we get here. I wonder if there's
more opportunity to unify code there. Short of that perhaps more ideal
solution one could still share the GPR's 19-29 and system register code, but
have the guest version save off GPR's 4-18 before going down an at least
source-level shared path.

[...]

> +/*
> + * Macros to perform system register save/restore.
> + *
> + * Ordering here is absolutely critical, and must be kept consistent
> + * in dump_sysregs, load_sysregs, {save,restore}_guest_sysregs,
> + * {save,restore}_guest_32bit_state, and in kvm_asm.h.
> + *
> + * In other words, don't touch any of these unless you know what
> + * you are doing.
> + */
> +.macro dump_sysregs
> +	mrs	x4,	mpidr_el1

Maybe this should be taken out of the shared code and put in save_host_sysregs
if it only applies to hosts? Also, is the use of mpidr_el1 here and vmpidr_el2
in load_sysregs intentional? If so it might be nice to add a note about that
to your existing comment.

> +	mrs	x5,	csselr_el1
> +	mrs	x6,	sctlr_el1
> +	mrs	x7,	actlr_el1
> +	mrs	x8,	cpacr_el1
> +	mrs	x9,	ttbr0_el1
> +	mrs	x10,	ttbr1_el1
> +	mrs	x11,	tcr_el1
> +	mrs	x12,	esr_el1
> +	mrs	x13, 	afsr0_el1
> +	mrs	x14,	afsr1_el1
> +	mrs	x15,	far_el1
> +	mrs	x16,	mair_el1
> +	mrs	x17,	vbar_el1
> +	mrs	x18,	contextidr_el1
> +	mrs	x19,	tpidr_el0
> +	mrs	x20,	tpidrro_el0
> +	mrs	x21,	tpidr_el1
> +	mrs	x22, 	amair_el1
> +	mrs	x23, 	cntkctl_el1
> +.endm

[...]

> +.macro save_guest_sysregs
> +	dump_sysregs
> +	add	x2, x0, #SYSREG_OFFSET(CSSELR_EL1) // MIPDR_EL2 not written back

MPIDR_EL1

[...]

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
