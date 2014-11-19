From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 19 Nov 2014 11:20:07 -0800
Subject: [PATCHv5 7/7] arm64: add better page protections to arm64
In-Reply-To: <CAKv+Gu-eAtpzU6LHWws11DONKTESWJ79_pzGmmo565S0q7sGXA@mail.gmail.com>
References: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
 <1416272105-14787-8-git-send-email-lauraa@codeaurora.org>
 <20141119163151.GC12851@leverpostej>
 <CAKv+Gu__TZeU4z5=D-znFTv9nKZ1LJK03bkX4pL9ni=cW1tRYA@mail.gmail.com>
 <20141119184656.GF12851@leverpostej>
 <CAKv+Gu-eAtpzU6LHWws11DONKTESWJ79_pzGmmo565S0q7sGXA@mail.gmail.com>
Message-ID: <546CED67.50505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2014 10:56 AM, Ard Biesheuvel wrote:
> On 19 November 2014 19:46, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Wed, Nov 19, 2014 at 05:38:07PM +0000, Ard Biesheuvel wrote:
>>> On 19 November 2014 17:31, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> Hi Laura,
>>>>
>>>> On Tue, Nov 18, 2014 at 12:55:05AM +0000, Laura Abbott wrote:
>>>>> Add page protections for arm64 similar to those in arm.
>>>>> This is for security reasons to prevent certain classes
>>>>> of exploits. The current method:
>>>>>
>>>>> - Map all memory as either RWX or RW. We round to the nearest
>>>>>    section to avoid creating page tables before everything is mapped
>>>>> - Once everything is mapped, if either end of the RWX section should
>>>>>    not be X, we split the PMD and remap as necessary
>>>>> - When initmem is to be freed, we change the permissions back to
>>>>>    RW (using stop machine if necessary to flush the TLB)
>>>>> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>>>>>    read only.
>>>>>
>>>>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>>>>> ---
>>>>> v5:
>>>>>   -Dropped map_io from the alloc_init_* functions
>>>>>   -Fixed a bug in split_pud and cleaned it up per suggestions from Steve
>>>>>   -Aligned _etext up to SECTION_SIZE of DEBUG_ALIGN_RODATA is enabled to ensure
>>>>>    that the section mapping is actually kept and we don't leak any RWX regions
>>>>>   -Dropped some old ioremap code that somehow snuck in from the last rebase
>>>>>   -Fixed create_id_mapping to use the early mapping since efi_idmap_init is
>>>>>    called early
>>>>> ---
>>>>>   arch/arm64/Kconfig.debug            |  23 +++
>>>>>   arch/arm64/include/asm/cacheflush.h |   4 +
>>>>>   arch/arm64/kernel/vmlinux.lds.S     |  20 +++
>>>>>   arch/arm64/mm/init.c                |   1 +
>>>>>   arch/arm64/mm/mm.h                  |   2 +
>>>>>   arch/arm64/mm/mmu.c                 | 289 +++++++++++++++++++++++++++++++-----
>>>>>   6 files changed, 298 insertions(+), 41 deletions(-)
>>>>
>>>> Unfortuantely this is blowing up on my Juno atop of v3.18-rc5, because
>>>> EFI runtime services seem to get mapped as non-executable, and at boot
>>>> we tried to read the RTC via runtime services:
>>>>
>>>> Bad mode in Synchronous Abort handler detected, code 0x8600000d
>>>> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.18.0-rc5+ #23
>>>> task: ffffffc9768b8000 ti: ffffffc9768c0000 task.ti: ffffffc9768c0000
>>>> PC is at 0xffffffc97ffaa3e4
>>>> LR is at virt_efi_get_time+0x60/0xa0
>>>> pc : [<ffffffc97ffaa3e4>] lr : [<ffffffc00044a6c8>] pstate: 800000c5
>>>> sp : ffffffc9768c39e0
>>>> x29: ffffffc9768c39e0 x28: ffffffc000723c90
>>>> x27: ffffffc0007b5678 x26: 0000000000000001
>>>> x25: ffffffc000584320 x24: ffffffc0006aaeb0
>>>> x23: ffffffc9768c3a60 x22: 0000000000000040
>>>> x21: ffffffc97ffaa3e4 x20: ffffffc0007b5a48
>>>> x19: ffffffc0007b5a40 x18: 0000000000000007
>>>> x17: 000000000000000e x16: 0000000000000001
>>>> x15: 0000000000000007 x14: 0ffffffffffffffe
>>>> x13: ffffffbe22feb720 x12: 0000000000000030
>>>> x11: 0000000000000003 x10: 0000000000000068
>>>> x9 : 0000000000000000 x8 : ffffffc97f981c00
>>>> x7 : 0000000000000000 x6 : 000000000000003f
>>>> x5 : 0000000000000040 x4 : 000000097f6c8000
>>>> x3 : 0000000000000000 x2 : 000000097f6c8000
>>>> x1 : ffffffc9768c3a50 x0 : ffffffc9768c3a60
>>>>
>>>> Ard, is this issue solved by any current series, or do we need to do
>>>> anything additional to ensure runtime services are mapped appropriately
>>>> for DEBUG_RODATA kernels?
>>>>
>>>
>>> This problem will just vanish with my uefi virtmap series, because
>>> then UEFI manages its own page tables.
>>> I use PXN for everything except EFI_RUNTIME_SERVICES_CODE (which
>>> [sadly] contains read-write data as well, due to how the PE/COFF
>>> loader in UEFI usually implemented, i.e., it allocates one single
>>> region to hold the entire static image, including .data and .bss).
>>> Once these changes land, the UEFI page tables will only be active
>>> during actual Runtime Services calls, so the attack service should be
>>> reduced substantially.
>>>
>>> For now, i guess adding a set_memory_x() in remap_region() for
>>> EFI_RUNTIME_SERVICES_CODE should suffice?
>>
>> Do we map that as module memory? I see change_memory_common (backing
>> set_memory_x) will fail if:
>>
>>          (!is_module_address(start) || !is_module_address(end - 1)
>>
>> If it is, I guess that will work for now.
>>
>
> Oh right, no we don't map it as module memory as far as I know.
>

Even if we remove that check, calling set_memory_x currently won't
work unless the underlying memory is mapped with pages. Modules
are mapped with pages but the rest of memory is not guaranteed to
have pages.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
