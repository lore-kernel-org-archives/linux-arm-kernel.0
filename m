From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 18 Mar 2016 10:03:50 +0800
Subject: Suspicious error for CMA stress test
In-Reply-To: <CAAmzW4PVc+v9NVyqrHZqh6qWaJD8hrwNUVSb6G=vZ3eA76J3yQ@mail.gmail.com>
References: <56DD38E7.3050107@huawei.com> <56DDCB86.4030709@redhat.com>
 <56DE30CB.7020207@huawei.com> <56DF7B28.9060108@huawei.com>
 <CAAmzW4NDJwgq_P33Ru_X0MKXGQEnY5dr_SY1GFutPAqEUAc_rg@mail.gmail.com>
 <56E2FB5C.1040602@suse.cz> <20160314064925.GA27587@js1304-P5Q-DELUXE>
 <56E662E8.700@suse.cz> <20160314071803.GA28094@js1304-P5Q-DELUXE>
 <56E92AFC.9050208@huawei.com> <20160317065426.GA10315@js1304-P5Q-DELUXE>
 <56EA77BC.2090702@huawei.com>
 <CAAmzW4PVc+v9NVyqrHZqh6qWaJD8hrwNUVSb6G=vZ3eA76J3yQ@mail.gmail.com>
Message-ID: <56EB6206.4070802@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/3/17 23:31, Joonsoo Kim wrote:
[...]
>>> I may find that there is a bug which was introduced by me some time
>>> ago. Could you test following change in __free_one_page() on top of
>>> Vlastimil's patch?
>>>
>>> -page_idx = pfn & ((1 << max_order) - 1);
>>> +page_idx = pfn & ((1 << MAX_ORDER) - 1);
>> I tested Vlastimil's patch + your change with stress for more than half hour, the bug
>> I reported is gone :)
> Good to hear!
>
>> I have some questions, Joonsoo, you provided a patch as following:
>>
>> diff --git a/mm/cma.c b/mm/cma.c
>> index 3a7a67b..952a8a3 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -448,7 +448,10 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>>
>>         VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
>>
>> + mutex_lock(&cma_mutex);
>>         free_contig_range(pfn, count);
>> + mutex_unlock(&cma_mutex);
>> +
>>         cma_clear_bitmap(cma, pfn, count);
>>         trace_cma_release(pfn, pages, count);
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 7f32950..68ed5ae 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1559,7 +1559,8 @@ void free_hot_cold_page(struct page *page, bool cold)
>>          * excessively into the page allocator
>>          */
>>         if (migratetype >= MIGRATE_PCPTYPES) {
>> -           if (unlikely(is_migrate_isolate(migratetype))) {
>> +         if (is_migrate_cma(migratetype) ||
>> +             unlikely(is_migrate_isolate(migratetype))) {
>>                         free_one_page(zone, page, pfn, 0, migratetype);
>>                         goto out;
>>                 }
>>
>> This patch also works to fix the bug, why not just use this one? is there
>> any side effects for this patch? maybe there is performance issue as the
>> mutex lock is used, any other issues?
> The changes in free_hot_cold_page() would cause unacceptable performance
> problem in a big machine, because, with above change,  it takes zone->lock
> whenever freeing one page on CMA region.

Thanks for the clarify :)

Hanjun
