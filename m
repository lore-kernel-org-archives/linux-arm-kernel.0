From: labbott@redhat.com (Laura Abbott)
Date: Thu, 5 Nov 2015 17:35:07 -0800
Subject: [PATCH 2/2] arm64: Allow changing of attributes outside of modules
In-Reply-To: <CAKv+Gu-v2uQK6GbyVn2i2HMf-5S-k5_w1CodQtCr9gOuLcW01A@mail.gmail.com>
References: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
 <1446587315-18145-3-git-send-email-labbott@fedoraproject.org>
 <CAKv+Gu-v2uQK6GbyVn2i2HMf-5S-k5_w1CodQtCr9gOuLcW01A@mail.gmail.com>
Message-ID: <563C03CB.9070703@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2015 11:44 PM, Ard Biesheuvel wrote:
> On 3 November 2015 at 22:48, Laura Abbott <labbott@fedoraproject.org> wrote:
>>
>> Currently, the set_memory_* functions that are implemented for arm64
>> are restricted to module addresses only. This was mostly done
>> because arm64 maps normal zone memory with larger page sizes to
>> improve TLB performance. This has the side effect though of making it
>> difficult to adjust attributes at the PAGE_SIZE granularity. There are
>> an increasing number of use cases related to security where it is
>> necessary to change the attributes of kernel memory. Add functionality
>> to the page attribute changing code under a Kconfig to let systems
>> designers decide if they want to make the trade off of security for TLB
>> pressure.
>>
>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>> ---
>>   arch/arm64/Kconfig.debug | 11 +++++++
>>   arch/arm64/mm/mm.h       |  3 ++
>>   arch/arm64/mm/mmu.c      |  2 +-
>>   arch/arm64/mm/pageattr.c | 74 ++++++++++++++++++++++++++++++++++++++++++++----
>>   4 files changed, 84 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
>> index d6285ef..abc6922 100644
>> --- a/arch/arm64/Kconfig.debug
>> +++ b/arch/arm64/Kconfig.debug
>> @@ -89,6 +89,17 @@ config DEBUG_ALIGN_RODATA
>>
>>            If in doubt, say N
>>
>> +config DEBUG_CHANGE_PAGEATTR
>
> I don't think this belongs in Kconfig.debug, and I don't think this
> should default to off.
>
> We know we currently have no users of set_memory_xx() in arch/arm64
> that operate on linear mapping addresses, so we will not introduce any
> performance regressions by adding this functionality now. By putting
> this feature behind a debug option, every newly introduced call
> set_memory_xx() that operates on linear or vmalloc() addresses needs
> to deal with -EINVAL (or depend on DEBUG_CHANGE_PAGEATTR), or it may
> error out at runtime if the feature is not enabled.
>

I stuck it in Kconfig.debug to have it match with the rest of the
module and DEBUG_RODATA options. I'll pull it out.
  
>> +       bool "Allow all kernel memory to have attributes changed"
>> +       help
>> +         If this option is selected, APIs that change page attributes
>> +         (RW <-> RO, X <-> NX) will be valid for all memory mapped in
>> +         the kernel space. The trade off is that there may be increased
>> +         TLB pressure from finer grained page mapping. Turn on this option
>> +         if performance is more important than security
>> +
>
> This is backwards
>
>> +         If in doubt, say N
>> +
>>   source "drivers/hwtracing/coresight/Kconfig"
>>
>>   endmenu
>
> [...]
>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index e47ed1c..48a4ce9 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>
> [...]
>
>> @@ -45,17 +108,18 @@ static int change_memory_common(unsigned long addr, int numpages,
>>          int ret;
>>          struct page_change_data data;
>>
>> +       if (addr < PAGE_OFFSET && !is_vmalloc_addr((void *)addr))
>> +               return -EINVAL;
>> +
>
> Doesn't this exclude the module area?
>
>>          if (!IS_ALIGNED(addr, PAGE_SIZE)) {
>>                  start &= PAGE_MASK;
>>                  end = start + size;
>>                  WARN_ON_ONCE(1);
>>          }
>>
>> -       if (start < MODULES_VADDR || start >= MODULES_END)
>> -               return -EINVAL;
>> -
>> -       if (end < MODULES_VADDR || end >= MODULES_END)
>> -               return -EINVAL;
>> +       ret = check_address(addr);
>> +       if (ret)
>> +               return ret;
>>
>>          data.set_mask = set_mask;
>>          data.clear_mask = clear_mask;
>> --
>> 2.4.3
>>
