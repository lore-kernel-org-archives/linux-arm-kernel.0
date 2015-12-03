From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 03 Dec 2015 16:29:19 +0000
Subject: [PATCH v9 4/4] irqchip:implement the mbigen irq chip operation
 functions
In-Reply-To: <1448248513-39760-5-git-send-email-majun258@huawei.com>
References: <1448248513-39760-1-git-send-email-majun258@huawei.com>
 <1448248513-39760-5-git-send-email-majun258@huawei.com>
Message-ID: <56606DDF.1070205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/15 03:15, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> Add the interrupt controller chip operation functions of mbigen chip.
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c |   84 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 84 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 81ae61f..540ad05 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -47,6 +47,20 @@
>  #define REG_MBIGEN_VEC_OFFSET		0x200
>  
>  /**
> + * offset of clear register in mbigen node
> + * This register is used to clear the status
> + * of interrupt
> + */
> +#define REG_MBIGEN_CLEAR_OFFSET		0xa000
> +
> +/**
> + * offset of interrupt type register
> + * This register is used to configure interrupt
> + * trigger type
> + */
> +#define REG_MBIGEN_TYPE_OFFSET		0x0
> +
> +/**
>   * struct mbigen_device - holds the information of mbigen device.
>   *
>   * @pdev:		pointer to the platform device structure of mbigen chip.
> @@ -69,8 +83,78 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
>  			+ REG_MBIGEN_VEC_OFFSET;
>  }
>  
> +static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
> +					unsigned int *mask,
> +					unsigned int *addr)

unsigned int is the wrong type if that's something you are going to use
with readl/writel. It should be u32.

> +{
> +	unsigned int nid, pin, ofst;
> +
> +	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
> +	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
> +	pin = hwirq % IRQS_PER_MBIGEN_NODE;
> +
> +	*mask = 1 << (pin % 32);
> +	
> +	ofst = pin / 32 * 4;
> +	*addr = ofst + nid * MBIGEN_NODE_OFFSET
> +		+ REG_MBIGEN_TYPE_OFFSET;
> +}
> +
> +static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
> +					unsigned int *mask,

Same here.

> +					unsigned int *addr)
> +{
> +	unsigned int ofst;
> +
> +	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
> +	ofst = hwirq / 32 * 4;
> +
> +	*mask = 1 << (hwirq % 32);
> +	*addr = ofst + REG_MBIGEN_CLEAR_OFFSET;
> +}
> +
> +static void mbigen_eoi_irq(struct irq_data *data)
> +{
> +	void __iomem *base = data->chip_data;
> +	unsigned int mask, addr;

same here.

> +
> +	get_mbigen_clear_reg(data->hwirq, &mask, &addr);
> +
> +	writel_relaxed(mask, base + addr);
> +
> +	irq_chip_eoi_parent(data);
> +}
> +
> +static int mbigen_set_type(struct irq_data *data, unsigned int type)
> +{
> +	void __iomem *base = data->chip_data;
> +	unsigned int mask, addr;

and here.

> +	u32 val;
> +
> +	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> +		return -EINVAL;
> +
> +	get_mbigen_type_reg(data->hwirq, &mask, &addr);
> +
> +	val = readl_relaxed(base + addr);
> +
> +	if (type == IRQ_TYPE_LEVEL_HIGH)
> +		val |= mask;
> +	else
> +		val &= ~mask;
> +
> +	writel_relaxed(val, base + addr);
> +
> +	return 0;
> +}
> +
>  static struct irq_chip mbigen_irq_chip = {
>  	.name =			"mbigen-v2",
> +	.irq_mask =		irq_chip_mask_parent,
> +	.irq_unmask =		irq_chip_unmask_parent,
> +	.irq_eoi =		mbigen_eoi_irq,
> +	.irq_set_type =		mbigen_set_type,
> +	.irq_set_affinity =	irq_chip_set_affinity_parent,
>  };
>  
>  static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
