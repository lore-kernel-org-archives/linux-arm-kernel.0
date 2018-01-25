From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 25 Jan 2018 20:46:53 +0100
Subject: [PATCH v3 09/41] KVM: arm64: Defer restoring host VFP state to
 vcpu_put
In-Reply-To: <20180122173326.GO22781@e103592.cambridge.arm.com>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
 <20180112120747.27999-10-christoffer.dall@linaro.org>
 <20180122173326.GO22781@e103592.cambridge.arm.com>
Message-ID: <20180125194653.GR21802@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 05:33:28PM +0000, Dave Martin wrote:
> On Fri, Jan 12, 2018 at 01:07:15PM +0100, Christoffer Dall wrote:
> > Avoid saving the guest VFP registers and restoring the host VFP
> > registers on every exit from the VM.  Only when we're about to run
> > userspace or other threads in the kernel do we really have to switch the
> > state back to the host state.
> > 
> > We still initially configure the VFP registers to trap when entering the
> > VM, but the difference is that we now leave the guest state in the
> > hardware registers as long as we're running this VCPU, even if we
> > occasionally trap to the host, and we only restore the host state when
> > we return to user space or when scheduling another thread.
> > 
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> [...]
> 
> > diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> > index 883a6383cd36..848a46eb33bf 100644
> > --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> > +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> 
> [...]
> 
> > @@ -213,6 +215,19 @@ void kvm_vcpu_load_sysregs(struct kvm_vcpu *vcpu)
> >   */
> >  void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu)
> >  {
> > +	struct kvm_cpu_context *host_ctxt = vcpu->arch.host_cpu_context;
> > +	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
> > +
> > +	/* Restore host FP/SIMD state */
> > +	if (vcpu->arch.guest_vfp_loaded) {
> > +		if (vcpu_el1_is_32bit(vcpu)) {
> > +			kvm_call_hyp(__fpsimd32_save_state,
> > +				     kern_hyp_va(guest_ctxt));
> > +		}
> > +		__fpsimd_save_state(&guest_ctxt->gp_regs.fp_regs);
> > +		__fpsimd_restore_state(&host_ctxt->gp_regs.fp_regs);
> > +		vcpu->arch.guest_vfp_loaded = 0;
> 
> Provided we've already marked the host FPSIMD state as dirty on the way
> in, we probably don't need to restore it here.
> 
> In v4.15, the kvm_fpsimd_flush_cpu_state() call in
> kvm_arch_vcpu_ioctl_run() is supposed to do this marking: currently
> it's only done for SVE, since KVM was previously restoring the host
> FPSIMD subset of the state anyway, but it could be made unconditional.
> 
> For a returning run ioctl, this would have the effect of deferring the
> host FPSIMD reload until we return to userspace, which is probably
> no more costly since the kernel must check whether to do this in
> ret_to_user anyway; OTOH if the vcpu thread was preempted by some
> other thread we save the cost of restoring the host state entirely here
> ... I think.

Yes, I agree.  However, currently the low-level logic in
arch/arm64/kvm/hyp/entry.S:__fpsimd_guest_restore which saves the host
state into vcpu->arch.host_cpu_context->gp_regs.fp_regs (where
host_cpu_context is a KVM-specific per-cpu variable).  I think means
that simply marking the state as invalid would cause the kernel to
restore some potentially stale values when returning to userspace.  Am I
missing something?

It might very well be possible to change the logic so that we store the
host logic the same place where task_fpsimd_save() would have, and I
think that would make what you suggest possible.

I'd like to make that a separate change from this patch though, as we're
already changing quite a bit with this series, so I'm trying to make any
logical change as contained per patch as possible, so that problems can
be spotted by bisecting.

> 
> Ultimately I'd like to go one better and actually treat a vcpu as a
> first-class fpsimd context, so that taking an interrupt to the host
> and then reentering the guest doesn't cause any reload at all.  

That should be the case already; kvm_vcpu_put_sysregs() is only called
when you run another thread (preemptively or voluntarily), or when you
return to user space, but making the vcpu fpsimd context a first-class
citizen fpsimd context would mean that you can run another thread (and
maybe run userspace if it doesn't use fpsimd?) without having to
save/restore anything.  Am I getting this right?

> But
> that feels like too big a step for this series, and there are likely
> side-issues I've not thought about yet.
> 

It should definitely be in separate patches, but I would be optn to
tagging something on to the end of this series if we can stabilize this
series early after -rc1 is out.

Thanks,
-Christoffer
