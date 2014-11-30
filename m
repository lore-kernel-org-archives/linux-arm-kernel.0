From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Sun, 30 Nov 2014 11:25:19 +0800
Subject: [PATCH v2] virt: kvm: arm: vgic: Process the failure case when
 kvm_register_device_ops() fails
In-Reply-To: <54662E13.2010507@gmail.com>
References: <54661D5F.3060304@gmail.com> <546625F8.6060900@arm.com>
 <54662E13.2010507@gmail.com>
Message-ID: <547A8E1F.60900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello maintainers:

Is this discussion OK? If necessary, I shall send patch v3 according to
your taste.

Thanks.

On 11/15/14 00:30, Chen Gang wrote:
> 
> According to your taste, we need improve 2 contents below:
> 
> On 11/14/2014 11:55 PM, Marc Zyngier wrote:
>>
>> No. This is completely overdesigned, and fixes something that really
>> cannot happen. What is wrong with:
>>
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 3aaca49..b7dffa80 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -2465,13 +2465,17 @@ int kvm_vgic_hyp_init(void)
>>  		goto out_free_irq;
>>  	}
>>  
>> +	ret = kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
>> +				       KVM_DEV_TYPE_ARM_VGIC_V2);
>> +	if (ret)
>> +		goto out_free_irq;
>> +
> 
> Need call __unregister_cpu_notifier(), since __register_cpu_notifier()
> is already successfully called.
> 
> Need print some information for failure via kvm_err().
> 
> Thanks.
>>  	/* Callback into for arch code for setup */
>>  	vgic_arch_setup(vgic);
>>  
>>  	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
>>  
>> -	return kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
>> -				       KVM_DEV_TYPE_ARM_VGIC_V2);
>> +	return 0;
>>  
>>  out_free_irq:
>>  	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
>>
>> This achieves the exact same effect.
>>
>> Thanks,
>>
>> 	M.
>>
> 
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
