From: wangxiongfeng2@huawei.com (Xiongfeng Wang)
Date: Wed, 22 Mar 2017 10:46:59 +0800
Subject: [PATCH V11 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <58B43092.6040401@arm.com>
References: <1487712121-16688-1-git-send-email-tbaicar@codeaurora.org>
 <1487712121-16688-11-git-send-email-tbaicar@codeaurora.org>
 <df6ba5dc-d93f-925a-46bf-1e1e209d17f3@huawei.com> <58B43092.6040401@arm.com>
Message-ID: <6eee7a67-808e-8712-2ec2-593eac52d921@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,


> Guests are a special case as QEMU may never access the faulty memory itself, so
> it won't receive the 'late' signal. It looks like ARM/arm64 KVM lacks support
> for KVM_PFN_ERR_HWPOISON which sends SIGBUS from KVM's fault-handling code. I
> have patches to add support for this which I intend to send at rc1.
> 
> [0] suggests 'KVM qemu' sets these MCE flags to take the 'early' path, but given
> x86s KVM_PFN_ERR_HWPOISON, this may be out of date.
> 
> 
> Either way, once QEMU gets a signal indicating the virtual address, it can
> generate its own APEI CPER records and use the KVM APIs to mock up an
> Synchronous External Abort, (or inject an IRQ or run the vcpu waiting for the
> guest's polling thread to come round, whichever was described to the guest via
> the HEST/GHES tables).
> 

I have another confusion about the SIGBUS signal. Can QEMU always get a SIGBUS when needed.
I know one circumstance which will send SIGBUS. The ghes_handle_memory_failure() in
ghes_do_proc() will send SIGBUS to QEMU, but this only happens when there exists memory section
in ghes, that is the section type is CPER_SEC_PLATFORM_MEM.
Suppose this case, an load  error in guest application causes an SEA, and the firmware take it.
The firmware begin to scan the error record and fill the ghes. But the error record in memory node
has been read by other handler. The firmware won't add memory section in ghes, so
ghes_handle_memory_failure() won't be called.
I mean that we may not rely on ghes_handle_memory_failure() to send SIGBUS to QEMU. Whether we should
add some other code to send SIGBUS in handle_guest_abort(). I don't know whether the ARM/arm64
 KVM_PFN_ERR_HWPOISON you mentioned above will cover all the cases.

Thanks,

Wang Xiongfeng
.
