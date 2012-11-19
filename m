From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 19 Nov 2012 11:09:06 -0500
Subject: [PATCH v4 07/14] KVM: ARM: Inject IRQs and FIQs from userspace
In-Reply-To: <20121119152629.GH3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154259.2836.49857.stgit@chazy-air>
 <20121119145546.GZ3205@mudshark.cambridge.arm.com>
 <CANM98qJmkZZ2H+y8sdxBoT6WRgzcFSmKkTPWQnONDhezx5GEQQ@mail.gmail.com>
 <20121119152629.GH3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98q+ts0s1DJO8CxjSDorh1wztjKKU5WdkoAGeWRrSUNi9DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 10:26 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Nov 19, 2012 at 03:04:38PM +0000, Christoffer Dall wrote:
>> On Mon, Nov 19, 2012 at 9:55 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Sat, Nov 10, 2012 at 03:42:59PM +0000, Christoffer Dall wrote:
>> >> +int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level)
>> >> +{
>> >> +       u32 irq = irq_level->irq;
>> >> +       unsigned int irq_type, vcpu_idx, irq_num;
>> >> +       int nrcpus = atomic_read(&kvm->online_vcpus);
>> >> +       struct kvm_vcpu *vcpu = NULL;
>> >> +       bool level = irq_level->level;
>> >> +
>> >> +       irq_type = (irq >> KVM_ARM_IRQ_TYPE_SHIFT) & KVM_ARM_IRQ_TYPE_MASK;
>> >> +       vcpu_idx = (irq >> KVM_ARM_IRQ_VCPU_SHIFT) & KVM_ARM_IRQ_VCPU_MASK;
>> >> +       irq_num = (irq >> KVM_ARM_IRQ_NUM_SHIFT) & KVM_ARM_IRQ_NUM_MASK;
>> >> +
>> >> +       trace_kvm_irq_line(irq_type, vcpu_idx, irq_num, irq_level->level);
>> >> +
>> >> +       if (irq_type == KVM_ARM_IRQ_TYPE_CPU ||
>> >> +           irq_type == KVM_ARM_IRQ_TYPE_PPI) {
>> >> +               if (vcpu_idx >= nrcpus)
>> >> +                       return -EINVAL;
>> >> +
>> >> +               vcpu = kvm_get_vcpu(kvm, vcpu_idx);
>> >> +               if (!vcpu)
>> >> +                       return -EINVAL;
>> >> +       }
>> >> +
>> >> +       switch (irq_type) {
>> >> +       case KVM_ARM_IRQ_TYPE_CPU:
>> >> +               if (irq_num > KVM_ARM_IRQ_CPU_FIQ)
>> >> +                       return -EINVAL;
>> >> +
>> >> +               return vcpu_interrupt_line(vcpu, irq_num, level);
>> >> +       }
>> >> +
>> >> +       return -EINVAL;
>> >> +}
>> >
>> > Holy cyclomatic complexity Batman! Any way this can be cleaned up?
>> >
>> you mean the interface or the implementation of kvm_vm_ioctl_irq_line?
>> If the latter, there's just a lot of bits to decode here.
>
> I just think that this function is incredibly hard to read: different nested
> conditions under duplicate checks of the same variables which differ between
> an if(...) and a switch(...). I appreciate that it's a complex problem,
> which is why I helpfully didn't suggest an alternative! There must be
> *something* we can do though.
>

It is indeed a bit hard to read, but then wait to see the vgic code ! :)

In all seriousness, I will unite myself with an alcoholic beverage one
of these evenings and try to see what I can do about it, maybe split
it up somehow, I'll give it a shot.

Cheers,
-Christoffer
