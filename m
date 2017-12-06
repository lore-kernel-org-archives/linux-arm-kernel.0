From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 6 Dec 2017 14:41:55 +0000
Subject: 4.15-rc1 crash on Midway in teardown_hyp_mode()
In-Reply-To: <10746458-42bd-c50f-3075-49811018099a@arm.com>
References: <45e72322-52dd-4fdb-2e51-176524fb56a8@arm.com>
 <10746458-42bd-c50f-3075-49811018099a@arm.com>
Message-ID: <2b9f0477-49bb-37e9-200c-0f2c477d559c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/17 14:17, Andre Przywara wrote:
> Hi,
> 
> On 06/12/17 14:11, Andre Przywara wrote:
>> Hi,
>>
>> while trying to boot 4.15-rc1 on my Calxeda Midway I observed a crash
>> (see below). I can't look further into this today, but wanted to report
>> this anyway.
>>
>> Digging around a bit this is due to the VGIC not initializing properly
>> due to GICC being advertised as just 4K, not 8K.
>> This can be worked around by adjusting the DT or using
>> irqchip.gicv2_force_probe. However this still raises some questions:
>> 1) Even if the VGIC fails to register, we should certainly not crash.
>> The chain of events seems to be:
>> virt/kvm/arm/arm.c:init_subsystems():
>>   - kvm_vgic_hyp_init() returns -ENODEV, this leads to vgic_present
>>     being set to false, but "err" being reset to 0 (meaning: carry on).
>>     However this seems now to miss some initialization.
>>   - kvm_timer_hyp_init() now fails on calling irq_set_vcpu_affinity(),
>>     because this returns -ENOSYS. This leads to it returning this error,
>>     init_subsystems() failing and subsequently tearing down KVM.
>>   - This seems to have some bug and leads to the kernel crash.
>>
>> Even with the VGIC not being usable, we should be able to cleanly tear
>> down KVM (or HYP?).
> 
> Just checked: If I let kvm_timer_hyp_init() deliberately fail in 4.14, I
> get the same splat (4.14 works fine, otherwise). So this particular
> issue existed already before. You should be able to reproduce it on any
> box by forcing "err = -ENOSYS;" after the call to kvm_timer_hyp_init()
> in virt/kvm/arm/arm.c:init_subsystems().

I wonder if the bigger hammer-type solution is not to expose that the
GIC is not capable of EOImode==1, and not enable the vgic in that
particular case...

I'll cook an RFC patch set for you to test.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
