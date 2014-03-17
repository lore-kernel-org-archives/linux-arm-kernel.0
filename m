From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Mar 2014 11:28:21 +0000
Subject: [PATCH v4 10/10] ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
In-Reply-To: <CAAhSdy3kbafDc=T0dYHpULKoGKxAner+zY1vdLDDyU1JrqD2tQ@mail.gmail.com>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-11-git-send-email-anup.patel@linaro.org>
 <20140317034130.GK20648@cbox>
 <CAAhSdy3kbafDc=T0dYHpULKoGKxAner+zY1vdLDDyU1JrqD2tQ@mail.gmail.com>
Message-ID: <20140317112820.GF8070@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 06:54:28AM +0000, Anup Patel wrote:
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
> >>
> >> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> >> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> >> ---
> >>  arch/arm/include/asm/kvm_host.h   |    5 +++
> >>  arch/arm/include/asm/kvm_psci.h   |    1 +
> >>  arch/arm/kvm/psci.c               |   88 +++++++++++++++++++++++++++++++++++--
> >>  arch/arm/kvm/reset.c              |    4 ++
> >>  arch/arm64/include/asm/kvm_host.h |    5 +++
> >>  arch/arm64/include/asm/kvm_psci.h |    1 +
> >>  arch/arm64/kvm/reset.c            |    4 ++
> >>  7 files changed, 104 insertions(+), 4 deletions(-)

[...]

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

I would expect interrupts to wake secondaries (e.g. SGIs for the
broadcast timer). Do you have that at least?

[...]

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

Per 5.4.3 in the PSCI 0.2 spec:

    The power state parameter expresses a constraint:
      Caller allows entry down to this state, but no deeper.

The AffinityLevel parameter is a maximum level to suspend, not a
required level to suspend. CPUs are never forcibly suspended.

There's an example table in 5.4.3 which might help to clarify.

> 
> >
> > My comments above notwithstanding, this also feels racy.  What happens
> > if two virtual cores within the same affinity level calls CPU_SUSPEND at
> > the same time?
> 
> Yes, I know its racy. I was expecting this comment.
> 
> What would be appropriate lock to protect per-VCPU suspend context?
> 
> I think spinlock would be better because psci_do_suspend() is called
> using SMP IPIs.
> 
> >
> > Also, there doesn't seem to be any handling of the StateType requested
> > by the caller, the reentry behavior is very different depending on the
> > state you enter, unless you always treat the request as a suspend
> > (clause 3 under Section 5.4.2 in the PSCI spec), in that case that
> > deserves a comment.
> 
> The StateType is completely implementation dependent. Also, it is the
> StateType that will help determine the wake-up event.
> 
> For KVM, we really don't have any StateType defined hence we don't
> have any wake-up events defined for KVM PSCI.
> 
> Should we have KVM specific suspend states?
> What would KVM suspend states look like because suspend states
> are platform specific?

This is something we need to figure out how to describe to the kernel.

Cheers,
Mark.
