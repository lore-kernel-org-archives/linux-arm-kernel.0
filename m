From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 May 2013 15:40:05 +0100
Subject: [PATCH v4 15/32] arm64: KVM: hypervisor initialization code
In-Reply-To: <1368540840-26750-16-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-16-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130521144005.GG27002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:43PM +0100, Marc Zyngier wrote:
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp-init.S
...
> +	.text
> +	.pushsection	.hyp.idmap.text, "ax"
> +
> +	.align	11
> +
> +__kvm_hyp_init:
> +	.global	__kvm_hyp_init
> +
> +ENTRY(__kvm_hyp_init_vector)

Why do you need both __kvm_hyp_init and __kvm_hyp_init_vector? You could
drop the former.

> +__do_hyp_init:
> +
> +	msr	ttbr0_el2, x0
> +
> +	mrs	x4, tcr_el1
> +	ldr	x5, =TCR_EL2_MASK
> +	and	x4, x4, x5
> +	ldr	x5, =TCR_EL2_FLAGS
> +	orr	x4, x4, x5
> +	msr	tcr_el2, x4
> +
> +	ldr	x4, =VTCR_EL2_FLAGS
> +	msr	vtcr_el2, x4
> +
> +	mrs	x4, mair_el1
> +	msr	mair_el2, x4
> +	isb
> +
> +	mov	x4, #SCTLR_EL2_FLAGS
> +	msr	sctlr_el2, x4
> +	isb
> +
> +	/* MMU is now enabled. Get ready for the trampoline dance */
> +	ldr	x4, =TRAMPOLINE_VA
> +	adr	x5, target
> +	bfi	x4, x5, #0, #PAGE_SHIFT
> +	br	x4
> +
> +	nop

What is this nop for?

-- 
Catalin
