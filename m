From: labbott@redhat.com (Laura Abbott)
Date: Thu, 3 Mar 2016 10:52:17 -0800
Subject: Suspicious error for CMA stress test
In-Reply-To: <56D832BD.5080305@huawei.com>
References: <56D6F008.1050600@huawei.com> <56D79284.3030009@redhat.com>
 <CAAmzW4PUwoVF+F-BpOZUHhH6YHp_Z8VkiUjdBq85vK6AWVkyPg@mail.gmail.com>
 <56D832BD.5080305@huawei.com>
Message-ID: <56D887E1.8000602@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 04:49 AM, Hanjun Guo wrote:
> On 2016/3/3 15:42, Joonsoo Kim wrote:
>> 2016-03-03 10:25 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>>> (cc -mm and Joonsoo Kim)
>>>
>>>
>>> On 03/02/2016 05:52 AM, Hanjun Guo wrote:
>>>> Hi,
>>>>
>>>> I came across a suspicious error for CMA stress test:
>>>>
>>>> Before the test, I got:
>>>> -bash-4.3# cat /proc/meminfo | grep Cma
>>>> CmaTotal:         204800 kB
>>>> CmaFree:          195044 kB
>>>>
>>>>
>>>> After running the test:
>>>> -bash-4.3# cat /proc/meminfo | grep Cma
>>>> CmaTotal:         204800 kB
>>>> CmaFree:         6602584 kB
>>>>
>>>> So the freed CMA memory is more than total..
>>>>
>>>> Also the the MemFree is more than mem total:
>>>>
>>>> -bash-4.3# cat /proc/meminfo
>>>> MemTotal:       16342016 kB
>>>> MemFree:        22367268 kB
>>>> MemAvailable:   22370528 kB
> [...]
>>>
>>> I played with this a bit and can see the same problem. The sanity
>>> check of CmaFree < CmaTotal generally triggers in
>>> __move_zone_freepage_state in unset_migratetype_isolate.
>>> This also seems to be present as far back as v4.0 which was the
>>> first version to have the updated accounting from Joonsoo.
>>> Were there known limitations with the new freepage accounting,
>>> Joonsoo?
>> I don't know. I also played with this and looks like there is
>> accounting problem, however, for my case, number of free page is slightly less
>> than total. I will take a look.
>>
>> Hanjun, could you tell me your malloc_size? I tested with 1 and it doesn't
>> look like your case.
>
> I tested with malloc_size with 2M, and it grows much bigger than 1M, also I
> did some other test:
>
>   - run with single thread with 100000 times, everything is fine.
>
>   - I hack the cam_alloc() and free as below [1] to see if it's lock issue, with
>     the same test with 100 multi-thread, then I got:
>
> -bash-4.3# cat /proc/meminfo | grep Cma
> CmaTotal: 204800 kB
> CmaFree: 225112 kB
>
> It only increased about 30M for free, not 6G+ in previous test, although
> the problem is not solved, the problem is less serious, is it a synchronization
> problem?
>

'only' 30M is still an issue although I think you are right about something related
to synchronization. When I put the cma_mutex around free_contig_range I don't see
the issue. I wonder if free of the pages is racing with the undo_isolate_page_range
on overlapping ranges caused by outer_start?

Thanks,
Laura


> Thanks
> Hanjun
>
> [1]:
> index ea506eb..4447494 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -379,6 +379,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align)
>          if (!count)
>                  return NULL;
>
> + mutex_lock(&cma_mutex);
>          mask = cma_bitmap_aligned_mask(cma, align);
>          offset = cma_bitmap_aligned_offset(cma, align);
>          bitmap_maxno = cma_bitmap_maxno(cma);
> @@ -402,17 +403,16 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align)
>                  mutex_unlock(&cma->lock);
>
>                  pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
> -           mutex_lock(&cma_mutex);
>                  ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA);
> -           mutex_unlock(&cma_mutex);
>                  if (ret == 0) {
>                          page = pfn_to_page(pfn);
>                          break;
>                  }
>
>                  cma_clear_bitmap(cma, pfn, count);
> -           if (ret != -EBUSY)
> +         if (ret != -EBUSY) {
>                          break;
> +         }
>
>                  pr_debug("%s(): memory range at %p is busy, retrying\n",
>                           __func__, pfn_to_page(pfn));
> @@ -420,6 +420,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align)
>                  start = bitmap_no + mask + 1;
>          }
>
> + mutex_unlock(&cma_mutex);
>          trace_cma_alloc(pfn, page, count, align);
>
>          pr_debug("%s(): returned %p\n", __func__, page);
> @@ -445,15 +446,19 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>
>          pr_debug("%s(page %p)\n", __func__, (void *)pages);
>
> + mutex_lock(&cma_mutex);
>          pfn = page_to_pfn(pages);
>
> -   if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> + if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count) {
> +         mutex_unlock(&cma_mutex);
>                  return false;
> + }
>
>          VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
>
>          free_contig_range(pfn, count);
>          cma_clear_bitmap(cma, pfn, count);
> + mutex_unlock(&cma_mutex);
>          trace_cma_release(pfn, pages, count);
>
>          return true;
>
