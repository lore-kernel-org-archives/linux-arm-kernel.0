From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Oct 2017 08:49:44 +0100
Subject: [PATCH v2] drivers/irqchip: gicv3: add workaround for Synquacer
 pre-ITS
In-Reply-To: <20171012065835.646-1-ard.biesheuvel@linaro.org>
References: <20171012065835.646-1-ard.biesheuvel@linaro.org>
Message-ID: <d7b465b0-9eee-ee01-e690-e4ec3295c04b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 12/10/17 07:58, Ard Biesheuvel wrote:
> The Socionext Synquacer SoC's implementation of GICv3 has a so-called
> 'pre-ITS', which maps 32-bit writes targeted at a separate window of
> size '4 << device_id_bits' onto writes to GITS_TRANSLATER with device
> ID taken from bits [device_id_bits + 1:2] of the window offset.
> Writes that target GITS_TRANSLATER directly are reported as originating
> from device ID #0.
> 
> So add a workaround for this. Given that this breaks isolation, clear
> the IRQ_DOMAIN_FLAG_MSI_REMAP flag as well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: - use a 32-bit host address/size rather than a PCI address, to factor
>       out the involvement of an SMMU (which the platform does have, but it
>       is unclear atm if it can be exposed to the OS)
>     - add msi_domain_flags member to move the quirk flag checks out of the
>       common code path
> 
>  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt |  4 ++
>  arch/arm64/Kconfig                                                    |  8 +++
>  drivers/irqchip/irq-gic-v3-its.c                                      | 53 +++++++++++++++++---
>  3 files changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> index 4c29cdab0ea5..3d8b3f910aef 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> @@ -75,6 +75,10 @@ These nodes must have the following properties:
>  - reg: Specifies the base physical address and size of the ITS
>    registers.
>  
> +Optional:
> +- socionext,synquacer-pre-its: (u32, u32) tuple describing the host address
> +  and size of the pre-ITS window.
> +
>  The main GIC node must contain the appropriate #address-cells,
>  #size-cells and ranges properties for the reg property of all ITS
>  nodes.
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0df64a6a56d4..c4361dff2b74 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -539,6 +539,14 @@ config QCOM_QDF2400_ERRATUM_0065
>  
>  	  If unsure, say Y.
>  
> +config SOCIONEXT_SYNQUACER_PREITS
> +	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
> +	default y
> +	help
> +	  Socionext Synquacer SoCs implement a separate h/w block to generate
> +	  MSI doorbell writes with non-zero values for the device ID.
> +
> +	  If unsure, say Y.
>  endmenu
>  
>  
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e8d89343d613..7a4536ce8e72 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -46,6 +46,7 @@
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
> +#define ITS_FLAGS_WORKAROUND_SOCIONEXT_PREITS	(1ULL << 3)
>  
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>  
> @@ -102,6 +103,11 @@ struct its_node {
>  	u32			ite_size;
>  	u32			device_ids;
>  	int			numa_node;
> +	unsigned int		msi_domain_flags;
> +#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
> +	u32			pre_its_base;
> +	u32			pre_its_size;
> +#endif
>  	bool			is_v4;
>  };
>  
> @@ -1095,14 +1101,31 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  	return IRQ_SET_MASK_OK_DONE;
>  }
>  
> +static u64 its_irq_get_msi_base(struct its_device *its_dev)
> +{
> +	struct its_node *its = its_dev->its;
> +
> +#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
> +	if (its->flags & ITS_FLAGS_WORKAROUND_SOCIONEXT_PREITS)
> +
> +		/*
> +		 * The Socionext Synquacer SoC has a so-called 'pre-ITS',
> +		 * which maps 32-bit writes targeted at a separate window of
> +		 * size '4 << device_id_bits' onto writes to GITS_TRANSLATER
> +		 * with device ID taken from bits [device_id_bits + 1:2] of
> +		 * the window offset.
> +		 */
> +		return its->pre_its_base + (its_dev->device_id << 2);
> +#endif
> +	return its->phys_base + GITS_TRANSLATER;
> +}
> +
>  static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>  {
>  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> -	struct its_node *its;
>  	u64 addr;
>  
> -	its = its_dev->its;
> -	addr = its->phys_base + GITS_TRANSLATER;
> +	addr = its_irq_get_msi_base(its_dev);
>  
>  	msg->address_lo		= lower_32_bits(addr);
>  	msg->address_hi		= upper_32_bits(addr);
> @@ -1666,6 +1689,11 @@ static int its_alloc_tables(struct its_node *its)
>  		ids     = 0x14;                 /* 20 bits, 8MB */
>  	}
>  
> +#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
> +	if (its->flags & ITS_FLAGS_WORKAROUND_SOCIONEXT_PREITS)
> +		ids = ilog2(its->pre_its_size) - 2;

You probably want to check that this is smaller or equal to the ITS's
own view of the DevID space.

> +#endif
> +
>  	its->device_ids = ids;
>  
>  	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
> @@ -2788,11 +2816,22 @@ static const struct gic_quirk its_quirks[] = {
>  	}
>  };
>  
> -static void its_enable_quirks(struct its_node *its)
> +static void its_enable_quirks(struct its_node *its,
> +			      struct fwnode_handle *handle)
>  {
>  	u32 iidr = readl_relaxed(its->base + GITS_IIDR);
>  
>  	gic_enable_quirks(iidr, its_quirks, its);
> +
> +#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
> +	if (!fwnode_property_read_u32_array(handle,
> +					    "socionext,synquacer-pre-its",
> +					    &its->pre_its_base, 2)) {

Erm. Populating these two fields with a single read is pretty horrible...

> +		its->flags |= ITS_FLAGS_WORKAROUND_SOCIONEXT_PREITS;
> +		its->msi_domain_flags &= ~IRQ_DOMAIN_FLAG_MSI_REMAP;
> +		pr_info("ITS: enabling workaround for Socionext Synquacer pre-ITS\n");
> +	}
> +#endif

I must say I'm not fond of adding a quirk outside of the quirk
infrastructure. Could you try this slightly different approach?

- Add the handle to the struct its_node
- Add a quirk structure to the its_quirks array, with a match on
whatever version of the GIC this platform is using (I suppose some
revision of GIC-500)
- Move this check in its own function

With a small change, we could also move the ids discovery to the quirk
function (and just check that its->device_ids is 0 before setting it in
the normal case).

>  }
>  
>  static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
> @@ -2811,8 +2850,9 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>  	}
>  
>  	inner_domain->parent = its_parent;
> +	inner_domain->flags |= its->msi_domain_flags;
>  	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
> -	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_REMAP;
> +
>  	info->ops = &its_msi_domain_ops;
>  	info->data = its;
>  	inner_domain->host_data = info;
> @@ -2942,6 +2982,7 @@ static int __init its_probe_one(struct resource *res,
>  	its->base = its_base;
>  	its->phys_base = res->start;
>  	its->ite_size = GITS_TYPER_ITT_ENTRY_SIZE(typer);
> +	its->msi_domain_flags = IRQ_DOMAIN_FLAG_MSI_REMAP;
>  	its->is_v4 = !!(typer & GITS_TYPER_VLPIS);
>  	if (its->is_v4) {
>  		if (!(typer & GITS_TYPER_VMOVP)) {
> @@ -2966,7 +3007,7 @@ static int __init its_probe_one(struct resource *res,
>  	}
>  	its->cmd_write = its->cmd_base;
>  
> -	its_enable_quirks(its);
> +	its_enable_quirks(its, handle);
>  
>  	err = its_alloc_tables(its);
>  	if (err)
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
