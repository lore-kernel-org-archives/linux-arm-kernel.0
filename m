From: laura@labbott.name (Laura Abbott)
Date: Mon, 2 Nov 2015 09:40:47 -0800
Subject: arm64: about Add CONFIG_DEBUG_SET_MODULE_RONX suport
In-Reply-To: <56343BF2.1070800@huawei.com>
References: <5633279A.7000003@huawei.com> <56332ADB.7030306@iogearbox.net>
 <563335FF.5020400@huawei.com> <5633864F.6030203@codeaurora.org>
 <5633872C.1000005@labbott.name> <56343BF2.1070800@huawei.com>
Message-ID: <5637A01F.4090806@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding Kees to see if he has any inputs)

On 10/30/15 8:56 PM, Xishi Qiu wrote:
> On 2015/10/30 23:05, Laura Abbott wrote:
>
>>>>
>>>> Hi Daniel,
>>>>
>>>> Sorry for didn't saying it clearly. I find this
>>>> interface(set_memory_ro/rw) can
>>>> only be used in module address. So why not extend the function? e.g.
>>>> like x86,
>>>> it can be used in direct mapping address too.
>>>>
>>>> Is there some limits in arm64 or we will do this later?
>>>>
>>>
>>> arm64 maps low mem (all direct mapped memory on arm64) with section
>>> mappings for performance. set_memory_ro/rw works on PAGE_SIZE
>>> granularity so if we wanted to use those functions on direct mapped
>>> memory we would need to break down the section mappings. On arm,
>>> this was a pain due to the TLB maintaince requried. On arm64, less
>>> so but we still lose the benefit of the section mappings.
>>>
>>> Do you have a use case in mind for wanting to use set_memory_ro/rw
>>> outside of the module area?
>>>
>
> Hi Laura,
>
> How about this case?
>
> module alloc some pages which from direct mapping area, and we write
> important data(e.g. password) on the pages, the data will not be changed
> during the runtime. If someone unfriendly try to rewrite the memory,
> something is going to get worse. So we can use set_memory_ro() to protect
> the date.
>

How long would you expected this data to stay around (minutes? hours?)
and how many instances of this would you expect?

It also looks like BPF wants to set its region as ro when in use
(https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/filter.h#n370) 
So it's not completely unheard of.
I don't think it would be too difficult to take the
split_{pud,pmd} functions used for the direct mapping and apply them
for the page_attr if people are willing to make the security/performance
trade off.

Thanks,
Laura
