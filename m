From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Fri, 30 Jan 2015 09:48:44 +0200
Subject: [PATCH v3 3/5] KVM: ARM VGIC add kvm_io_bus_ frontend
In-Reply-To: <54C7CE7A.200@arm.com>
References: <20150124115815.11052.20755.stgit@i3820>
 <20150124115947.11052.73994.stgit@i3820> <54C79339.3070800@arm.com>
 <CADDJ2=Mtc57F9pdMVPD8UfsOkkuEhDpe_txXiYJVAFtzigQgDQ@mail.gmail.com>
 <54C7CA2D.7060700@linaro.org> <54C7CE7A.200@arm.com>
Message-ID: <CADDJ2=MJU0mQW-xYRERpX974GmdBz6tNcqwRBs2KG840AuccyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 7:44 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> On 27/01/15 17:26, Eric Auger wrote:
>> On 01/27/2015 05:51 PM, Nikolay Nikolaev wrote:
>>> Hi Andre,
>>>
>>> On Tue, Jan 27, 2015 at 3:31 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>>>>
>>>> Hi Nikolay,
>>>>
>>>> On 24/01/15 11:59, Nikolay Nikolaev wrote:
>>>>> In io_mem_abort remove the call to vgic_handle_mmio. The target is to have
>>>>> a single MMIO handling path - that is through the kvm_io_bus_ API.
>>>>>
>>>>> Register a kvm_io_device in kvm_vgic_init on the whole vGIC MMIO region.
>>>>> Both read and write calls are redirected to vgic_io_dev_access where
>>>>> kvm_exit_mmio is composed to pass it to vm_ops.handle_mmio.
>>>>>
>>>>>
>>>>> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
>>>>> ---
>>>>>  arch/arm/kvm/mmio.c    |    3 -
>>>>>  include/kvm/arm_vgic.h |    3 -
>>>>>  virt/kvm/arm/vgic.c    |  123 ++++++++++++++++++++++++++++++++++++++++++++----
>>>>>  3 files changed, 114 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
>>>>> index d852137..8dc2fde 100644
>>>>> --- a/arch/arm/kvm/mmio.c
>>>>> +++ b/arch/arm/kvm/mmio.c
>>>>> @@ -230,9 +230,6 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>>                              fault_ipa, 0);
>>>>>       }
>>>>>
>>>>> -     if (vgic_handle_mmio(vcpu, run, &mmio))
>>>>> -             return 1;
>>>>> -
>>>>
>>>> Why is this (whole patch) actually needed? Is that just to make it nicer
>>>> by pulling everything under one umbrella?
>>>
>>>
>>> It started from this mail form Christofer:
>>> https://lkml.org/lkml/2014/3/28/403
>> Hi Nikolay, Andre,
>>
>> I also understood that the target was to handle all kernel mmio through
>> the same API, hence the first patch. This patch shows that at least for
>> GICv2 it was doable without upheavals in vgic code and it also serves
>> ioeventd which is good. Andre do you think the price to pay to integrate
>> missing redistributors and forthcoming components is too high?
>
> Hopefully not, actually I reckon that moving the "upper level" MMIO
> dispatching out of vgic.c and letting the specific VGIC models register
> what they need themselves (in their -emul.c files) sounds quite promising.
> But this particular patch does not serve this purpose:
> a) we replace two lines with a bunch of more layered code
> b) we copy the MMIOed data to convert between the interfaces
> c) we miss GICv3 emulation
>
> So this needs to be addressed in a more general way (which maybe I will
> give a try). That being sad I don't see why we would need to do this

Andre,

we've already overspent our resource budget on this so I would be more
than glad if you can take over the VGIC part here.
Of course I'll help with whatever I can (review, testing, patches
logistics etc)

Here is the v3 of the patches in case you need to clone and base your
work on top of it:
https://git.virtualopensystems.com/common/linux/commits/ioeventfd_v3

regards,
Nikolay Nikolaev

