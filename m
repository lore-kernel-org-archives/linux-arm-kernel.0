From: james.morse@arm.com (James Morse)
Date: Thu, 31 Aug 2017 18:43:39 +0100
Subject: [PATCH v6 0/7] Add RAS virtualization support for SEA/SEI
 notification type in KVM
In-Reply-To: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <59A84ACB.7030808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 28/08/17 11:38, Dongjiu Geng wrote:
> In the firmware-first RAS solution, corrupt data is detected in a
> memory location when guest OS application software executing at EL0
> or guest OS kernel El1 software are reading from the memory. The
> memory node records errors in an error record accessible using
> system registers.
> 
> Because SCR_EL3.EA is 1, then CPU will trap to El3 firmware, EL3
> firmware records the error to APEI table through reading system
> register.

Strictly speaking these are CPER records in a memory region pointed to by the
HEST->GHES ACPI table.


> Because the error was taken from a lower Exception level, if the
> exception is SEA/SEI and HCR_EL2.TEA/HCR_EL2.AMO is 1, firmware
> sets ESR_EL2/FAR_EL2 to fake a exception trap to EL2, then
> transfers to hypervisor.

What happens if you took an SError from EL2 and EL2 has PSTATE.A set masking
SError? (this is very common today: all kernel code runs like this).

What happens if the hypervisor then executes an ESB with PSTATE.A set? It
expects to see any pending SError deferred and its syndrome written to DISR_EL1,
but this register is RAZ/WI when you set SCR_EL3.EA. '4.4.2' of [0]


> For the synchronous external abort(SEA), Hypervisor calls the
> ghes_handle_memory_failure() to deal with this error,
> ghes_handle_memory_failure() function reads the APEI table and 
> callls memory_failure() to decide whether it needs to deliver
> SIGBUS signal to user space, the advantage of using SIGBUS signal
> to notify user space is that it can be compatible with Non-Kvm users.
> 
> For the SError Interrupt(SEI),KVM firstly classified the error.

KVM can't parse the CPER records, nor does it know where to look to find them.
KVM should call out to the APEI code so the host kernel can handle the error.

User-space may be signalled by the memory_failure() helper, and user-space may
choose to notify the guest about the memory-failure, but this would be a new error.


> Not call memory_failure() to handle it. Because the error address recorded
> by APEI is not accurated, so can not identify the address to hwpoison
> memory.

This looks like a firmware bug, what address do you get in your CPER records? It
should be a physical address.

To report a memory-error you must have an address.

If the error wasn't detected as a synchronous access then delivering a
synchronous-external-abort is inappropriate (I think we both agree on this), and
SError-interrupt doesn't have a way of specifying an address ... but the CPER
records do.

For firmware-first your SError-interrupt is just a notification, its the CPER
records the OS uses to handle the error.


> If the SError error comes from guest user mode and is not propagated,
> then signal user space to handle it, otherwise, directly injects virtual
> SError, or panic if the error is fatal.

What do you mean by propagated?

I don't think we should ever hand RAS notifications to user-space, the host
kernel should handle them, then describe the symptom (e.g. this region of your
va space is gone) to user-space.


> when user space handles the error,
> it will specify syndrome for the injected virtual SError. This syndrome value
> is set to the VSESR_EL2. VSESR_EL2 is a new ARMv8.2 RAS extensions register
> which provides the syndrome value reported to software on taking a virtual
> SError interrupt exception.


Thanks,

James

[0]
https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf
