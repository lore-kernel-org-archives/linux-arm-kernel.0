From: christoffer.dall@arm.com (Christoffer Dall)
Date: Thu, 24 May 2018 10:12:20 +0200
Subject: [PATCH v10 05/18] KVM: arm64: Convert lazy FPSIMD context switch
 trap to C
In-Reply-To: <87k1rutbbi.fsf@linaro.org>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-6-git-send-email-Dave.Martin@arm.com>
 <87k1rutbbi.fsf@linaro.org>
Message-ID: <20180524081220.GJ55598@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 08:35:13PM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > To make the lazy FPSIMD context switch trap code easier to hack on,
> > this patch converts it to C.
> >
> > This is not amazingly efficient, but the trap should typically only
> > be taken once per host context switch.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm64/kvm/hyp/entry.S  | 57 +++++++++++++++++----------------------------
> >  arch/arm64/kvm/hyp/switch.c | 24 +++++++++++++++++++
> >  2 files changed, 46 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
> > index e41a161..40f349b 100644
> > --- a/arch/arm64/kvm/hyp/entry.S
> > +++ b/arch/arm64/kvm/hyp/entry.S
> > @@ -172,40 +172,27 @@ ENTRY(__fpsimd_guest_restore)
> >  	// x1: vcpu
> >  	// x2-x29,lr: vcpu regs
> >  	// vcpu x0-x1 on the stack
> > -	stp	x2, x3, [sp, #-16]!
> > -	stp	x4, lr, [sp, #-16]!
> > -
> > -alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
> > -	mrs	x2, cptr_el2
> > -	bic	x2, x2, #CPTR_EL2_TFP
> > -	msr	cptr_el2, x2
> > -alternative_else
> > -	mrs	x2, cpacr_el1
> > -	orr	x2, x2, #CPACR_EL1_FPEN
> > -	msr	cpacr_el1, x2
> > -alternative_endif
> > -	isb
> > -
> > -	mov	x3, x1
> > -
> > -	ldr	x0, [x3, #VCPU_HOST_CONTEXT]
> > -	kern_hyp_va x0
> > -	add	x0, x0, #CPU_GP_REG_OFFSET(CPU_FP_REGS)
> > -	bl	__fpsimd_save_state
> > -
> > -	add	x2, x3, #VCPU_CONTEXT
> > -	add	x0, x2, #CPU_GP_REG_OFFSET(CPU_FP_REGS)
> > -	bl	__fpsimd_restore_state
> > -
> > -	// Skip restoring fpexc32 for AArch64 guests
> > -	mrs	x1, hcr_el2
> > -	tbnz	x1, #HCR_RW_SHIFT, 1f
> > -	ldr	x4, [x3, #VCPU_FPEXC32_EL2]
> > -	msr	fpexc32_el2, x4
> > -1:
> > -	ldp	x4, lr, [sp], #16
> > -	ldp	x2, x3, [sp], #16
> > -	ldp	x0, x1, [sp], #16
> > -
> > +	stp	x2, x3, [sp, #-144]!
> > +	stp	x4, x5, [sp, #16]
> > +	stp	x6, x7, [sp, #32]
> > +	stp	x8, x9, [sp, #48]
> > +	stp	x10, x11, [sp, #64]
> > +	stp	x12, x13, [sp, #80]
> > +	stp	x14, x15, [sp, #96]
> > +	stp	x16, x17, [sp, #112]
> > +	stp	x18, lr, [sp, #128]
> > +
> > +	bl	__hyp_switch_fpsimd
> > +
> > +	ldp	x4, x5, [sp, #16]
> > +	ldp	x6, x7, [sp, #32]
> > +	ldp	x8, x9, [sp, #48]
> > +	ldp	x10, x11, [sp, #64]
> > +	ldp	x12, x13, [sp, #80]
> > +	ldp	x14, x15, [sp, #96]
> > +	ldp	x16, x17, [sp, #112]
> > +	ldp	x18, lr, [sp, #128]
> > +	ldp	x0, x1, [sp, #144]
> > +	ldp	x2, x3, [sp], #160
> >  	eret
> >  ENDPROC(__fpsimd_guest_restore)
> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index d964523..c0796c4 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -318,6 +318,30 @@ static bool __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
> >  	}
> >  }
> >
> > +void __hyp_text __hyp_switch_fpsimd(u64 esr __always_unused,
> > +				    struct kvm_vcpu *vcpu)
> > +{
> > +	kvm_cpu_context_t *host_ctxt;
> > +
> > +	if (has_vhe())
> > +		write_sysreg(read_sysreg(cpacr_el1) | CPACR_EL1_FPEN,
> > +			     cpacr_el1);
> > +	else
> > +		write_sysreg(read_sysreg(cptr_el2) & ~(u64)CPTR_EL2_TFP,
> > +			     cptr_el2);
> 
> Is there no way to do alternative() in C or does it always come down to
> different inline asms?
> 

has_vhe() should resolve to a static key, and I prefer this over the
previous alternative construct we had for selecting function calls in C,
as that resultet in having to follow too many levels of indirection.

Thanks,
-Christoffer
