From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 27 Aug 2014 17:42:58 +0200
Subject: [RFC 8/9] KVM: KVM-VFIO: add kvm_vfio_arch_data and accessors
In-Reply-To: <1409153842.2906.255.camel@ul30vt.home>
References: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>		
 <1408973264-30384-9-git-send-email-eric.auger@linaro.org>	
 <1409079750.2906.130.camel@ul30vt.home> <53FDF7B6.507@linaro.org>
 <1409153842.2906.255.camel@ul30vt.home>
Message-ID: <53FDFC82.1050505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 05:37 PM, Alex Williamson wrote:
> On Wed, 2014-08-27 at 17:22 +0200, Eric Auger wrote:
>> On 08/26/2014 09:02 PM, Alex Williamson wrote:
>>> On Mon, 2014-08-25 at 15:27 +0200, Eric Auger wrote:
>>>> add a pointer to architecture specific data in kvm_vfio struct
>>>> add accessors to keep kvm_vfio private
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>>> ---
>>>>  arch/arm/include/asm/kvm_host.h |  8 ++++++++
>>>>  virt/kvm/vfio.c                 | 21 +++++++++++++++++++++
>>>>  2 files changed, 29 insertions(+)
>>>>
>>>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>>>> index 62cbf5b..4f1edbf 100644
>>>> --- a/arch/arm/include/asm/kvm_host.h
>>>> +++ b/arch/arm/include/asm/kvm_host.h
>>>> @@ -177,6 +177,14 @@ void kvm_vfio_device_put_external_user(struct vfio_device *vdev);
>>>>  int kvm_vfio_external_get_type(struct vfio_device *vdev);
>>>>  struct device *kvm_vfio_external_get_base_device(struct vfio_device *vdev);
>>>>  
>>>> +struct kvm_vfio;
>>>> +struct kvm_vfio_arch_data;
>>>> +void kvm_vfio_device_set_arch_data(struct kvm_vfio *kv,
>>>> +				   struct kvm_vfio_arch_data *ptr);
>>>> +struct kvm_vfio_arch_data *kvm_vfio_device_get_arch_data(struct kvm_vfio *kv);
>>>> +void kvm_vfio_lock(struct kvm_vfio *kv);
>>>> +void kvm_vfio_unlock(struct kvm_vfio *kv);
>>>> +
>>>>  /* We do not have shadow page tables, hence the empty hooks */
>>>>  static inline int kvm_age_hva(struct kvm *kvm, unsigned long hva)
>>>>  {
>>>> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
>>>> index f1c4e35..177b71e 100644
>>>> --- a/virt/kvm/vfio.c
>>>> +++ b/virt/kvm/vfio.c
>>>> @@ -28,6 +28,7 @@ struct kvm_vfio {
>>>>  	struct list_head group_list;
>>>>  	struct mutex lock;
>>>>  	bool noncoherent;
>>>> +	struct kvm_vfio_arch_data *arch_data;
>>>>  };
>>>>  
>>>>  static struct vfio_group *kvm_vfio_group_get_external_user(struct file *filep)
>>>> @@ -338,6 +339,26 @@ static int kvm_vfio_create(struct kvm_device *dev, u32 type)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +void kvm_vfio_device_set_arch_data(struct kvm_vfio *kv,
>>>> +				   struct kvm_vfio_arch_data *ptr)
>>>> +{
>>>> +	kv->arch_data = ptr;
>>>> +}
>>>> +
>>>> +struct kvm_vfio_arch_data *kvm_vfio_device_get_arch_data(struct kvm_vfio *kv)
>>>> +{
>>>
>>> My preference would be s/get_//
>> ok
>>>
>>>> +	return kv->arch_data;
>>>> +}
>>>> +
>>>> +void kvm_vfio_lock(struct kvm_vfio *kv)
>>>> +{
>>>> +	mutex_lock(&kv->lock);
>>>> +}
>>>> +
>>>> +void kvm_vfio_unlock(struct kvm_vfio *kv)
>>>> +{
>>>> +	mutex_unlock(&kv->lock);
>>>> +}
>>>
>>> Gosh, what could go wrong...
>> Hum sorry I did not understand what you meant here
> 
> Sorry, I was just sarcastically noting that exposing an internal lock
> like this seems to be asking for trouble.  As you rework it to pull more
> into the common code and generalize the architecture callouts, I hope we
> can avoid exporting these locks.  Thanks,
ok thanks. No problem I learnt a new word ;-)

> 
> Alex
> 
