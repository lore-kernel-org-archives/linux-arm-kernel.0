From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Fri, 8 Jul 2016 11:36:57 +0800
Subject: [PATCH 1/1] arm64/hugetlb: clear PG_dcache_clean if the page is
 dirty when munmap
In-Reply-To: <20160707153741.GC27180@e104818-lin.cambridge.arm.com>
References: <1467893344-8352-1-git-send-email-thunder.leizhen@huawei.com>
 <20160707153741.GC27180@e104818-lin.cambridge.arm.com>
Message-ID: <577F1FD9.1040205@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/7/7 23:37, Catalin Marinas wrote:
> On Thu, Jul 07, 2016 at 08:09:04PM +0800, Zhen Lei wrote:
>> At present, PG_dcache_clean is only cleared when the related huge page
>> is about to be freed. But sometimes, there maybe a process is in charge
>> to copy binary codes into a shared memory, and notifies other processes
>> to execute base on that. For the first time, there is no problem, because
>> the default value of page->flags is PG_dcache_clean cleared. So the cache
>> will be maintained at the time of set_pte_at for other processes. But if
>> the content of the shared memory have been updated again, there is no
>> cache operations, because the PG_dcache_clean is still set.
>>
>> For example:
>> Process A
>> 	open a hugetlbfs file
>> 	mmap it as a shared memory
>> 	copy some binary codes into it
>> 	munmap
>>
>> Process B
>> 	open the hugetlbfs file
>> 	mmap it as a shared memory, executable
>> 	invoke the functions in the shared memory
>> 	munmap
>>
>> repeat the above steps.
> 
> Does this work as you would expect with small pages (and for example
> shared file mmap)? I don't want to have a different behaviour between
> small and huge pages.

The small pages also have this problem, I will try to fix it too.

> 
