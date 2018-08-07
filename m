From: christoffer.dall@arm.com (Christoffer Dall)
Date: Tue, 7 Aug 2018 21:43:38 +0200
Subject: [RFC PATCH 12/16] KVM: arm64/sve: Context switch the SVE registers
In-Reply-To: <20180807111526.GD9097@e103592.cambridge.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-13-git-send-email-Dave.Martin@arm.com>
 <20180806131910.GC5985@e113682-lin.lund.arm.com>
 <20180807111526.GD9097@e103592.cambridge.arm.com>
Message-ID: <20180807194338.GI5985@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 12:15:26PM +0100, Dave Martin wrote:
> On Mon, Aug 06, 2018 at 03:19:10PM +0200, Christoffer Dall wrote:
> > On Thu, Jun 21, 2018 at 03:57:36PM +0100, Dave Martin wrote:
> > > In order to give each vcpu its own view of the SVE registers, this
> > > patch adds context storage via a new sve_state pointer in struct
> > > vcpu_arch.  An additional member sve_max_vl is also added for each
> > > vcpu, to determine the maximum vector length visible to the guest
> > > and thus the value to be configured in ZCR_EL2.LEN while the is
> > > active.  This also determines the layout and size of the storage in
> > > sve_state, which is read and written by the same backend functions
> > > that are used for context-switching the SVE state for host tasks.
> > > 
> > > On SVE-enabled vcpus, SVE access traps are now handled by switching
> > > in the vcpu's SVE context and disabling the trap before returning
> > > to the guest.  On other vcpus, the trap is not handled and an exit
> > > back to the host occurs, where the handle_sve() fallback path
> > > reflects an undefined instruction exception back to the guest,
> > > consistently with the behaviour of non-SVE-capable hardware (as was
> > > done unconditionally prior to this patch).
> > > 
> > > No SVE handling is added on non-VHE-only paths, since VHE is an
> > > architectural and Kconfig prerequisite of SVE.
> > > 
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_host.h |  2 ++
> > >  arch/arm64/kvm/fpsimd.c           |  5 +++--
> > >  arch/arm64/kvm/hyp/switch.c       | 43 ++++++++++++++++++++++++++++++---------
> > >  3 files changed, 38 insertions(+), 12 deletions(-)
> 
> [...]
> 
> > > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> 
> [...]
> 
> > > @@ -361,7 +373,13 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
> > >  		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
> > >  	}
> > >  
> > > -	__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
> > > +	if (system_supports_sve() && guest_has_sve)
> > > +		sve_load_state((char *)vcpu->arch.sve_state +
> > > +					sve_ffr_offset(vcpu->arch.sve_max_vl),
> > 
> > nit: would it make sense to have a macro 'vcpu_get_sve_state_ptr(vcpu)'
> > to make this first argument more pretty?
> 
> Could do, I guess.  I'll take a look.
> 
> > 
> > > +			       &vcpu->arch.ctxt.gp_regs.fp_regs.fpsr,
> > > +			       sve_vq_from_vl(vcpu->arch.sve_max_vl) - 1);
> > > +	else
> > > +		__fpsimd_restore_state(&vcpu->arch.ctxt.gp_regs.fp_regs);
> > >  
> > >  	/* Skip restoring fpexc32 for AArch64 guests */
> > >  	if (!(read_sysreg(hcr_el2) & HCR_RW))
> > > @@ -380,6 +398,8 @@ static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
> > >   */
> > >  static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
> > >  {
> > > +	bool guest_has_sve;
> > > +
> > >  	if (ARM_EXCEPTION_CODE(*exit_code) != ARM_EXCEPTION_IRQ)
> > >  		vcpu->arch.fault.esr_el2 = read_sysreg_el2(esr);
> > >  
> > > @@ -397,10 +417,13 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
> > >  	 * and restore the guest context lazily.
> > >  	 * If FP/SIMD is not implemented, handle the trap and inject an
> > >  	 * undefined instruction exception to the guest.
> > > +	 * Similarly for trapped SVE accesses.
> > >  	 */
> > > -	if (system_supports_fpsimd() &&
> > > -	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_FP_ASIMD)
> > > -		return __hyp_switch_fpsimd(vcpu);
> > > +	guest_has_sve = vcpu_has_sve(&vcpu->arch);
> > > +	if ((system_supports_fpsimd() &&
> > > +	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_FP_ASIMD) ||
> > > +	    (guest_has_sve && kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SVE))
> > 
> > nit: this may also be folded nicely into a static bool
> > __trap_fpsimd_sve_access() check.
> 
> It wouldn't hurt to make this look less fiddly, certainly.
> 
> Can you elaborate on precisely what you had in mind?

sure:

static bool __hyp_text __trap_is_fpsimd_sve_access(struct kvm_vcpu *vcpu)
{
	/*
	 * Can we support SVE without FPSIMD? If not, this can be
	 * simplified by reversing the condition.
	 */
	if (system_supports_fpsimd() &&
	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_FP_ASIMD)
		return true;

	if (guest_has_sve && kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SVE)
		return true;

	return false;
}


static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
{
	[...]
	if (__trap_is_fpsimd_sve_access(vcpu))
		return __hyp_switch_fpsimd(vcpu, guest_has_sve);
	[...]
}

Of course not even compile-tested or anything like that.

Thanks,
-Christoffer
