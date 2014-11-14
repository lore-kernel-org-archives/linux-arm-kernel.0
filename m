From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Fri, 14 Nov 2014 23:18:27 +0800
Subject: [PATCH] virt: kvm: arm: vgic: Process the failure case when
 kvm_register_device_ops() fails
In-Reply-To: <5466177F.8070704@arm.com>
References: <5464C865.90504@gmail.com> <5464CE9A.6050209@arm.com>
 <54660C32.6090602@gmail.com> <54660D33.5090309@arm.com>
 <54661137.4000806@gmail.com> <5466177F.8070704@arm.com>
Message-ID: <54661D43.3040901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 10:53 PM, Marc Zyngier wrote:
> On 14/11/14 14:27, Chen Gang wrote:
>> On 11/14/2014 10:09 PM, Marc Zyngier wrote:
>>> On 14/11/14 14:05, Chen Gang wrote:
>>>> On 11/13/2014 11:30 PM, Marc Zyngier wrote:
>>>>> On 13/11/14 15:04, Chen Gang wrote:
>>>>>> When kvm_register_device_ops() fails, also need call free_percpu_irq()
>>>>>> just like others have down within kvm_vgic_hyp_init().
>>>>>>
>>>>>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>>>>>> ---
>>>>>>  virt/kvm/arm/vgic.c | 10 ++++++++--
>>>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>>>>>> index 3aaca49..b799f17 100644
>>>>>> --- a/virt/kvm/arm/vgic.c
>>>>>> +++ b/virt/kvm/arm/vgic.c
>>>>>> @@ -2470,8 +2470,14 @@ int kvm_vgic_hyp_init(void)
>>>>>>  
>>>>>>  	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
>>>>>>  
>>>>>> -	return kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
>>>>>> -				       KVM_DEV_TYPE_ARM_VGIC_V2);
>>>>>> +	ret = kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
>>>>>> +				      KVM_DEV_TYPE_ARM_VGIC_V2);
>>>>>> +	if (ret) {
>>>>>> +		kvm_err("Cannot register device ops\n");
>>>>>> +		goto out_free_irq;
>>>>>> +	}
>>>>>> +
>>>>>> +	return 0;
>>>>>>  
>>>>>>  out_free_irq:
>>>>>>  	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
>>>>>>
>>>>>
>>>>> Awesome. You're now freeing a per-cpu interrupt after just after having
>>>>> enabled it on all CPUs. What could possibly go wrong?
>>>>>
>>>>
>>>> OK, thanks. What you said sound reasonable to me. Need call on_each_cpu
>>>> for disable_percpu_irq(). Also need call __unregister_cpu_notifier(),
>>>> and need a new function vgic_arch_unsetup() for arm64.
>>>
>>> No. Just look at the code. Why don't you just move the
>>> kvm_register_device_ops call *before* enabling the interrupt?
>>>
>>
>> Only based on the current code, what you said is reasonable to me.
>>
>> But in the normal initializing sequence, firstly for architecture
>> dependence features, then for common cpu features, at last for other
>> devices (at least, other devices need be the last).
>>
>> So for me, we need still remain current initializing sequence for
>> extensible in the future.
> 
> Well, the current code is what matters to me, not some hypothetical
> consideration about how things should (or should not) be.
> 

Different members have different tastes. For me, I want to try to keep
original author's taste no touch (try to keep orginal working flow and
styles).

> If you plan to add some code that will require such a refactor, then
> post the code together with whatever you want to see changed, and we can
> talk about it.
> 

OK, thanks. I will send patch v2 for it, next.

> Until then, I'm not willing to take something that looks over-designed
> in place of a 4 line fix.
> 

At least, __unregister_cpu_notifier() or kvm_unregister_device_ops() is
requited for us to process the related failure (which exceeds 4 lines).


Thanks.
-- 
Chen Gang

Open share and attitude like air water and life which God blessed
