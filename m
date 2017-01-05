From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 Jan 2017 15:33:01 +0000
Subject: [PATCH v2,9/9] irqchip/ls-scfg-msi: add MSI affinity support
In-Reply-To: <1483603837-4629-9-git-send-email-Minghuan.Lian@nxp.com>
References: <1483603837-4629-1-git-send-email-Minghuan.Lian@nxp.com>
 <1483603837-4629-9-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <7888f3a1-ae4a-f2b6-f41b-fc414f7ca968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/17 08:10, Minghuan Lian wrote:
> For LS1046a and LS1043a v1.1, the MSI controller has 4 MSIRs and 4
> CPUs. A GIC SPI interrupt of MSIR can be associated with a CPU.
> When changing MSI interrupt affinity, this MSI will be moved to the
> corresponding MSIR and MSI message data will be changed according to
> MSIR. when requesting a MSI, the bits of all 4 MSIR will be reserved.
> The parameter 'msi_affinity_flag' is provide to change this mode.
> "lsmsi=no-affinity" will disable affinity, all MSI can only be
> associated with CPU 0.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> v2-v1:
> - None
> 
>  drivers/irqchip/irq-ls-scfg-msi.c | 75 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
> index dc19569..753fe39 100644
> --- a/drivers/irqchip/irq-ls-scfg-msi.c
> +++ b/drivers/irqchip/irq-ls-scfg-msi.c
> @@ -40,6 +40,7 @@ struct ls_scfg_msir {
>  	unsigned int gic_irq;
>  	unsigned int bit_start;
>  	unsigned int bit_end;
> +	unsigned int srs; /* Shared interrupt register select */
>  	void __iomem *reg;
>  };
>  
> @@ -70,6 +71,19 @@ struct ls_scfg_msi {
>  	.chip	= &ls_scfg_msi_irq_chip,
>  };
>  
> +static int msi_affinity_flag = 1;
> +
> +static int __init early_parse_ls_scfg_msi(char *p)
> +{
> +	if (p && strncmp(p, "no-affinity", 11) == 0)
> +		msi_affinity_flag = 0;
> +	else
> +		msi_affinity_flag = 1;
> +
> +	return 0;
> +}
> +early_param("lsmsi", early_parse_ls_scfg_msi);

What is the point of this option? If feels like an unnecessary complexity.

> +
>  static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  	struct ls_scfg_msi *msi_data = irq_data_get_irq_chip_data(data);
> @@ -77,12 +91,43 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
>  	msg->address_hi = upper_32_bits(msi_data->msiir_addr);
>  	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
>  	msg->data = data->hwirq;
> +
> +	if (msi_affinity_flag) {
> +		u32 msir_index;
> +
> +		msir_index = cpumask_first(data->common->affinity);
> +		if (msir_index >= msi_data->msir_num)
> +			msir_index = 0;

How can this happen?

> +
> +		msg->data |= msir_index;

How do you guarantee that the low bits were clear? Please document the
way you encode your MSI payload.

> +	}
>  }
>  
>  static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
>  				    const struct cpumask *mask, bool force)
>  {
> -	return -EINVAL;
> +	struct ls_scfg_msi *msi_data = irq_data_get_irq_chip_data(irq_data);
> +	u32 cpu;
> +
> +	if (!msi_affinity_flag)
> +		return -EINVAL;
> +
> +	if (!force)
> +		cpu = cpumask_any_and(mask, cpu_online_mask);
> +	else
> +		cpu = cpumask_first(mask);
> +
> +	if (cpu >= msi_data->msir_num)
> +		return -EINVAL;
> +
> +	if (msi_data->msir[cpu].gic_irq <= 0) {
> +		pr_warn("cannot bind the irq to cpu%d\n", cpu);

Please don't. Returning an error is enough. If you really want to have
something, turn it into a proper debug message.

> +		return -EINVAL;
> +	}
> +
> +	cpumask_copy(irq_data->common->affinity, mask);
> +
> +	return IRQ_SET_MASK_OK;
>  }
>  
>  static struct irq_chip ls_scfg_msi_parent_chip = {
> @@ -158,7 +203,7 @@ static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
>  
>  	for_each_set_bit_from(pos, &val, size) {
>  		hwirq = ((msir->bit_end - pos) << msi_data->cfg->ibs_shift) |
> -			msir->index;
> +			msir->srs;
>  		virq = irq_find_mapping(msi_data->parent, hwirq);
>  		if (virq)
>  			generic_handle_irq(virq);
> @@ -221,10 +266,19 @@ static int ls_scfg_msi_setup_hwirq(struct ls_scfg_msi *msi_data, int index)
>  					 ls_scfg_msi_irq_handler,
>  					 msir);
>  
> +	if (msi_affinity_flag) {
> +		/* Associate MSIR interrupt to the cpu */
> +		irq_set_affinity(msir->gic_irq, get_cpu_mask(index));
> +		msir->srs = 0; /* This value is determined by the CPU */
> +	} else
> +		msir->srs = index;
> +
>  	/* Release the hwirqs corresponding to this MSIR */
> -	for (i = 0; i < msi_data->cfg->msir_irqs; i++) {
> -		hwirq = i << msi_data->cfg->ibs_shift | msir->index;
> -		bitmap_clear(msi_data->used, hwirq, 1);
> +	if (!msi_affinity_flag || msir->index == 0) {
> +		for (i = 0; i < msi_data->cfg->msir_irqs; i++) {
> +			hwirq = i << msi_data->cfg->ibs_shift | msir->index;
> +			bitmap_clear(msi_data->used, hwirq, 1);
> +		}
>  	}
>  
>  	return 0;
> @@ -316,6 +370,17 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
>  	bitmap_set(msi_data->used, 0, msi_data->irqs_num);
>  
>  	msi_data->msir_num = of_irq_count(pdev->dev.of_node);
> +
> +	if (msi_affinity_flag) {
> +		u32 cpu_num;
> +
> +		cpu_num = num_possible_cpus();
> +		if (msi_data->msir_num >= cpu_num)
> +			msi_data->msir_num = cpu_num;
> +		else
> +			msi_affinity_flag = 0;
> +	}
> +
>  	msi_data->msir = devm_kcalloc(&pdev->dev, msi_data->msir_num,
>  				      sizeof(*msi_data->msir),
>  				      GFP_KERNEL);
> 

This is a very confusing patch. Please get rid of this useless option
and document how you encode the routing in the hwirq.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
