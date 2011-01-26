From: mel@csn.ul.ie (Mel Gorman)
Date: Wed, 26 Jan 2011 08:29:16 +0000
Subject: [PATCH] ARM: mm: enforce pageblock alignment when freeing
	memmap entries at init
In-Reply-To: <1295567231-2384-1-git-send-email-dima@android.com>
References: <1295567231-2384-1-git-send-email-dima@android.com>
Message-ID: <20110126082916.GM18984@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 03:47:11PM -0800, Dima Zavin wrote:
> On some machines, the nodes do not always start on pageblock
> boundaries. In these cases it is possible for free_unused_memmap
> to free mappings for pages inside a pageblock with otherwise
> valid pages. This presents problems for page migration since it
> operates on whole pageblocks at a time.
> 

This patch is not aligning on a pageblock boundary - it's aligning on
MAX_ORDER_NR_PAGES which is the boundary the buddy allocator works on.
This is a minor but important nit as different assumptions are made
about pageblocks and MAX_ORDER_NR_PAGES. Anyway;

If the node is not starting on the MAX_ORDER boundary then node_start_pfn
should also not be on the same boundary but the patch does not imply
that this has been broken. If anything it appears at a glance that there
is memmap *not* being freed because it was allocated on the
MAX_ORDER_NR_PAGES boundary and only partially freed.

The comment then is confusing because the function is freeing memmap but
rounding down to free more of it ensures that all pages get a mapping?
It's not clear at all to me what was broken or how this patch fixes it
but bear in mind that it's rare I look at how ARM is initialised.

> Round down bank_start to pageblock boundary so that whole
> pageblocks always have valid mappings.
> 
> Signed-off-by: Dima Zavin <dima@android.com>
> ---
>  arch/arm/mm/init.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 5164069..98de5d8 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -418,7 +418,11 @@ static void __init free_unused_memmap(struct meminfo *mi)
>  	for_each_bank(i, mi) {
>  		struct membank *bank = &mi->bank[i];
>  
> -		bank_start = bank_pfn_start(bank);
> +		/* Round bank_start down to the start of a pageblock so that
> +		 * all pages in a pageblock always have a mapping.
> +		 */
> +		bank_start = round_down(bank_pfn_start(bank),
> +					MAX_ORDER_NR_PAGES);
>  
>  		/*
>  		 * If we had a previous bank, and there is a space
> -- 
> 1.7.3.1
> 

-- 
Mel Gorman
Linux Technology Center
IBM Dublin Software Lab
