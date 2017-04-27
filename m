From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 27 Apr 2017 16:42:12 +0200
Subject: [PATCH 1/3] mm: Silence vmap() allocation failures based on
 caller gfp_flags
In-Reply-To: <20170425223332.6999-4-f.fainelli@gmail.com>
References: <20170425223332.6999-1-f.fainelli@gmail.com>
 <20170425223332.6999-4-f.fainelli@gmail.com>
Message-ID: <20170427144211.GL4706@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 25-04-17 15:33:29, Florian Fainelli wrote:
> If the caller has set __GFP_NOWARN don't print the following message:
> vmap allocation for size 15736832 failed: use vmalloc=<size> to increase
> size.
> 
> This can happen with the ARM/Linux module loader built with
> CONFIG_ARM_MODULE_PLTS=y which does a first attempt at loading a large
> module from module space, then falls back to vmalloc space.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0b057628a7ba..5a788eb58741 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -521,7 +521,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		}
>  	}
>  
> -	if (printk_ratelimit())
> +	if (printk_ratelimit() && !(gfp_mask & __GFP_NOWARN))

Are you sure about this ordering? Should NOWARN requests alter the
ratelimit state?

>  		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
>  			size);
>  	kfree(va);
> -- 
> 2.9.3
> 

-- 
Michal Hocko
SUSE Labs
