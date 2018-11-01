From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 1 Nov 2018 18:09:48 +0100
Subject: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
In-Reply-To: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <20181101170948.GN23921@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 02-11-18 01:00:07, miles.chen at mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> The page owner read might allocate a large size of memory with
> a large read count. Allocation fails can easily occur when doing
> high order allocations.
> 
> Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation
> and avoid allocation fails due to high order allocation.

It is good to mention that interface is root only so the harm due to
unbounded allocation request is somehow reduced.

I believe we want to use seq_file infrastructure in the long term
solution.
 
> Change since v3:
>   - remove the change in kvmalloc
>   - keep kmalloc in page_owner.c
> 
> Change since v2:
>   - improve kvmalloc, allow sub page allocations fallback to
>     vmalloc when CONFIG_HIGHMEM=y
> 
> Change since v1:
>   - use kvmalloc()
>   - clamp buffer size to PAGE_SIZE
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/page_owner.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 87bc0dfdb52b..b83f295e4eca 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -351,6 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		.skip = 0
>  	};
>  
> +	count = count > PAGE_SIZE ? PAGE_SIZE : count;
>  	kbuf = kmalloc(count, GFP_KERNEL);
>  	if (!kbuf)
>  		return -ENOMEM;
> -- 
> 2.18.0
> 

-- 
Michal Hocko
SUSE Labs
