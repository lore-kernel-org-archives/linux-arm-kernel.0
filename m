From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 20 Apr 2016 19:29:44 +0900
Subject: [PATCH v7 07/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <57166CC9.4030804@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-8-git-send-email-james.morse@arm.com>
 <571656E9.5050402@arm.com> <57166CC9.4030804@arm.com>
Message-ID: <20160420102944.GD1234@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 06:37:13PM +0100, James Morse wrote:
> Hi Marc, Takahiro,
> 
> On 19/04/16 17:03, Marc Zyngier wrote:
> > On 01/04/16 17:53, James Morse wrote:
> >> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> >> index b5384311dec4..962904a443be 100644
> >> --- a/arch/arm/kvm/arm.c
> >> +++ b/arch/arm/kvm/arm.c
> >> @@ -591,7 +587,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >>  		/*
> >>  		 * Re-check atomic conditions
> >>  		 */
> >> -		if (signal_pending(current)) {
> >> +		if (unlikely(!__this_cpu_read(kvm_arm_hardware_enabled))) {
> >> +			/* cpu has been torn down */
> >> +			ret = 0;
> >> +			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
> >> +			run->fail_entry.hardware_entry_failure_reason
> >> +					= (u64)-ENOEXEC;
> > 
> > This hunk makes me feel a bit uneasy. Having to check something that
> > critical on the entry path is at least a bit weird. If we've reset EL2
> > already, it means that we must have forced an exit on the guest to do so.
> 
> (To save anyone else digging: the story comes from v12 of the kexec copy of this
> patch [0])
> 
> 
> > So why do we hand the control back to KVM (or anything else) once we've
> > nuked a CPU? I'd expect it to be put on some back-burner, never to
> > return in this lifetime...
> 
> This looks like the normal reboot code being called in the middle of a running
> system. Kexec calls kernel_restart_prepare(), which kicks each reboot notifier,
> one of which is kvm_reboot(), which calls:
> > on_each_cpu(hardware_disable_nolock, NULL, 1);
> 
> We have to give the CPU back as there may be other reboot notifiers, and kexec
> hasn't yet shuffled onto the boot cpu.

Right, and this kvm reboot notifier can be executed via IPI at any time
while interrupted is enabled, and so the check must be done between
local_irq_disable() and local_irq_enable().

> How about moving this check into handle_exit()[1]?
> Currently this sees ARM_EXCEPTION_IRQ, and tries to re-enter the guest, we can
> test for kvm_rebooting, which is set by kvm's reboot notifier .... but this
> would still break if another vcpu wakes from cond_resched() and sprints towards
> __kvm_vcpu_run(). Can we move cond_resched() to immediately before handle_exit()?

I don't think that it would break as reboot process is *one-directional*,
and any cpu should be torn down sooner or later.

I'm not quite sure about Marc's point, but if he has concern on overhead
of checking per-cpu kvm_arm_hardware_enabled, we may, instead, check on
kvm_rebooting.
(And this check won't make sense for VHE-enabled platform.)

Thanks,
-Takahiro AKASHI

> I can't see a reason why this doesn't happen on the normal reboot path,
> presumably we rely on user space to kill any running guests.
> 
> 
> 
> It looks like x86 uses the extable to work around this, their vmx_vcpu_run() has:
> > 		__ex(ASM_VMX_VMLAUNCH) "\n\t"
> Where __ex ends up calling ____kvm_handle_fault_on_reboot(), with a nearby comment:
> > * Hardware virtualization extension instructions may fault if a
> > * reboot turns off virtualization while processes are running.
> > * Trap the fault and ignore the instruction if that happens.
> 
> 
> Takahiro, any ideas/wisdom on this?
> 
> 
> Thanks,
> 
> James
> 
> [0] http://lists.infradead.org/pipermail/kexec/2015-December/014953.html
> [1] Untested(!) alternative.
> ====================================================
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 0e63047a9530..dfa3cc42ec89 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -562,11 +562,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct k
> vm_run *run)
>         ret = 1;
>         run->exit_reason = KVM_EXIT_UNKNOWN;
>         while (ret > 0) {
> -               /*
> -                * Check conditions before entering the guest
> -                */
> -               cond_resched();
> -
>                 update_vttbr(vcpu->kvm);
> 
>                 if (vcpu->arch.power_off || vcpu->arch.pause)
> @@ -662,6 +657,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kv
> m_run *run)
> 
>                 preempt_enable();
> 
> +               cond_resched();
> +
>                 ret = handle_exit(vcpu, run, ret);
>         }
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index eba89e42f0ed..cc562d9ff905 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -170,6 +170,12 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  {
>         exit_handle_fn exit_handler;
> 
> +       if (kvm_rebooting) {
> +               run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
> +               run->fail_entry.hardware_entry_failure_reason = (u64)-ENOEXEC;
> +               return 0;
> +       }
> +
>         switch (exception_index) {
>         case ARM_EXCEPTION_IRQ:
>                 return 1;
> ====================================================
> 
> 

-- 
Thanks,
-Takahiro AKASHI
