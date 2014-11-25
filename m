From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 25 Nov 2014 14:39:51 +0100
Subject: [PATCH v3 7/8] KVM: kvm-vfio: generic forwarding control
In-Reply-To: <E959C4978C3B6342920538CF579893F0022B12C5@SHSMSX104.ccr.corp.intel.com>
References: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
 <1416767760-14487-8-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0022B12C5@SHSMSX104.ccr.corp.intel.com>
Message-ID: <547486A7.7010003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2014 05:33 AM, Wu, Feng wrote:
> 
> 
>> -----Original Message-----
>> From: Eric Auger [mailto:eric.auger at linaro.org]
>> Sent: Monday, November 24, 2014 2:36 AM
>> To: eric.auger at st.com; eric.auger at linaro.org; christoffer.dall at linaro.org;
>> marc.zyngier at arm.com; linux-arm-kernel at lists.infradead.org;
>> kvmarm at lists.cs.columbia.edu; kvm at vger.kernel.org;
>> alex.williamson at redhat.com; joel.schopp at amd.com;
>> kim.phillips at freescale.com; paulus at samba.org; gleb at kernel.org;
>> pbonzini at redhat.com; agraf at suse.de
>> Cc: linux-kernel at vger.kernel.org; patches at linaro.org; will.deacon at arm.com;
>> a.motakis at virtualopensystems.com; a.rigo at virtualopensystems.com;
>> john.liuli at huawei.com; ming.lei at canonical.com; Wu, Feng
>> Subject: [PATCH v3 7/8] KVM: kvm-vfio: generic forwarding control
>>
>> This patch introduces a new KVM_DEV_VFIO_DEVICE group.
>>
>> This is a new control channel which enables KVM to cooperate with
>> viable VFIO devices.
>>
>> Functions are introduced to check the validity of a VFIO device
>> file descriptor, increment/decrement the ref counter of the VFIO
>> device.
>>
>> The patch introduces 2 attributes for this new device group:
>> KVM_DEV_VFIO_DEVICE_FORWARD_IRQ,
>> KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ.
>> Their purpose is to turn a VFIO device IRQ into a forwarded IRQ and
>> unset respectively unset the feature.
>>
>> The VFIO device stores a list of registered forwarded IRQs. The reference
>> counter of the device is incremented each time a new IRQ is forwarded.
>> Reference counter is decremented when the IRQ forwarding is unset.
>>
>> The forwarding programmming is architecture specific, implemented in
>> kvm_arch_set_fwd_state function. Architecture specific implementation is
>> enabled when __KVM_HAVE_ARCH_KVM_VFIO_FORWARD is set. When not
>> set those
>> functions are void.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>
>> ---
>>
>> v2 -> v3:
>> - add API comments in kvm_host.h
>> - improve the commit message
>> - create a private kvm_vfio_fwd_irq struct
>> - fwd_irq_action replaced by a bool and removal of VFIO_IRQ_CLEANUP. This
>>   latter action will be handled in vgic.
>> - add a vfio_device handle argument to kvm_arch_set_fwd_state. The goal is
>>   to move platform specific stuff in architecture specific code.
>> - kvm_arch_set_fwd_state renamed into kvm_arch_vfio_set_forward
>> - increment the ref counter each time we do an IRQ forwarding and decrement
>>   this latter each time one IRQ forward is unset. Simplifies the whole
>>   ref counting.
>> - simplification of list handling: create, search, removal
>>
>> v1 -> v2:
>> - __KVM_HAVE_ARCH_KVM_VFIO renamed into
>> __KVM_HAVE_ARCH_KVM_VFIO_FORWARD
>> - original patch file separated into 2 parts: generic part moved in vfio.c
>>   and ARM specific part(kvm_arch_set_fwd_state)
>> ---
>>  include/linux/kvm_host.h |  28 ++++++
>>  virt/kvm/vfio.c          | 249
>> ++++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 274 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index ea53b04..0b9659d 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -1076,6 +1076,15 @@ struct kvm_device_ops {
>>  		      unsigned long arg);
>>  };
>>
>> +/* internal self-contained structure describing a forwarded IRQ */
>> +struct kvm_fwd_irq {
>> +	struct kvm *kvm; /* VM to inject the GSI into */
>> +	struct vfio_device *vdev; /* vfio device the IRQ belongs to */
>> +	__u32 index; /* VFIO device IRQ index */
>> +	__u32 subindex; /* VFIO device IRQ subindex */
>> +	__u32 gsi; /* gsi, ie. virtual IRQ number */
>> +};
>> +
>>  void kvm_device_get(struct kvm_device *dev);
>>  void kvm_device_put(struct kvm_device *dev);
>>  struct kvm_device *kvm_device_from_filp(struct file *filp);
>> @@ -1085,6 +1094,25 @@ void kvm_unregister_device_ops(u32 type);
>>  extern struct kvm_device_ops kvm_mpic_ops;
>>  extern struct kvm_device_ops kvm_xics_ops;
>>
>> +#ifdef __KVM_HAVE_ARCH_KVM_VFIO_FORWARD
>> +/**
>> + * kvm_arch_vfio_set_forward - changes the forwarded state of an IRQ
>> + *
>> + * @fwd_irq: handle to the forwarded irq struct
>> + * @forward: true means forwarded, false means not forwarded
>> + * returns 0 on success, < 0 on failure
>> + */
>> +int kvm_arch_vfio_set_forward(struct kvm_fwd_irq *fwd_irq,
>> +			      bool forward);
>> +
>> +#else
>> +static inline int kvm_arch_vfio_set_forward(struct kvm_fwd_irq *fwd_irq,
>> +					    bool forward)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
>>
>>  static inline void kvm_vcpu_set_in_spin_loop(struct kvm_vcpu *vcpu, bool val)
>> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
>> index 6f0cc34..af178bb 100644
>> --- a/virt/kvm/vfio.c
>> +++ b/virt/kvm/vfio.c
>> @@ -25,8 +25,16 @@ struct kvm_vfio_group {
>>  	struct vfio_group *vfio_group;
>>  };
>>
>> +/* private linkable kvm_fwd_irq struct */
>> +struct kvm_vfio_fwd_irq_node {
>> +	struct list_head link;
>> +	struct kvm_fwd_irq fwd_irq;
>> +};
>> +
>>  struct kvm_vfio {
>>  	struct list_head group_list;
>> +	/* list of registered VFIO forwarded IRQs */
>> +	struct list_head fwd_node_list;
>>  	struct mutex lock;
>>  	bool noncoherent;
>>  };
>> @@ -247,12 +255,239 @@ static int kvm_vfio_set_group(struct kvm_device
>> *dev, long attr, u64 arg)
>>  	return -ENXIO;
>>  }
>>
>> +/**
>> + * kvm_vfio_get_vfio_device - Returns a handle to a vfio-device
>> + *
>> + * Checks it is a valid vfio device and increments its reference counter
>> + * @fd: file descriptor of the vfio platform device
>> + */
>> +static struct vfio_device *kvm_vfio_get_vfio_device(int fd)
>> +{
>> +	struct fd f = fdget(fd);
>> +	struct vfio_device *vdev;
>> +
>> +	if (!f.file)
>> +		return NULL;
>> +	vdev = kvm_vfio_device_get_external_user(f.file);
>> +	fdput(f);
>> +	return vdev;
>> +}
>> +
>> +/**
>> + * kvm_vfio_put_vfio_device: decrements the reference counter of the
>> + * vfio platform * device
>> + *
>> + * @vdev: vfio_device handle to release
>> + */
>> +static void kvm_vfio_put_vfio_device(struct vfio_device *vdev)
>> +{
>> +	kvm_vfio_device_put_external_user(vdev);
>> +}
>> +
>> +/**
>> + * kvm_vfio_find_fwd_irq - checks whether a forwarded IRQ already is
>> + * registered in the list of forwarded IRQs
>> + *
>> + * @kv: handle to the kvm-vfio device
>> + * @fwd: handle to the forwarded irq struct
>> + * In the positive returns the handle to its node in the kvm-vfio
>> + * forwarded IRQ list, returns NULL otherwise.
>> + * Must be called with kv->lock hold.
>> + */
>> +static struct kvm_vfio_fwd_irq_node *kvm_vfio_find_fwd_irq(
>> +				struct kvm_vfio *kv,
>> +				struct kvm_fwd_irq *fwd)
>> +{
>> +	struct kvm_vfio_fwd_irq_node *node;
>> +
>> +	list_for_each_entry(node, &kv->fwd_node_list, link) {
>> +		if ((node->fwd_irq.index == fwd->index) &&
>> +		    (node->fwd_irq.subindex == fwd->subindex) &&
>> +		    (node->fwd_irq.vdev == fwd->vdev))
>> +			return node;
>> +	}
>> +	return NULL;
>> +}
>> +/**
>> + * kvm_vfio_register_fwd_irq - Allocates, populates and registers a
>> + * forwarded IRQ
>> + *
>> + * @kv: handle to the kvm-vfio device
>> + * @fwd: handle to the forwarded irq struct
>> + * In case of success returns a handle to the new list node,
>> + * NULL otherwise.
>> + * Must be called with kv->lock hold.
>> + */
>> +static struct kvm_vfio_fwd_irq_node *kvm_vfio_register_fwd_irq(
>> +				struct kvm_vfio *kv,
>> +				struct kvm_fwd_irq *fwd)
>> +{
>> +	struct kvm_vfio_fwd_irq_node *node;
>> +
>> +	node = kmalloc(sizeof(*node), GFP_KERNEL);
>> +	if (!node)
>> +		return NULL;
>> +
>> +	node->fwd_irq = *fwd;
>> +
>> +	list_add(&node->link, &kv->fwd_node_list);
>> +
>> +	return node;
>> +}
>> +
>> +/**
>> + * kvm_vfio_unregister_fwd_irq - unregisters and frees a forwarded IRQ
>> + *
>> + * @node: handle to the node struct
>> + * Must be called with kv->lock hold.
>> + */
>> +static void kvm_vfio_unregister_fwd_irq(struct kvm_vfio_fwd_irq_node
>> *node)
>> +{
>> +	list_del(&node->link);
>> +	kfree(node);
>> +}
>> +
>> +/**
>> + * kvm_vfio_set_forward - turns a VFIO device IRQ into a forwarded IRQ
>> + * @kv: handle to the kvm-vfio device
>> + * @fd: file descriptor of the vfio device the IRQ belongs to
>> + * @fwd: handle to the forwarded irq struct
>> + *
>> + * Registers an IRQ as forwarded and calls the architecture specific
>> + * implementation of set_forward. In case of operation failure, the IRQ
>> + * is unregistered. In case of success, the vfio device ref counter is
>> + * incremented.
>> + */
>> +static int kvm_vfio_set_forward(struct kvm_vfio *kv, int fd,
>> +				struct kvm_fwd_irq *fwd)
>> +{
>> +	int ret;
>> +	struct kvm_vfio_fwd_irq_node *node =
>> +			kvm_vfio_find_fwd_irq(kv, fwd);
>> +
>> +	if (node)
>> +		return -EINVAL;
>> +	node = kvm_vfio_register_fwd_irq(kv, fwd);
>> +	if (!node)
>> +		return -ENOMEM;
>> +	ret = kvm_arch_vfio_set_forward(fwd, true);
>> +	if (ret < 0)  {
>> +		kvm_vfio_unregister_fwd_irq(node);
>> +		return ret;
>> +	}
>> +	/* increment the ref counter */
>> +	kvm_vfio_get_vfio_device(fd);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * kvm_vfio_unset_forward - Sets a VFIO device IRQ as non forwarded
>> + * @kv: handle to the kvm-vfio device
>> + * @fwd: handle to the forwarded irq struct
>> + *
>> + * Calls the architecture specific implementation of set_forward and
>> + * unregisters the IRQ from the forwarded IRQ list. Decrements the vfio
>> + * device reference counter.
>> + */
>> +static int kvm_vfio_unset_forward(struct kvm_vfio *kv,
>> +				  struct kvm_fwd_irq *fwd)
>> +{
>> +	int ret;
>> +	struct kvm_vfio_fwd_irq_node *node =
>> +			kvm_vfio_find_fwd_irq(kv, fwd);
>> +	if (!node)
>> +		return -EINVAL;
>> +	ret = kvm_arch_vfio_set_forward(fwd, false);
>> +	kvm_vfio_unregister_fwd_irq(node);
>> +
>> +	/* decrement the ref counter */
>> +	kvm_vfio_put_vfio_device(fwd->vdev);
>> +	return ret;
>> +}
>> +
>> +static int kvm_vfio_control_irq_forward(struct kvm_device *kdev, long attr,
>> +					int32_t __user *argp)
>> +{
>> +	struct kvm_arch_forwarded_irq user_fwd_irq;
>> +	struct kvm_fwd_irq fwd;
>> +	struct vfio_device *vdev;
>> +	struct kvm_vfio *kv = kdev->private;
>> +	int ret;
>> +
>> +	if (copy_from_user(&user_fwd_irq, argp, sizeof(user_fwd_irq)))
>> +		return -EFAULT;
>> +
>> +	vdev = kvm_vfio_get_vfio_device(user_fwd_irq.fd);
>> +	if (IS_ERR(vdev)) {
>> +		ret = PTR_ERR(vdev);
>> +		goto out;
>> +	}
>> +
>> +	fwd.vdev =  vdev;
>> +	fwd.kvm =  kdev->kvm;
>> +	fwd.index = user_fwd_irq.index;
>> +	fwd.subindex = user_fwd_irq.subindex;
>> +	fwd.gsi = user_fwd_irq.gsi;
>> +
>> +	switch (attr) {
>> +	case KVM_DEV_VFIO_DEVICE_FORWARD_IRQ:
>> +		mutex_lock(&kv->lock);
>> +		ret = kvm_vfio_set_forward(kv, user_fwd_irq.fd, &fwd);
>> +		mutex_unlock(&kv->lock);
>> +		break;
>> +	case KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ:
>> +		mutex_lock(&kv->lock);
>> +		ret = kvm_vfio_unset_forward(kv, &fwd);
>> +		mutex_unlock(&kv->lock);
>> +		break;
>> +	}
>> +out:
>> +	kvm_vfio_put_vfio_device(vdev);
>> +	return ret;
>> +}
>> +
>> +static int kvm_vfio_set_device(struct kvm_device *kdev, long attr, u64 arg)
>> +{
>> +	int32_t __user *argp = (int32_t __user *)(unsigned long)arg;
>> +	int ret;
>> +
>> +	switch (attr) {
>> +	case KVM_DEV_VFIO_DEVICE_FORWARD_IRQ:
>> +	case KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ:
>> +		ret = kvm_vfio_control_irq_forward(kdev, attr, argp);
>> +		break;
>> +	default:
>> +		ret = -ENXIO;
>> +	}
>> +	return ret;
>> +}
>> +
>> +/**
>> + * kvm_vfio_clean_fwd_irq - Unset forwarding state of all
>> + * registered forwarded IRQs and free their list nodes.
>> + * @kv: kvm-vfio device
>> + *
>> + * Loop on all registered device/IRQ combos, reset the non forwarded state,
>> + * void the lists and release the reference
>> + */
>> +static int kvm_vfio_clean_fwd_irq(struct kvm_vfio *kv)
>> +{
>> +	struct kvm_vfio_fwd_irq_node *node, *tmp;
>> +
>> +	list_for_each_entry_safe(node, tmp, &kv->fwd_node_list, link) {
>> +		kvm_vfio_unset_forward(kv, &node->fwd_irq);
>> +	}
>> +	return 0;
>> +}
>> +
>>  static int kvm_vfio_set_attr(struct kvm_device *dev,
>>  			     struct kvm_device_attr *attr)
>>  {
>>  	switch (attr->group) {
>>  	case KVM_DEV_VFIO_GROUP:
>>  		return kvm_vfio_set_group(dev, attr->attr, attr->addr);
>> +	case KVM_DEV_VFIO_DEVICE:
>> +		return kvm_vfio_set_device(dev, attr->attr, attr->addr);
>>  	}
>>
>>  	return -ENXIO;
>> @@ -268,10 +503,17 @@ static int kvm_vfio_has_attr(struct kvm_device
>> *dev,
>>  		case KVM_DEV_VFIO_GROUP_DEL:
>>  			return 0;
>>  		}
>> -
>>  		break;
>> +#ifdef __KVM_HAVE_ARCH_KVM_VFIO_FORWARD
>> +	case KVM_DEV_VFIO_DEVICE:
>> +		switch (attr->attr) {
>> +		case KVM_DEV_VFIO_DEVICE_FORWARD_IRQ:
>> +		case KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ:
>> +			return 0;
>> +		}
>> +		break;
>> +#endif
> 
> Hi Eric,
> 
> Can you make the above code like this since group KVM_DEV_VFIO_DEVICE
> will be used by posted interrupts as well, and new attributes will be added
> in this group.
> 
>  +	case KVM_DEV_VFIO_DEVICE:
>  +		switch (attr->attr) {
>  +#ifdef __KVM_HAVE_ARCH_KVM_VFIO_FORWARD
>  +		case KVM_DEV_VFIO_DEVICE_FORWARD_IRQ:
>  +		case KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ:
>  +			return 0;
>  +#endif
>  +		}
>  +		break;
> 
> Thanks,
> Feng
Hi Feng,

yes sure!

Best Regards

Eric
> 
> 
>>  	}
>> -
>>  	return -ENXIO;
>>  }
>>
>> @@ -285,7 +527,7 @@ static void kvm_vfio_destroy(struct kvm_device *dev)
>>  		list_del(&kvg->node);
>>  		kfree(kvg);
>>  	}
>> -
>> +	kvm_vfio_clean_fwd_irq(kv);
>>  	kvm_vfio_update_coherency(dev);
>>
>>  	kfree(kv);
>> @@ -317,6 +559,7 @@ static int kvm_vfio_create(struct kvm_device *dev,
>> u32 type)
>>  		return -ENOMEM;
>>
>>  	INIT_LIST_HEAD(&kv->group_list);
>> +	INIT_LIST_HEAD(&kv->fwd_node_list);
>>  	mutex_init(&kv->lock);
>>
>>  	dev->private = kv;
>> --
>> 1.9.1
> 
