From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Mon, 20 Mar 2017 15:48:16 +0800
Subject: [PATCH v2 3/3] arm64: KVM: add guest SEI support
In-Reply-To: <58C7BBA2.4080208@arm.com>
References: <1488946181-130774-1-git-send-email-xiexiuqi@huawei.com>
 <1488946181-130774-4-git-send-email-xiexiuqi@huawei.com>
 <58C7BBA2.4080208@arm.com>
Message-ID: <0d082cbb-8163-1163-cdd3-3daecd57a823@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Thank you for your comments and detail explanation.

On 2017/3/14 17:45, James Morse wrote:
> Hi Xie XiuQi,
> 
> On 08/03/17 04:09, Xie XiuQi wrote:
>> Add ghes handling for SEI so that the host kernel could parse and
>> report detailed error information for SEI which occur in the guest
>> kernel.
> 
> How does this interact with Synchronous External Abort as a notify method?
> Both of these take the in_nmi() path through APEI.
> 
> SError Interrupts are masked during exception processing, so we don't have to
> worry about them becoming recursive.

If we use firmware first mode, SEI will be routed to EL3 first, in which mode
the interrupt cannot be masked by the PSTATE.{A,I,F}.

> For SEA the firmware has to promise not to invoke another SEA while we are still
> processing the first, and SEI will be masked if we took it as an exception.
> 

Yes, for SEI the firmware should also promise not to invoke another SEI while the
first SEI processing.

But I have a question here, how to handle this case: on the same cpu, another SEA
is taken while we are processing the first SEA. Should firmware detect this case and
reset the system directly?

The same question is also for SEI.

> What happens if we take an SEA while processing another event notified via SEI?
> Can this happen on your platform? Can someone else build a platform where this
> happens? Does the GHES APEI code need to be able to handle this?

IMO, the system should be panic if we take an SEA while processing another event
notified via SEI on the same cpu, and it's not necessary to parse the GHES for the
second SEA. However, if on different cpu, it might be taken simultaneously.

> 
> If we need to support both at the same time we will need to change Linux's APEI
> code to reserve a page of virtual address space per GHES entry, instead of one
> for NMI and one for IRQ.
> 

We cannot assume that firmware could prevent the SEA notify to OS while SEI is
processing on different cpu. Because firmware use two different GHES for SEA and SEI.
Yes, indeed, we could reserve another virtual address space for the second SEA or SEI.

All above, I just analyze the spec and discuss with BIOS team, but I have no platform
to test now. Any comments is welcome.

> 
>> diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
>> index 5b2cecd..d68d61f 100644
>> --- a/arch/arm64/include/asm/system_misc.h
>> +++ b/arch/arm64/include/asm/system_misc.h
>> @@ -59,5 +59,6 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
>>  #endif	/* __ASSEMBLY__ */
>>  
>>  int handle_guest_sea(unsigned long addr, unsigned int esr);
>> +int handle_guest_sei(unsigned long addr, unsigned int esr);
>>  
>>  #endif	/* __ASM_SYSTEM_MISC_H */
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 65dbfa9..cf9f569 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -616,6 +616,24 @@ const char *esr_get_class_string(u32 esr)
>>  }
>>  
>>  /*
>> + * Handle asynchronous SError interrupt that occur in a guest kernel.
>> + */
>> +int handle_guest_sei(unsigned long addr, unsigned int esr)
>> +{
>> +	/*
>> +	 * synchronize_rcu() will wait for nmi_exit(), so no need to
>> +	 * rcu_read_lock().
>> +	 */
> 
> This comment was true for patch 4 of Tyler's series, but not-true when we got to
> patch 10. Please remove it,

OK, thanks.

> 
> 
>> +	if(IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
>> +		rcu_read_lock();
> 
> Please put the rcu calls against the thing using them.
> 
> 
>> +		ghes_notify_sei();
>> +		rcu_read_unlock();
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>>   * bad_mode handles the impossible case in the exception vector. This is always
>>   * fatal.
>>   */
> 
>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>> index 1bfe30d..8c7dba0 100644
>> --- a/arch/arm64/kvm/handle_exit.c
>> +++ b/arch/arm64/kvm/handle_exit.c
>> @@ -172,6 +173,23 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>>  	return arm_exit_handlers[hsr_ec];
>>  }
>>  
>> +static int kvm_handle_guest_sei(struct kvm_vcpu *vcpu, struct kvm_run *run)
>> +{
>> +	unsigned long fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
>> +
>> +	if (handle_guest_sei((unsigned long)fault_ipa,
>> +				kvm_vcpu_get_hsr(vcpu))) {
>> +		kvm_err("Failed to handle guest SEI, FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
>> +				kvm_vcpu_trap_get_class(vcpu),
>> +				(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
>> +				(unsigned long)kvm_vcpu_get_hsr(vcpu));
>> +	}
>> +
> 
>> +	kvm_inject_vabt(vcpu);
> 
> Always inject an SError Interrupt? How should this work when Qemu supports
> guest-RAS too?
> 
> If we do want to kill the guest for RAS-related reasons we should go via
> user-space to allow Qemu to handle the error and potentially notify the guest.
> This would let Qemu generate CPER records for the guest, mirroring what just
> happened with the firmware-generated records.
> 
> As on the other thread: if there were CPER records processed by
> handle_guest_sei() we should continue as normal as the fault was handled in some
> way.
> If there were no CPER records, (or the system doesn't support SEI as a GHES
> notification mechanism), then yes we should still call kvm_inject_vabt().
> 
> A suggestion of how do this: [0], if you have a better suggestion please chime in!

We need use ESB to isolate the asynchronous error, so that, recovery from SEI is possible then.
I'll do more analyze at spec & code.

-- 
Thanks,
Xie XiuQi

> 
> 
> Thanks,
> 
> James
> 
> 
> [0] https://www.spinics.net/lists/kvm/msg146131.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 
