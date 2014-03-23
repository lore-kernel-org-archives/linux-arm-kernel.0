From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Mar 2014 10:54:13 -0700
Subject: [PATCH v5 10/11] ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
In-Reply-To: <CALrVBksdYsNhWY9fr1PZOqNfmfo3BiLWzy0gGx+6SAATQ-eVwA@mail.gmail.com>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
 <1395406414-11707-11-git-send-email-anup.patel@linaro.org>
 <20140321233715.GE25519@cbox>
 <CALrVBksdYsNhWY9fr1PZOqNfmfo3BiLWzy0gGx+6SAATQ-eVwA@mail.gmail.com>
Message-ID: <20140323175413.GF30885@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 10:03:28AM +0530, Anup Patel wrote:
> On 22 March 2014 05:07, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Fri, Mar 21, 2014 at 06:23:33PM +0530, Anup Patel wrote:
> >> This patch adds emulation of PSCI v0.2 CPU_SUSPEND function call for
> >> KVM ARM/ARM64. This is a CPU-level function call which can suspend
> >> current CPU or current CPU cluster. We don't have VCPU clusters in
> >> KVM so for KVM we simply suspend the current VCPU.
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
> >> for KVM ARM/ARM64.
> >>
> >> Due to this, the CPU_SUSPEND emulation added by this patch only pause
> >> current VCPU and to wakeup a suspended VCPU we need to explicity call
> >> PSCI CPU_ON from Guest.
> >>
> >> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> >> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> >> ---
> >>  arch/arm/kvm/psci.c |   24 ++++++++++++++++++++----
> >>  1 file changed, 20 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> >> index 1e85452..e32ad10 100644
> >> --- a/arch/arm/kvm/psci.c
> >> +++ b/arch/arm/kvm/psci.c
> >> @@ -52,6 +52,22 @@ static unsigned long psci_affinity_mask(unsigned long affinity_level)
> >>       return affinity_mask;
> >>  }
> >>
> >> +static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
> >> +{
> >> +     /*
> >> +      * NOTE: Currently, we don't have any wakeup events for KVM
> >> +      * hence VCPU suspend turns-out to be same as VCPU off request.
> >> +      * This means to suspend a VCPU we simply set the pause flag
> >> +      * and update VCPU registers as-per wakeup parameters provided
> >> +      * via r2 & r3 (or x2 & x3).
> >> +      */
> >> +     vcpu->arch.pause = true;
> >> +     *vcpu_pc(vcpu) = *vcpu_reg(vcpu, 2);
> >> +     *vcpu_reg(vcpu, 0) = *vcpu_reg(vcpu, 3);
> >
> > But the spec states in Section 5.1.2 that if Bit[16] StateType == 0,
> > then the entry point and context_id parameters are ignored, because all
> > state is retained for a standby state.
> 
> OK, I will update this accordingly.
> 
> >
> > I think Mark Rutland commented that KVM should define at last interrupts
> > to the CPU as a wakeup event.
> 
> How about using kvm_vcpu_block(vcpu) instead of "vcpu->arch.pause = true"?

You mean if StateType==0 only, or will you always force a shutdown event
to be handled as a suspend event (I believe the spec allows for you to
do so)?  If you are going down this path, please document that clearly
somewhere.

I definitely want to see us using something like kvm_vcpu_block(vcpu)
for suspend requests, but the thing with kvm_vcpu_block() is that a
regular signal to the VCPU thread wakes up that VCPU, which I think we
agreed was fine for the WFI implementation, as it should handle spurious
interrupts as wake up events (which is also how we handle the fact that
any VCPUs in WFI will be woken up when migrated).

But for PSCI CPU_SUSPEND, I'm not sure if that's still a valid
assumption.  Anyone?

> 
> This will make CPU_SUSPEND emulation very similar to WFI emulation.
> 

Yes, I think the PSCI docs suggest this should be the behavior as well.

Thanks,
-Christoffer
