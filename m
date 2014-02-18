From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 18 Feb 2014 18:44:08 +0100
Subject: [BUG] Circular locking dependency - DRM/CMA/MM/hotplug/...
In-Reply-To: <53036D51.2070502@samsung.com>
References: <20140211183543.GK26684@n2100.arm.linux.org.uk>
 <52FB9602.1000805@samsung.com>
 <20140212163317.GQ26684@n2100.arm.linux.org.uk>
 <53036D51.2070502@samsung.com>
Message-ID: <xa1t8ut8wc2f.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 2014-02-12 17:33, Russell King - ARM Linux wrote:
>> What if we did these changes:
>>
>> struct page *dma_alloc_from_contiguous(struct device *dev, int count,
>>                                         unsigned int align)
>> {
>> ...
>>          mutex_lock(&cma_mutex);
>> ...
>>          for (;;) {
>>                  pageno = bitmap_find_next_zero_area(cma->bitmap, cma->count,
>>                                                      start, count, mask);
>>                  if (pageno >= cma->count)
>>                          break;
>>
>>                  pfn = cma->base_pfn + pageno;
>> +               bitmap_set(cma->bitmap, pageno, count);
>> +               mutex_unlock(&cma_mutex);
>>                  ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA);
>> +               mutex_lock(&cma_mutex);
>>                  if (ret == 0) {
>> -                       bitmap_set(cma->bitmap, pageno, count);
>>                          page = pfn_to_page(pfn);
>>                          break;
>> -               } else if (ret != -EBUSY) {
>> +		}
>> +		bitmap_clear(cma->bitmap, pageno, count);
>> +		if (ret != -EBUSY) {
>>                          break;
>>                  }
>> ...
>>          mutex_unlock(&cma_mutex);
>>          pr_debug("%s(): returned %p\n", __func__, page);
>>          return page;
>> }

Like Marek said, this will fail if two concurrent calls to
alloc_contig_range are made such that they operate on the same pageblock
(which is possible as the allocated regions do not need to be pageblock
aligned).

Another mutex could be added just for this one call, but as I understand
this would not solve the problem.

>> bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>>                                   int count)
>> {
>> ...
>> +       free_contig_range(pfn, count);
>>          mutex_lock(&cma_mutex);
>>          bitmap_clear(cma->bitmap, pfn - cma->base_pfn, count);
>> -       free_contig_range(pfn, count);
>>          mutex_unlock(&cma_mutex);
>> ...
>> }

This *should* be fine.  Didn't test it.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/d68d0a91/attachment-0001.sig>
