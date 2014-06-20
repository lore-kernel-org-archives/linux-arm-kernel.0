From: msalter@redhat.com (Mark Salter)
Date: Fri, 20 Jun 2014 11:48:02 -0400
Subject: [PATCHv2] mm: page_alloc: fix CMA area initialisation when
 pageblock > MAX_ORDER
In-Reply-To: <xa1td2e41xs2.fsf@mina86.com>
References: <1402522435-13884-1-git-send-email-msalter@redhat.com>
 <alpine.DEB.2.02.1406111557030.27885@chino.kir.corp.google.com>
 <xa1t61jzwfo6.fsf@mina86.com> <1403201524.32688.62.camel@deneb.redhat.com>
 <xa1td2e41xs2.fsf@mina86.com>
Message-ID: <1403279282.755.23.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-06-19 at 21:53 +0200, Michal Nazarewicz wrote:
> With a kernel configured with ARM64_64K_PAGES && !TRANSPARENT_HUGEPAGE,
> the following is triggered at early boot:
> 
>   SMP: Total of 8 processors activated.
>   devtmpfs: initialized
>   Unable to handle kernel NULL pointer dereference at virtual address 00000008
>   pgd = fffffe0000050000
>   [00000008] *pgd=00000043fba00003, *pmd=00000043fba00003, *pte=00e0000078010407
>   Internal error: Oops: 96000006 [#1] SMP
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.15.0-rc864k+ #44
>   task: fffffe03bc040000 ti: fffffe03bc080000 task.ti: fffffe03bc080000
>   PC is at __list_add+0x10/0xd4
>   LR is at free_one_page+0x270/0x638
>   ...
>   Call trace:
>   [<fffffe00003ee970>] __list_add+0x10/0xd4
>   [<fffffe000019c478>] free_one_page+0x26c/0x638
>   [<fffffe000019c8c8>] __free_pages_ok.part.52+0x84/0xbc
>   [<fffffe000019d5e8>] __free_pages+0x74/0xbc
>   [<fffffe0000c01350>] init_cma_reserved_pageblock+0xe8/0x104
>   [<fffffe0000c24de0>] cma_init_reserved_areas+0x190/0x1e4
>   [<fffffe0000090418>] do_one_initcall+0xc4/0x154
>   [<fffffe0000bf0a50>] kernel_init_freeable+0x204/0x2a8
>   [<fffffe00007520a0>] kernel_init+0xc/0xd4
> 
> This happens because init_cma_reserved_pageblock() calls
> __free_one_page() with pageblock_order as page order but it is bigger
> han MAX_ORDER.  This in turn causes accesses past zone->free_list[].
> 
> Fix the problem by changing init_cma_reserved_pageblock() such that it
> splits pageblock into individual MAX_ORDER pages if pageblock is
> bigger than a MAX_ORDER page.
> 
> In cases where !CONFIG_HUGETLB_PAGE_SIZE_VARIABLE, which is all
> architectures expect for ia64, powerpc and tile at the moment, the
> ?pageblock_order > MAX_ORDER? condition will be optimised out since
> both sides of the operator are constants.  In cases where pageblock
> size is variable, the performance degradation should not be
> significant anyway since init_cma_reserved_pageblock() is called
> only at boot time at most MAX_CMA_AREAS times which by default is
> eight.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Reported-by: Mark Salter <msalter@redhat.com>
> ---
>  mm/page_alloc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7f97767..fe114db 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -817,7 +817,18 @@ void __init init_cma_reserved_pageblock(struct page *page)
>  
>  	set_page_refcounted(page);
>  	set_pageblock_migratetype(page, MIGRATE_CMA);
> -	__free_pages(page, pageblock_order);
> +
> +	if (pageblock_order > MAX_ORDER) {
> +		i = pageblock_order - MAX_ORDER;
> +		i = 1 << i;
> +		p = page;
> +		do {
> +			__free_pages(p, MAX_ORDER);
> +		} while (p += MAX_ORDER_NR_PAGES, --i);
> +	} else {
> +		__free_pages(page, pageblock_order);
> +	}
> +
>  	adjust_managed_page_count(page, pageblock_nr_pages);
>  }
>  #endif

This still isn't quite right. __free_pages can only take up to
MAX_ORDER-1 (MAX_ORDER_NR_PAGES is 1 << (MAX_ORDER - 1)). But
I'm hitting a slightly different issue even with that fixed up. 
Still looking...
