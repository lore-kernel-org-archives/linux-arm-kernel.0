From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 27 Apr 2017 19:56:54 +0200
Subject: [PATCH v2 1/3] mm: Silence vmap() allocation failures based on
 caller gfp_flags
In-Reply-To: <20170427173900.2538-2-f.fainelli@gmail.com>
References: <20170427173900.2538-1-f.fainelli@gmail.com>
 <20170427173900.2538-2-f.fainelli@gmail.com>
Message-ID: <20170427175653.GB30672@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 27-04-17 10:38:58, Florian Fainelli wrote:
> If the caller has set __GFP_NOWARN don't print the following message:
> vmap allocation for size 15736832 failed: use vmalloc=<size> to increase
> size.
> 
> This can happen with the ARM/Linux or ARM64/Linux module loader built
> with CONFIG_ARM{,64}_MODULE_PLTS=y which does a first attempt at loading
> a large module from module space, then falls back to vmalloc space.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

just a nit

> ---
>  mm/vmalloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0b057628a7ba..d8a851634674 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -521,9 +521,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		}
>  	}
>  
> +	if (gfp_mask & __GFP_NOWARN)
> +		goto out;
> +
>  	if (printk_ratelimit())

	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
>  		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
>  			size);

would be shorter and you wouldn't need the goto and a label.

> +out:
>  	kfree(va);
>  	return ERR_PTR(-EBUSY);
>  }
> -- 
> 2.9.3
> 

-- 
Michal Hocko
SUSE Labs
