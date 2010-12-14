From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 14 Dec 2010 11:23:15 +0100
Subject: [PATCHv7 08/10] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <20101214102401.37bf812d.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Tue, 14 Dec 2010 10:24:01 +0900")
References: <cover.1292004520.git.m.nazarewicz@samsung.com>
	<fc8aa07ac71d554ba10af4943fdb05197c681fa2.1292004520.git.m.nazarewicz@samsung.com>
	<20101214102401.37bf812d.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <87zks8fyb0.fsf@erwin.mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, 13 Dec 2010 12:26:49 +0100
> Michal Nazarewicz <m.nazarewicz@samsung.com> wrote:
>> +/************************* Initialise CMA *************************/
>> +
>> +static struct cma_grabbed {
>> +	unsigned long start;
>> +	unsigned long size;
>> +} cma_grabbed[8] __initdata;
>> +static unsigned cma_grabbed_count __initdata;
>> +
>> +int cma_init(unsigned long start, unsigned long size)
>> +{
>> +	pr_debug("%s(%p+%p)\n", __func__, (void *)start, (void *)size);
>> +
>> +	if (!size)
>> +		return -EINVAL;
>> +	if ((start | size) & ((MAX_ORDER_NR_PAGES << PAGE_SHIFT) - 1))
>> +		return -EINVAL;
>> +	if (start + size < start)
>> +		return -EOVERFLOW;
>> +
>> +	if (cma_grabbed_count == ARRAY_SIZE(cma_grabbed))
>> +		return -ENOSPC;
>> +
>> +	cma_grabbed[cma_grabbed_count].start = start;
>> +	cma_grabbed[cma_grabbed_count].size  = size;
>> +	++cma_grabbed_count;
>> +	return 0;
>> +}
>> +

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> Is it guaranteed that there are no memory holes, or zone overlap
> in the range ? I think correctness of the range must be checked.

I keep thinking about it myself.  The idea is that you get memory range
reserved using memblock (or some such) thus it should not contain any
memory holes.  I'm not entirely sure about spanning different zones.
I'll add the checking code.

>> +#define MIGRATION_RETRY	5
>> +static int __cm_migrate(unsigned long start, unsigned long end)
>> +{
[...]
>> +}
>> +
>> +static int __cm_alloc(unsigned long start, unsigned long size)
>> +{
>> +	unsigned long end, _start, _end;
>> +	int ret;
>> +
[...]
>> +
>> +	start = phys_to_pfn(start);
>> +	end   = start + (size >> PAGE_SHIFT);
>> +
>> +	pr_debug("\tisolate range(%lx, %lx)\n",
>> +		 pfn_to_maxpage(start), pfn_to_maxpage_up(end));
>> +	ret = __start_isolate_page_range(pfn_to_maxpage(start),
>> +					 pfn_to_maxpage_up(end), MIGRATE_CMA);
>> +	if (ret)
>> +		goto done;
>> +
>> +	pr_debug("\tmigrate range(%lx, %lx)\n", start, end);
>> +	ret = __cm_migrate(start, end);
>> +	if (ret)
>> +		goto done;
>> +
[...]
>> +
>> +	pr_debug("\tfinding buddy\n");
>> +	ret = 0;
>> +	while (!PageBuddy(pfn_to_page(start & (~0UL << ret))))
>> +		if (WARN_ON(++ret >= MAX_ORDER))
>> +			return -EINVAL;
>> +
>> +	_start = start & (~0UL << ret);
>> +	pr_debug("\talloc freed(%lx, %lx)\n", _start, end);
>> +	_end   = alloc_contig_freed_pages(_start, end, 0);
>> +
>> +	/* Free head and tail (if any) */
>> +	pr_debug("\tfree contig(%lx, %lx)\n", _start, start);
>> +	free_contig_pages(pfn_to_page(_start), start - _start);
>> +	pr_debug("\tfree contig(%lx, %lx)\n", end, _end);
>> +	free_contig_pages(pfn_to_page(end), _end - end);
>> +
>> +	ret = 0;
>> +
>> +done:
>> +	pr_debug("\tundo isolate range(%lx, %lx)\n",
>> +		 pfn_to_maxpage(start), pfn_to_maxpage_up(end));
>> +	__undo_isolate_page_range(pfn_to_maxpage(start),
>> +				  pfn_to_maxpage_up(end), MIGRATE_CMA);
>> +
>> +	pr_debug("ret = %d\n", ret);
>> +	return ret;
>> +}
>> +
>> +static void __cm_free(unsigned long start, unsigned long size)
>> +{
>> +	pr_debug("%s(%p+%p)\n", __func__, (void *)start, (void *)size);
>> +
>> +	free_contig_pages(pfn_to_page(phys_to_pfn(start)),
>> +			  size >> PAGE_SHIFT);
>> +}

> Hmm, it seems __cm_alloc() and __cm_migrate() has no special codes for CMA.
> I'd like reuse this for my own contig page allocator.
> So, could you make these function be more generic (name) ?
> as
> 	__alloc_range(start, size, mirate_type);
>
> Then, what I have to do is only to add "search range" functions.

Sure thing.  I'll post it tomorrow or Friday. How about
alloc_contig_range() maybe?

-- 
Pozdrawiam                                            _     _
 .o. | Wasal Jasnie Oswieconej Pani Informatyki     o' \,=./ `o
 ..o | Michal "mina86" Nazarewicz  <mina86*tlen.pl>    (o o)
 ooo +---<jid:mina86-jabber.org>---<tlen:mina86>---ooO--(_)--Ooo--
