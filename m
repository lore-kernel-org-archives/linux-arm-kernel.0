From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 14:57:58 +0000
Subject: [PATCH v4 08/14] KVM: ARM: World-switch implementation
In-Reply-To: <20121110154306.2836.93473.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154306.2836.93473.stgit@chazy-air>
Message-ID: <20121119145758.GA3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:43:06PM +0000, Christoffer Dall wrote:
> Provides complete world-switch implementation to switch to other guests
> running in non-secure modes. Includes Hyp exception handlers that
> capture necessary exception information and stores the information on
> the VCPU and KVM structures.

[...]

> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 15e2ab1..d8f8c60 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -40,6 +40,7 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/kvm_emulate.h>
> 
>  #ifdef REQUIRES_VIRT
>  __asm__(".arch_extension       virt");
> @@ -49,6 +50,10 @@ static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>  static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
>  static unsigned long hyp_default_vectors;
> 
> +/* The VMID used in the VTTBR */
> +static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
> +static u8 kvm_next_vmid;
> +static DEFINE_SPINLOCK(kvm_vmid_lock);
> 
>  int kvm_arch_hardware_enable(void *garbage)
>  {
> @@ -264,6 +269,8 @@ int __attribute_const__ kvm_target_cpu(void)
> 
>  int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>  {
> +       /* Force users to call KVM_ARM_VCPU_INIT */
> +       vcpu->arch.target = -1;
>         return 0;
>  }
> 
> @@ -274,6 +281,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  {
>         vcpu->cpu = cpu;
> +       vcpu->arch.vfp_host = this_cpu_ptr(kvm_host_vfp_state);
>  }
> 
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> @@ -306,12 +314,168 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
> 
>  int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
>  {
> +       return v->mode == IN_GUEST_MODE;
> +}
> +
> +static void reset_vm_context(void *info)
> +{
> +       kvm_call_hyp(__kvm_flush_vm_context);
> +}
> +
> +/**
> + * need_new_vmid_gen - check that the VMID is still valid
> + * @kvm: The VM's VMID to checkt
> + *
> + * return true if there is a new generation of VMIDs being used
> + *
> + * The hardware supports only 256 values with the value zero reserved for the
> + * host, so we check if an assigned value belongs to a previous generation,
> + * which which requires us to assign a new value. If we're the first to use a
> + * VMID for the new generation, we must flush necessary caches and TLBs on all
> + * CPUs.
> + */
> +static bool need_new_vmid_gen(struct kvm *kvm)
> +{
> +       return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
> +}
> +
> +/**
> + * update_vttbr - Update the VTTBR with a valid VMID before the guest runs
> + * @kvm        The guest that we are about to run
> + *
> + * Called from kvm_arch_vcpu_ioctl_run before entering the guest to ensure the
> + * VM has a valid VMID, otherwise assigns a new one and flushes corresponding
> + * caches and TLBs.
> + */
> +static void update_vttbr(struct kvm *kvm)
> +{
> +       phys_addr_t pgd_phys;
> +       u64 vmid;
> +
> +       if (!need_new_vmid_gen(kvm))
> +               return;
> +
> +       spin_lock(&kvm_vmid_lock);
> +
> +       /* First user of a new VMID generation? */
> +       if (unlikely(kvm_next_vmid == 0)) {
> +               atomic64_inc(&kvm_vmid_gen);
> +               kvm_next_vmid = 1;
> +
> +               /*
> +                * On SMP we know no other CPUs can use this CPU's or
> +                * each other's VMID since the kvm_vmid_lock blocks
> +                * them from reentry to the guest.
> +                */
> +               on_each_cpu(reset_vm_context, NULL, 1);
> +       }
> +
> +       kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
> +       kvm->arch.vmid = kvm_next_vmid;
> +       kvm_next_vmid++;
> +
> +       /* update vttbr to be used with the new vmid */
> +       pgd_phys = virt_to_phys(kvm->arch.pgd);
> +       vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
> +       kvm->arch.vttbr = pgd_phys & VTTBR_BADDR_MASK;
> +       kvm->arch.vttbr |= vmid;
> +
> +       spin_unlock(&kvm_vmid_lock);
> +}

I must be missing something here: how do you ensure that a guest running
on multiple CPUs continues to have the same VMID across them after a
rollover?

> +
> +/*
> + * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
> + * proper exit to QEMU.
> + */
> +static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +                      int exception_index)
> +{
> +       run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>         return 0;
>  }
> 
> +/**
> + * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
> + * @vcpu:      The VCPU pointer
> + * @run:       The kvm_run structure pointer used for userspace state exchange
> + *
> + * This function is called through the VCPU_RUN ioctl called from user space. It
> + * will execute VM code in a loop until the time slice for the process is used
> + * or some emulation is needed from user space in which case the function will
> + * return with return value 0 and with the kvm_run structure filled in with the
> + * required data for the requested emulation.
> + */
>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -       return -EINVAL;
> +       int ret;
> +       sigset_t sigsaved;
> +
> +       /* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
> +       if (unlikely(vcpu->arch.target < 0))
> +               return -ENOEXEC;
> +
> +       if (vcpu->sigset_active)
> +               sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
> +
> +       ret = 1;
> +       run->exit_reason = KVM_EXIT_UNKNOWN;
> +       while (ret > 0) {
> +               /*
> +                * Check conditions before entering the guest
> +                */
> +               cond_resched();
> +
> +               update_vttbr(vcpu->kvm);
> +
> +               local_irq_disable();
> +
> +               /*
> +                * Re-check atomic conditions
> +                */
> +               if (signal_pending(current)) {
> +                       ret = -EINTR;
> +                       run->exit_reason = KVM_EXIT_INTR;
> +               }
> +
> +               if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
> +                       local_irq_enable();
> +                       continue;
> +               }

I don't see what the VMID generation check buys you here as you're not
holding the vmid lock, so rollover can occur at any time. If rollover
*does* occur, you'll get signalled when re-enabling interrupts during
guest entry, right?

Is it because your rollover handling doesn't actually update the vttbr
directly and relies on guest sched in to do it? If so, this all feels
pretty racy to me.

Will
