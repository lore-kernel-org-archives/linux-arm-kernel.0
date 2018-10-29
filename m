From: mhocko@kernel.org (Michal Hocko)
Date: Mon, 29 Oct 2018 09:07:08 +0100
Subject: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
In-Reply-To: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <20181029080708.GA32673@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 29-10-18 13:16:16, miles.chen at mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> The kbuf used by page owner is allocated by kmalloc(), which means it
> can use only normal memory and there might be a "out of memory"
> issue when we're out of normal memory.
> 
> To solve this problem, use kvmalloc() to allocate kbuf
> from normal/highmem. But there is one problem here: kvmalloc()
> does not fallback to vmalloc for sub page allocations. So sub
> page allocation fails due to out of normal memory cannot fallback
> to vmalloc.
> 
> Modify kvmalloc() to allow sub page allocations fallback to
> vmalloc when CONFIG_HIGHMEM=y and use kvmalloc() to allocate
> kbuf.
> 
> Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation.
> 
> Change since v2:
>   - improve kvmalloc, allow sub page allocations fallback to
>     vmalloc when CONFIG_HIGHMEM=y

Matthew has suggested a much more viable way to go around this. We do
not really want to allow an unbound kernel allocation - even if the
interface is root only.

Besides that, the following doesn't make much sense to me. It simply
makes no sense to use vmalloc for sub page allocation regardless of
HIGHMEM.

> diff --git a/mm/util.c b/mm/util.c
> index 8bf08b5b5760..7b1c59b9bfbf 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  	ret = kmalloc_node(size, kmalloc_flags, node);
>  
>  	/*
> -	 * It doesn't really make sense to fallback to vmalloc for sub page
> -	 * requests
> +	 * It only makes sense to fallback to vmalloc for sub page
> +	 * requests if we might be able to allocate highmem pages.
>  	 */
> -	if (ret || size <= PAGE_SIZE)
> +	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
>  		return ret;
>  
>  	return __vmalloc_node_flags_caller(size, node, flags,
> -- 
> 2.18.0
> 

-- 
Michal Hocko
SUSE Labs
