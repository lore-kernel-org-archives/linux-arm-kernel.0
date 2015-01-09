From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 09 Jan 2015 13:42:42 +0000
Subject: [PATCH v6 18/20] KVM: introduce kvm_check_device_type()
In-Reply-To: <20150109123345.GR21092@cbox>
References: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
 <1420804478-17354-19-git-send-email-andre.przywara@arm.com>
 <20150109123345.GR21092@cbox>
Message-ID: <54AFDAD2.7010505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 09/01/15 12:33, Christoffer Dall wrote:
> On Fri, Jan 09, 2015 at 11:54:36AM +0000, Andre Przywara wrote:
>> While we can easily register and unregister KVM devices, there is
>> currently no easy way of checking whether a device has been
>> registered.
>> Introduce kvm_check_device_type() for that purpose and use it in two
>> existing functions. Also change the return code for an invalid
>> type number from ENOSPC to EINVAL.
>> This function will be later used by another patch set to check
>> whether a KVM_CREATE_IRQCHIP ioctl is valid.
> 
> I feel like this is misguided and the vgic should be able to figure this
> stuff out internally.  Did you have code for this approach somewhere
> that I can take a look at?

I pushed my WIP patch on top of the kvm-gicv3/v6 tree.
Given how that looks I reckoned the generic solution would be more
preferable.
Basically we internally decide in the _probe function whether we support
GICv2 emulation or not, which is mostly driven by device tree
properties. So at the moment I just register the GIC_V2 KVM device or
not. Now with the "vgic internal" solution I misuse the GICV address
base as a hint of the GICv2 emulation availability. Alternatively I have
to introduce a new variable to mirror what the KVM device array already
holds, which seems kind of exerted to me.
Besides that I am not sure if the GICV address hint will always be a
reliable indicator and what we will do if there will be another GIC
model to be emulated in the future (maybe we need that for the ITS
emulation already?)

So I prefer the more generic solution.
Let me know what you think, I can as well drop 18/20 and merge the above
mentioned patch.

> I forget: Are we still requiring KVM_CREATE_IRQCHIP for VGICv3 or are we
> just relying on users to use KVM_CREATE_DEVICE for anything in the
> future?

Since KVM_CREATE_IRQCHIP does not take an argument, we cannot use it for
GICv3. So GICv3 mandates KVM_CREATE_DEVICE. We need userspace
adjustments for GICv3 anyway, so that's not a problem.

Cheers,
Andre.

>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> Changelog:
>>  (new in v6)
>>
>>  include/linux/kvm_host.h |    1 +
>>  virt/kvm/kvm_main.c      |   33 +++++++++++++++++++++------------
>>  2 files changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 83d770e..723d0d2 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -1038,6 +1038,7 @@ void kvm_device_get(struct kvm_device *dev);
>>  void kvm_device_put(struct kvm_device *dev);
>>  struct kvm_device *kvm_device_from_filp(struct file *filp);
>>  int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type);
>> +int kvm_check_device_type(u32 type);
>>  void kvm_unregister_device_ops(u32 type);
>>  
>>  extern struct kvm_device_ops kvm_mpic_ops;
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 1cc6e2e..c7711b2 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2341,13 +2341,24 @@ static struct kvm_device_ops *kvm_device_ops_table[KVM_DEV_TYPE_MAX] = {
>>  #endif
>>  };
>>  
>> -int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type)
>> +int kvm_check_device_type(u32 type)
>>  {
>>  	if (type >= ARRAY_SIZE(kvm_device_ops_table))
>> -		return -ENOSPC;
>> +		return -EINVAL;
>>  
>> -	if (kvm_device_ops_table[type] != NULL)
>> -		return -EEXIST;
>> +	if (kvm_device_ops_table[type] == NULL)
>> +		return -ENODEV;
>> +
>> +	return -EEXIST;
> 
> I think this looks a bit screwy, the function always return errors...?
> 
>> +}
>> +
>> +int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type)
>> +{
>> +	int ret;
>> +
>> +	ret = kvm_check_device_type(type);
>> +	if (ret != -ENODEV)
>> +		return ret;
>>  
>>  	kvm_device_ops_table[type] = ops;
>>  	return 0;
>> @@ -2364,19 +2375,17 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
>>  {
>>  	struct kvm_device_ops *ops = NULL;
>>  	struct kvm_device *dev;
>> -	bool test = cd->flags & KVM_CREATE_DEVICE_TEST;
>>  	int ret;
>>  
>> -	if (cd->type >= ARRAY_SIZE(kvm_device_ops_table))
>> -		return -ENODEV;
> 
> now you're basically changing a userspace-facing ABI because the ENODEV
> becomes an EINVAL, right?
> 
>> -
>> -	ops = kvm_device_ops_table[cd->type];
>> -	if (ops == NULL)
>> -		return -ENODEV;
>> +	ret = kvm_check_device_type(cd->type);
>> +	if (ret != -EEXIST)
>> +		return ret;
>>  
>> -	if (test)
>> +	if (cd->flags & KVM_CREATE_DEVICE_TEST)
>>  		return 0;
>>  
>> +	ops = kvm_device_ops_table[cd->type];
>> +
>>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>  	if (!dev)
>>  		return -ENOMEM;
>> -- 
>> 1.7.9.5
>>
> 
> Thanks,
> -Christoffer
> 
