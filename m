From: qiuxishi@huawei.com (Xishi Qiu)
Date: Fri, 29 Jan 2016 09:21:40 +0800
Subject: [PATCH] arm64: Allow vmalloc regions to be set with set_memory_*
In-Reply-To: <20160128142746.GL17123@leverpostej>
References: <1452635187-8057-1-git-send-email-labbott@fedoraproject.org>
 <CAKv+Gu_A1C9hXgqrYDekoy1YHaRXi_mUF-kYx-TqsOBkWMVjmQ@mail.gmail.com>
 <CAKv+Gu-73QKAsFQCa=yO5+=DihLXp_AKYyY6QRTVM4nuDH=-8g@mail.gmail.com>
 <20160118115640.GK21067@leverpostej> <56A97328.9070003@huawei.com>
 <20160128105138.GE17123@leverpostej> <56A9FFBD.8030303@huawei.com>
 <20160128142746.GL17123@leverpostej>
Message-ID: <56AABEA4.3010301@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/28 22:27, Mark Rutland wrote:

> On Thu, Jan 28, 2016 at 07:47:09PM +0800, Xishi Qiu wrote:
>> On 2016/1/28 18:51, Mark Rutland wrote:
>>
>>> On Thu, Jan 28, 2016 at 09:47:20AM +0800, Xishi Qiu wrote:
>>>> On 2016/1/18 19:56, Mark Rutland wrote:
>>>>> On Wed, Jan 13, 2016 at 05:10:31PM +0100, Ard Biesheuvel wrote:
>>>>>> Something along these lines, perhaps?
>>>>>>
>>>>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>>>>> index 3571c7309c5e..bda0a776c58e 100644
>>>>>> --- a/arch/arm64/mm/pageattr.c
>>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>>> @@ -13,6 +13,7 @@
>>>>>>  #include <linux/kernel.h>
>>>>>>  #include <linux/mm.h>
>>>>>>  #include <linux/module.h>
>>>>>> +#include <linux/vmalloc.h>
>>>>>>  #include <linux/sched.h>
>>>>>>
>>>>>>  #include <asm/pgtable.h>
>>>>>> @@ -44,6 +45,7 @@ static int change_memory_common(unsigned long addr
>>>>>>         unsigned long end = start + size;
>>>>>>         int ret;
>>>>>>         struct page_change_data data;
>>>>>> +       struct vm_struct *area;
>>>>>>
>>>>>>         if (!PAGE_ALIGNED(addr)) {
>>>>>>                 start &= PAGE_MASK;
>>>>>> @@ -51,10 +53,14 @@ static int change_memory_common(unsigned long addr,
>>>>>>                 WARN_ON_ONCE(1);
>>>>>>         }
>>>>>>
>>>>>> -       if (start < MODULES_VADDR || start >= MODULES_END)
>>>>>> -               return -EINVAL;
>>>>>> -
>>>>>> -       if (end < MODULES_VADDR || end >= MODULES_END)
>>>>>> +       /*
>>>>>> +        * Check whether the [addr, addr + size) interval is entirely
>>>>>> +        * covered by precisely one VM area that has the VM_ALLOC flag set
>>>>>> +        */
>>>>>> +       area = find_vm_area((void *)addr);
>>>>>> +       if (!area ||
>>>>>> +           end > (unsigned long)area->addr + area->size ||
>>>>>> +           !(area->flags & VM_ALLOC))
>>>>>>                 return -EINVAL;
>>>>>>
>>>>>>         data.set_mask = set_mask;
>>>>>
>>>>> Neat. That fixes the fencepost bug too.
>>>>>
>>>>> Looks good to me, though as Laura suggested we should have a comment as
>>>>> to why we limit changes to such regions. Fancy taking her wording below
>>>>> and spinning this as a patch?
>>>>>
>>>>>>>> +       /*
>>>>>>>> +        * This check explicitly excludes most kernel memory. Most kernel
>>>>>>>> +        * memory is mapped with a larger page size and breaking down the
>>>>>>>> +        * larger page size without causing TLB conflicts is very difficult.
>>>>>>>> +        *
>>>>>>>> +        * If you need to call set_memory_* on a range, the recommendation is
>>>>>>>> +        * to use vmalloc since that range is mapped with pages.
>>>>>>>> +        */
>>>>>
>>>>> Thanks,
>>>>> Mark.
>>>>>
>>>>
>>>> Hi Mark,
>>>>
>>>> After change the flag, it calls only flush_tlb_kernel_range(), so why not use 
>>>> cpu_replace_ttbr1(swapper_pg_dir)? 
>>>
>>> We cannot use cpu_replace_ttbr1 here. Other CPUs may be online, and we
>>> have no mechanism to place them in a safe set of page tables while
>>> swapping TTBR1, we'd have to perform a deep copy of tables, and this
>>> would be horrendously expensive.
>>>
>>> Using flush_tlb_kernel_range() is sufficient. As modules don't share a
>>> page or section mapping with other users, we can follow a
>>> Break-Before-Make approach. Additionally, they're mapped at page
>>> granularity so we never split or fuse sections anyway. We only modify
>>> the permission bits.
>>>
>>
>> Hi Mark,
>>
>> Is it safe in the following path?
>>
>> alloc the whole linear map section
> 
> I don't understand what you mean by this, you will need to elaborate.
> The terms "alloc" and "section" can mean a number of different things in
> this context.
> 
>> cpu A write something on it
>> cpu B write something on it
>> cpu C set read only flag and call flush_tlb_kernel_range()
> 
> If you want to modify a portion of the linear map, this will not work.
> Modfiying the linear map in this manner is not safe.
> 
> If you want an alias of the linear map which was mapped using pages, and
> you wanted to change that alias, that could work.
> 

Hi Mark,

I mean I change the whole section(maybe 1G?) in linear map.

In our software, kernel create mapping(linear map) on special memory, and
it is separated from buddy system, the service manage the special memory itself.
And the service alloc/free the memory based on the physical address, so if 
the service want to change the prot dynamically, vmalloc doesn't work, and
fixmap is a little complex.

I think if I create the spacial memory in 4kb, then the service could
use set_memory_ro() directly, right?

Thanks,
Xishi Qiu

> It depends on what precisely you are trying to do.
> 
> Thanks,
> Mark.
> 
> .
> 
