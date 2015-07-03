From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 03 Jul 2015 07:32:01 +0200
Subject: [RFC 09/17] bypass: IRQ bypass manager proto by Alex
In-Reply-To: <E959C4978C3B6342920538CF579893F0025E6C0E@SHSMSX104.ccr.corp.intel.com>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-10-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0025E6C0E@SHSMSX104.ccr.corp.intel.com>
Message-ID: <55961E51.6010202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Feng,
On 07/03/2015 04:16 AM, Wu, Feng wrote:
> 
> 
>> -----Original Message-----
>> From: Eric Auger [mailto:eric.auger at linaro.org]
>> Sent: Thursday, July 02, 2015 9:17 PM
>> To: eric.auger at st.com; eric.auger at linaro.org;
>> linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
>> kvm at vger.kernel.org; christoffer.dall at linaro.org; marc.zyngier at arm.com;
>> alex.williamson at redhat.com; pbonzini at redhat.com; avi.kivity at gmail.com;
>> mtosatti at redhat.com; Wu, Feng; joro at 8bytes.org;
>> b.reynal at virtualopensystems.com
>> Cc: linux-kernel at vger.kernel.org; patches at linaro.org
>> Subject: [RFC 09/17] bypass: IRQ bypass manager proto by Alex
>>
>> From: Alex Williamson <alex.williamson@redhat.com>
>>
>> There are plenty of details to be filled in, but I think the basics
>> looks something like the code below.  The IRQ bypass manager just
>> defines a pair of structures, one for interrupt producers and one for
>> interrupt consumers.  I'm certain that we'll need more callbacks than
>> I've defined below, but figuring out what those should be for the best
>> abstraction is the hardest part of this idea.  The manager provides both
>> registration and de-registration interfaces for both types of objects
>> and keeps lists for each, protected by a lock.  The manager doesn't even
>> really need to know what the match token is, but I assume for our
>> purposes it will be an eventfd_ctx.
>>
>> On the vfio side, the producer struct would be embedded in the
>> vfio_pci_irq_ctx struct.  KVM would probably embed the consumer struct
>> in _irqfd.  As I've coded below, the IRQ bypass manager calls the
>> consumer callbacks, so the producer struct would need fields or
>> callbacks to provide the consumer the info it needs.  AIUI the Posted
>> Interrupt model, VFIO only needs to provide data to the consumer.  For
>> IRQ Forwarding, I think the producer needs to be informed when bypass is
>> active to model the incoming interrupt as edge vs level.
>>
>> I've prototyped the base IRQ bypass manager here as static, but I don't
>> see any reason it couldn't be a module that's loaded by dependency when
>> either vfio-pci or kvm-intel is loaded (or other producer/consumer
>> objects).
>>
>> Is this a reasonable starting point to craft the additional fields and
>> callbacks and interaction of who calls who that we need to support
>> Posted Interrupts and IRQ Forwarding?  Is the AMD version of this still
>> alive?  Thanks,
>>
>> Alex
> 
> In fact, I also implement a RFC patch for this new framework. I am
> thinking, can we discuss all the requirements for irq forwarding and
> posted interrupts, and make it a separate patchset as a general
> layer? Then we can continue to push arch specific stuff, it is more
> clear and easy.

Sure. I intend to respin today according to Paolo's directives and I
will put common patches in a separate series. Let's see next week with
Alex how he prefers things to be handled.

Best Regards

Eric


