From: sgoel@codeaurora.org (Goel, Sameer)
Date: Thu, 4 May 2017 13:58:48 -0600
Subject: [PATCH] arm64: Add translation functions for /dev/mem read/write
In-Reply-To: <CAKv+Gu-z8_OeTEp-4DSLtfvirKHct8sD+uThz4wseuZgHBxyoA@mail.gmail.com>
References: <1493756885-29704-1-git-send-email-sgoel@codeaurora.org>
 <20170503112639.GG8233@arm.com>
 <bda22142-6b46-0e11-9d13-4bed0dcfd713@codeaurora.org>
 <20170503201814.GP1657@bivouac.eciton.net>
 <345a59fb-085f-a776-2d7e-4889a0f86d7f@codeaurora.org>
 <CAKv+Gu-z8_OeTEp-4DSLtfvirKHct8sD+uThz4wseuZgHBxyoA@mail.gmail.com>
Message-ID: <a7bcc4e1-afaa-f504-9496-a775abfc6ba5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/4/2017 12:40 AM, Ard Biesheuvel wrote:
> On 3 May 2017 at 22:47, Goel, Sameer <sgoel@codeaurora.org> wrote:
>>
>>
>> On 5/3/2017 2:18 PM, Leif Lindholm wrote:
>>> On Wed, May 03, 2017 at 11:07:45AM -0600, Goel, Sameer wrote:
>>>> On 5/3/2017 5:26 AM, Will Deacon wrote:
>>>>> [adding some /dev/mem fans to cc]
>>>>>
>>>>> On Tue, May 02, 2017 at 02:28:05PM -0600, Sameer Goel wrote:
>>>>>> Port architecture specific xlate and unxlate functions for /dev/mem
>>>>>> read/write. This sets up the mapping for a valid physical address if a
>>>>>> kernel direct mapping is not already present.
>>>>>>
>>>>>> This is a generic issue as a user space app should not be allowed to crash
>>>>>> the kernel.
>>>>>
>>>>>> This issue was observed when systemd tried to access performance
>>>>>> pointer record from the FPDT table.
>>>>>
>>>>> Why is it doing that? Is there not a way to get this via /sys?
>>>>
>>>> There is no ACPI FPDT implementation in the kernel, so the userspace
>>>> systemd code is getting the FPDT table contents from /sys
>>>> and parsing the entries. The performance pointer record is a
>>>> reserved address populated by UEFI and the userspace code tries to
>>>> access it using /dev/mem. The physical address is valid, so cannot
>>>> push back on the user space code.
>>>
>>> OK, so then we need to add support for parsing this table in the
>>> kernel and exposing the referred-to regions in a controllable fashion.
>>> Maybe something that belongs under /sys/firmware/efi (adding Matt), or
>>> maybe something that deserves its own driver.
>>>
>>> The only two use-cases for /dev/mem on arm64 are:
>>> - Implementing interfaces in the kernel takes up-front effort.
>>> - Being able to accidentally panic the kernel from userland.
>>>
>> We will see this issue with any access using /dev/mem to a MEMBLOCK_NOMAP marked
>> memblock. The kernel crash issue has to be fixed irrespective of ACPI FPDT support.
>>
> 
> I reported the same issue a couple of weeks ago [0]. So while we all
> agree that such accesses shouldn't oops the kernel, I think we may
> disagree on whether such accesses should be allowed in the first
> place, especially when using read/write on /dev/mem (as opposed to
> mmap())
> 
> One the UEFI/EDK2 side, there are two fundamental issues here, which
> we should resolve:
> - The use of EfiRuntimeServicesData for such regions: these tables
> have no significance to the firmware itself (not after
> ExitBootServices()) anyway, and so the only reason for choosing this
> memory type is that they are guaranteed to be left untouched by the
> OS. Also, using this type rather than something like 'ACPI Reclaim'
> results in the memory to be occupied regardless of whether you
> understand cq. are interested in its contents, which is something we
> usually try to avoid in UEFI.
> - The unconditional use of the EFI_MEMORY_RUNTIME attribute for
> EfiRuntimeServicesData regions, which requests the OS to create a
> runtime mapping for it in the OS page tables. We should be able to
> take this attribute as a cue that the firmware has no interest in its
> contents (given that it never requested a mapping for it) making it
> safe for the OS to map it with any attributes it likes. However, EDK2
> currently does not provide this facility, i.e., the EFI_MEMORY_RUNTIME
> bit is always set.
> 
> So modulo the feedback on my patch, I think that approach is
> preferred, and we should really look into cleaning this up further on
> the firmware side. For now, the userland fix is to use mmap() rather
> than read() (which is already documented in the code as something that
> should not be relied upon to remain available indefinitely).
> 
> 
> 
> 
> 
> [0] http://marc.info/?l=linux-arm-kernel&m=149198561609050
> 
 Makes sense. I will pick up the patch mentioned in [0] for fixing my current issue.

Thanks,
Sameer
-- 
 Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
