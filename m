From: gerald.schaefer@de.ibm.com (Gerald Schaefer)
Date: Wed, 9 Nov 2016 16:55:49 +0100
Subject: [PATCH v2 2/2] mm: hugetlb: support gigantic surplus pages
In-Reply-To: <1478675294-2507-1-git-send-email-shijie.huang@arm.com>
References: <1478141499-13825-3-git-send-email-shijie.huang@arm.com>
 <1478675294-2507-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20161109165549.1cf320c5@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Nov 2016 15:08:14 +0800
Huang Shijie <shijie.huang@arm.com> wrote:

> When testing the gigantic page whose order is too large for the buddy
> allocator, the libhugetlbfs test case "counter.sh" will fail.
> 
> The failure is caused by:
>  1) kernel fails to allocate a gigantic page for the surplus case.
>     And the gather_surplus_pages() will return NULL in the end.
> 
>  2) The condition checks for "over-commit" is wrong.
> 
> This patch adds code to allocate the gigantic page in the
> __alloc_huge_page(). After this patch, gather_surplus_pages()
> can return a gigantic page for the surplus case.
> 
> This patch changes the condition checks for:
>      return_unused_surplus_pages()
>      nr_overcommit_hugepages_store()
>      hugetlb_overcommit_handler()
> 
> This patch also set @nid with proper value when NUMA_NO_NODE is
> passed to alloc_gigantic_page().
> 
> After this patch, the counter.sh can pass for the gigantic page.
> 
> Acked-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> ---
>   1. fix the wrong check in hugetlb_overcommit_handler();
>   2. try to fix the s390 issue.
> ---
>  mm/hugetlb.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9fdfc24..5dbfd62 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1095,6 +1095,9 @@ static struct page *alloc_gigantic_page(int nid, unsigned int order)
>  	unsigned long ret, pfn, flags;
>  	struct zone *z;
> 
> +	if (nid == NUMA_NO_NODE)
> +		nid = numa_mem_id();
> +

Now counter.sh works (on s390) w/o the lockdep warning. However, it looks
like this change will now result in inconsistent behavior compared to the
normal sized hugepages, regarding surplus page allocation. Setting nid to
numa_mem_id() means that only the node of the current CPU will be considered
for allocating a gigantic page, as opposed to just "preferring" the current
node in the normal size case (__hugetlb_alloc_buddy_huge_page() ->
alloc_pages_node()) with a fallback to using other nodes.

I am not really familiar with NUMA, and I might be wrong here, but if
this is true then gigantic pages, which may be hard allocate at runtime
in general, will be even harder to find (as surplus pages) because you
only look on the current node.

I honestly do not understand why alloc_gigantic_page() needs a nid
parameter at all, since it looks like it will only be called from
alloc_fresh_gigantic_page_node(), which in turn is only called
from alloc_fresh_gigantic_page() in a "for_each_node" loop (at least
before your patch).

Now it could be an option to also use alloc_fresh_gigantic_page()
in your patch, instead of directly calling alloc_gigantic_page(),
in __alloc_huge_page(). This would fix the "local node only" issue,
but I am not sure how to handle the required nodes_allowed parameter.

Maybe someone with more NUMA insight could have a look at this.
The patch as it is also seems to work, with the "local node only"
restriction, so it may be an option to just accept this restriction.
