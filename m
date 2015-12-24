From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Dec 2015 13:48:52 +0000
Subject: [RFC PATCH] irqchip/gic-v3-its:Fix the bug while calculating
 the page number of ITS table
In-Reply-To: <1450768223-10860-1-git-send-email-majun258@huawei.com>
References: <1450768223-10860-1-git-send-email-majun258@huawei.com>
Message-ID: <20151224134852.6da6dd45@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015 15:10:23 +0800
MaJun <majun258@huawei.com> wrote:

> From: Ma Jun <majun258@huawei.com>
> 
> Hi Marc, Robert:
> 
> Maybe there is a bug introduced by commit
> "irqchip/gicv3-its: Add range check for number of allocated pages"
> 30f2136346cab91e1ffd9ee6370d76809f20487a
> 
> I think, before setting the page number, the variable "alloc_pages"
> should be calculated and checked again. 
> Or else, the page number programmed into GITS_BASER register is always
> the number of 64KB even though the page size is 16KB or 4KB.
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e23d1d1..100181b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -879,7 +879,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>  		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>  			alloc_pages = GITS_BASER_PAGES_MAX;
>  			order = get_order(GITS_BASER_PAGES_MAX * psz);
> -			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
> +			pr_warn("%s: Table too large, reduce its page order to %u (%u pages)\n",
>  				node_name, order, alloc_pages);

No, this can only be a device table. Even with the smallest ITS page
size, you cannot end-up with with more than 256 ITS pages, since the
original allocation is still a single CPU page.

>  		}
>  
> @@ -911,6 +911,13 @@ retry_baser:
>  			break;
>  		}
>  
> +               alloc_pages = (alloc_size / psz);
> +                if (alloc_pages > GITS_BASER_PAGES_MAX) {
> +                        alloc_pages = GITS_BASER_PAGES_MAX;
> +                        pr_warn("%s: Table too large, reduce its page number to %u pages\n",
> +                                node_name, alloc_pages);
> +                }
> +

So you now have limited the number of pages, but you also have
allocated too much memory. Not really ideal.

>  		val |= alloc_pages - 1;
>  
>  		writeq_relaxed(val, its->base + GITS_BASER + i * 8);

Instead of duplicating that code and making it even less readable, how
about something like this, which simply goes back to a clean slate and
tries it again with the new page size:

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e23d1d1..3447549 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -875,6 +875,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		}
 
 		alloc_size = (1 << order) * PAGE_SIZE;
+retry_alloc_baser:
 		alloc_pages = (alloc_size / psz);
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
 			alloc_pages = GITS_BASER_PAGES_MAX;
@@ -938,13 +939,16 @@ retry_baser:
 			 * size and retry. If we reach 4K, then
 			 * something is horribly wrong...
 			 */
+			free_pages((unsigned long)base, order);
+			its->tables[i] = NULL;
+
 			switch (psz) {
 			case SZ_16K:
 				psz = SZ_4K;
-				goto retry_baser;
+				goto retry_alloc_baser;
 			case SZ_64K:
 				psz = SZ_16K;
-				goto retry_baser;
+				goto retry_alloc_baser;
 			}
 		}
 


I haven't tested it, but it looks less invasive. Care to give it a go?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
