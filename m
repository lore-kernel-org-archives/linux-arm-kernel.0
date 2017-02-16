From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Feb 2017 14:22:43 +0100
Subject: [RFC PATCH 04/33] irqchip/gic-v3-its: Move LPI definitions around
In-Reply-To: <1484648454-21216-5-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <d35f9268-e840-67d6-6b5a-646fbeb5e531@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 17/01/2017 11:20, Marc Zyngier wrote:
> The various LPI definitions are in the middle of the code, and
> would be better placed at the beginning, given that we're going
> to use some of them much earlier.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 49b681e..2ca27f6 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -49,6 +49,21 @@
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>  
>  /*
> + * We allocate 64kB for PROPBASE. That gives us at most 64K LPIs to
> + * deal with (one configuration byte per interrupt). PENDBASE has to
> + * be 64kB aligned (one bit per LPI, plus 8192 bits for SPI/PPI/SGI).
> + */
> +#define LPI_PROPBASE_SZ		SZ_64K
> +#define LPI_PENDBASE_SZ		(LPI_PROPBASE_SZ / 8 + SZ_1K)
> +
> +/*
> + * This is how many bits of ID we need, including the useless ones.
> + */
> +#define LPI_NRBITS		ilog2(LPI_PROPBASE_SZ + SZ_8K)
> +
> +#define LPI_PROP_DEFAULT_PRIO	0xa0
> +
> +/*
>   * Collection structure - just an ID, and a redistributor address to
>   * ping. We use one per CPU as a bag of interrupts assigned to this
>   * CPU.
> @@ -779,20 +794,8 @@ static void its_lpi_free(struct event_lpi_map *map)
>  	kfree(map->col_map);
>  }
>  
> -/*
> - * We allocate 64kB for PROPBASE. That gives us at most 64K LPIs to
> - * deal with (one configuration byte per interrupt). PENDBASE has to
> - * be 64kB aligned (one bit per LPI, plus 8192 bits for SPI/PPI/SGI).
> - */
> -#define LPI_PROPBASE_SZ		SZ_64K
> -#define LPI_PENDBASE_SZ		(LPI_PROPBASE_SZ / 8 + SZ_1K)
>  
> -/*
> - * This is how many bits of ID we need, including the useless ones.
> - */
> -#define LPI_NRBITS		ilog2(LPI_PROPBASE_SZ + SZ_8K)
>  
> -#define LPI_PROP_DEFAULT_PRIO	0xa0
>  
>  static int __init its_alloc_lpi_tables(void)
>  {
> 
