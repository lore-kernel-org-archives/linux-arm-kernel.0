From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Thu, 27 Apr 2017 17:33:51 +0100
Subject: [PATCH 1/4] arm64: traps: fix userspace cache maintenance
 emulation on a tagged pointer
In-Reply-To: <f5ef088a-7d95-a43a-843e-064f8e13d2a7@arm.com>
References: <1492712234-4950-1-git-send-email-kristina.martsenko@arm.com>
 <1492712234-4950-2-git-send-email-kristina.martsenko@arm.com>
 <f5ef088a-7d95-a43a-843e-064f8e13d2a7@arm.com>
Message-ID: <fefff31c-9d81-4b4d-4ffb-44ce78624b2f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 21/04/17 11:59, Andre Przywara wrote:
> On 20/04/17 19:17, Kristina Martsenko wrote:
>> When we emulate userspace cache maintenance in the kernel, we can
>> currently send the task a SIGSEGV even though the maintenance was done
>> on a valid address. This happens if the address has a non-zero address
>> tag, and happens to not be mapped in.
>>
>> When we get the address from a user register, we don't currently remove
>> the address tag before performing cache maintenance on it. If the
>> maintenance faults, we end up in either __do_page_fault, where find_vma
>> can't find the VMA if the address has a tag, or in do_translation_fault,
>> where the tagged address will appear to be above TASK_SIZE. In both
>> cases, the address is not mapped in, and the task is sent a SIGSEGV.
> 
> Right, well spotted!
> So thanks for the patch, which I think is correct. But ...

Thanks for taking a look.

>> This patch removes the tag from the address before using it. With this
>> patch, the fault is handled correctly, the address gets mapped in, and
>> the cache maintenance succeeds.
> 
> Looking more closely at this code, I see that we actually don't use the
> address parameter in the force_signal_inject() function. Instead we
> always put the PC address into the siginfo structure, which is wrong in
> case this SEGV is triggered by an invalid address of a cache maintenance
> operation.

I agree this is a bug in existing code, as it means we currently put a
different address into the siginfo structure when we emulate cache
maintenance, compared to when we don't emulate it.

I think the bug is independent of this series though, and the fix should
be sent as a separate patch/series, as it is not blocking this series
and doesn't involve address tags.

> I made a simple patch to fix this (using the address argument and
> explicitly passing the PC in when we fault on an invalid instruction).

Sounds about right to me. Although I noticed that swp emulation also
goes through arm64_notify_segfault. I think the behaviour for swp
emulation should stay the same as in arch/arm/ set_segfault(), i.e.
faulting address used in find_vma, but PC passed in siginfo. Unless
that's a bug in arch/arm/ (for a non-emulated swp, they seem to pass the
faulting address in siginfo instead).

> But now we would pass the untagged address back into userland. I am not
> sure this is a real problem, since we don't promise anything in case of
> tagged pointers, if I got this correctly.

Yes, as documented in Documentation/arm64/tagged-pointers.txt, we do not
guarantee that the tag is preserved when delivering a signal.

> But also our untagged_addr() macro seems to not cover all cases
> correctly, for instance passing in 0x00ffffffffff5678 (which is an
> invalid, but untagged address) would extend to some probably valid
> kernel pointer. And although this would fail our user space address
> check, we would return a wrong address (with all the upper bits being 1)
> in siginfo.
> 
> Do we care about this?
> What would be the best fix for the untagged_addr macro? Is that macro
> actually the proper place to fix this issue?

I don't know if we care, but personally I think that if
force_signal_inject is fixed, then untagged_addr should be fixed along
with it. I think the macro is the right place to fix it, by only sign
extending if bit 55 is 0. That way it will turn a tagged address into an
untagged address, and will not change a non-tagged address. (This is
also what clear_address_tag in patch #3 of this series does.)

Thanks,
Kristina