> right now and hold back ioeventfd by this rather orthogonal issue.
>
> Christoffer, what's your take on this?
>
> Cheers,
> Andre.
>
>> Best Regards
>>
>> Eric
>>
>>
>>>
>>>>
>>>> For enabling ioeventfd you actually don't need this patch, right?
>>> Yes, we don't need it.
>>>> (I am asking because this breaks GICv3 emulation, see below)
>>>>
>>>>>       if (handle_kernel_mmio(vcpu, run, &mmio))
>>>>>               return 1;
>>>>>
>>>>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>>>>> index 7c55dd5..60639b1 100644
>>>>> --- a/include/kvm/arm_vgic.h
>>>>> +++ b/include/kvm/arm_vgic.h
>>>>> @@ -237,6 +237,7 @@ struct vgic_dist {
>>>>>       unsigned long           *irq_pending_on_cpu;
>>>>>
>>>>>       struct vgic_vm_ops      vm_ops;
>>>>> +     struct kvm_io_device    *io_dev;
>>>>>  #endif
>>>>>  };
>>>>>
>>>>> @@ -311,8 +312,6 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>>>>>                       bool level);
>>>>>  void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg);
>>>>>  int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
>>>>> -bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>> -                   struct kvm_exit_mmio *mmio);
>>>>>
>>>>>  #define irqchip_in_kernel(k) (!!((k)->arch.vgic.in_kernel))
>>>>>  #define vgic_initialized(k)  (!!((k)->arch.vgic.nr_cpus))
>>>>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>>>>> index 0cc6ab6..195d2ba 100644
>>>>> --- a/virt/kvm/arm/vgic.c
>>>>> +++ b/virt/kvm/arm/vgic.c
>>>>> @@ -31,6 +31,9 @@
>>>>>  #include <asm/kvm_emulate.h>
>>>>>  #include <asm/kvm_arm.h>
>>>>>  #include <asm/kvm_mmu.h>
>>>>> +#include <asm/kvm.h>
>>>>> +
>>>>> +#include "iodev.h"
>>>>>
>>>>>  /*
>>>>>   * How the whole thing works (courtesy of Christoffer Dall):
>>>>> @@ -77,6 +80,7 @@
>>>>>
>>>>>  #include "vgic.h"
>>>>>
>>>>> +static int vgic_register_kvm_io_dev(struct kvm *kvm);
>>>>>  static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
>>>>>  static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu);
>>>>>  static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr);
>>>>> @@ -97,6 +101,7 @@ static bool queue_sgi(struct kvm_vcpu *vcpu, int irq)
>>>>>
>>>>>  int kvm_vgic_map_resources(struct kvm *kvm)
>>>>>  {
>>>>> +     vgic_register_kvm_io_dev(kvm);
>>>>>       return kvm->arch.vgic.vm_ops.map_resources(kvm, vgic);
>>>>>  }
>>>>>
>>>>> @@ -776,27 +781,123 @@ bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>>  }
>>>>>
>>>>>  /**
>>>>> - * vgic_handle_mmio - handle an in-kernel MMIO access for the GIC emulation
>>>>> + * vgic_io_dev_access - handle an in-kernel MMIO access for the GIC emulation
>>>>>   * @vcpu:      pointer to the vcpu performing the access
>>>>> - * @run:       pointer to the kvm_run structure
>>>>> - * @mmio:      pointer to the data describing the access
>>>>> + * @this:      pointer to the kvm_io_device structure
>>>>> + * @addr:      the MMIO address being accessed
>>>>> + * @len:       the length of the accessed data
>>>>> + * @val:       pointer to the value being written,
>>>>> + *             or where the read operation will store its result
>>>>> + * @is_write:  flag to show whether a write access is performed
>>>>>   *
>>>>> - * returns true if the MMIO access has been performed in kernel space,
>>>>> - * and false if it needs to be emulated in user space.
>>>>> + * returns 0 if the MMIO access has been performed in kernel space,
>>>>> + * and 1 if it needs to be emulated in user space.
>>>>>   * Calls the actual handling routine for the selected VGIC model.
>>>>>   */
>>>>> -bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>> -                   struct kvm_exit_mmio *mmio)
>>>>> +static int vgic_io_dev_access(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>>>>> +                         gpa_t addr, int len, void *val, bool is_write)
>>>>>  {
>>>>> -     if (!irqchip_in_kernel(vcpu->kvm))
>>>>> -             return false;
>>>>> +     struct kvm_exit_mmio mmio;
>>>>> +     bool ret;
>>>>> +
>>>>> +     mmio = (struct kvm_exit_mmio) {
>>>>> +             .phys_addr = addr,
>>>>> +             .len = len,
>>>>> +             .is_write = is_write,
>>>>> +     };
>>>>> +
>>>>> +     if (is_write)
>>>>> +             memcpy(mmio.data, val, len);
>>>>>
>>>>>       /*
>>>>>        * This will currently call either vgic_v2_handle_mmio() or
>>>>>        * vgic_v3_handle_mmio(), which in turn will call
>>>>>        * vgic_handle_mmio_range() defined above.
>>>>>        */
>>>>> -     return vcpu->kvm->arch.vgic.vm_ops.handle_mmio(vcpu, run, mmio);
>>>>> +     ret = vcpu->kvm->arch.vgic.vm_ops.handle_mmio(vcpu, vcpu->run, &mmio);
>>>>> +
>>>>> +     if (!is_write)
>>>>> +             memcpy(val, mmio.data, len);
>>>>> +
>>>>> +     return ret ? 0 : 1;
>>>>> +}
>>>>> +
>>>>> +static int vgic_io_dev_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>>>>> +                       gpa_t addr, int len, void *val)
>>>>> +{
>>>>> +     return vgic_io_dev_access(vcpu, this, addr, len, val, false);
>>>>> +}
>>>>> +
>>>>> +static int vgic_io_dev_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>>>>> +                        gpa_t addr, int len, const void *val)
>>>>> +{
>>>>> +     return vgic_io_dev_access(vcpu, this, addr, len, (void *)val, true);
>>>>> +}
>>>>> +
>>>>> +static const struct kvm_io_device_ops vgic_io_dev_ops = {
>>>>> +     .read       = vgic_io_dev_read,
>>>>> +     .write      = vgic_io_dev_write,
>>>>> +};
>>>>> +
>>>>> +static int vgic_register_kvm_io_dev(struct kvm *kvm)
>>>>> +{
>>>>> +     int len = 0;
>>>>> +     int ret;
>>>>> +
>>>>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>>>>> +     unsigned long base = dist->vgic_dist_base;
>>>>> +     u32 type = kvm->arch.vgic.vgic_model;
>>>>> +     struct kvm_io_device *dev;
>>>>> +
>>>>> +     if (IS_VGIC_ADDR_UNDEF(base)) {
>>>>> +             kvm_err("Need to set vgic distributor address first\n");
>>>>> +             return -ENXIO;
>>>>> +     }
>>>>> +
>>>>> +     dev = kzalloc(sizeof(struct kvm_io_device), GFP_KERNEL);
>>>>> +     if (!dev)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     switch (type) {
>>>>> +     case KVM_DEV_TYPE_ARM_VGIC_V2:
>>>>> +             len = KVM_VGIC_V2_DIST_SIZE;
>>>>> +             break;
>>>>> +#ifdef CONFIG_ARM_GIC_V3
>>>>> +     case KVM_DEV_TYPE_ARM_VGIC_V3:
>>>>> +             len = KVM_VGIC_V3_DIST_SIZE;
>>>>> +             break;
>>>>> +#endif
>>>>> +     }
>>>>
>>>> But this only registers the GIC distributor, leaving out the
>>>> redistributor regions introduced by GICv3. To me it looks like this
>>> I see GICv3 needs more work.
>>>
>>>> kvm_iodevice registration code should be moved into *-emul.c, where each
>>>> emulated device registers what it needs.
>>>> Especially in the wake of the upcoming v2M/ITS emulation I think we need
>>>> a proper solution for this, so I am wondering if we could just leave
>>>> that patch out (at least for now) and keep the two-line special
>>>> treatment for the VGIC above in.
>>>> That should enable ioeventfd without breaking the VGIC.
>>> Then we're back to the original RFC patch series.
>>> I have no issues droppin this one (and propably patch 1 in the series)
>>> and leaving only the eventfd related handling.
>>> I just need some consensus/confirmation on the mailing list.
>>>
>>> regards,
>>> Nikolay Nikolaev
>>>
>>>>
>>>> Cheers,
>>>> Andre.
>>>>
>>>>> +
>>>>> +     kvm_iodevice_init(dev, &vgic_io_dev_ops);
>>>>> +
>>>>> +     mutex_lock(&kvm->slots_lock);
>>>>> +
>>>>> +     ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS,
>>>>> +                     base, len, dev);
>>>>> +     if (ret < 0)
>>>>> +             goto out_unlock;
>>>>> +     mutex_unlock(&kvm->slots_lock);
>>>>> +
>>>>> +     kvm->arch.vgic.io_dev = dev;
>>>>> +
>>>>> +     return 0;
>>>>> +
>>>>> +out_unlock:
>>>>> +     mutex_unlock(&kvm->slots_lock);
>>>>> +     kfree(dev);
>>>>> +     return ret;
>>>>> +}
>>>>> +
>>>>> +static void vgic_unregister_kvm_io_dev(struct kvm *kvm)
>>>>> +{
>>>>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>>>>> +
>>>>> +     if (dist) {
>>>>> +             kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, dist->io_dev);
>>>>> +             kfree(dist->io_dev);
>>>>> +             dist->io_dev = NULL;
>>>>> +     }
>>>>>  }
>>>>>
>>>>>  static int vgic_nr_shared_irqs(struct vgic_dist *dist)
>>>>> @@ -1428,6 +1529,8 @@ void kvm_vgic_destroy(struct kvm *kvm)
>>>>>       struct kvm_vcpu *vcpu;
>>>>>       int i;
>>>>>
>>>>> +     vgic_unregister_kvm_io_dev(kvm);
>>>>> +
>>>>>       kvm_for_each_vcpu(i, vcpu, kvm)
>>>>>               kvm_vgic_vcpu_destroy(vcpu);
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> kvmarm mailing list
>>>>> kvmarm at lists.cs.columbia.edu
>>>>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>>>>
>>
>>
