From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 22 Mar 2017 20:08:48 +0800
Subject: [PATCH V11 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <58D25C8D.3070507@arm.com>
References: <1487712121-16688-1-git-send-email-tbaicar@codeaurora.org>
 <1487712121-16688-11-git-send-email-tbaicar@codeaurora.org>
 <df6ba5dc-d93f-925a-46bf-1e1e209d17f3@huawei.com> <58B43092.6040401@arm.com>
 <6eee7a67-808e-8712-2ec2-593eac52d921@huawei.com> <58D25C8D.3070507@arm.com>
Message-ID: <b57e2cb1-129b-7369-96e0-33e5c87dbb74@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 2017/3/22 19:14, James Morse wrote:
> Hi Wang Xiongfeng,
> 
> On 22/03/17 02:46, Xiongfeng Wang wrote:
>>> Guests are a special case as QEMU may never access the faulty memory itself, so
>>> it won't receive the 'late' signal. It looks like ARM/arm64 KVM lacks support
>>> for KVM_PFN_ERR_HWPOISON which sends SIGBUS from KVM's fault-handling code. I
>>> have patches to add support for this which I intend to send at rc1.
>>>
>>> [0] suggests 'KVM qemu' sets these MCE flags to take the 'early' path, but given
>>> x86s KVM_PFN_ERR_HWPOISON, this may be out of date.
>>>
>>>
>>> Either way, once QEMU gets a signal indicating the virtual address, it can
>>> generate its own APEI CPER records and use the KVM APIs to mock up an
>>> Synchronous External Abort, (or inject an IRQ or run the vcpu waiting for the
>>> guest's polling thread to come round, whichever was described to the guest via
>>> the HEST/GHES tables).
>>>
>>
>> I have another confusion about the SIGBUS signal. Can QEMU always get a SIGBUS when needed.
>> I know one circumstance which will send SIGBUS. The ghes_handle_memory_failure() in
>> ghes_do_proc() will send SIGBUS to QEMU, but this only happens when there exists memory section
>> in ghes, that is the section type is CPER_SEC_PLATFORM_MEM.
>> Suppose this case, an load  error in guest application causes an SEA, and the firmware take it.
>> The firmware begin to scan the error record and fill the ghes. But the error record in memory node
>> has been read by other handler.
> 
> (this looks like a race)
> 
>> The firmware won't add memory section in ghes, so ghes_handle_memory_failure() won't be called.
> 
> I think this would be a firmware bug. Firmware can reserve as much memory as it
> needs for writing CPER records, there should not be a case where 'the memory' is
> currently being processed by another handler.

I have a question here:
Consider this case, the memory controller first detected a memory error,
but it has not been consumed. So it will not generate the SEA. Memory error
may be reported to the OS by IRQ with MEM section in CPER record; and
after for a while, the error data was loaded into the cache and consumed,
when the SEA is generated. Is it possible only processor section, and no
MEM section in CPER record?

Obviously there are two different GHES above, one for SEA and another for IRQ/GSIV.
Could we assume that there is mem section in the SEA ghes table?

> 
> The memory firmware uses to write CPER records too shouldn't be published to the
> OS until it has finished. Once firmware has finished writing the CPER records it
> can update the memory pointed to by GHES->ErrorStatusAddress with the location
> of the CPER records and invoke the Notification method for this GHES. (SEI, SEA,
> IRQ etc). We should always get a complete set of CPER records to describe the error.
> 

Does it mean that the BIOS has the responsibility to ensure that the GHES table has a
complete error info, including memory, bus, tlb, cache and other related error info?

-- 
Thanks,
Xie XiuQi

> It firmware uses GHESv2 it can get an 'ack' write from APEI once it has finished
> processing the records. Once it gets this firmware knows it can re-use the memory.
> 
> (Obviously each GHES entry can only process one error at a time. Firmware should
> either handle this, or have one entry for each Error Source that can happen
> independently)
> 
> 
>> I mean that we may not rely on ghes_handle_memory_failure() to send SIGBUS to QEMU. Whether we should
>> add some other code to send SIGBUS in handle_guest_abort(). I don't know whether the ARM/arm64
>>  KVM_PFN_ERR_HWPOISON you mentioned above will cover all the cases.
> 
> The SIGBUS routine is part of the kernel's recovery method for memory errors. It
> should cover all the errors reported with this CPER_SEC_PLATFORM_MEM.
> 
> Back to the race you describe. It shouldn't matter if one CPU processes an error
> for guest memory while a vcpu is running on another. This may happen if the
> error was detected by DRAM's background scrub.
> If we don't treat KVM/Qemu as anything special the memory_failure()->SIGBUS path
> will happen regardless of whether the fault interrupted the guest or not.
> 
> 
> There are other types of error such as PCIe, CPU, BUS error etc. If it's
> possible to recover from these we may need additional code in the kernel. This
> shouldn't necessarily treat KVM as a special case.
> 
> 
> Thanks,
> 
> James
> 
> 
> .
> 
