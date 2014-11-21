From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 21 Nov 2014 10:59:22 +0100
Subject: [RFC PATCH 0/6] ARM64: KVM: PMU infrastructure support
In-Reply-To: <CAAhSdy2rQf-26SjeEspcc+LgwmhDr+QeYOOSyOUApF+0-8WdeA@mail.gmail.com>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
 <20141107202502.GJ22848@cbox>
 <CAAhSdy3CPMdK9+_FesKuJaPt9=VVHsnw=DQO5UQUVNm1aPuZNg@mail.gmail.com>
 <CAMJs5B8VqS2-3dhSX+PBaQruzyXiYwaYRQ7vvWEMrHbvbjn+9A@mail.gmail.com>
 <CAAhSdy3iyMpXLh1Qq-TqZ-1W368kG0Oz9iE2McnJkYbA9ZaNPg@mail.gmail.com>
 <20141119152952.GB9776@lvm>
 <CAAhSdy2rQf-26SjeEspcc+LgwmhDr+QeYOOSyOUApF+0-8WdeA@mail.gmail.com>
Message-ID: <20141121095922.GR19598@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 08:17:32PM +0530, Anup Patel wrote:
> On Wed, Nov 19, 2014 at 8:59 PM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > On Tue, Nov 11, 2014 at 02:48:25PM +0530, Anup Patel wrote:
> >> Hi All,
> >>
> >> I have second thoughts about rebasing KVM PMU patches
> >> to Marc's irq-forwarding patches.
> >>
> >> The PMU IRQs (when virtualized by KVM) are not exactly
> >> forwarded IRQs because they are shared between Host
> >> and Guest.
> >>
> >> Scenario1
> >> -------------
> >>
> >> We might have perf running on Host and no KVM guest
> >> running. In this scenario, we wont get interrupts on Host
> >> because the kvm_pmu_hyp_init() (similar to the function
> >> kvm_timer_hyp_init() of Marc's IRQ-forwarding
> >> implementation) has put all host PMU IRQs in forwarding
> >> mode.
> >>
> >> The only way solve this problem is to not set forwarding
> >> mode for PMU IRQs in kvm_pmu_hyp_init() and instead
> >> have special routines to turn on and turn off the forwarding
> >> mode of PMU IRQs. These routines will be called from
> >> kvm_arch_vcpu_ioctl_run() for toggling the PMU IRQ
> >> forwarding state.
> >>
> >> Scenario2
> >> -------------
> >>
> >> We might have perf running on Host and Guest simultaneously
> >> which means it is quite likely that PMU HW trigger IRQ meant
> >> for Host between "ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);"
> >> and "kvm_pmu_sync_hwstate(vcpu);" (similar to timer sync routine
> >> of Marc's patchset which is called before local_irq_enable()).
> >>
> >> In this scenario, the updated kvm_pmu_sync_hwstate(vcpu)
> >> will accidentally forward IRQ meant for Host to Guest unless
> >> we put additional checks to inspect VCPU PMU state.
> >>
> >> Am I missing any detail about IRQ forwarding for above
> >> scenarios?
> >>
> > Hi Anup,
> 
> Hi Christoffer,
> 
> >
> > I briefly discussed this with Marc.  What I don't understand is how it
> > would be possible to get an interrupt for the host while running the
> > guest?
> >
> > The rationale behind my question is that whenever you're running the
> > guest, the PMU should be programmed exclusively with guest state, and
> > since the PMU is per core, any interrupts should be for the guest, where
> > it would always be pending.
> 
> Yes, thats right PMU is programmed exclusively for guest when
> guest is running and for host when host is running.
> 
> Let us assume a situation (Scenario2 mentioned previously)
> where both host and guest are using PMU. When the guest is
> running we come back to host mode due to variety of reasons
> (stage2 fault, guest IO, regular host interrupt, host interrupt
> meant for guest, ....) which means we will return from the
> "ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);" statement in the
> kvm_arch_vcpu_ioctl_run() function with local IRQs disabled.
> At this point we would have restored back host PMU context and
> any PMU counter used by host can trigger PMU overflow interrup
> for host. Now we will be having "kvm_pmu_sync_hwstate(vcpu);"
> in the kvm_arch_vcpu_ioctl_run() function (similar to the
> kvm_timer_sync_hwstate() of Marc's IRQ forwarding patchset)
> which will try to detect PMU irq forwarding state in GIC hence it
> can accidentally discover PMU irq pending for guest while this
> PMU irq is actually meant for host.
> 
> This above mentioned situation does not happen for timer
> because virtual timer interrupts are exclusively used for guest.
> The exclusive use of virtual timer interrupt for guest ensures that
> the function kvm_timer_sync_hwstate() will always see correct
> state of virtual timer IRQ from GIC.
> 
I'm not quite following.

When you call kvm_pmu_sync_hwstate(vcpu) in the non-preemtible section,
you would (1) capture the active state of the IRQ pertaining to the
guest and (2) deactive the IRQ on the host, then (3) switch the state of
the PMU to the host state, and finally (4) re-enable IRQs on the CPU
you're running on.

If the host PMU state restored in (3) causes the PMU to raise an
interrupt, you'll take an interrupt after (4), which is for the host,
and you'll handle it on the host.

Whenever you schedule the guest VCPU again, you'll (a) disable
interrupts on the CPU, (b) restore the active state of the IRQ for the
guest, (c) restore the guest PMU state, (d) switch to the guest with
IRQs enabled on the CPU (potentially).

If the state in (c) causes an IRQ it will not fire on the host, because
it is marked as active in (b).

Where does this break?

-Christoffer
