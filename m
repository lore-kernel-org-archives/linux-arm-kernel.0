From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 17 Mar 2014 10:49:44 -0700
Subject: [PATCH v4 10/10] ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
In-Reply-To: <CAAhSdy3kbafDc=T0dYHpULKoGKxAner+zY1vdLDDyU1JrqD2tQ@mail.gmail.com>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-11-git-send-email-anup.patel@linaro.org>
 <20140317034130.GK20648@cbox>
 <CAAhSdy3kbafDc=T0dYHpULKoGKxAner+zY1vdLDDyU1JrqD2tQ@mail.gmail.com>
Message-ID: <20140317174944.GD1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 12:24:28PM +0530, Anup Patel wrote:
> On Mon, Mar 17, 2014 at 9:11 AM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > On Thu, Feb 06, 2014 at 05:01:42PM +0530, Anup Patel wrote:
> >> This patch adds emulation of PSCI v0.2 CPU_SUSPEND function call for
> >> KVM ARM/ARM64. This is a VCPU-level function call which can suspend
> >> current VCPU or all VCPUs within current VCPU's affinity level.
> >>
> >> The CPU_SUSPEND emulation is not tested much because currently there
> >> is no CPUIDLE driver in Linux kernel that uses PSCI CPU_SUSPEND. The
> >> PSCI CPU_SUSPEND implementation in ARM64 kernel was tested using a
> >> Simple CPUIDLE driver which is not published due to unstable DT-bindings
> >> for PSCI.
> >> (For more info, http://lwn.net/Articles/574950/)
> >>
> >> Even if we had stable DT-bindings for PSCI and CPUIDLE driver that
> >> uses PSCI CPU_SUSPEND then still we need to define SUSPEND states
> >> for KVM ARM/ARM64. Due to this, the CPU_SUSPEND emulation added
> >> by this patch only pause a VCPU and to wakeup a VCPU we need to
> >> explicity call PSCI CPU_ON from Guest.

[...]

> >>
> >> +
> >> +static void psci_do_suspend(void *context)
> >> +{
> >> +     struct psci_suspend_info *sinfo = context;
> >> +
> >> +     sinfo->vcpu->arch.pause = true;
> >> +     sinfo->vcpu->arch.suspend = true;
> >> +     sinfo->vcpu->arch.suspend_entry = sinfo->saved_entry;
> >> +     sinfo->vcpu->arch.suspend_context_id = sinfo->saved_context_id;
> >
> > I don't really understand this, why are you not just setting pause =
> > true and modifying the registers as per the reentry rules in the spec?
> >
> > Doesn't seem like this patch ever reads any of these values back?
> 
> Thats because we don't have any wake-up events defined for PSCI v0.2
> emulated by KVM.
> 

That doesn't make the code any more useful.  All you're doing which has
an effect here is setting pause = true.

If you're adding the other logic to create an infrastructure for some
later time where you plan to add some logic, then (1) I think you should
wait with introducing this infrastructure until you're going to use it,
and (2) it needs a big fat comment and an explanation of this in the
commit message.

> >
> >> +}
> >> +
> >> +static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
> >> +{
> >> +     int i;
> >> +     unsigned long mpidr;
> >> +     unsigned long target_affinity;
> >> +     unsigned long target_affinity_mask;
> >> +     unsigned long lowest_affinity_level;
> >> +     struct kvm *kvm = vcpu->kvm;
> >> +     struct kvm_vcpu *tmp;
> >> +     struct psci_suspend_info sinfo;
> >> +
> >> +     target_affinity = kvm_vcpu_get_mpidr(vcpu);
> >> +     lowest_affinity_level = (*vcpu_reg(vcpu, 1) >> 24) & 0x3;
> >> +
> >> +     /* Determine target affinity mask */
> >> +     target_affinity_mask = MPIDR_HWID_BITMASK;
> >> +     switch (lowest_affinity_level) {
> >> +     case 0: /* All affinity levels are valid */
> >> +             target_affinity_mask &= ~0x0UL;
> >> +             break;
> >> +     case 1: /* Aff0 ignored */
> >> +             target_affinity_mask &= ~0xFFUL;
> >> +             break;
> >> +     case 2: /* Aff0 and Aff1 ignored */
> >> +             target_affinity_mask &= ~0xFFFFUL;
> >> +             break;
> >> +     case 3: /* Aff0, Aff1, and Aff2 ignored */
> >> +             target_affinity_mask &= ~0xFFFFFFUL;
> >> +             break;
> >> +     default:
> >> +             return KVM_PSCI_RET_INVAL;
> >> +     };
> >
> > I feel like I've read this code before, can you factor it out?
> 
> OK, I will factor-out this portion since it can be shared
> with AFFINTIY_INFO emulation.
> 
> >
> >> +
> >> +     /* Ignore other bits of target affinity */
> >> +     target_affinity &= target_affinity_mask;
> >> +
> >> +     /* Prepare suspend info */
> >> +     sinfo.vcpu = NULL;
> >> +     sinfo.saved_entry = *vcpu_reg(vcpu, 2);
> >> +     sinfo.saved_context_id = *vcpu_reg(vcpu, 3);
> >> +
> >> +     /* Suspend all VCPUs within target affinity */
> >> +     kvm_for_each_vcpu(i, tmp, kvm) {
> >> +             mpidr = kvm_vcpu_get_mpidr(tmp);
> >> +             if (((mpidr & target_affinity_mask) == target_affinity) &&
> >> +                 !tmp->arch.suspend) {
> >> +                     sinfo.vcpu = tmp;
> >> +                     smp_call_function_single(tmp->cpu,
> >> +                                              psci_do_suspend, &sinfo, 1);
> >
> > Hmmm, are you sure this is correct?  How does that correspond to the
> > PSCI docs saying
> >
> > "It is only possible to call CPU_SUSPEND from the current core. That is,
> > it is not possible to request suspension of another core."
> >
> > I would think this means, if all other cores in the specified affinity
> > level are already suspended, allow suspending the entire
> > cluster/group/..., but I may be wrong.
> 
> Actually, CPU_SUSPEND is for all cores belonging to affinity
> of current core.
> 

I don't think so, see Mark's response.  I think the note I quoted above
about it not being possible to request suspend of other cores makes it
clear that this is not the intended behavior.

> >
> > My comments above notwithstanding, this also feels racy.  What happens
> > if two virtual cores within the same affinity level calls CPU_SUSPEND at
> > the same time?
> 
> Yes, I know its racy. I was expecting this comment.

uh, ok :)  Maybe that would make this an RFC patch and known race
conditions should be pointed out at least in the commit message.

> 
> What would be appropriate lock to protect per-VCPU suspend context?
> 
> I think spinlock would be better because psci_do_suspend() is called
> using SMP IPIs.
> 

Since we are not keeping any live state for anything else than each
vcpu, this should all just be local operations and you don't need
locking at all.

If needed, a per-VM spin-lock for psci state seems appropriate, but I
didn't think carefully about this.


> >
> > Also, there doesn't seem to be any handling of the StateType requested
> > by the caller, the reentry behavior is very different depending on the
> > state you enter, unless you always treat the request as a suspend
> > (clause 3 under Section 5.4.2 in the PSCI spec), in that case that
> > deserves a comment.
> 
> The StateType is completely implementation dependent. Also, it is the
> StateType that will help determine the wake-up event.

How do you arrive at this conclusion?

The StateID is completely platform-specific.

The StateType is referenced throughout the document, and the reentry
from standby vs. power-down is very different (return to caller vs.
reentry to different entry point address).

The only exception I can find in the spec is that power-down may not
succeed and the firmware may just do standby instead, if this is what
we're doing, this needs to be very clearly commented.

> 
> For KVM, we really don't have any StateType defined hence we don't
> have any wake-up events defined for KVM PSCI.

StateType is defined in the PSCI spec, see above.

> 
> Should we have KVM specific suspend states?
> What would KVM suspend states look like because suspend states
> are platform specific?
> 

Do you mean StateID here?  I don't think we need anything for KVM.

[...]

Thanks,
-Christoffer
