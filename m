From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 19 Nov 2012 10:04:38 -0500
Subject: [PATCH v4 07/14] KVM: ARM: Inject IRQs and FIQs from userspace
In-Reply-To: <20121119145546.GZ3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154259.2836.49857.stgit@chazy-air>
 <20121119145546.GZ3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98qJmkZZ2H+y8sdxBoT6WRgzcFSmKkTPWQnONDhezx5GEQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 9:55 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Nov 10, 2012 at 03:42:59PM +0000, Christoffer Dall wrote:
>> From: Christoffer Dall <cdall@cs.columbia.edu>
>>
>> All interrupt injection is now based on the VM ioctl KVM_IRQ_LINE.  This
>> works semantically well for the GIC as we in fact raise/lower a line on
>> a machine component (the gic).  The IOCTL uses the follwing struct.
>>
>> struct kvm_irq_level {
>>         union {
>>                 __u32 irq;     /* GSI */
>>                 __s32 status;  /* not used for KVM_IRQ_LEVEL */
>>         };
>>         __u32 level;           /* 0 or 1 */
>> };
>>
>> ARM can signal an interrupt either at the CPU level, or at the in-kernel irqchip
>> (GIC), and for in-kernel irqchip can tell the GIC to use PPIs designated for
>> specific cpus.  The irq field is interpreted like this:
>>
>>   bits:  | 31 ... 24 | 23  ... 16 | 15    ...    0 |
>>   field: | irq_type  | vcpu_index |   irq_number   |
>>
>> The irq_type field has the following values:
>> - irq_type[0]: out-of-kernel GIC: irq_number 0 is IRQ, irq_number 1 is FIQ
>> - irq_type[1]: in-kernel GIC: SPI, irq_number between 32 and 1019 (incl.)
>>                (the vcpu_index field is ignored)
>> - irq_type[2]: in-kernel GIC: PPI, irq_number between 16 and 31 (incl.)
>>
>> The irq_number thus corresponds to the irq ID in as in the GICv2 specs.
>>
>> This is documented in Documentation/kvm/api.txt.
>>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
> [...]
>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 5ac3132..15e2ab1 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/fs.h>
>>  #include <linux/mman.h>
>>  #include <linux/sched.h>
>> +#include <linux/kvm.h>
>>  #include <trace/events/kvm.h>
>>
>>  #define CREATE_TRACE_POINTS
>> @@ -272,6 +273,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
>>
>>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>>  {
>> +       vcpu->cpu = cpu;
>>  }
>>
>>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>> @@ -312,6 +314,74 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>         return -EINVAL;
>>  }
>>
>> +static int vcpu_interrupt_line(struct kvm_vcpu *vcpu, int number, bool level)
>> +{
>> +       int bit_index;
>> +       bool set;
>> +       unsigned long *ptr;
>> +
>> +       if (number == KVM_ARM_IRQ_CPU_IRQ)
>> +               bit_index = __ffs(HCR_VI);
>> +       else /* KVM_ARM_IRQ_CPU_FIQ */
>> +               bit_index = __ffs(HCR_VF);
>> +
>> +       ptr = (unsigned long *)&vcpu->arch.irq_lines;
>> +       if (level)
>> +               set = test_and_set_bit(bit_index, ptr);
>> +       else
>> +               set = test_and_clear_bit(bit_index, ptr);
>> +
>> +       /*
>> +        * If we didn't change anything, no need to wake up or kick other CPUs
>> +        */
>> +       if (set == level)
>> +               return 0;
>> +
>> +       /*
>> +        * The vcpu irq_lines field was updated, wake up sleeping VCPUs and
>> +        * trigger a world-switch round on the running physical CPU to set the
>> +        * virtual IRQ/FIQ fields in the HCR appropriately.
>> +        */
>> +       kvm_vcpu_kick(vcpu);
>> +
>> +       return 0;
>> +}
>> +
>> +int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level)
>> +{
>> +       u32 irq = irq_level->irq;
>> +       unsigned int irq_type, vcpu_idx, irq_num;
>> +       int nrcpus = atomic_read(&kvm->online_vcpus);
>> +       struct kvm_vcpu *vcpu = NULL;
>> +       bool level = irq_level->level;
>> +
>> +       irq_type = (irq >> KVM_ARM_IRQ_TYPE_SHIFT) & KVM_ARM_IRQ_TYPE_MASK;
>> +       vcpu_idx = (irq >> KVM_ARM_IRQ_VCPU_SHIFT) & KVM_ARM_IRQ_VCPU_MASK;
>> +       irq_num = (irq >> KVM_ARM_IRQ_NUM_SHIFT) & KVM_ARM_IRQ_NUM_MASK;
>> +
>> +       trace_kvm_irq_line(irq_type, vcpu_idx, irq_num, irq_level->level);
>> +
>> +       if (irq_type == KVM_ARM_IRQ_TYPE_CPU ||
>> +           irq_type == KVM_ARM_IRQ_TYPE_PPI) {
>> +               if (vcpu_idx >= nrcpus)
>> +                       return -EINVAL;
>> +
>> +               vcpu = kvm_get_vcpu(kvm, vcpu_idx);
>> +               if (!vcpu)
>> +                       return -EINVAL;
>> +       }
>> +
>> +       switch (irq_type) {
>> +       case KVM_ARM_IRQ_TYPE_CPU:
>> +               if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
>> +                       return -EINVAL;
>> +
>> +               return vcpu_interrupt_line(vcpu, irq_num, level);
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>
> Holy cyclomatic complexity Batman! Any way this can be cleaned up?
>
you mean the interface or the implementation of kvm_vm_ioctl_irq_line?
If the latter, there's just a lot of bits to decode here.

Thanks,
-Christoffer
