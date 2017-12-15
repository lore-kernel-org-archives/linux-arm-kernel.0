From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Dec 2017 09:09:05 +0000
Subject: [PATCH] KVM: arm/arm64: don't set vtimer->cnt_ctl in
 kvm_arch_timer_handler
In-Reply-To: <e5ccbf1c-6078-4c43-8aa3-fc226ed358f7@gmail.com>
References: <1513148407-2611-1-git-send-email-hejianet@gmail.com>
 <20171213091803.GQ910@cbox> <dc95b58c-ee6c-e5c7-1f37-8f69c789a1fc@gmail.com>
 <20171214130954.GV910@cbox> <5615f3e1-756e-0537-f0b6-20ae8626ac87@gmail.com>
 <20171214154518.GX910@cbox> <e5ccbf1c-6078-4c43-8aa3-fc226ed358f7@gmail.com>
Message-ID: <519f0e33-4419-68be-32b4-11bb5e19cf17@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/17 02:27, Jia He wrote:
> 
> 

[...]

>> @@ -367,6 +368,7 @@ static void vtimer_save_state(struct kvm_vcpu *vcpu)
>>   
>>   	/* Disable the virtual timer */
>>   	write_sysreg_el0(0, cntv_ctl);
>> +	isb();
> My only concern is whether this isb() is required here?
> Sorryif this is a stupid question.I understand little about arm arch 
> memory barrier. But seems isb will flush all the instruction prefetch.Do 
> you think if an timer interrupt irq arrives, arm will use the previous 
> instruction prefetch?


This barrier has little to do with prefetch. It just guarantees that the
code after the isb() is now running with a disabled virtual timer.
Otherwise, a CPU can freely reorder the write_sysreg() until the next
context synchronization event.

An interrupt coming between the write and the barrier will also act as a
context synchronization event. For more details, see the ARMv8 ARM (the
glossary has a section on the concept).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
