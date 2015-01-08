From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Jan 2015 11:13:53 +0100
Subject: [PATCH v2 02/21] irqchip: tegra: add DT-based support for legacy
 interrupt controller
In-Reply-To: <1420652576-22309-3-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108101351.GD1987@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 05:42:37PM +0000, Marc Zyngier wrote:
> Tegra's LIC (Legacy Interrupt Controller) has been so far only
> supported as a weird extension of the GIC, which is not exactly
> pretty.
> 
> The stacked irq domain framework fits this pretty well, and allows

Nit: s/irq/IRQ/

> the LIC code to be turned into a standalone irqchip. In the process,
> make the driver DT aware, something that was sorely missing from
> the mach-tegra implementation.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/Makefile    |   1 +
>  drivers/irqchip/irq-tegra.c | 335 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 336 insertions(+)
>  create mode 100644 drivers/irqchip/irq-tegra.c

This matches largely what I have in a local patch (modulo the stacked
domains vs. gic_arch_extn). A few comments below.

> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 9516a32..59f34be 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
>  obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
>  obj-$(CONFIG_ARCH_MVEBU)		+= irq-armada-370-xp.o
>  obj-$(CONFIG_ARCH_MXS)			+= irq-mxs.o
> +obj-$(CONFIG_ARCH_TEGRA)		+= irq-tegra.o
>  obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o

Should these be sorted alphabetically?

> diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
[...]
> +#define TEGRA_MAX_NUM_ICTLRS	5
> +
> +static int num_ictlrs;

This could be unsigned int.

> +struct tegra_ictlr_info {
> +	void __iomem *ictlr_reg_base[TEGRA_MAX_NUM_ICTLRS];

Maybe only "reg_base" or "base". The ictlr_ prefix is redundant.

> +#ifdef CONFIG_PM_SLEEP
> +	u32 cop_ier[TEGRA_MAX_NUM_ICTLRS];
> +	u32 cop_iep[TEGRA_MAX_NUM_ICTLRS];
> +	u32 cpu_ier[TEGRA_MAX_NUM_ICTLRS];
> +	u32 cpu_iep[TEGRA_MAX_NUM_ICTLRS];
> +
> +	u32 ictlr_wake_mask[TEGRA_MAX_NUM_ICTLRS];

Same here.

> +#endif
> +};
> +
> +static struct tegra_ictlr_info *tegra_ictlr_info;

This variable name could be shorter, say "lic", to make some of the code
below more terse.

> +static int tegra_ictlr_suspend(void)
> +{
> +	unsigned long flags;
> +	int i;

This could be unsigned int, too.

[...]
> +static void tegra_ictlr_resume(void)
> +{
> +	unsigned long flags;
> +	int i;

And here.

> +static struct syscore_ops tegra_ictlr_syscore_ops = {
> +	.suspend	= tegra_ictlr_suspend,
> +	.resume		= tegra_ictlr_resume,
> +};
> +
> +static int tegra_ictlr_syscore_init(void)
> +{
> +	register_syscore_ops(&tegra_ictlr_syscore_ops);
> +
> +	return 0;
> +}
> +#else
> +#define tegra_set_wake	NULL
> +static inline void tegra_ictlr_syscore_init(void) {}
> +#endif

Both prototypes for tegra_ictlr_syscore_init() should match here. Since
it never fails, returning void for both should be fine.

> +static struct irq_chip tegra_ictlr_chip = {
> +	.name		= "ICTLR",

Maybe name it "LIC" since that's the more common name for it?

> +static int tegra_ictlr_domain_xlate(struct irq_domain *domain,
> +				    struct device_node *controller,
> +				    const u32 *intspec,
> +				    unsigned int intsize,
> +				    unsigned long *out_hwirq,
> +				    unsigned int *out_type)
> +{
> +	if (domain->of_node != controller)
> +		return -EINVAL;	/* Shouldn't happen, really... */
> +	if (intsize != 3)
> +		return -EINVAL;	/* Not GIC compliant */
> +	if (intspec[0] != 0)

Maybe use GIC_SPI from dt-bindings/interrupt-controller/arm-gic.h here?
To match the DTS content?

> +static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
> +				    unsigned int virq,
> +				    unsigned int nr_irqs, void *data)
> +{
> +	struct of_phandle_args *args = data;
> +	struct of_phandle_args parent_args;
> +	struct tegra_ictlr_info *info = domain->host_data;
> +	irq_hw_number_t hwirq;
> +	int i;

unsigned int?

> +
> +	if (args->args_count != 3)
> +		return -EINVAL;	/* Not GIC compliant */
> +	if (args->args[0] != 0)

GIC_SPI?

> +	hwirq = args->args[1];
> +	if (hwirq >= (num_ictlrs * 32))
> +		return -EINVAL;	/* Can't deal with this */

Not sure if that comment is necessary here. It's fairly obvious why this
is an error. But it doesn't hurt, so if you prefer to leave it, that's
fine with me.

> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		int ictlr = (hwirq + i) / 32;

irq_hw_number_t? Or unsigned int?

> +
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &tegra_ictlr_chip,
> +					      &info->ictlr_reg_base[ictlr]);
> +	}
> +
> +	parent_args = *args;
> +	parent_args.np = domain->parent->of_node;
> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
> +}
> +
> +

There's an extra blank line here.

> +static void tegra_ictlr_domain_free(struct irq_domain *domain,
> +				    unsigned int virq,
> +				    unsigned int nr_irqs)
> +{
> +	int i;

unsigned int?

> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
> +		irq_domain_reset_irq_data(d);
> +	}
> +}

