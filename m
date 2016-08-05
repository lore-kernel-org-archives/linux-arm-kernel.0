From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 5 Aug 2016 15:31:13 +0000
Subject: [PATCH 2/4] irqchip: irq-mvebu-pic: new driver for Marvell
 Armada 7K/8K PIC
In-Reply-To: <1470408921-447-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1470408921-447-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160805153113.GW4541@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Aug 05, 2016 at 04:55:19PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 7K/8K integrates a secondary interrupt controller
> very originally named "PIC". It is connected to the main GIC via a
> PPI. Amongst other things, this PIC is used for the ARM PMU.
> 
> This commit adds a simple irqchip driver for this interrupt
> controller. Since this interrupt controller is not needed early at boot
> time, we make the driver a proper platform driver rather than use the
> IRQCHIP_DECLARE() mechanism.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/irqchip/Kconfig         |   3 +
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-mvebu-pic.c | 195 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 drivers/irqchip/irq-mvebu-pic.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index fa33c50..a6f90c5 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -246,6 +246,9 @@ config MVEBU_ODMI
>  	bool
>  	select GENERIC_MSI_IRQ_DOMAIN
>  
> +config MVEBU_PIC
> +	bool

tri-state?  Is there anything else attached to the PIC besides the PMU?

> +
>  config LS_SCFG_MSI
>  	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
>  	depends on PCI && PCI_MSI
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 38853a1..024a78d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -67,5 +67,6 @@ obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
>  obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
>  obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
>  obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
> +obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
> diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
> new file mode 100644
> index 0000000..4a3aa7f
> --- /dev/null
> +++ b/drivers/irqchip/irq-mvebu-pic.c
> @@ -0,0 +1,195 @@
> +/*
> + * Copyright (C) 2016 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +
> +#define PIC_CAUSE	       0x0
> +#define PIC_MASK	       0x4
> +
> +#define PIC_MAX_IRQS		32
> +#define PIC_MAX_IRQ_MASK	((1UL << PIC_MAX_IRQS) - 1)
> +
> +struct mvebu_pic {
> +	void __iomem *base;
> +	u32 parent_irq;
> +	struct irq_domain *domain;
> +	struct irq_chip irq_chip;
> +};
> +
> +static void mvebu_pic_reset(struct mvebu_pic *pic)
> +{
> +	/* ACK and mask all interrupts */
> +	writel(0, pic->base + PIC_MASK);
> +	writel(PIC_MAX_IRQ_MASK, pic->base + PIC_CAUSE);
> +}
> +
> +static void mvebu_pic_eoi_irq(struct irq_data *d)
> +{
> +	struct mvebu_pic *pic = irq_data_get_irq_chip_data(d);
> +
> +	writel(1 << d->hwirq, pic->base + PIC_CAUSE);
> +}
> +
> +static void mvebu_pic_mask_irq(struct irq_data *d)
> +{
> +	struct mvebu_pic *pic = irq_data_get_irq_chip_data(d);
> +	u32 reg;
> +
> +	reg =  readl(pic->base + PIC_MASK);
> +	reg |= (1 << d->hwirq);
> +	writel(reg, pic->base + PIC_MASK);
> +}
> +
> +static void mvebu_pic_unmask_irq(struct irq_data *d)
> +{
> +	struct mvebu_pic *pic = irq_data_get_irq_chip_data(d);
> +	u32 reg;
> +
> +	reg = readl(pic->base + PIC_MASK);
> +	reg &= ~(1 << d->hwirq);
> +	writel(reg, pic->base + PIC_MASK);
> +}
> +
> +static int mvebu_pic_irq_map(struct irq_domain *domain, unsigned int virq,
> +			     irq_hw_number_t hwirq)
> +{
> +	struct mvebu_pic *pic = domain->host_data;
> +
> +	irq_set_percpu_devid(virq);
> +	irq_set_chip_data(virq, pic);
> +	irq_set_chip_and_handler(virq, &pic->irq_chip,
> +				 handle_percpu_devid_irq);
> +	irq_set_status_flags(virq, IRQ_LEVEL);
> +	irq_set_probe(virq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops mvebu_pic_domain_ops = {
> +	.map = mvebu_pic_irq_map,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +static void mvebu_pic_handle_cascade_irq(struct irq_desc *desc)
> +{
> +	struct mvebu_pic *pic = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long irqmap, irqn;
> +	unsigned int cascade_irq;
> +
> +	irqmap = readl_relaxed(pic->base + PIC_CAUSE);
> +	chained_irq_enter(chip, desc);
> +
> +	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG) {
> +		cascade_irq = irq_find_mapping(pic->domain, irqn);
> +		generic_handle_irq(cascade_irq);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void mvebu_pic_enable_percpu_irq(void *data)
> +{
> +	struct mvebu_pic *pic = data;
> +
> +	mvebu_pic_reset(pic);
> +	enable_percpu_irq(pic->parent_irq, IRQ_TYPE_NONE);
> +}
> +
> +static void mvebu_pic_disable_percpu_irq(void *data)
> +{
> +	struct mvebu_pic *pic = data;
> +
> +	disable_percpu_irq(pic->parent_irq);
> +}
> +
> +static int mvebu_pic_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct mvebu_pic *pic;
> +	struct irq_chip *irq_chip;
> +	struct resource *res;
> +
> +	pic = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pic), GFP_KERNEL);
> +	if (!pic)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pic->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pic->base))
> +		return PTR_ERR(pic->base);
> +
> +	irq_chip = &pic->irq_chip;
> +	irq_chip->name = dev_name(&pdev->dev);
> +	irq_chip->irq_mask = mvebu_pic_mask_irq;
> +	irq_chip->irq_unmask = mvebu_pic_unmask_irq;
> +	irq_chip->irq_eoi = mvebu_pic_eoi_irq;
> +
> +	pic->parent_irq = irq_of_parse_and_map(node, 0);
> +	if (pic->parent_irq <= 0) {
> +		dev_err(&pdev->dev, "Failed to parse parent interrupt\n");
> +		return -EINVAL;
> +	}
> +
> +	pic->domain = irq_domain_add_linear(node, PIC_MAX_IRQS,
> +					    &mvebu_pic_domain_ops, pic);
> +	if (!pic->domain) {
> +		dev_err(&pdev->dev, "Failed to allocate irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler(pic->parent_irq, mvebu_pic_handle_cascade_irq);
> +	irq_set_handler_data(pic->parent_irq, pic);
> +
> +	on_each_cpu(mvebu_pic_enable_percpu_irq, pic, 1);
> +
> +	platform_set_drvdata(pdev, pic);
> +
> +	return 0;
> +}
> +
> +static int mvebu_pic_remove(struct platform_device *pdev)
> +{
> +	struct mvebu_pic *pic = platform_get_drvdata(pdev);
> +
> +	on_each_cpu(mvebu_pic_disable_percpu_irq, pic, 1);
> +	irq_domain_remove(pic->domain);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mvebu_pic_of_match[] = {
> +	{ .compatible = "marvell,armada-8k-pic", },

You mention 7k in $subject, should you use that here as the youngest
compatible SoC generation?

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mvebu_pic_of_match);
> +
> +static struct platform_driver mvebu_pic_driver = {
> +	.probe  = mvebu_pic_probe,
> +	.remove = mvebu_pic_remove,
> +	.driver = {
> +		.name = "mvebu-pic",
> +		.of_match_table = mvebu_pic_of_match,
> +	},
> +};
> +module_platform_driver(mvebu_pic_driver);
> +
> +MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:mvebu_pic");

thx,

Jason.
