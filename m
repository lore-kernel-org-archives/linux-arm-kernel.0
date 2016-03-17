From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 17 Mar 2016 17:24:12 +0800
Subject: Suspicious error for CMA stress test
In-Reply-To: <20160317065426.GA10315@js1304-P5Q-DELUXE>
References: <56DD38E7.3050107@huawei.com> <56DDCB86.4030709@redhat.com>
 <56DE30CB.7020207@huawei.com> <56DF7B28.9060108@huawei.com>
 <CAAmzW4NDJwgq_P33Ru_X0MKXGQEnY5dr_SY1GFutPAqEUAc_rg@mail.gmail.com>
 <56E2FB5C.1040602@suse.cz> <20160314064925.GA27587@js1304-P5Q-DELUXE>
 <56E662E8.700@suse.cz> <20160314071803.GA28094@js1304-P5Q-DELUXE>
 <56E92AFC.9050208@huawei.com> <20160317065426.GA10315@js1304-P5Q-DELUXE>
Message-ID: <56EA77BC.2090702@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/3/17 14:54, Joonsoo Kim wrote:
> On Wed, Mar 16, 2016 at 05:44:28PM +0800, Hanjun Guo wrote:
>> On 2016/3/14 15:18, Joonsoo Kim wrote:
>>> On Mon, Mar 14, 2016 at 08:06:16AM +0100, Vlastimil Babka wrote:
>>>> On 03/14/2016 07:49 AM, Joonsoo Kim wrote:
>>>>> On Fri, Mar 11, 2016 at 06:07:40PM +0100, Vlastimil Babka wrote:
>>>>>> On 03/11/2016 04:00 PM, Joonsoo Kim wrote:
>>>>>>
>>>>>> How about something like this? Just and idea, probably buggy (off-by-one etc.).
>>>>>> Should keep away cost from <pageblock_order iterations@the expense of the
>>>>>> relatively fewer >pageblock_order iterations.
>>>>> Hmm... I tested this and found that it's code size is a little bit
>>>>> larger than mine. I'm not sure why this happens exactly but I guess it would be
>>>>> related to compiler optimization. In this case, I'm in favor of my
>>>>> implementation because it looks like well abstraction. It adds one
>>>>> unlikely branch to the merge loop but compiler would optimize it to
>>>>> check it once.
>>>> I would be surprised if compiler optimized that to check it once, as
>>>> order increases with each loop iteration. But maybe it's smart
>>>> enough to do something like I did by hand? Guess I'll check the
>>>> disassembly.
>>> Okay. I used following slightly optimized version and I need to
>>> add 'max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1)'
>>> to yours. Please consider it, too.
>> Hmm, this one is not work, I still can see the bug is there after applying
>> this patch, did I miss something?
> I may find that there is a bug which was introduced by me some time
> ago. Could you test following change in __free_one_page() on top of
> Vlastimil's patch?
>
> -page_idx = pfn & ((1 << max_order) - 1);
> +page_idx = pfn & ((1 << MAX_ORDER) - 1);

I tested Vlastimil's patch + your change with stress for more than half hour, the bug
I reported is gone :)

I have some questions, Joonsoo, you provided a patch as following:

diff --git a/mm/cma.c b/mm/cma.c
index 3a7a67b..952a8a3 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -448,7 +448,10 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 
        VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
 
+ mutex_lock(&cma_mutex);
        free_contig_range(pfn, count);
+ mutex_unlock(&cma_mutex);
+
        cma_clear_bitmap(cma, pfn, count);
        trace_cma_release(pfn, pages, count);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7f32950..68ed5ae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1559,7 +1559,8 @@ void free_hot_cold_page(struct page *page, bool cold)
         * excessively into the page allocator
         */
        if (migratetype >= MIGRATE_PCPTYPES) {
-           if (unlikely(is_migrate_isolate(migratetype))) {
+         if (is_migrate_cma(migratetype) ||
+             unlikely(is_migrate_isolate(migratetype))) {
                        free_one_page(zone, page, pfn, 0, migratetype);
                        goto out;
                }

This patch also works to fix the bug, why not just use this one? is there
any side effects for this patch? maybe there is performance issue as the
mutex lock is used, any other issues?

Thanks
Hanjun
