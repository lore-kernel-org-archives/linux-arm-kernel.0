From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 13 Jul 2017 18:25:29 +0200
Subject: [PATCH v2] irqchip: gicv3-its: Use NUMA aware memory allocation
 for ITS tables
In-Reply-To: <1499702025-21383-1-git-send-email-shankerd@codeaurora.org>
References: <1499702025-21383-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20170713162529.GB18024@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.07.17 10:53:45, Shanker Donthineni wrote:
> The NUMA node information is visible to ITS driver but not being used
> other than handling hardware errata. ITS/GICR hardware accesses to the
> local NUMA node is usually quicker than the remote NUMA node. How slow
> the remote NUMA accesses are depends on the implementation details.
> 
> This patch allocates memory for ITS management tables and command
> queue from the corresponding NUMA node using the appropriate NUMA
> aware functions. This change improves the performance of the ITS
> tables read latency on systems where it has more than one ITS block,
> and with the slower inter node accesses.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)

> @@ -1773,7 +1777,7 @@ static int __init its_probe_one(struct resource *res,
>  out_free_tables:
>  	its_free_tables(its);
>  out_free_cmd:
> -	free_pages((unsigned long)its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
> +	__free_pages(virt_to_page(its->cmd_base), get_order(ITS_CMD_QUEUE_SZ));

This change is not required as free_pages() can be used here directly.

-Robert

>  out_free_its:
>  	kfree(its);
>  out_unmap:
