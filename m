From: ebru.akagunduz@gmail.com (Ebru Akagunduz)
Date: Tue, 19 Jan 2016 00:18:40 +0200
Subject: [PATCH] mm: avoid uninitialized variable in tracepoint
In-Reply-To: <4117363.Ys1FTDH7Wz@wuerfel>
References: <4117363.Ys1FTDH7Wz@wuerfel>
Message-ID: <20160118221839.GA5787@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 09:50:26PM +0100, Arnd Bergmann wrote:
> A newly added tracepoint in the hugepage code uses a variable in the
> error handling that is not initialized at that point:
> 
> include/trace/events/huge_memory.h:81:230: error: 'isolated' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> The result is relatively harmless, as the trace data will in rare
> cases contain incorrect data.
> 
> This works around the problem by adding an explicit initialization.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
Reviewed-by: Ebru Akagunduz <ebru.akagunduz@gmail.com>
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b2db98136af9..bb3b763b1829 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2320,7 +2320,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	pgtable_t pgtable;
>  	struct page *new_page;
>  	spinlock_t *pmd_ptl, *pte_ptl;
> -	int isolated, result = 0;
> +	int isolated = 0, result = 0;
>  	unsigned long hstart, hend;
>  	struct mem_cgroup *memcg;
>  	unsigned long mmun_start;	/* For mmu_notifiers */
> 
