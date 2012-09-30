From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sun, 30 Sep 2012 10:34:13 -0400
Subject: [PATCH 09/15] KVM: ARM: Inject IRQs and FIQs from userspace
In-Reply-To: <20120930124858.GA18755@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153527.21241.61813.stgit@ubuntu>
 <20120925155505.GD28728@mudshark.cambridge.arm.com>
 <CANM98qJ5PJZ3KAgxvizqHC2Q0OmkGvVjrRkhO511OvwpMvGgzQ@mail.gmail.com>
 <20120930124858.GA18755@mudshark.cambridge.arm.com>
Message-ID: <CANM98qKtzK1Z3jjNowej_3h1qbOmA3+tKKKoA4DgScVWWQABkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 8:48 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Christoffer,
>
> On Sat, Sep 29, 2012 at 04:50:25PM +0100, Christoffer Dall wrote:
>> On Tue, Sep 25, 2012 at 11:55 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Sat, Sep 15, 2012 at 04:35:27PM +0100, Christoffer Dall wrote:
>> >> diff --git a/arch/arm/include/asm/kvm.h b/arch/arm/include/asm/kvm.h
>> >> index a13b582..131e632 100644
>> >> --- a/arch/arm/include/asm/kvm.h
>> >> +++ b/arch/arm/include/asm/kvm.h
>> >> @@ -22,6 +22,7 @@
>> >>  #include <asm/types.h>
>> >>
>> >>  #define __KVM_HAVE_GUEST_DEBUG
>> >> +#define __KVM_HAVE_IRQ_LINE
>> >>
>> >>  #define KVM_REG_SIZE(id)                                             \
>> >>       (1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
>> >> @@ -85,4 +86,24 @@ struct kvm_reg_list {
>> >>  #define KVM_REG_ARM_CORE             (0x0010 << KVM_REG_ARM_COPROC_SHIFT)
>> >>  #define KVM_REG_ARM_CORE_REG(name)   (offsetof(struct kvm_regs, name) / 4)
>> >>
>> >> +/* KVM_IRQ_LINE irq field index values */
>> >> +#define KVM_ARM_IRQ_TYPE_SHIFT               24
>> >> +#define KVM_ARM_IRQ_TYPE_MASK                0xff
>> >> +#define KVM_ARM_IRQ_VCPU_SHIFT               16
>> >> +#define KVM_ARM_IRQ_VCPU_MASK                0xff
>> >> +#define KVM_ARM_IRQ_NUM_SHIFT                0
>> >> +#define KVM_ARM_IRQ_NUM_MASK         0xffff
>> >> +
>> >> +/* irq_type field */
>> >> +#define KVM_ARM_IRQ_TYPE_CPU         0
>> >> +#define KVM_ARM_IRQ_TYPE_SPI         1
>> >> +#define KVM_ARM_IRQ_TYPE_PPI         2
>> >> +
>> >> +/* out-of-kernel GIC cpu interrupt injection irq_number field */
>> >> +#define KVM_ARM_IRQ_CPU_IRQ          0
>> >> +#define KVM_ARM_IRQ_CPU_FIQ          1
>> >> +
>> >> +/* Highest supported SPI, from VGIC_NR_IRQS */
>> >> +#define KVM_ARM_IRQ_GIC_MAX          127
>> >
>> > This define, and those referring to PPIs and SPIs sound highly GIC-specific.
>> > Is that really appropriate for kvm.h? Do you mandate a single GIC as the
>> > only interrupt controller?
>> >
>>
>> you can add a another gic with another in-kernel gic emulation if
>> someone makes such one that's different from the vgic specifications
>> by defining another irq type.
>>
>> devices must interact with a gic available in the kernel, so I think
>> referring to PPIs and SPIs is very appropriate in kvm.h for a user
>> space device emulation that must inject either a PPI or an SPI.
>>
>> We can call them TYPE_GIC_V2_XXX or something like that if you feel
>> this is cleaner.
>
> It's more that the GIC isn't really part of the architecture, so it would be
> cleaner to have the GIC-specifics separated out from the architectural part
> of KVM. That will also make it easier when adding support for future
> versions of the GIC.
>
> If core KVM needs the concept of a per-cpu interrupt, just call it
> IRQ_TYPE_PERCPU or something rather than PPI.
>
that we have already, KVM_ARM_IRQ_TYPE_CPU

then how do you propose an interface for a user space emulation of a
board that uses the vgic where a device needs to inject a PPI to the
kernel that emulates the vgic?

I don't see the dire need for this separation: the API is extendable
and covers all the needs at this point.
