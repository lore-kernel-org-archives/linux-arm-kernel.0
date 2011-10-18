From: mel@csn.ul.ie (Mel Gorman)
Date: Tue, 18 Oct 2011 14:05:06 +0200
Subject: [PATCH 1/9] mm: move some functions from memory_hotplug.c to
	page_isolation.c
In-Reply-To: <1317909290-29832-2-git-send-email-m.szyprowski@samsung.com>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20111018120506.GA6660@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 03:54:41PM +0200, Marek Szyprowski wrote:
> From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Memory hotplug is a logic for making pages unused in the specified
> range of pfn. So, some of core logics can be used for other purpose
> as allocating a very large contigous memory block.
> 
> This patch moves some functions from mm/memory_hotplug.c to
> mm/page_isolation.c. This helps adding a function for large-alloc in
> page_isolation.c with memory-unplug technique.
> 
> Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> [m.nazarewicz: reworded commit message]
> Signed-off-by: Michal Nazarewicz <m.nazarewicz@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> [m.szyprowski: rebased and updated to Linux v3.0-rc1]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/page-isolation.h |    7 +++
>  mm/memory_hotplug.c            |  111 --------------------------------------
>  mm/page_isolation.c            |  114 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 111 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 051c1b1..58cdbac 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -33,5 +33,12 @@ test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn);
>  extern int set_migratetype_isolate(struct page *page);
>  extern void unset_migratetype_isolate(struct page *page);
>  
> +/*
> + * For migration.
> + */
> +
> +int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn);

bool

> +unsigned long scan_lru_pages(unsigned long start, unsigned long end);

Both function names are misleading.

> +int do_migrate_range(unsigned long start_pfn, unsigned long end_pfn);
>  

scan_lru_pages as it is used by memory hotplug is also extremely
expensive. Unplugging memory is rare so the performance is not a concern
but it make be for CMA.

I think it would have made more sense to either express this as an iterator
like for_each_lru_page_in_range() and use cursors or reuse the compaction
code. As it is, these functions are a bit rough. I'm biased but this code
seems to have very similar responsibilities to the compaction.c code for
isolate_migratepages and how it handles migration. It also knows how to avoid
isolating so much memory as to put the system in the risk of being livelocked,
isolate pages from the LRU in batch etc.

This is not a show-stopper as such but personally I would prefer that
the memory hotplug code be sharing code with compaction than CMA adding
a new dependency on memory hotplug.

-- 
Mel Gorman
SUSE Labs
