From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 3 Jan 2018 08:47:02 +0000
Subject: [PATCH] irqchip/gic-v3-its: Add workaround for ThunderX2 erratum
 #174
In-Reply-To: <20180103063224.9965-1-ganapatrao.kulkarni@cavium.com>
References: <20180103063224.9965-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <410d1cf1-c2f4-53a9-77e5-24323a960739@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/18 06:32, Ganapatrao Kulkarni wrote:
> When an interrupt is moved across node collections on ThunderX2

node collections?

> multi Socket platform, an interrupt stops routed to new collection
> and results in loss of interrupts.
> 
> Adding workaround to issue INV after MOVI for cross-node collection
> move to flush out the cached entry.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  Documentation/arm64/silicon-errata.txt |  1 +
>  arch/arm64/Kconfig                     | 11 +++++++++++
>  drivers/irqchip/irq-gic-v3-its.c       | 24 ++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index fc1c884..fb27cb5 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -63,6 +63,7 @@ stable kernels.
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
>  | Cavium         | ThunderX Core   | #30115          | CAVIUM_ERRATUM_30115        |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
> +| Cavium         | ThunderX2 ITS   | #174            | CAVIUM_ERRATUM_174          |
>  | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>  | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
>  |                |                 |                 |                             |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c9a7e9e..71a7e30 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -461,6 +461,17 @@ config ARM64_ERRATUM_843419
>  
>  	  If unsure, say Y.
>  
> +config CAVIUM_ERRATUM_174
> +	bool "Cavium ThunderX2 erratum 174"
> +	depends on NUMA

Why? This system will be affected no matter whether NUMA is selected or not.

> +	default y
> +	help
> +	  LPI stops routed to redistributors after inter node collection
> +	  move in ITS. Enable workaround to invalidate ITS entry after
> +	  inter-node collection move.

That's a very terse description. Nobody knows what an LPI, a
redistributor or a collection is. Please explain what the erratum is in
layman's terms (Cavium ThunderX2 systems may loose interrupts on
affinity change) so that people understand whether or not they are affected.

> +
> +	  If unsure, say Y.
> +
>  config CAVIUM_ERRATUM_22375
>  	bool "Cavium erratum 22375, 24313"
>  	default y
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 06f025f..d8b9c96 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -46,6 +46,7 @@
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
> +#define ITS_FLAGS_WORKAROUND_CAVIUM_174		(1ULL << 3)
>  
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>  
> @@ -1119,6 +1120,12 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  	if (cpu != its_dev->event_map.col_map[id]) {
>  		target_col = &its_dev->its->collections[cpu];
>  		its_send_movi(its_dev, target_col, id);
> +		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_174) {
> +			/* Issue INV for cross node collection move. */
> +			if (cpu_to_node(cpu) !=
> +				cpu_to_node(its_dev->event_map.col_map[id]))
> +				its_send_inv(its_dev, id);
> +		}

What happens if an interrupt happens after the MOV, but before the INV?

>  		its_dev->event_map.col_map[id] = cpu;
>  		irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  	}
> @@ -2904,6 +2911,15 @@ static int its_force_quiescent(void __iomem *base)
>  	}
>  }
>  
> +static bool __maybe_unused its_enable_quirk_cavium_174(void *data)
> +{
> +	struct its_node *its = data;
> +
> +	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_174;
> +
> +	return true;
> +}
> +
>  static bool __maybe_unused its_enable_quirk_cavium_22375(void *data)
>  {
>  	struct its_node *its = data;
> @@ -3031,6 +3047,14 @@ static const struct gic_quirk its_quirks[] = {
>  		.init	= its_enable_quirk_hip07_161600802,
>  	},
>  #endif
> +#ifdef CONFIG_CAVIUM_ERRATUM_174
> +	{
> +		.desc	= "ITS: Cavium ThunderX2 erratum 174",
> +		.iidr	= 0x13f,	/* ThunderX2 pass A1/A2/B0 */

Do all 3 revisions have the same IIDR?

> +		.mask	= 0xffffffff,
> +		.init	= its_enable_quirk_cavium_174,
> +	},
> +#endif
>  	{
>  	}
>  };
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