Aren't you missing a call to irq_domain_free_irqs_parent() here? If so,
why not use irq_domain_free_irqs_common() instead?

> +static struct irq_domain_ops tegra_ictlr_domain_ops = {

static const?

> +	.xlate	= tegra_ictlr_domain_xlate,
> +	.alloc	= tegra_ictlr_domain_alloc,
> +	.free	= tegra_ictlr_domain_free,
> +};
> +
> +static int __init tegra_ictlr_init(struct device_node *node,
> +				   struct device_node *parent)
> +{
> +	struct irq_domain *parent_domain, *domain;
> +	int err;
> +	int i;

unsigned int?

> +
> +	if (!parent) {
> +		pr_err("%s: no parent, giving up\n", node->full_name);
> +		return -ENODEV;
> +	}
> +
> +	parent_domain = irq_find_host(parent);
> +	if (!parent_domain) {
> +		pr_err("%s: unable to obtain parent domain\n", node->full_name);
> +		return -ENXIO;
> +	}
> +
> +	tegra_ictlr_info = kzalloc(sizeof(*tegra_ictlr_info), GFP_KERNEL);
> +	if (!tegra_ictlr_info)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < TEGRA_MAX_NUM_ICTLRS; i++) {
> +		void __iomem *base;
> +
> +		base = of_iomap(node, i);
> +		if (!base)
> +			break;
> +
> +		tegra_ictlr_info->ictlr_reg_base[i] = base;
> +
> +		/* Disable all interrupts */
> +		writel_relaxed(~0, base + ICTLR_CPU_IER_CLR);

I think you used ~0ul elsewhere, so maybe make this (or the other
instances) consistent?

> +		/* All interrupts target IRQ */
> +		writel_relaxed(0, base + ICTLR_CPU_IEP_CLASS);
> +
> +		num_ictlrs++;
> +	}
> +
> +	if (!num_ictlrs) {
> +		pr_err("%s: no valid regions, giving up\n", node->full_name);
> +		err = -ENOMEM;
> +		goto out_free;
> +	}

The local patch that I have does this slightly differently. We have a
tiny table of struct of_device_ids that contains the number of interrupt
controllers to expect for a given compatible (see also below). The code
then checks that the node indeed has valid reg entries for each of the
controllers. So this could be something like:

	struct tegra_ictlr_soc {
		unsigned int num_ictlrs;
	};

	static const struct tegra_ictlr_soc tegra20_ictlr_soc = {
		.num_ictlrs = 4,
	};

	static const struct tegra_ictlr_soc tegra30_ictlr_soc = {
		.num_ictlrs = 5,
	};

	static const struct of_device_id ictlr_matches[] = {
		{ .compatible = "nvidia,tegra30-ictlr", .data = &tegra30_ictlr_soc },
		{ .compatible = "nvidia,tegra20-ictlr", .data = &tegra20_ictlr_soc },
		{ }
	};

And in tegra_ictrl_init():

	const struct of_device_id *match;

	match = of_match_node(ictlr_matches, node);
	if (!match)
		return -ENODEV;

	soc = match->data;

	...

	WARN(num_ictlrs != soc->num_ictlrs,
	     "Found %u interrupt controllers in DT; expected %u.\n",
	     num_ictlrs, soc->num_ictlrs);

> +
> +	domain = irq_domain_add_hierarchy(parent_domain, 0, num_ictlrs * 32,
> +					  node, &tegra_ictlr_domain_ops,
> +					  tegra_ictlr_info);

Do we need to add a select IRQ_DOMAIN_HIERARCHY somewhere for this to
compile? I guess it's already implied by the select ARM_GIC from
ARCH_TEGRA, so maybe we don't have to be explicit.

> +	if (!domain) {
> +		pr_err("%s: failed to allocated domain\n", node->full_name);
> +		err = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	tegra_ictlr_syscore_init();
> +
> +	pr_info("%s: %d interrupts forwarded to %s\n",
> +		node->full_name, num_ictlrs * 32, parent->full_name);
> +
> +	return 0;
> +
> +out_unmap:
> +	for (i = 0; i < num_ictlrs; i++)
> +		iounmap(tegra_ictlr_info->ictlr_reg_base[i]);
> +out_free:
> +	kfree(tegra_ictlr_info);
> +	return err;
> +}
> +
> +IRQCHIP_DECLARE(tegra_ictlr, "nvidia,tegra-ictlr", tegra_ictlr_init);

In general we name compatible values after the first generation of the
SoC that introduced them. For the LIC this would be:

	compatible = "nvidia,tegra20-ictlr";
	
With Tegra30 the number of interrupt controllers was increased to 5, so
it needs a new compatible:

	compatible = "nvidia,tegra30-ictlr";

Subsequent generations remain compatible with this variant, but they
traditionally get their own compatible, so for Tegra114 we'd get:

	compatible = "nvidia,tegra114-ictlr", "nvidia,tegra30-ictlr";

And similar for Tegra124. So I think the IRQCHIP_DECLARE should match on
"nvidia,tegra20-ictlr" instead. For the same reason we should have a
second entry for the "nvidia,tegra30-ictlr" compatible.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/028f9853/attachment.sig>
