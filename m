From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Feb 2014 18:08:34 +0000
Subject: [PATCH 18/18] arm64: KVM: vgic: add GICv3 world switch
In-Reply-To: <1391607050-540-19-git-send-email-marc.zyngier@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-19-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140225180834.GK23136@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 01:30:50PM +0000, Marc Zyngier wrote:
> Introduce the GICv3 world switch code and helper functions, enabling
> GICv2 emulation on GICv3 hardware.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h  |   4 +
>  arch/arm64/include/asm/kvm_host.h |   5 +
>  arch/arm64/kernel/asm-offsets.c   |   8 ++
>  arch/arm64/kvm/Makefile           |   2 +
>  arch/arm64/kvm/vgic-v3-switch.S   | 275 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 294 insertions(+)
>  create mode 100644 arch/arm64/kvm/vgic-v3-switch.S

[...]

> +.macro	save_vgic_v3_state
> +	/* Compute the address of struct vgic_cpu */
> +	add	x3, x0, #VCPU_VGIC_CPU
> +
> +	mrs	x5, ICC_SRE_EL2
> +	orr	x5, x5, #(1 << 3)
> +	msr	ICC_SRE_EL2, x5
> +	isb
> +
> +	dsb	st

Aha, so you *do* use a dsb here (see my comments to patch 1/18). Does it
really need to be full-system, and does -st apply to an msr?

Saying that, why would ICC_SRE_EL2 not already be initialised by the hyp
setup code?


