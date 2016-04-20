From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Apr 2016 11:37:11 +0100
Subject: [PATCH v7 07/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <57166CC9.4030804@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-8-git-send-email-james.morse@arm.com>
 <571656E9.5050402@arm.com> <57166CC9.4030804@arm.com>
Message-ID: <57175BD7.30902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/16 18:37, James Morse wrote:
> Hi Marc, Takahiro,
> 

[...]

> It looks like x86 uses the extable to work around this, their vmx_vcpu_run() has:
>> 		__ex(ASM_VMX_VMLAUNCH) "\n\t"
> Where __ex ends up calling ____kvm_handle_fault_on_reboot(), with a nearby comment:
>> * Hardware virtualization extension instructions may fault if a
>> * reboot turns off virtualization while processes are running.
>> * Trap the fault and ignore the instruction if that happens.

I very much like that approach, to be honest. Tearing down a CPU is
something exceptional, so let's make it an actual exception.

It is now pretty easy to discriminate between KVM functions and stub
functions thanks to your earlier patch, so if we end up calling the
hyp-stub because we've torn down KVM's EL2, let's just return an
appropriate error code (ARM_EXCEPTION_HYP_GONE), and handle it at EL1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
