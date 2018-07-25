From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Thu, 26 Jul 2018 01:27:42 +0530
Subject: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
In-Reply-To: <9c4d7c8d-3f0b-ff2f-68e8-03638a5fe2a4@arm.com>
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
 <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
 <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
 <9c4d7c8d-3f0b-ff2f-68e8-03638a5fe2a4@arm.com>
Message-ID: <CACi5LpM9sc+c1M_dAEL9z+Sw6t0Wi1CsQ=M4E1nbQ4RRnkysRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello James,

On Mon, Jul 23, 2018 at 10:35 PM, James Morse <james.morse@arm.com> wrote:
> Hi Bhupesh,
>
> (CC: +mips list, looks like mips is missing vmcore's KERNELOFFSET too.
> Start of this thread: https://lkml.org/lkml/2018/7/18/951 )

Yes, but the current upstream makedumpfile doesn't seem to contain
mips specific support (please see
<git://git.code.sf.net/p/makedumpfile/code> for details), so I am not
sure they need the 'KERNELOFFSET=' supported in kernel as they are
probably not using it in the user-space.

If someone from the mips list can help suggest if my understanding is
correct it would be great. Just as a side note, I don't have access to
mips hardware, so I will be happy to update the v2 to add mips kernel
bits as well, in case someone is willing to give it a try on their
mips hardware.

> On 19/07/18 15:55, Bhupesh Sharma wrote:
>> On Thu, Jul 19, 2018 at 5:01 PM, James Morse <james.morse@arm.com> wrote:
>>> On 18/07/18 22:37, Bhupesh Sharma wrote:
>>>> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
>>>>
>>>> makedumpfile user-space utility will need fixup to use this KASLR offset
>>>> to work with cases where we need to find a way to translate symbol
>>>> address from vmlinux to kernel run time address in case of KASLR boot on
>>>> arm64.
>>>
>>> You need the kernel VA for a symbol. Isn't this what kallsyms is for?
>>> | root at frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
>>> | ffff5404610d0000 B swapper_pg_dir
>
>> Its already used by other archs like x86_64.
>> Its just that we are enabling this feature for arm64 now that the
>> KASLR boot cases are more widely seen on arm64 boards (as newer EFI
>> firmware implementations are available which support EFI_RNG_PROTOCOL
>> and hence KASLR boot).
>>
>> And we want existing user-space application(s) to work similarly on
>> arm64 distributions as they work historically on other archs like
>> x86_64 (in most cases the user-space user is not even aware, if he is
>> developing for or using an underlying hardware which is arm64 or
>> x86_64)
>
> Aha, so its ABI. This is the information that should be in the commit message as
> it describes why this patch should be merged.

Sure, will add the description in the commit message of v2.

> ... Ideally core code would do this, that way this information won't be missed
> when an architecture adds KASLR support.
>
> But mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
> and x86 always provides this value, not just if CONFIG_RANDOMIZE_BASE is
> selected. I can't see a way to do this without touching all three architectures.
> (we can try and tidy it up once its clear whether mips needs this too)

Yes, I checked internally at Red Hat and no use-cases for mips
surfaced for this feature. So, if someone from the mips list can help
clarify, it will help me re-write the v2 accordingly.

> I think the patch is fine, but could you re-post it with a commit message that
> describes that vmcore parsing in user-space already expects this value in the
> notes. We're providing it for portability of those existing tools with x86.

Sure.

>>> I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
>>> to work out this offset. (you should expect the kernel to rename these symbols
>>> at a whim).
>>>
>>
>> Perhaps you missed what the above makedumpfile command was doing, so
>> let me summarize again:
>
> Yes, I glossed over it, all that seemed relevant is you are trying to find the
> kernel-va of a symbol from the value in the vmlinux.

Yes, that's correct.

>
>> as it breaks the
>> existing user-space use-cases and the .conf file can be user-defined
>> (and hence he can pick any symbol/functions
>
> My suggestion was you can calculate the offset between the link-time and
> run-time address from information you already have. You just need one of each.
> This would be better as its independent of how the kernel does the relocation.
>
> But, this is irrelevant as 'KERNELOFFSET=' is already an ABI string.

Indeed. We would like to have ABI strings similar across archs.

>> which might not even be present in 'kallsyms').
>
> Eh? How can that happen? I thought even modules had their symbols added to kallsyms.

Sorry, when I re-read my reply, I think I did not explain it better in
terms of the distribution use-cases we usually encounter. Let me try
again:

One of the reason is that existing user-space implementations (for
archs like x86_64), historically use 'vmlinux' for filtering of
symbols from 'vmcore'.

Usually when an end-user uses a distribution kernel on their hardware
and face issues with it, they share the 'vmcore' (crash dump) and
'vmlinux' with the distribution provider. 'vmlinux' can be used by
utilities like gdb/crash-utility to debug the reason for kernel crash.

Let's assume, even if the user manages to save the 'kallsyms' on some
external media (e.g. usb stick) when the kernel crashed, since the
symbol addresses in 'kallsyms' change on each boot (as KASLR
randomizes the same), so we cannot use 'KERNELOFFSET=' to calculate
kaslr offset to the symbols reliably.

For example, let me share the following values of a real use-case:

Let's saw we are looking to find and erase the symbol 'jiffies' from
the vmcore, using (1) - vmlinux and (2) - kallsyms:

(1) vmlinux - Address of 'jiffies' -> 0xffff000009291980
(2) kallsyms - Address of 'jiffies' -> 0xffff4ce385291980 (value seen
during the boot when primary kernel crashed)

In this particular boot, makedumpfile reports 'kaslr_offset' as 0x2934e3000000
So, if we use:
(1) vmlinux - We calculate Address of 'jiffies' as ->
0xffff000009291980 + 0x2934e3000000 = 0xFFFF2934EC291980
(2) kallsyms - We calculate Address of 'jiffies' as ->
0xffff4ce385291980 + 0x2934e3000000 = 0xFFFF761868291980

When we check the 'vmcore' we can see that the address of 'jiffies' is
indeed 0xFFFF2934EC291980 and not 0xFFFF761868291980:

crash> sym jiffies
ffff2934ec291980 (D) jiffies

Since, the address of 'jiffies' pointed to by 'kallsyms' will change
on every boot, its probably not a good source for such user-space
use-cases.

Will send out a v2 shortly (after waiting for some inputs from the mips guys).

Thanks,
Bhupesh
