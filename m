From: james.morse@arm.com (James Morse)
Date: Fri, 02 Jun 2017 11:16:10 +0100
Subject: [PATCH v2] KVM: arm/arm64: Signal SIGBUS when stage2 discovers
 hwpoison memory
In-Reply-To: <20170601222235.GN20919@cbox>
References: <20170524163250.29281-1-james.morse@arm.com>
 <20170601222235.GN20919@cbox>
Message-ID: <59313AEA.2060705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 01/06/17 23:22, Christoffer Dall wrote:
> On Wed, May 24, 2017 at 05:32:50PM +0100, James Morse wrote:
>> Once we enable ARCH_SUPPORTS_MEMORY_FAILURE on arm64, notifications for
>> broken memory can call memory_failure() in mm/memory-failure.c to deliver
>> SIGBUS to any user space process using the page, and notify all the
>> in-kernel users.
>>
>> If the page corresponded with guest memory, KVM will unmap this page
>> from its stage2 page tables. The user space process that allocated
>> this memory may have never touched this page in which case it may not
>> be mapped meaning SIGBUS won't be delivered.

> Sorry, I don't remember, what is the scenario where KVM can have a
> mapping in stage 2 without there being a corresponding mapping for user
> space?

(looks like I mean more than one thing by mapping... oops.)

Mapping in that there is a physical page for this user-space address, but when
qemu first touches it, it will be faulted in as its not been touched before.

(rambling on:)
When mm/memory_failure.c:memory_failure() walks the rmap for the poisoned page
it doesn't find qemu, so no user-space processes gets signalled.

If qemu were to touch the page, fixup_user_fault() will return -EHWPOISON and we
deliver sigbus to qemu.

This doesn't happen when the guest touches the page as kvm's core code maps
-EHWPOISON to KVM_PFN_ERR_HWPOISON, which the arm/arm64 kvm code ignores and
drops -EFAULT on userspace instead.


>> This works well until a guest accesses that page, and KVM discovers
>> pfn == KVM_PFN_ERR_HWPOISON when it comes to process the stage2 fault.
>>
>> Do as x86 does, and deliver the SIGBUS when we discover
>> KVM_PFN_ERR_HWPOISON. Use the stage2 mapping size as the si_addr_lsb
> 
> But this part about the stage 2 mapping size is not what the code does.
> It uses the granularity of the mmap region, if I'm not mistaken.

Yes. This is what I got wrong last time, Punit put me right, but I forgot to
update the commit message.

I will change this 'Use the'... sentence in v3 to:
> Use the hugepage size as si_addr_lsb if this vma was allocated as a hugepage.
> Transparent hugepages will be split by memory_failure() before we see them
> here.


Thanks,

James
