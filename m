From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Dec 2016 13:42:45 +0000
Subject: [PATCH 2/2] ARM: soft-reboot into same mode that we entered the
 kernel
In-Reply-To: <20161214120541.GD14217@n2100.armlinux.org.uk>
References: <20161213113044.GC19985@leverpostej>
 <E1cH751-0003kk-Ts@rmk-PC.armlinux.org.uk>
 <20161214115648.GG17982@leverpostej>
 <20161214120541.GD14217@n2100.armlinux.org.uk>
Message-ID: <2c6fd1cb-dd14-56f7-60c5-5030e0b02e1d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/16 12:05, Russell King - ARM Linux wrote:
> On Wed, Dec 14, 2016 at 11:56:49AM +0000, Mark Rutland wrote:
>> On Wed, Dec 14, 2016 at 10:46:35AM +0000, Russell King wrote:
>>> When we soft-reboot (eg, kexec) from one kernel into the next, we need
>>> to ensure that we enter the new kernel in the same processor mode as
>>> when we were entered, so that (eg) the new kernel can install its own
>>> hypervisor - the old kernel's hypervisor will have been overwritten.
>>>
>>> In order to do this, we need to pass a flag to cpu_reset() so it knows
>>> what to do, and we need to modify the kernel's own hypervisor stub to
>>> allow it to handle a soft-reboot.
>>>
>>> As we are always guaranteed to install our own hypervisor if we're
>>> entered in HYP32 mode, and KVM will have moved itself out of the way
>>> on kexec/normal reboot, we can assume that our hypervisor is in place
>>> when we want to kexec, so changing our hypervisor API should not be a
>>> problem.
>>
>> Just to check, does that also hold true for kdump?
>>
>> I haven't gone digging yet, but it looks like KVM might still be
>> installed, rather than the hyp stub, and we might need some logic to
>> ensure that it's torn down...
> 
> The same problem will be true of ARM64 - I don't see any solution to
> that in the present state.
> 
>>> @@ -51,7 +52,9 @@ static void __soft_restart(void *addr)
>>>  
>>>  	/* Switch to the identity mapping. */
>>>  	phys_reset = (phys_reset_t)virt_to_idmap(cpu_reset);
>>> -	phys_reset((unsigned long)addr);
>>> +
>>> +	/* original stub should be restored by kvm */
>>> +	phys_reset((unsigned long)addr, is_hyp_mode_available());
>>
>> ... otherwise here we'd call into the KVM hyp code in a potentially
>> confusing manner.
>>
>> Otherwise, this looks fine to me.
> 
> The only thing that I can think which would resolve that would be to
> lay down a standard API for the hyp code, so things like reboot into
> hyp mode can work irrespective of the hyp stub in place.

That looks like a sensible thing to do. I'll look into it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
