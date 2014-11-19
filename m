From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Nov 2014 07:29:52 -0800
Subject: [RFC PATCH 0/6] ARM64: KVM: PMU infrastructure support
In-Reply-To: <CAAhSdy3iyMpXLh1Qq-TqZ-1W368kG0Oz9iE2McnJkYbA9ZaNPg@mail.gmail.com>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
 <20141107202502.GJ22848@cbox>
 <CAAhSdy3CPMdK9+_FesKuJaPt9=VVHsnw=DQO5UQUVNm1aPuZNg@mail.gmail.com>
 <CAMJs5B8VqS2-3dhSX+PBaQruzyXiYwaYRQ7vvWEMrHbvbjn+9A@mail.gmail.com>
 <CAAhSdy3iyMpXLh1Qq-TqZ-1W368kG0Oz9iE2McnJkYbA9ZaNPg@mail.gmail.com>
Message-ID: <20141119152952.GB9776@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 02:48:25PM +0530, Anup Patel wrote:
> Hi All,
> 
> I have second thoughts about rebasing KVM PMU patches
> to Marc's irq-forwarding patches.
> 
> The PMU IRQs (when virtualized by KVM) are not exactly
> forwarded IRQs because they are shared between Host
> and Guest.
> 
> Scenario1
> -------------
> 
> We might have perf running on Host and no KVM guest
> running. In this scenario, we wont get interrupts on Host
> because the kvm_pmu_hyp_init() (similar to the function
> kvm_timer_hyp_init() of Marc's IRQ-forwarding
> implementation) has put all host PMU IRQs in forwarding
> mode.
> 
> The only way solve this problem is to not set forwarding
> mode for PMU IRQs in kvm_pmu_hyp_init() and instead
> have special routines to turn on and turn off the forwarding
> mode of PMU IRQs. These routines will be called from
> kvm_arch_vcpu_ioctl_run() for toggling the PMU IRQ
> forwarding state.
> 
> Scenario2
> -------------
> 
> We might have perf running on Host and Guest simultaneously
> which means it is quite likely that PMU HW trigger IRQ meant
> for Host between "ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);"
> and "kvm_pmu_sync_hwstate(vcpu);" (similar to timer sync routine
> of Marc's patchset which is called before local_irq_enable()).
> 
> In this scenario, the updated kvm_pmu_sync_hwstate(vcpu)
> will accidentally forward IRQ meant for Host to Guest unless
> we put additional checks to inspect VCPU PMU state.
> 
> Am I missing any detail about IRQ forwarding for above
> scenarios?
> 
Hi Anup,

I briefly discussed this with Marc.  What I don't understand is how it
would be possible to get an interrupt for the host while running the
guest?

The rationale behind my question is that whenever you're running the
guest, the PMU should be programmed exclusively with guest state, and
since the PMU is per core, any interrupts should be for the guest, where
it would always be pending.

When migrating a VM with a pending PMU interrupt away for a CPU core, we
also capture the active state (the forwarding patches already handle
this), and obviously the PMU state along with it.

Does this address your concern?

-Christoffer