> 
> Thanks,
> Feng
> 
>> ---
>>  arch/x86/kvm/Kconfig              |   1 +
>>  drivers/vfio/pci/Kconfig          |   1 +
>>  drivers/vfio/pci/vfio_pci_intrs.c |   6 ++
>>  include/linux/irqbypass.h         |  23 ++++++++
>>  kernel/irq/Kconfig                |   3 +
>>  kernel/irq/Makefile               |   1 +
>>  kernel/irq/bypass.c               | 116
>> ++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/eventfd.c                |   4 ++
>>  8 files changed, 155 insertions(+)
>>  create mode 100644 include/linux/irqbypass.h
>>  create mode 100644 kernel/irq/bypass.c
>>
>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>> index d8a1d56..86d0d77 100644
>> --- a/arch/x86/kvm/Kconfig
>> +++ b/arch/x86/kvm/Kconfig
>> @@ -61,6 +61,7 @@ config KVM_INTEL
>>  	depends on KVM
>>  	# for perf_guest_get_msrs():
>>  	depends on CPU_SUP_INTEL
>> +	select IRQ_BYPASS_MANAGER
>>  	---help---
>>  	  Provides support for KVM on Intel processors equipped with the VT
>>  	  extensions.
>> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>> index 579d83b..02912f1 100644
>> --- a/drivers/vfio/pci/Kconfig
>> +++ b/drivers/vfio/pci/Kconfig
>> @@ -2,6 +2,7 @@ config VFIO_PCI
>>  	tristate "VFIO support for PCI devices"
>>  	depends on VFIO && PCI && EVENTFD
>>  	select VFIO_VIRQFD
>> +	select IRQ_BYPASS_MANAGER
>>  	help
>>  	  Support for the PCI VFIO bus driver.  This is required to make
>>  	  use of PCI drivers using the VFIO framework.
>> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>> index 1f577b4..4e053be 100644
>> --- a/drivers/vfio/pci/vfio_pci_intrs.c
>> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
>> @@ -181,6 +181,7 @@ static int vfio_intx_set_signal(struct vfio_pci_device
>> *vdev, int fd)
>>
>>  	if (vdev->ctx[0].trigger) {
>>  		free_irq(pdev->irq, vdev);
>> +		/* irq_bypass_unregister_producer(); */
>>  		kfree(vdev->ctx[0].name);
>>  		eventfd_ctx_put(vdev->ctx[0].trigger);
>>  		vdev->ctx[0].trigger = NULL;
>> @@ -214,6 +215,8 @@ static int vfio_intx_set_signal(struct vfio_pci_device
>> *vdev, int fd)
>>  		return ret;
>>  	}
>>
>> +	/* irq_bypass_register_producer(); */
>> +
>>  	/*
>>  	 * INTx disable will stick across the new irq setup,
>>  	 * disable_irq won't.
>> @@ -319,6 +322,7 @@ static int vfio_msi_set_vector_signal(struct
>> vfio_pci_device *vdev,
>>
>>  	if (vdev->ctx[vector].trigger) {
>>  		free_irq(irq, vdev->ctx[vector].trigger);
>> +		/* irq_bypass_unregister_producer(); */
>>  		kfree(vdev->ctx[vector].name);
>>  		eventfd_ctx_put(vdev->ctx[vector].trigger);
>>  		vdev->ctx[vector].trigger = NULL;
>> @@ -360,6 +364,8 @@ static int vfio_msi_set_vector_signal(struct
>> vfio_pci_device *vdev,
>>  		return ret;
>>  	}
>>
>> +	/* irq_bypass_register_producer(); */
>> +
>>  	vdev->ctx[vector].trigger = trigger;
>>
>>  	return 0;
>> diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
>> new file mode 100644
>> index 0000000..718508e
>> --- /dev/null
>> +++ b/include/linux/irqbypass.h
>> @@ -0,0 +1,23 @@
>> +#ifndef IRQBYPASS_H
>> +#define IRQBYPASS_H
>> +
>> +#include <linux/list.h>
>> +
>> +struct irq_bypass_producer {
>> +	struct list_head node;
>> +	void *token;
>> +	/* TBD */
>> +};
>> +
>> +struct irq_bypass_consumer {
>> +	struct list_head node;
>> +	void *token;
>> +	void (*add_producer)(struct irq_bypass_producer *);
>> +	void (*del_producer)(struct irq_bypass_producer *);
>> +};
>> +
>> +int irq_bypass_register_producer(struct irq_bypass_producer *);
>> +void irq_bypass_unregister_producer(struct irq_bypass_producer *);
>> +int irq_bypass_register_consumer(struct irq_bypass_consumer *);
>> +void irq_bypass_unregister_consumer(struct irq_bypass_consumer *);
>> +#endif /* IRQBYPASS_H */
>> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
>> index 9a76e3b..4502cdc 100644
>> --- a/kernel/irq/Kconfig
>> +++ b/kernel/irq/Kconfig
>> @@ -100,4 +100,7 @@ config SPARSE_IRQ
>>
>>  	  If you don't know what to do here, say N.
>>
>> +config IRQ_BYPASS_MANAGER
>> +	bool
>> +
>>  endmenu
>> diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
>> index d121235..a30ed77 100644
>> --- a/kernel/irq/Makefile
>> +++ b/kernel/irq/Makefile
>> @@ -7,3 +7,4 @@ obj-$(CONFIG_PROC_FS) += proc.o
>>  obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
>>  obj-$(CONFIG_PM_SLEEP) += pm.o
>>  obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
>> +obj-$(CONFIG_IRQ_BYPASS_MANAGER) += bypass.o
>> diff --git a/kernel/irq/bypass.c b/kernel/irq/bypass.c
>> new file mode 100644
>> index 0000000..5d0f92b
>> --- /dev/null
>> +++ b/kernel/irq/bypass.c
>> @@ -0,0 +1,116 @@
>> +/*
>> + * IRQ offload/bypass manager
>> + *
>> + * Various virtualization hardware acceleration techniques allow bypassing
>> + * or offloading interrupts receieved from devices around the host kernel.
>> + * Posted Interrupts on Intel VT-d systems can allow interrupts to be
>> + * recieved directly by a virtual machine.  ARM IRQ Forwarding can allow
>> + * level triggered device interrupts to be de-asserted directly by the VM.
>> + * This manager allows interrupt producers and consumers to find each other
>> + * to enable this sort of bypass.
>> + */
>> +
>> +#include <linux/irqbypass.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +
>> +static LIST_HEAD(producers);
>> +static LIST_HEAD(consumers);
>> +static DEFINE_MUTEX(lock);
>> +
>> +int irq_bypass_register_producer(struct irq_bypass_producer *producer)
>> +{
>> +	struct irq_bypass_producer *tmp;
>> +	struct irq_bypass_consumer *consumer;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&lock);
>> +
>> +	list_for_each_entry(tmp, &producers, node) {
>> +		if (tmp->token == producer->token) {
>> +			ret = -EINVAL;
>> +			goto unlock;
>> +		}
>> +	}
>> +
>> +	list_add(&producer->node, &producers);
>> +
>> +	list_for_each_entry(consumer, &consumers, node) {
>> +		if (consumer->token == producer->token) {
>> +			consumer->add_producer(producer);
>> +			break;
>> +		}
>> +	}
>> +unlock:
>> +	mutex_unlock(&lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
>> +
>> +void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
>> +{
>> +	struct irq_bypass_consumer *consumer;
>> +
>> +	mutex_lock(&lock);
>> +
>> +	list_for_each_entry(consumer, &consumers, node) {
>> +		if (consumer->token == producer->token) {
>> +			consumer->del_producer(producer);
>> +			break;
>> +		}
>> +	}
>> +
>> +	list_del(&producer->node);
>> +
>> +	mutex_unlock(&lock);
>> +}
>> +EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
>> +
>> +int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
>> +{
>> +	struct irq_bypass_consumer *tmp;
>> +	struct irq_bypass_producer *producer;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&lock);
>> +
>> +	list_for_each_entry(tmp, &consumers, node) {
>> +		if (tmp->token == consumer->token) {
>> +			ret = -EINVAL;
>> +			goto unlock;
>> +		}
>> +	}
>> +
>> +	list_add(&consumer->node, &consumers);
>> +
>> +	list_for_each_entry(producer, &producers, node) {
>> +		if (producer->token == consumer->token) {
>> +			consumer->add_producer(producer);
>> +			break;
>> +		}
>> +	}
>> +unlock:
>> +	mutex_unlock(&lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
>> +
>> +void irq_bypass_unregister_consumer(struct irq_bypass_consumer
>> *consumer)
>> +{
>> +	struct irq_bypass_producer *producer;
>> +
>> +	mutex_lock(&lock);
>> +
>> +	list_for_each_entry(producer, &producers, node) {
>> +		if (producer->token == consumer->token) {
>> +			consumer->del_producer(producer);
>> +			break;
>> +		}
>> +	}
>> +
>> +	list_del(&consumer->node);
>> +
>> +	mutex_unlock(&lock);
>> +}
>> +EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
>> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
>> index 9ff4193..f3da161 100644
>> --- a/virt/kvm/eventfd.c
>> +++ b/virt/kvm/eventfd.c
>> @@ -429,6 +429,8 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd
>> *args)
>>  	 */
>>  	fdput(f);
>>
>> +	/* irq_bypass_register_consumer(); */
>> +
>>  	return 0;
>>
>>  fail:
>> @@ -528,6 +530,8 @@ kvm_irqfd_deassign(struct kvm *kvm, struct kvm_irqfd
>> *args)
>>  	struct _irqfd *irqfd, *tmp;
>>  	struct eventfd_ctx *eventfd;
>>
>> +	/* irq_bypass_unregister_consumer() */
>> +
>>  	eventfd = eventfd_ctx_fdget(args->fd);
>>  	if (IS_ERR(eventfd))
>>  		return PTR_ERR(eventfd);
>> --
>> 1.9.1
> 