> +
> +	/* Save all interesting registers */
> +	mrs	x4, ICH_HCR_EL2
> +	mrs	x5, ICH_VMCR_EL2
> +	mrs	x6, ICH_MISR_EL2
> +	mrs	x7, ICH_EISR_EL2
> +	mrs	x8, ICH_ELSR_EL2
> +
> +	str	w4, [x3, #VGIC_V3_CPU_HCR]
> +	str	w5, [x3, #VGIC_V3_CPU_VMCR]
> +	str	w6, [x3, #VGIC_V3_CPU_MISR]
> +	str	w7, [x3, #VGIC_V3_CPU_EISR]
> +	str	w8, [x3, #VGIC_V3_CPU_ELRSR]
> +
> +	msr	ICH_HCR_EL2, xzr
> +	isb

Why do you need an isb here?

> +
> +	mrs	x21, ICH_VTR_EL2
> +	and	w22, w21, #0xf
> +	mov	w23, #0xf
> +	sub	w23, w23, w22	// How many regs we have to skip
> +
> +	adr	x24, 1f
> +	add	x24, x24, x23, lsl #2
> +	br	x24
> +
> +1:
> +	mrs	x20, ICH_LR15_EL2
> +	mrs	x19, ICH_LR14_EL2
> +	mrs	x18, ICH_LR13_EL2
> +	mrs	x17, ICH_LR12_EL2
> +	mrs	x16, ICH_LR11_EL2
> +	mrs	x15, ICH_LR10_EL2
> +	mrs	x14, ICH_LR9_EL2
> +	mrs	x13, ICH_LR8_EL2
> +	mrs	x12, ICH_LR7_EL2
> +	mrs	x11, ICH_LR6_EL2
> +	mrs	x10, ICH_LR5_EL2
> +	mrs	x9, ICH_LR4_EL2
> +	mrs	x8, ICH_LR3_EL2
> +	mrs	x7, ICH_LR2_EL2
> +	mrs	x6, ICH_LR1_EL2
> +	mrs	x5, ICH_LR0_EL2
> +
> +	adr	x24, 1f
> +	add	x24, x24, x23, lsl #2	// adr(1f) + unimp_nr*4
> +	br	x24
> +
> +1:
> +	str	x20, [x3, #(VGIC_V3_CPU_LR + 15*8)]
> +	str	x19, [x3, #(VGIC_V3_CPU_LR + 14*8)]
> +	str	x18, [x3, #(VGIC_V3_CPU_LR + 13*8)]
> +	str	x17, [x3, #(VGIC_V3_CPU_LR + 12*8)]
> +	str	x16, [x3, #(VGIC_V3_CPU_LR + 11*8)]
> +	str	x15, [x3, #(VGIC_V3_CPU_LR + 10*8)]
> +	str	x14, [x3, #(VGIC_V3_CPU_LR + 9*8)]
> +	str	x13, [x3, #(VGIC_V3_CPU_LR + 8*8)]
> +	str	x12, [x3, #(VGIC_V3_CPU_LR + 7*8)]
> +	str	x11, [x3, #(VGIC_V3_CPU_LR + 6*8)]
> +	str	x10, [x3, #(VGIC_V3_CPU_LR + 5*8)]
> +	str	x9, [x3, #(VGIC_V3_CPU_LR + 4*8)]
> +	str	x8, [x3, #(VGIC_V3_CPU_LR + 3*8)]
> +	str	x7, [x3, #(VGIC_V3_CPU_LR + 2*8)]
> +	str	x6, [x3, #(VGIC_V3_CPU_LR + 1*8)]
> +	str	x5, [x3, #VGIC_V3_CPU_LR]
> +
> +	lsr	w22, w21, #29	// Get PRIbits
> +	cmp	w22, #4		// 5 bits
> +	b.eq	5f
> +	cmp	w22, #5		// 6 bits
> +	b.eq	6f
> +				// 7 bits
> +	mrs	x20, ICH_AP0R3_EL2
> +	str	w20, [x3, #(VGIC_V3_CPU_AP0R + 3*4)]
> +	mrs	x19, ICH_AP0R2_EL2
> +	str	w19, [x3, #(VGIC_V3_CPU_AP0R + 2*4)]
> +6:	mrs	x18, ICH_AP0R1_EL2
> +	str	w18, [x3, #(VGIC_V3_CPU_AP0R + 1*4)]
> +5:	mrs	x17, ICH_AP0R0_EL2
> +	str	w17, [x3, #VGIC_V3_CPU_AP0R]
> +
> +	cmp	w22, #4		// 5 bits
> +	b.eq	5f
> +	cmp	w22, #5		// 6 bits
> +	b.eq	6f
> +				// 7 bits
> +	mrs	x20, ICH_AP1R3_EL2
> +	str	w20, [x3, #(VGIC_V3_CPU_AP1R + 3*4)]
> +	mrs	x19, ICH_AP1R2_EL2
> +	str	w19, [x3, #(VGIC_V3_CPU_AP1R + 2*4)]
> +6:	mrs	x18, ICH_AP1R1_EL2
> +	str	w18, [x3, #(VGIC_V3_CPU_AP1R + 1*4)]
> +5:	mrs	x17, ICH_AP1R0_EL2
> +	str	w17, [x3, #VGIC_V3_CPU_AP1R]
> +
> +	mov	x2, #HCR_RW
> +	msr	hcr_el2, x2
> +	isb

Same here -- HCR_EL2.RW is for lower exception levels.

> +
> +	// Restore SRE_EL1 access
> +	mov	x5, #1
> +	msr	ICC_SRE_EL1, x5
> +.endm
> +
> +/*
> + * Restore the VGIC CPU state from memory
> + * x0: Register pointing to VCPU struct
> + */
> +.macro	restore_vgic_v3_state
> +	ldr	x2, [x0, #VCPU_IRQ_LINES]
> +	ldr	x1, [x0, #VCPU_HCR_EL2]
> +	orr	x2, x2, x1
> +	msr	hcr_el2, x2
> +
> +	// Disable SRE_EL1 access
> +	msr	ICC_SRE_EL1, xzr
> +	isb

We're executing at EL2, why the isb?

> +
> +	/* Compute the address of struct vgic_cpu */
> +	add	x3, x0, #VCPU_VGIC_CPU
> +
> +	/* Restore all interesting registers */
> +	ldr	w4, [x3, #VGIC_V3_CPU_HCR]
> +	ldr	w5, [x3, #VGIC_V3_CPU_VMCR]
> +
> +	msr	ICH_HCR_EL2, x4
> +	msr	ICH_VMCR_EL2, x5
> +
> +	mrs	x21, ICH_VTR_EL2
> +
> +	lsr	w22, w21, #29	// Get PRIbits
> +	cmp	w22, #4		// 5 bits
> +	b.eq	5f
> +	cmp	w22, #5		// 6 bits
> +	b.eq	6f
> +				// 7 bits
> +	ldr	w20, [x3, #(VGIC_V3_CPU_AP1R + 3*4)]
> +	msr	ICH_AP1R3_EL2, x20
> +	ldr	w19, [x3, #(VGIC_V3_CPU_AP1R + 2*4)]
> +	msr	ICH_AP1R2_EL2, x19
> +6:	ldr	w18, [x3, #(VGIC_V3_CPU_AP1R + 1*4)]
> +	msr	ICH_AP1R1_EL2, x18
> +5:	ldr	w17, [x3, #VGIC_V3_CPU_AP1R]
> +	msr	ICH_AP1R0_EL2, x17
> +
> +	cmp	w22, #4		// 5 bits
> +	b.eq	5f
> +	cmp	w22, #5		// 6 bits
> +	b.eq	6f
> +				// 7 bits
> +	ldr	w20, [x3, #(VGIC_V3_CPU_AP0R + 3*4)]
> +	msr	ICH_AP0R3_EL2, x20
> +	ldr	w19, [x3, #(VGIC_V3_CPU_AP0R + 2*4)]
> +	msr	ICH_AP0R2_EL2, x19
> +6:	ldr	w18, [x3, #(VGIC_V3_CPU_AP0R + 1*4)]
> +	msr	ICH_AP0R1_EL2, x18
> +5:	ldr	w17, [x3, #VGIC_V3_CPU_AP0R]
> +	msr	ICH_AP0R0_EL2, x17
> +
> +	and	w22, w21, #0xf
> +	mov	w23, #0xf
> +	sub	w23, w23, w22	// How many regs we have to skip
> +
> +	adr	x24, 1f
> +	add	x24, x24, x23, lsl #2	// adr(1f) + unimp_nr*4
> +	br	x24
> +
> +1:
> +	ldr	x20, [x3, #(VGIC_V3_CPU_LR + 15*8)]
> +	ldr	x19, [x3, #(VGIC_V3_CPU_LR + 14*8)]
> +	ldr	x18, [x3, #(VGIC_V3_CPU_LR + 13*8)]
> +	ldr	x17, [x3, #(VGIC_V3_CPU_LR + 12*8)]
> +	ldr	x16, [x3, #(VGIC_V3_CPU_LR + 11*8)]
> +	ldr	x15, [x3, #(VGIC_V3_CPU_LR + 10*8)]
> +	ldr	x14, [x3, #(VGIC_V3_CPU_LR + 9*8)]
> +	ldr	x13, [x3, #(VGIC_V3_CPU_LR + 8*8)]
> +	ldr	x12, [x3, #(VGIC_V3_CPU_LR + 7*8)]
> +	ldr	x11, [x3, #(VGIC_V3_CPU_LR + 6*8)]
> +	ldr	x10, [x3, #(VGIC_V3_CPU_LR + 5*8)]
> +	ldr	x9, [x3, #(VGIC_V3_CPU_LR + 4*8)]
> +	ldr	x8, [x3, #(VGIC_V3_CPU_LR + 3*8)]
> +	ldr	x7, [x3, #(VGIC_V3_CPU_LR + 2*8)]
> +	ldr	x6, [x3, #(VGIC_V3_CPU_LR + 1*8)]
> +	ldr	x5, [x3, #VGIC_V3_CPU_LR]
> +
> +	adr	x24, 1f
> +	add	x24, x24, x23, lsl #2
> +	br	x24
> +
> +1:
> +	msr	ICH_LR15_EL2, x20
> +	msr	ICH_LR14_EL2, x19
> +	msr	ICH_LR13_EL2, x18
> +	msr	ICH_LR12_EL2, x17
> +	msr	ICH_LR11_EL2, x16
> +	msr	ICH_LR10_EL2, x15
> +	msr	ICH_LR9_EL2,  x14
> +	msr	ICH_LR8_EL2,  x13
> +	msr	ICH_LR7_EL2,  x12
> +	msr	ICH_LR6_EL2,  x11
> +	msr	ICH_LR5_EL2,  x10
> +	msr	ICH_LR4_EL2,   x9
> +	msr	ICH_LR3_EL2,   x8
> +	msr	ICH_LR2_EL2,   x7
> +	msr	ICH_LR1_EL2,   x6
> +	msr	ICH_LR0_EL2,   x5
> +
> +	dsb	st

Now you have a dsb without an isb! There's no consistency here and the docs
don't tell me much either.

> +
> +	mrs	x5, ICC_SRE_EL2
> +	and	x5, x5, #~(1 << 3)
> +	msr	ICC_SRE_EL2, x5

Why are you doing this? Should't we leave bits 0 and 3 of SRE_EL2 always
set?

Will
