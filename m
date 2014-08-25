From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 25 Aug 2014 12:04:05 -0700
Subject: [PATCHv3 7/7] arm64: add better page protections to arm64
In-Reply-To: <CAGXu5jJNkmZZt4WCV1suw6Wi8jua_c8=Y6PnarCTpwBp6BmLUA@mail.gmail.com>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
 <1408584039-12735-8-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jJNkmZZt4WCV1suw6Wi8jua_c8=Y6PnarCTpwBp6BmLUA@mail.gmail.com>
Message-ID: <53FB88A5.4070701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/2014 10:59 PM, Kees Cook wrote:
> On Wed, Aug 20, 2014 at 6:20 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
>> Add page protections for arm64 similar to those in arm.
>> This is for security reasons to prevent certain classes
>> of exploits. The current method:
>>
>> - Map all memory as either RWX or RW. We round to the nearest
>>   section to avoid creating page tables before everything is mapped
>> - Once everything is mapped, if either end of the RWX section should
>>   not be X, we split the PMD and remap as necessary
>> - When initmem is to be freed, we change the permissions back to
>>   RW (using stop machine if necessary to flush the TLB)
>> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>>   read only.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>  arch/arm64/Kconfig                  |   8 +
>>  arch/arm64/Kconfig.debug            |  23 +++
>>  arch/arm64/include/asm/cacheflush.h |   3 +
>>  arch/arm64/kernel/vmlinux.lds.S     |  17 ++
>>  arch/arm64/mm/init.c                |   1 +
>>  arch/arm64/mm/mm.h                  |   2 +
>>  arch/arm64/mm/mmu.c                 | 303 +++++++++++++++++++++++++++++++-----
>>  7 files changed, 321 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index fd4e81a..b718974 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -328,6 +328,14 @@ config FORCE_MAX_ZONEORDER
>>         default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
>>         default "11"
>>
>> +config NX_KERNEL_AREAS
>> +       bool "Allow no execute kernel areas"
>> +       help
>> +         Mark areas of the kernel that should never be executed (data, heap
>> +         etc.) as no execute. This helps with a certain set of security issues.
>> +         You should say Y here unless you like malicious code doing unexpected
>> +         things on your hardware.
>> +
>>  endmenu
>>
>>  menu "Boot options"
>> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
>> index 4ee8e90..032ccc1 100644
>> --- a/arch/arm64/Kconfig.debug
>> +++ b/arch/arm64/Kconfig.debug
>> @@ -43,4 +43,27 @@ config ARM64_RANDOMIZE_TEXT_OFFSET
>>           of TEXT_OFFSET and platforms must not require a specific
>>           value.
>>
>> +config DEBUG_RODATA
>> +       bool "Make kernel text and rodata read-only"
>> +       help
>> +         If this is set, kernel text and rodata will be made read-only. This
>> +         is to help catch accidental or malicious attempts to change the
>> +         kernel's executable code. Additionally splits rodata from kernel
>> +         text so it can be made explicitly non-executable.
>> +
>> +          If in doubt, say Y
> 
> I wonder if this option should explicitly select NX_KERNEL_AREAS? It
> seems crazy to me that someone would only want one of these. And this
> config is the cross-arch name for "make kernel page tables protected",
> so it might be nice to turn everything on via this one switch?
> 

I think I will just merge the two Kconfigs. It just seems a little odd to have
CONFIG_DEBUG_RODATA also setting nx permissions. Perhaps this needs
some clarification elsewhere. (CONFIG_DEBUG_RODATA ->
CONFIG_STRICT_KERNEL_PERMS ?)

>> +
>> +config DEBUG_ALIGN_RODATA
>> +       depends on DEBUG_RODATA
>> +       bool "Align linker sections up to SECTION_SIZE"
>> +       help
>> +         If this option is enabled, sections that may potentially be marked as
>> +         read only or non-executable will be aligned up to the section size of
>> +         the kernel. This prevents sections from being split into pages and
>> +         avoids a potential TLB penalty. The downside is an increase in
>> +         alignment and potentially wasted space. Turn on this option if
>> +         performance is more important than memory pressure.
>> +
>> +         If in doubt, say N
> 
> Making this configurable is pretty neat. What's the overhead on memory
> pressure for arm64? Is the correct default "N"?
> 

Last time I measured this, it was a loss of about 5.5MB when we align up
to section size. Depending on the memory footprint, this can either be
negligible or pretty drastic. From other experimental patches, breaking
down sections can result in ~10% performance drop on some benchmarks.

Given what are the expected use case for arm64, I suspect this should actually
be Y. My plan was to get the infrastructure in and then let everyone conclude
what would be a reasonable default.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
