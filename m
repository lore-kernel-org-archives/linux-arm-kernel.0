From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Sep 2012 18:00:31 +0100
Subject: [PATCH 10/15] KVM: ARM: World-switch implementation
In-Reply-To: <20120915153533.21241.82489.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153533.21241.82489.stgit@ubuntu>
Message-ID: <20120925170031.GF28728@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:35:33PM +0100, Christoffer Dall wrote:
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 1429d89..cd8fc86 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched.h>
>  #include <linux/mm.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/kvm_host.h>
>  #include <asm/cacheflush.h>
>  #include <asm/glue-df.h>
>  #include <asm/glue-pf.h>
> @@ -144,5 +145,48 @@ int main(void)
>    DEFINE(DMA_BIDIRECTIONAL,    DMA_BIDIRECTIONAL);
>    DEFINE(DMA_TO_DEVICE,                DMA_TO_DEVICE);
>    DEFINE(DMA_FROM_DEVICE,      DMA_FROM_DEVICE);
> +#ifdef CONFIG_KVM_ARM_HOST
> +  DEFINE(VCPU_KVM,             offsetof(struct kvm_vcpu, kvm));
> +  DEFINE(VCPU_MIDR,            offsetof(struct kvm_vcpu, arch.midr));
> +  DEFINE(VCPU_MPIDR,           offsetof(struct kvm_vcpu, arch.cp15[c0_MPIDR]));
> +  DEFINE(VCPU_CSSELR,          offsetof(struct kvm_vcpu, arch.cp15[c0_CSSELR]));
> +  DEFINE(VCPU_SCTLR,           offsetof(struct kvm_vcpu, arch.cp15[c1_SCTLR]));
> +  DEFINE(VCPU_CPACR,           offsetof(struct kvm_vcpu, arch.cp15[c1_CPACR]));
> +  DEFINE(VCPU_TTBR0,           offsetof(struct kvm_vcpu, arch.cp15[c2_TTBR0]));
> +  DEFINE(VCPU_TTBR1,           offsetof(struct kvm_vcpu, arch.cp15[c2_TTBR1]));
> +  DEFINE(VCPU_TTBCR,           offsetof(struct kvm_vcpu, arch.cp15[c2_TTBCR]));
> +  DEFINE(VCPU_DACR,            offsetof(struct kvm_vcpu, arch.cp15[c3_DACR]));
> +  DEFINE(VCPU_DFSR,            offsetof(struct kvm_vcpu, arch.cp15[c5_DFSR]));
> +  DEFINE(VCPU_IFSR,            offsetof(struct kvm_vcpu, arch.cp15[c5_IFSR]));
> +  DEFINE(VCPU_ADFSR,           offsetof(struct kvm_vcpu, arch.cp15[c5_ADFSR]));
> +  DEFINE(VCPU_AIFSR,           offsetof(struct kvm_vcpu, arch.cp15[c5_AIFSR]));
> +  DEFINE(VCPU_DFAR,            offsetof(struct kvm_vcpu, arch.cp15[c6_DFAR]));
> +  DEFINE(VCPU_IFAR,            offsetof(struct kvm_vcpu, arch.cp15[c6_IFAR]));
> +  DEFINE(VCPU_PRRR,            offsetof(struct kvm_vcpu, arch.cp15[c10_PRRR]));
> +  DEFINE(VCPU_NMRR,            offsetof(struct kvm_vcpu, arch.cp15[c10_NMRR]));
> +  DEFINE(VCPU_VBAR,            offsetof(struct kvm_vcpu, arch.cp15[c12_VBAR]));
> +  DEFINE(VCPU_CID,             offsetof(struct kvm_vcpu, arch.cp15[c13_CID]));
> +  DEFINE(VCPU_TID_URW,         offsetof(struct kvm_vcpu, arch.cp15[c13_TID_URW]));
> +  DEFINE(VCPU_TID_URO,         offsetof(struct kvm_vcpu, arch.cp15[c13_TID_URO]));
> +  DEFINE(VCPU_TID_PRIV,                offsetof(struct kvm_vcpu, arch.cp15[c13_TID_PRIV]));

Could you instead define an offset for arch.cp15, then use scaled offsets
from that in the assembly code?

> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 8a87fc7..087f9d1 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -41,6 +41,7 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/kvm_emulate.h>
> 
>  #ifdef REQUIRES_VIRT
>  __asm__(".arch_extension       virt");
> @@ -50,6 +51,10 @@ static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
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
> @@ -273,6 +278,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  {
>         vcpu->cpu = cpu;
> +       vcpu->arch.vfp_host = this_cpu_ptr(kvm_host_vfp_state);
>  }
> 
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> @@ -305,12 +311,169 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
> 
>  int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
>  {
> +       return v->mode == IN_GUEST_MODE;
> +}
> +
> +static void reset_vm_context(void *info)
> +{
> +       __kvm_flush_vm_context();
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

Why on_each_cpu? The maintenance operations should be broadcast, right?

> +       }
> +
> +       kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
> +       kvm->arch.vmid = kvm_next_vmid;
> +       kvm_next_vmid++;
> +
> +       /* update vttbr to be used with the new vmid */
> +       pgd_phys = virt_to_phys(kvm->arch.pgd);
> +       kvm->arch.vttbr = pgd_phys & ((1LLU << 40) - 1)
> +                         & ~((2 << VTTBR_X) - 1);
> +       kvm->arch.vttbr |= (u64)(kvm->arch.vmid) << 48;
> +
> +       spin_unlock(&kvm_vmid_lock);
> +}

