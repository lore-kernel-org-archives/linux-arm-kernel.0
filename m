From: majun258@huawei.com (majun (F))
Date: Fri, 25 Dec 2015 16:24:27 +0800
Subject: [RFC PATCH] irqchip/gic-v3-its:Fix the bug while calculating the
 page number of ITS table
In-Reply-To: <20151224134852.6da6dd45@arm.com>
References: <1450768223-10860-1-git-send-email-majun258@huawei.com>
 <20151224134852.6da6dd45@arm.com>
Message-ID: <567CFD3B.2020101@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc:

? 2015/12/24 21:48, Marc Zyngier ??:
> On Tue, 22 Dec 2015 15:10:23 +0800
> MaJun <majun258@huawei.com> wrote:
> 
[...]
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e23d1d1..3447549 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -875,6 +875,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>  		}
>  
>  		alloc_size = (1 << order) * PAGE_SIZE;
> +retry_alloc_baser:
>  		alloc_pages = (alloc_size / psz);
>  		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>  			alloc_pages = GITS_BASER_PAGES_MAX;
> @@ -938,13 +939,16 @@ retry_baser:
>  			 * size and retry. If we reach 4K, then
>  			 * something is horribly wrong...
>  			 */
> +			free_pages((unsigned long)base, order);
> +			its->tables[i] = NULL;
> +
>  			switch (psz) {
>  			case SZ_16K:
>  				psz = SZ_4K;
> -				goto retry_baser;
> +				goto retry_alloc_baser;
>  			case SZ_64K:
>  				psz = SZ_16K;
> -				goto retry_baser;
> +				goto retry_alloc_baser;
>  			}
>  		}
>  
> 
> 
> I haven't tested it, but it looks less invasive. Care to give it a go?
> 

This patch works fine on my board.
Tested-by: Ma Jun <majun258@huawei.com>

Thanks
Ma Jun





> Thanks,
> 
> 	M.
> 
