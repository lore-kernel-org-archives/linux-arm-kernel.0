From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Sat, 24 Jan 2015 02:57:42 +0200
Subject: [PATCH v2 3/5] KVM: ARM VGIC add kvm_io_bus_ frontend
In-Reply-To: <54B43F81.4020007@linaro.org>
References: <20141207093641.17563.84226.stgit@i3820>
 <20141207093756.17563.4063.stgit@i3820>
 <54B43F81.4020007@linaro.org>
Message-ID: <CADDJ2=N-g5Pbe3+f=dq9K6nM9=artoBOoc94Fs2bhybAgzLQyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 11:41 PM, Eric Auger <eric.auger@linaro.org> wrote:
> On 12/07/2014 10:37 AM, Nikolay Nikolaev wrote:
>> In io_mem_abort remove the call to vgic_handle_mmio. The target is to have
>> a single MMIO handling path - that is through the kvm_io_bus_ API.
>>
>> Register a kvm_io_device in kvm_vgic_init on the whole vGIC MMIO region.
>> Both read and write calls are redirected to vgic_io_dev_access where
>> kvm_exit_mmio is composed to pass it to vm_ops.handle_mmio.
>>
>>
>> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
>> ---
>>  arch/arm/kvm/mmio.c    |    3 -
>>  include/kvm/arm_vgic.h |    3 -
>>  virt/kvm/arm/vgic.c    |  127 ++++++++++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 118 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
>> index e42469f..bf466c8 100644
>> --- a/arch/arm/kvm/mmio.c
>> +++ b/arch/arm/kvm/mmio.c
>> @@ -227,9 +227,6 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>       if (mmio.is_write)
>>               mmio_write_buf(mmio.data, mmio.len, data);
>>
>> -     if (vgic_handle_mmio(vcpu, run, &mmio))
>> -             return 1;
>> -
>>       if (handle_kernel_mmio(vcpu, run, &mmio))
>>               return 1;
>>
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index e452ef7..d9b7d2a 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -233,6 +233,7 @@ struct vgic_dist {
>>       unsigned long           *irq_pending_on_cpu;
>>
>>       struct vgic_vm_ops      vm_ops;
>> +     struct kvm_io_device    *io_dev;
>>  #endif
>>  };
>>
>> @@ -307,8 +308,6 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>>                       bool level);
>>  void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg);
>>  int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
>> -bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>> -                   struct kvm_exit_mmio *mmio);
>>
>>  #define irqchip_in_kernel(k) (!!((k)->arch.vgic.in_kernel))
>>  #define vgic_initialized(k)  ((k)->arch.vgic.ready)
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index bd74207..1c7cbec 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -31,6 +31,9 @@
>>  #include <asm/kvm_emulate.h>
>>  #include <asm/kvm_arm.h>
>>  #include <asm/kvm_mmu.h>
>> +#include <asm/kvm.h>
>> +
>> +#include "iodev.h"
>>
>>  /*
>>   * How the whole thing works (courtesy of Christoffer Dall):
>> @@ -776,27 +779,127 @@ bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>  }
>>
>>  /**
>> - * vgic_handle_mmio - handle an in-kernel MMIO access for the GIC emulation
>> + * vgic_io_dev_access - handle an in-kernel MMIO access for the GIC emulation
>>   * @vcpu:      pointer to the vcpu performing the access
>> - * @run:       pointer to the kvm_run structure
>> - * @mmio:      pointer to the data describing the access
>> + * @this:      pointer to the kvm_io_device structure
>> + * @addr:      the MMIO address being accessed
>> + * @len:       the length of the accessed data
>> + * @val:       pointer to the value being written,
>> + *             or where the read operation will store its result
>> + * @is_write:  flag to show whether a write access is performed
>>   *
>> - * returns true if the MMIO access has been performed in kernel space,
>> - * and false if it needs to be emulated in user space.
>> + * returns 0 if the MMIO access has been performed in kernel space,
>> + * and 1 if it needs to be emulated in user space.
>>   * Calls the actual handling routine for the selected VGIC model.
>>   */
>> -bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>> -                   struct kvm_exit_mmio *mmio)
>> +static int vgic_io_dev_access(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>> +                         gpa_t addr, int len, void *val, bool is_write)
>>  {
>> -     if (!irqchip_in_kernel(vcpu->kvm))
>> -             return false;
>> +     struct kvm_exit_mmio mmio;
>> +     bool ret;
>> +
>> +     mmio = (struct kvm_exit_mmio) {
>> +             .phys_addr = addr,
>> +             .len = len,
>> +             .is_write = is_write,
>> +     };
>> +
>> +     if (is_write)
>> +             memcpy(mmio.data, val, len);
>>
>>       /*
>>        * This will currently call either vgic_v2_handle_mmio() or
>>        * vgic_v3_handle_mmio(), which in turn will call
>>        * vgic_handle_mmio_range() defined above.
>>        */
>> -     return vcpu->kvm->arch.vgic.vm_ops.handle_mmio(vcpu, run, mmio);
>> +     ret = vcpu->kvm->arch.vgic.vm_ops.handle_mmio(vcpu, vcpu->run, &mmio);
>> +
>> +     if (!is_write)
>> +             memcpy(val, mmio.data, len);
>> +
>> +     return ret ? 0 : 1;
>> +}
>> +
>> +static int vgic_io_dev_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>> +                       gpa_t addr, int len, void *val)
>> +{
>> +     return vgic_io_dev_access(vcpu, this, addr, len, val, false);
>> +}
>> +
>> +static int vgic_io_dev_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>> +                        gpa_t addr, int len, const void *val)
>> +{
>> +     return vgic_io_dev_access(vcpu, this, addr, len, (void *)val, true);
>> +}
>> +
>> +static const struct kvm_io_device_ops vgic_io_dev_ops = {
>> +     .read       = vgic_io_dev_read,
>> +     .write      = vgic_io_dev_write,
>> +};
>> +
>> +static int vgic_register_kvm_io_dev(struct kvm *kvm)
>> +{
>> +     int len, ret;
>> +
>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>> +     unsigned long base = dist->vgic_dist_base;
>> +     u32 type = kvm->arch.vgic.vgic_model;
>> +     struct kvm_io_device *dev;
>> +
>> +     if (IS_VGIC_ADDR_UNDEF(base)) {
>> +             kvm_err("Need to set vgic distributor address first\n");
>> +             return -ENXIO;
>> +     }
>> +
>> +     dev = kzalloc(sizeof(struct kvm_io_device), GFP_KERNEL);
>> +     if (!dev)
>> +             return -ENOMEM;
> what was the outcome of the dynamic/static allocation discussion?

To have a static member I have to add virt/kvm/iodev.h in include/kvm/arm_vgic.h
And then I get this error at the earliest stage of kernel compilation:

  CC      arch/arm64/kernel/asm-offsets.s
In file included from ./arch/arm64/include/asm/kvm_host.h:41:0,
                 from include/linux/kvm_host.h:34,
                 from arch/arm64/kernel/asm-offsets.c:24:
include/kvm/arm_vgic.h:28:19: fatal error: iodev.h: No such file or directory

This one is invoked from the toplevel Kbuild script when trying to
generate the include/generated/asm-offsets.h

I didn't manage to find and obvious way to add "-I virt/kvm" for this
file's compilation. arch/arm64/kernel/Makefile is not used at this
stage.

>> +
>> +     switch (type) {
>> +     case KVM_DEV_TYPE_ARM_VGIC_V2:
>> +             len = KVM_VGIC_V2_DIST_SIZE;
>> +             break;
>> +#ifdef CONFIG_ARM_GIC_V3
>> +     case KVM_DEV_TYPE_ARM_VGIC_V3:
>> +             len = KVM_VGIC_V3_DIST_SIZE;
>> +             break;
>> +#endif
>> +     default:
>> +             kvm_err("Unsupported VGIC model\n");
>> +             goto out_free_dev;
>> +             break;
> may be removed
>> +     }
>> +
>> +     kvm_iodevice_init(dev, &vgic_io_dev_ops);
>> +
>> +     mutex_lock(&kvm->slots_lock);
>> +
>> +     ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS,
>> +                     base, len, dev);
>> +     if (ret < 0)
>> +             goto out_unlock;
>> +     mutex_unlock(&kvm->slots_lock);
>> +
>> +     kvm->arch.vgic.io_dev = dev;
>> +
>> +     return 0;
>> +
>> +out_unlock:
>> +     mutex_unlock(&kvm->slots_lock);
>> +out_free_dev:
>> +     kfree(dev);
>> +     return ret;
>> +}
>> +
>> +static void vgic_unregister_kvm_io_dev(struct kvm *kvm)
>> +{
>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>> +
>> +     if (dist) {
>> +             kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, dist->io_dev);
>> +             kfree(dist->io_dev);
>> +             dist->io_dev = NULL;
> could be put in a destructor function but not sure it is worth the candle.
>> +     }
>>  }
>>
>>  static int vgic_nr_shared_irqs(struct vgic_dist *dist)
>> @@ -1427,6 +1530,8 @@ void kvm_vgic_destroy(struct kvm *kvm)
>>       struct kvm_vcpu *vcpu;
>>       int i;
>>
>> +     vgic_unregister_kvm_io_dev(kvm);
>> +
>>       kvm_for_each_vcpu(i, vcpu, kvm)
>>               kvm_vgic_vcpu_destroy(vcpu);
>>
>> @@ -1548,6 +1653,8 @@ int kvm_vgic_init(struct kvm *kvm)
>>       if (vgic_initialized(kvm))
>>               goto out;
>>
>> +     vgic_register_kvm_io_dev(kvm);
>> +
> should happen in kvm_vgic_map_resources now after rebase on
> Christoffer's series.
>
> Best Regards
>
> Eric
>>       ret = vgic_init_maps(kvm);
>>       if (ret) {
>>               kvm_err("Unable to allocate maps\n");
>>
>