This smells like a watered-down version of the ASID allocator. Now, I can't
really see much code sharing going on here, but perhaps your case is
simpler... do you anticipate running more than 255 VMs in parallel? If not,
then you could just invalidate the relevant TLB entries on VM shutdown and
avoid the rollover case.

> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index edf9ed5..cc9448b 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -23,6 +23,12 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_arm.h>
> +#include <asm/vfpmacros.h>
> +
> +#define VCPU_USR_REG(_reg_nr)  (VCPU_USR_REGS + (_reg_nr * 4))
> +#define VCPU_USR_SP            (VCPU_USR_REG(13))
> +#define VCPU_FIQ_REG(_reg_nr)  (VCPU_FIQ_REGS + (_reg_nr * 4))
> +#define VCPU_FIQ_SPSR          (VCPU_FIQ_REG(7))
> 
>         .text
>         .align  PAGE_SHIFT
> @@ -34,7 +40,33 @@ __kvm_hyp_code_start:
>  @  Flush per-VMID TLBs
>  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

This comment syntax crops up a few times in your .S files but doesn't match
anything currently under arch/arm/. Please can you follow what we do there
and use /* */ ?

>  ENTRY(__kvm_tlb_flush_vmid)
> +       hvc     #0                      @ Switch to Hyp mode
> +       push    {r2, r3}
> +
> +       add     r0, r0, #KVM_VTTBR
> +       ldrd    r2, r3, [r0]
> +       mcrr    p15, 6, r2, r3, c2      @ Write VTTBR
> +       isb
> +       mcr     p15, 0, r0, c8, c3, 0   @ TLBIALLIS (rt ignored)
> +       dsb
> +       isb
> +       mov     r2, #0
> +       mov     r3, #0
> +       mcrr    p15, 6, r2, r3, c2      @ Back to VMID #0
> +       isb

Do you need this isb, given that you're about to do an hvc?

> +       pop     {r2, r3}
> +       hvc     #0                      @ Back to SVC
>         bx      lr
>  ENDPROC(__kvm_tlb_flush_vmid)
> 
> @@ -42,26 +74,702 @@ ENDPROC(__kvm_tlb_flush_vmid)
>  @  Flush TLBs and instruction caches of current CPU for all VMIDs
>  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> 
> +/*
> + * void __kvm_flush_vm_context(void);
> + */
>  ENTRY(__kvm_flush_vm_context)
> +       hvc     #0                      @ switch to hyp-mode
> +
> +       mov     r0, #0                  @ rn parameter for c15 flushes is SBZ
> +       mcr     p15, 4, r0, c8, c7, 4   @ Invalidate Non-secure Non-Hyp TLB
> +       mcr     p15, 0, r0, c7, c5, 0   @ Invalidate instruction caches
> +       dsb
> +       isb

Likewise.

> +       hvc     #0                      @ switch back to svc-mode, see hyp_svc
>         bx      lr
>  ENDPROC(__kvm_flush_vm_context)
> 
> +/* These are simply for the macros to work - value don't have meaning */
> +.equ usr, 0
> +.equ svc, 1
> +.equ abt, 2
> +.equ und, 3
> +.equ irq, 4
> +.equ fiq, 5
> +
> +.macro store_mode_state base_reg, mode
> +       .if \mode == usr
> +       mrs     r2, SP_usr
> +       mov     r3, lr
> +       stmdb   \base_reg!, {r2, r3}
> +       .elseif \mode != fiq
> +       mrs     r2, SP_\mode
> +       mrs     r3, LR_\mode
> +       mrs     r4, SPSR_\mode
> +       stmdb   \base_reg!, {r2, r3, r4}
> +       .else
> +       mrs     r2, r8_fiq
> +       mrs     r3, r9_fiq
> +       mrs     r4, r10_fiq
> +       mrs     r5, r11_fiq
> +       mrs     r6, r12_fiq
> +       mrs     r7, SP_fiq
> +       mrs     r8, LR_fiq
> +       mrs     r9, SPSR_fiq
> +       stmdb   \base_reg!, {r2-r9}
> +       .endif
> +.endm

Perhaps you could stick the assembly macros into a separate file, like we do
in assembler.h, so the code is more readable and they can be reused if
need-be?

Will
