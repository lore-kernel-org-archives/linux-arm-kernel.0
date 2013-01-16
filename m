From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 15 Jan 2013 23:08:24 -0500
Subject: [PATCH v5 07/14] KVM: ARM: World-switch implementation
In-Reply-To: <CANM98q+qScaXniyYjrd9QEZzWKzj3PkCE0YNFUp2ijnCfS_v4w@mail.gmail.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183924.46302.65998.stgit@ubuntu>
 <20130115094312.GI11529@redhat.com>
 <CANM98q+qScaXniyYjrd9QEZzWKzj3PkCE0YNFUp2ijnCfS_v4w@mail.gmail.com>
Message-ID: <CANM98qJZcuF95-D=1Qu6cwXUkQrR4a12bZtrZOuP00U2HGkjMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 9:08 PM, Christoffer Dall
<c.dall@virtualopensystems.com> wrote:
> On Tue, Jan 15, 2013 at 4:43 AM, Gleb Natapov <gleb@redhat.com> wrote:
>> On Tue, Jan 08, 2013 at 01:39:24PM -0500, Christoffer Dall wrote:
>>> Provides complete world-switch implementation to switch to other guests
>>> running in non-secure modes. Includes Hyp exception handlers that
>>> capture necessary exception information and stores the information on
>>> the VCPU and KVM structures.
>>>
>>> The following Hyp-ABI is also documented in the code:
>>>
>>> Hyp-ABI: Calling HYP-mode functions from host (in SVC mode):
>>>    Switching to Hyp mode is done through a simple HVC #0 instruction. The
>>>    exception vector code will check that the HVC comes from VMID==0 and if
>>>    so will push the necessary state (SPSR, lr_usr) on the Hyp stack.
>>>    - r0 contains a pointer to a HYP function
>>>    - r1, r2, and r3 contain arguments to the above function.
>>>    - The HYP function will be called with its arguments in r0, r1 and r2.
>>>    On HYP function return, we return directly to SVC.
>>>
>>> A call to a function executing in Hyp mode is performed like the following:
>>>
>>>         <svc code>
>>>         ldr     r0, =BSYM(my_hyp_fn)
>>>         ldr     r1, =my_param
>>>         hvc #0  ; Call my_hyp_fn(my_param) from HYP mode
>>>         <svc code>
>>>
>>> Otherwise, the world-switch is pretty straight-forward. All state that
>>> can be modified by the guest is first backed up on the Hyp stack and the
>>> VCPU values is loaded onto the hardware. State, which is not loaded, but
>>> theoretically modifiable by the guest is protected through the
>>> virtualiation features to generate a trap and cause software emulation.
>>> Upon guest returns, all state is restored from hardware onto the VCPU
>>> struct and the original state is restored from the Hyp-stack onto the
>>> hardware.
>>>
>>> SMP support using the VMPIDR calculated on the basis of the host MPIDR
>>> and overriding the low bits with KVM vcpu_id contributed by Marc Zyngier.
>>>
>>> Reuse of VMIDs has been implemented by Antonios Motakis and adapated from
>>> a separate patch into the appropriate patches introducing the
>>> functionality. Note that the VMIDs are stored per VM as required by the ARM
>>> architecture reference manual.
>>>
>>> To support VFP/NEON we trap those instructions using the HPCTR. When
>>> we trap, we switch the FPU.  After a guest exit, the VFP state is
>>> returned to the host.  When disabling access to floating point
>>> instructions, we also mask FPEXC_EN in order to avoid the guest
>>> receiving Undefined instruction exceptions before we have a chance to
>>> switch back the floating point state.  We are reusing vfp_hard_struct,
>>> so we depend on VFPv3 being enabled in the host kernel, if not, we still
>>> trap cp10 and cp11 in order to inject an undefined instruction exception
>>> whenever the guest tries to use VFP/NEON. VFP/NEON developed by
>>> Antionios Motakis and Rusty Russell.
>>>
>>> Aborts that are permission faults, and not stage-1 page table walk, do
>>> not report the faulting address in the HPFAR.  We have to resolve the
>>> IPA, and store it just like the HPFAR register on the VCPU struct. If
>>> the IPA cannot be resolved, it means another CPU is playing with the
>>> page tables, and we simply restart the guest.  This quirk was fixed by
>>> Marc Zyngier.
>>>
>>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>>> Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
>>> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>> ---
>>>  arch/arm/include/asm/kvm_arm.h  |   51 ++++
>>>  arch/arm/include/asm/kvm_host.h |   10 +
>>>  arch/arm/kernel/asm-offsets.c   |   25 ++
>>>  arch/arm/kvm/arm.c              |  187 ++++++++++++++++
>>>  arch/arm/kvm/interrupts.S       |  396 +++++++++++++++++++++++++++++++++++
>>>  arch/arm/kvm/interrupts_head.S  |  443 +++++++++++++++++++++++++++++++++++++++
>>>  6 files changed, 1108 insertions(+), 4 deletions(-)
>>>  create mode 100644 arch/arm/kvm/interrupts_head.S
>>>
>>> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
>>> index fb22ee8..a3262a2 100644
>>> --- a/arch/arm/include/asm/kvm_arm.h
>>> +++ b/arch/arm/include/asm/kvm_arm.h
>>> @@ -98,6 +98,18 @@
>>>  #define TTBCR_T0SZ   3
>>>  #define HTCR_MASK    (TTBCR_T0SZ | TTBCR_IRGN0 | TTBCR_ORGN0 | TTBCR_SH0)
>>>
>>> +/* Hyp System Trap Register */
>>> +#define HSTR_T(x)    (1 << x)
>>> +#define HSTR_TTEE    (1 << 16)
>>> +#define HSTR_TJDBX   (1 << 17)
>>> +
>>> +/* Hyp Coprocessor Trap Register */
>>> +#define HCPTR_TCP(x) (1 << x)
>>> +#define HCPTR_TCP_MASK       (0x3fff)
>>> +#define HCPTR_TASE   (1 << 15)
>>> +#define HCPTR_TTA    (1 << 20)
>>> +#define HCPTR_TCPAC  (1 << 31)
>>> +
>>>  /* Hyp Debug Configuration Register bits */
>>>  #define HDCR_TDRA    (1 << 11)
>>>  #define HDCR_TDOSA   (1 << 10)
>>> @@ -144,6 +156,45 @@
>>>  #else
>>>  #define VTTBR_X              (5 - KVM_T0SZ)
>>>  #endif
>>> +#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
>>> +#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
>>> +#define VTTBR_VMID_SHIFT  (48LLU)
>>> +#define VTTBR_VMID_MASK        (0xffLLU << VTTBR_VMID_SHIFT)
>>> +
>>> +/* Hyp Syndrome Register (HSR) bits */
>>> +#define HSR_EC_SHIFT (26)
>>> +#define HSR_EC               (0x3fU << HSR_EC_SHIFT)
>>> +#define HSR_IL               (1U << 25)
>>> +#define HSR_ISS              (HSR_IL - 1)
>>> +#define HSR_ISV_SHIFT        (24)
>>> +#define HSR_ISV              (1U << HSR_ISV_SHIFT)
>>> +#define HSR_FSC              (0x3f)
>>> +#define HSR_FSC_TYPE (0x3c)
>>> +#define HSR_WNR              (1 << 6)
>>> +
>>> +#define FSC_FAULT    (0x04)
>>> +#define FSC_PERM     (0x0c)
>>> +
>>> +/* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
>>> +#define HPFAR_MASK   (~0xf)
>>>
>>> +#define HSR_EC_UNKNOWN       (0x00)
>>> +#define HSR_EC_WFI   (0x01)
>>> +#define HSR_EC_CP15_32       (0x03)
>>> +#define HSR_EC_CP15_64       (0x04)
>>> +#define HSR_EC_CP14_MR       (0x05)
>>> +#define HSR_EC_CP14_LS       (0x06)
>>> +#define HSR_EC_CP_0_13       (0x07)
>>> +#define HSR_EC_CP10_ID       (0x08)
>>> +#define HSR_EC_JAZELLE       (0x09)
>>> +#define HSR_EC_BXJ   (0x0A)
>>> +#define HSR_EC_CP14_64       (0x0C)
>>> +#define HSR_EC_SVC_HYP       (0x11)
>>> +#define HSR_EC_HVC   (0x12)
>>> +#define HSR_EC_SMC   (0x13)
>>> +#define HSR_EC_IABT  (0x20)
>>> +#define HSR_EC_IABT_HYP      (0x21)
>>> +#define HSR_EC_DABT  (0x24)
>>> +#define HSR_EC_DABT_HYP      (0x25)
>>>
>>>  #endif /* __ARM_KVM_ARM_H__ */
>>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>>> index 1de6f0d..ddb09da 100644
>>> --- a/arch/arm/include/asm/kvm_host.h
>>> +++ b/arch/arm/include/asm/kvm_host.h
>>> @@ -21,6 +21,7 @@
>>>
>>>  #include <asm/kvm.h>
>>>  #include <asm/kvm_asm.h>
>>> +#include <asm/fpstate.h>
>>>
>>>  #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
>>>  #define KVM_USER_MEM_SLOTS 32
>>> @@ -85,6 +86,14 @@ struct kvm_vcpu_arch {
>>>       u32 hxfar;              /* Hyp Data/Inst Fault Address Register */
>>>       u32 hpfar;              /* Hyp IPA Fault Address Register */
>>>
>>> +     /* Floating point registers (VFP and Advanced SIMD/NEON) */
>>> +     struct vfp_hard_struct vfp_guest;
>>> +     struct vfp_hard_struct *vfp_host;
>>> +
>>> +     /*
>>> +      * Anything that is not used directly from assembly code goes
>>> +      * here.
>>> +      */
>>>       /* Interrupt related fields */
>>>       u32 irq_lines;          /* IRQ and FIQ levels */
>>>
>>> @@ -112,6 +121,7 @@ struct kvm_one_reg;
>>>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>>>  int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>>>  u64 kvm_call_hyp(void *hypfn, ...);
>>> +void force_vm_exit(const cpumask_t *mask);
>>>
>>>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>>>  struct kvm;
>>> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
>>> index c985b48..c8b3272 100644
>>> --- a/arch/arm/kernel/asm-offsets.c
>>> +++ b/arch/arm/kernel/asm-offsets.c
>>> @@ -13,6 +13,9 @@
>>>  #include <linux/sched.h>
>>>  #include <linux/mm.h>
>>>  #include <linux/dma-mapping.h>
>>> +#ifdef CONFIG_KVM_ARM_HOST
>>> +#include <linux/kvm_host.h>
>>> +#endif
>>>  #include <asm/cacheflush.h>
>>>  #include <asm/glue-df.h>
>>>  #include <asm/glue-pf.h>
>>> @@ -146,5 +149,27 @@ int main(void)
>>>    DEFINE(DMA_BIDIRECTIONAL,  DMA_BIDIRECTIONAL);
>>>    DEFINE(DMA_TO_DEVICE,              DMA_TO_DEVICE);
>>>    DEFINE(DMA_FROM_DEVICE,    DMA_FROM_DEVICE);
>>> +#ifdef CONFIG_KVM_ARM_HOST
>>> +  DEFINE(VCPU_KVM,           offsetof(struct kvm_vcpu, kvm));
>>> +  DEFINE(VCPU_MIDR,          offsetof(struct kvm_vcpu, arch.midr));
>>> +  DEFINE(VCPU_CP15,          offsetof(struct kvm_vcpu, arch.cp15));
>>> +  DEFINE(VCPU_VFP_GUEST,     offsetof(struct kvm_vcpu, arch.vfp_guest));
>>> +  DEFINE(VCPU_VFP_HOST,              offsetof(struct kvm_vcpu, arch.vfp_host));
>>> +  DEFINE(VCPU_REGS,          offsetof(struct kvm_vcpu, arch.regs));
>>> +  DEFINE(VCPU_USR_REGS,              offsetof(struct kvm_vcpu, arch.regs.usr_regs));
>>> +  DEFINE(VCPU_SVC_REGS,              offsetof(struct kvm_vcpu, arch.regs.svc_regs));
>>> +  DEFINE(VCPU_ABT_REGS,              offsetof(struct kvm_vcpu, arch.regs.abt_regs));
>>> +  DEFINE(VCPU_UND_REGS,              offsetof(struct kvm_vcpu, arch.regs.und_regs));
>>> +  DEFINE(VCPU_IRQ_REGS,              offsetof(struct kvm_vcpu, arch.regs.irq_regs));
>>> +  DEFINE(VCPU_FIQ_REGS,              offsetof(struct kvm_vcpu, arch.regs.fiq_regs));
>>> +  DEFINE(VCPU_PC,            offsetof(struct kvm_vcpu, arch.regs.usr_regs.ARM_pc));
>>> +  DEFINE(VCPU_CPSR,          offsetof(struct kvm_vcpu, arch.regs.usr_regs.ARM_cpsr));
>>> +  DEFINE(VCPU_IRQ_LINES,     offsetof(struct kvm_vcpu, arch.irq_lines));
>>> +  DEFINE(VCPU_HSR,           offsetof(struct kvm_vcpu, arch.hsr));
>>> +  DEFINE(VCPU_HxFAR,         offsetof(struct kvm_vcpu, arch.hxfar));
>>> +  DEFINE(VCPU_HPFAR,         offsetof(struct kvm_vcpu, arch.hpfar));
>>> +  DEFINE(VCPU_HYP_PC,                offsetof(struct kvm_vcpu, arch.hyp_pc));
>>> +  DEFINE(KVM_VTTBR,          offsetof(struct kvm, arch.vttbr));
>>> +#endif
>>>    return 0;
>>>  }
>>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>>> index 9b4566e..c94d278 100644
>>> --- a/arch/arm/kvm/arm.c
>>> +++ b/arch/arm/kvm/arm.c
>>> @@ -40,6 +40,7 @@
>>>  #include <asm/kvm_arm.h>
>>>  #include <asm/kvm_asm.h>
>>>  #include <asm/kvm_mmu.h>
>>> +#include <asm/kvm_emulate.h>
>>>
>>>  #ifdef REQUIRES_VIRT
>>>  __asm__(".arch_extension     virt");
>>> @@ -49,6 +50,10 @@ static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>>>  static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
>>>  static unsigned long hyp_default_vectors;
>>>
>>> +/* The VMID used in the VTTBR */
>>> +static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
>>> +static u8 kvm_next_vmid;
>>> +static DEFINE_SPINLOCK(kvm_vmid_lock);
>>>
>>>  int kvm_arch_hardware_enable(void *garbage)
>>>  {
>>> @@ -276,6 +281,8 @@ int __attribute_const__ kvm_target_cpu(void)
>>>
>>>  int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>>>  {
>>> +     /* Force users to call KVM_ARM_VCPU_INIT */
>>> +     vcpu->arch.target = -1;
>>>       return 0;
>>>  }
>>>
>>> @@ -286,6 +293,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
>>>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>>>  {
>>>       vcpu->cpu = cpu;
>>> +     vcpu->arch.vfp_host = this_cpu_ptr(kvm_host_vfp_state);
>>>  }
>>>
>>>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>>> @@ -318,12 +326,189 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>>>
>>>  int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
>> As far as I see the function is unused.
>>
>>>  {
>>> +     return v->mode == IN_GUEST_MODE;
>>> +}
>>> +
>>> +/* Just ensure a guest exit from a particular CPU */
>>> +static void exit_vm_noop(void *info)
>>> +{
>>> +}
>>> +
>>> +void force_vm_exit(const cpumask_t *mask)
>>> +{
>>> +     smp_call_function_many(mask, exit_vm_noop, NULL, true);
>>> +}
>> There is make_all_cpus_request() for that. It actually sends IPIs only
>> to cpus that are running vcpus.
>>
>>> +
>>> +/**
>>> + * need_new_vmid_gen - check that the VMID is still valid
>>> + * @kvm: The VM's VMID to checkt
>>> + *
>>> + * return true if there is a new generation of VMIDs being used
>>> + *
>>> + * The hardware supports only 256 values with the value zero reserved for the
>>> + * host, so we check if an assigned value belongs to a previous generation,
>>> + * which which requires us to assign a new value. If we're the first to use a
>>> + * VMID for the new generation, we must flush necessary caches and TLBs on all
>>> + * CPUs.
>>> + */
>>> +static bool need_new_vmid_gen(struct kvm *kvm)
>>> +{
>>> +     return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
>>> +}
>>> +
>>> +/**
>>> + * update_vttbr - Update the VTTBR with a valid VMID before the guest runs
>>> + * @kvm      The guest that we are about to run
>>> + *
>>> + * Called from kvm_arch_vcpu_ioctl_run before entering the guest to ensure the
>>> + * VM has a valid VMID, otherwise assigns a new one and flushes corresponding
>>> + * caches and TLBs.
>>> + */
>>> +static void update_vttbr(struct kvm *kvm)
>>> +{
>>> +     phys_addr_t pgd_phys;
>>> +     u64 vmid;
>>> +
>>> +     if (!need_new_vmid_gen(kvm))
>>> +             return;
>>> +
>>> +     spin_lock(&kvm_vmid_lock);
>>> +
>>> +     /*
>>> +      * We need to re-check the vmid_gen here to ensure that if another vcpu
>>> +      * already allocated a valid vmid for this vm, then this vcpu should
>>> +      * use the same vmid.
>>> +      */
>>> +     if (!need_new_vmid_gen(kvm)) {
>>> +             spin_unlock(&kvm_vmid_lock);
>>> +             return;
>>> +     }
>>> +
>>> +     /* First user of a new VMID generation? */
>>> +     if (unlikely(kvm_next_vmid == 0)) {
>>> +             atomic64_inc(&kvm_vmid_gen);
>>> +             kvm_next_vmid = 1;
>>> +
>>> +             /*
>>> +              * On SMP we know no other CPUs can use this CPU's or each
>>> +              * other's VMID after force_vm_exit returns since the
>>> +              * kvm_vmid_lock blocks them from reentry to the guest.
>>> +              */
>>> +             force_vm_exit(cpu_all_mask);
>>> +             /*
>>> +              * Now broadcast TLB + ICACHE invalidation over the inner
>>> +              * shareable domain to make sure all data structures are
>>> +              * clean.
>>> +              */
>>> +             kvm_call_hyp(__kvm_flush_vm_context);
>>> +     }
>>> +
>>> +     kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
>>> +     kvm->arch.vmid = kvm_next_vmid;
>>> +     kvm_next_vmid++;
>>> +
>>> +     /* update vttbr to be used with the new vmid */
>>> +     pgd_phys = virt_to_phys(kvm->arch.pgd);
>>> +     vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
>>> +     kvm->arch.vttbr = pgd_phys & VTTBR_BADDR_MASK;
>>> +     kvm->arch.vttbr |= vmid;
>>> +
>>> +     spin_unlock(&kvm_vmid_lock);
>>> +}
>>> +
>>> +/*
>>> + * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
>>> + * proper exit to QEMU.
>>> + */
>>> +static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>> +                    int exception_index)
>>> +{
>>> +     run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>>>       return 0;
>>>  }
>>>
>>> +/**
>>> + * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
>>> + * @vcpu:    The VCPU pointer
>>> + * @run:     The kvm_run structure pointer used for userspace state exchange
>>> + *
>>> + * This function is called through the VCPU_RUN ioctl called from user space. It
>>> + * will execute VM code in a loop until the time slice for the process is used
>>> + * or some emulation is needed from user space in which case the function will
>>> + * return with return value 0 and with the kvm_run structure filled in with the
>>> + * required data for the requested emulation.
>>> + */
>>>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>  {
>>> -     return -EINVAL;
>>> +     int ret;
>>> +     sigset_t sigsaved;
>>> +
>>> +     /* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
>>> +     if (unlikely(vcpu->arch.target < 0))
>>> +             return -ENOEXEC;
>>> +
>>> +     if (vcpu->sigset_active)
>>> +             sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
>>> +
>>> +     ret = 1;
>>> +     run->exit_reason = KVM_EXIT_UNKNOWN;
>>> +     while (ret > 0) {
>>> +             /*
>>> +              * Check conditions before entering the guest
>>> +              */
>>> +             cond_resched();
>>> +
>>> +             update_vttbr(vcpu->kvm);
>>> +
>>> +             local_irq_disable();
>>> +
>>> +             /*
>>> +              * Re-check atomic conditions
>>> +              */
>>> +             if (signal_pending(current)) {
>>> +                     ret = -EINTR;
>>> +                     run->exit_reason = KVM_EXIT_INTR;
>>> +             }
>>> +
>>> +             if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
>>> +                     local_irq_enable();
>>> +                     continue;
>>> +             }
>>> +
>>> +             /**************************************************************
>>> +              * Enter the guest
>>> +              */
>>> +             trace_kvm_entry(*vcpu_pc(vcpu));
>>> +             kvm_guest_enter();
>>> +             vcpu->mode = IN_GUEST_MODE;
>> You need to set mode to IN_GUEST_MODE before disabling interrupt and
>> check that mode != EXITING_GUEST_MODE after disabling interrupt but
>> before entering the guest. This way you will catch kicks that were sent
>> between setting of the mode and disabling the interrupts. Also you need
>> to check vcpu->requests and exit if it is not empty. I see that you do
>> not use vcpu->requests at all, but you should since common kvm code
>> assumes that it is used. make_all_cpus_request() uses it for instance.
>>
>
> I don't quite agree, but almost:
>
> Why would you set IN_GUEST_MODE before disabling interrupts? The only
> reason I can see for to be a requirement is to leverage an implicit
> memory barrier. Receiving the IPI in this little window does nothing
> (the smp_cross_call is a noop).
>
> Checking that mode != EXITING_GUEST_MODE is equally useless in my
> opinion, as I read the requests code the only reason for this mode is
> to avoid sending an IPI twice.
>
> Kicks sent between setting the mode and disabling the interrupts is
> not the point, the point is to check the requests field (which we
> don't use at all on ARM, and generic code also doesn't use on ARM)
> after disabling interrupts, and after setting IN_GUEST_MODE.
>
> The patch below fixes your issues, and while I would push back on
> anything else than direct bug fixes at this point, the current code is
> semantically incorrect wrt. KVM vcpu requests, so it's worth a fix,
> and the patch itself is trivial.
>
[...]

Actually, I take that back, the kvm_vcpu_block function does make a
request, which we don't need to handle, so adding code that checks for
features we don't support is useless at this point. Please ignore the
patch I sent earlier.

Later on we can change some of the code to use the vcpu->features map
if there's a real benefit, but right now the priority is to merge this
code, so anything that's not a bugfix should not go in.

The srcu lock is a real bug though, and should be fixed.

-Christoffer
