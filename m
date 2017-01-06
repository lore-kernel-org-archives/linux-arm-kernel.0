From: minghuan.lian@nxp.com (M.H. Lian)
Date: Fri, 6 Jan 2017 01:45:20 +0000
Subject: [PATCH v2,7/9] irqchip/ls-scfg-msi: add LS1046a MSI support
In-Reply-To: <7cd3cc33-741a-6ab1-6444-17a626991d33@arm.com>
References: <1483603837-4629-1-git-send-email-Minghuan.Lian@nxp.com>
 <1483603837-4629-7-git-send-email-Minghuan.Lian@nxp.com>
 <7cd3cc33-741a-6ab1-6444-17a626991d33@arm.com>
Message-ID: <VI1PR04MB1615D724A4E6029EE8F2B7FAE8630@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thanks for your review.
Please see my comments inline.

Thanks,
Minghuan

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Thursday, January 05, 2017 11:19 PM
> To: M.H. Lian <minghuan.lian@nxp.com>; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>; Jason Cooper
> <jason@lakedaemon.net>; Roy Zang <roy.zang@nxp.com>; Mingkai Hu
> <mingkai.hu@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Leo Li
> <leoyang.li@nxp.com>; Scott Wood <scott.wood@nxp.com>
> Subject: Re: [PATCH v2,7/9] irqchip/ls-scfg-msi: add LS1046a MSI support
> 
> On 05/01/17 08:10, Minghuan Lian wrote:
> > LS1046a includes 4 MSIRs, each MSIR is assigned a dedicate GIC SPI
> > interrupt and provides 32 MSI interrupts. Compared to previous MSI,
> > LS1046a's IBS(interrupt bit select) shift is changed to 2 and total
> > MSI interrupt number is changed to 128.
> >
> > The patch adds structure 'ls_scfg_msir' to describe MSIR setting and
> > 'ibs_shift' to store the different value between the SoCs.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > ---
> > v2-v1:
> > - MSI dts node change has been merged into the patch 6/9
> >
> >  drivers/irqchip/irq-ls-scfg-msi.c | 161
> > +++++++++++++++++++++++++++++---------
> >  1 file changed, 126 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-ls-scfg-msi.c
> > b/drivers/irqchip/irq-ls-scfg-msi.c
> > index cef67cc..67547bd 100644
> > --- a/drivers/irqchip/irq-ls-scfg-msi.c
> > +++ b/drivers/irqchip/irq-ls-scfg-msi.c
> > @@ -17,13 +17,24 @@
> >  #include <linux/irq.h>
> >  #include <linux/irqchip/chained_irq.h>  #include <linux/irqdomain.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/spinlock.h>
> >
> > -#define MSI_MAX_IRQS	32
> > -#define MSI_IBS_SHIFT	3
> > -#define MSIR		4
> > +#define MSI_IRQS_PER_MSIR	32
> > +#define MSI_MSIR_OFFSET		4
> > +
> > +struct ls_scfg_msi_cfg {
> > +	u32 ibs_shift; /* Shift of interrupt bit select */ };
> > +
> > +struct ls_scfg_msir {
> > +	struct ls_scfg_msi *msi_data;
> > +	unsigned int index;
> > +	unsigned int gic_irq;
> > +	void __iomem *reg;
> > +};
> >
> >  struct ls_scfg_msi {
> >  	spinlock_t		lock;
> > @@ -32,8 +43,11 @@ struct ls_scfg_msi {
> >  	struct irq_domain	*msi_domain;
> >  	void __iomem		*regs;
> >  	phys_addr_t		msiir_addr;
> > -	int			irq;
> > -	DECLARE_BITMAP(used, MSI_MAX_IRQS);
> > +	struct ls_scfg_msi_cfg	*cfg;
> > +	u32			msir_num;
> > +	struct ls_scfg_msir	*msir;
> > +	u32			irqs_num;
> > +	unsigned long		*used;
> >  };
> >
> >  static struct irq_chip ls_scfg_msi_irq_chip = { @@ -55,7 +69,7 @@
> > static void ls_scfg_msi_compose_msg(struct irq_data *data, struct
> > msi_msg *msg)
> >
> >  	msg->address_hi = upper_32_bits(msi_data->msiir_addr);
> >  	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
> > -	msg->data = data->hwirq << MSI_IBS_SHIFT;
> > +	msg->data = data->hwirq;
> >  }
> >
> >  static int ls_scfg_msi_set_affinity(struct irq_data *irq_data, @@
> > -81,8 +95,8 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain
> *domain,
> >  	WARN_ON(nr_irqs != 1);
> >
> >  	spin_lock(&msi_data->lock);
> > -	pos = find_first_zero_bit(msi_data->used, MSI_MAX_IRQS);
> > -	if (pos < MSI_MAX_IRQS)
> > +	pos = find_first_zero_bit(msi_data->used, msi_data->irqs_num);
> > +	if (pos < msi_data->irqs_num)
> >  		__set_bit(pos, msi_data->used);
> >  	else
> >  		err = -ENOSPC;
> > @@ -106,7 +120,7 @@ static void ls_scfg_msi_domain_irq_free(struct
> irq_domain *domain,
> >  	int pos;
> >
> >  	pos = d->hwirq;
> > -	if (pos < 0 || pos >= MSI_MAX_IRQS) {
> > +	if (pos < 0 || pos >= msi_data->irqs_num) {
> >  		pr_err("failed to teardown msi. Invalid hwirq %d\n", pos);
> >  		return;
> >  	}
> > @@ -123,15 +137,17 @@ static void ls_scfg_msi_domain_irq_free(struct
> > irq_domain *domain,
> >
> >  static void ls_scfg_msi_irq_handler(struct irq_desc *desc)  {
> > -	struct ls_scfg_msi *msi_data = irq_desc_get_handler_data(desc);
> > +	struct ls_scfg_msir *msir = irq_desc_get_handler_data(desc);
> > +	struct ls_scfg_msi *msi_data = msir->msi_data;
> >  	unsigned long val;
> > -	int pos, virq;
> > +	int pos, virq, hwirq;
> >
> >  	chained_irq_enter(irq_desc_get_chip(desc), desc);
> >
> > -	val = ioread32be(msi_data->regs + MSIR);
> > -	for_each_set_bit(pos, &val, MSI_MAX_IRQS) {
> > -		virq = irq_find_mapping(msi_data->parent, (31 - pos));
> > +	val = ioread32be(msir->reg);
> > +	for_each_set_bit(pos, &val, MSI_IRQS_PER_MSIR) {
> > +		hwirq = ((31 - pos) << msi_data->cfg->ibs_shift) | msir-
> >index;
> > +		virq = irq_find_mapping(msi_data->parent, hwirq);
> >  		if (virq)
> >  			generic_handle_irq(virq);
> >  	}
> > @@ -143,7 +159,7 @@ static int ls_scfg_msi_domains_init(struct
> > ls_scfg_msi *msi_data)  {
> >  	/* Initialize MSI domain parent */
> >  	msi_data->parent = irq_domain_add_linear(NULL,
> > -						 MSI_MAX_IRQS,
> > +						 msi_data->irqs_num,
> >  						 &ls_scfg_msi_domain_ops,
> >  						 msi_data);
> >  	if (!msi_data->parent) {
> > @@ -164,16 +180,83 @@ static int ls_scfg_msi_domains_init(struct
> ls_scfg_msi *msi_data)
> >  	return 0;
> >  }
> >
> > +static int ls_scfg_msi_setup_hwirq(struct ls_scfg_msi *msi_data, int
> > +index) {
> > +	struct ls_scfg_msir *msir;
> > +	int virq, i, hwirq;
> > +
> > +	virq = platform_get_irq(msi_data->pdev, index);
> > +	if (virq <= 0)
> > +		return -ENODEV;
> > +
> > +	msir = &msi_data->msir[index];
> > +	msir->index = index;
> > +	msir->msi_data = msi_data;
> > +	msir->gic_irq = virq;
> > +	msir->reg = msi_data->regs + MSI_MSIR_OFFSET + 4 * index;
> > +
> > +	irq_set_chained_handler_and_data(msir->gic_irq,
> > +					 ls_scfg_msi_irq_handler,
> > +					 msir);
> > +
> > +	/* Release the hwirqs corresponding to this MSIR */
> > +	for (i = 0; i < MSI_IRQS_PER_MSIR; i++) {
> > +		hwirq = i << msi_data->cfg->ibs_shift | msir->index;
> > +		bitmap_clear(msi_data->used, hwirq, 1);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ls_scfg_msi_teardown_hwirq(struct ls_scfg_msir *msir) {
> > +	struct ls_scfg_msi *msi_data = msir->msi_data;
> > +	int i, hwirq;
> > +
> > +	if (msir->gic_irq > 0)
> > +		irq_set_chained_handler_and_data(msir->gic_irq, NULL,
> NULL);
> > +
> > +	for (i = 0; i < MSI_IRQS_PER_MSIR; i++) {
> > +		hwirq = i << msi_data->cfg->ibs_shift | msir->index;
> > +		bitmap_set(msi_data->used, hwirq, 1);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct ls_scfg_msi_cfg ls1021_msi_cfg = {
> > +	.ibs_shift = 3,
> > +};
> > +
> > +static struct ls_scfg_msi_cfg ls1046_msi_cfg = {
> > +	.ibs_shift = 2,
> > +};
> > +
> > +static const struct of_device_id ls_scfg_msi_id[] = {
> > +	{ .compatible = "fsl,ls1021a-msi", .data = &ls1021_msi_cfg },
> > +	{ .compatible = "fsl,ls1043a-msi", .data = &ls1021_msi_cfg },
> > +	{ .compatible = "fsl,ls1046a-msi", .data = &ls1046_msi_cfg },
> 
> So after 3 patches adding compatibility between the fsl,1s10 and
> fsl,ls10 names, you discard them? How does it work again with the old DTs?
> 
[Minghuan Lian]  ok, I will store the old compatible.
This typo makes me very uncomfortable  :(

> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, ls_scfg_msi_id);
> > +
> >  static int ls_scfg_msi_probe(struct platform_device *pdev)  {
> > +	const struct of_device_id *match;
> >  	struct ls_scfg_msi *msi_data;
> >  	struct resource *res;
> > -	int ret;
> > +	int i, ret;
> > +
> > +	match = of_match_device(ls_scfg_msi_id, &pdev->dev);
> > +	if (!match)
> > +		return -ENODEV;
> >
> >  	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data),
> GFP_KERNEL);
> >  	if (!msi_data)
> >  		return -ENOMEM;
> >
> > +	msi_data->cfg = (struct ls_scfg_msi_cfg *) match->data;
> > +
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	msi_data->regs = devm_ioremap_resource(&pdev->dev, res);
> >  	if (IS_ERR(msi_data->regs)) {
> > @@ -182,23 +265,37 @@ static int ls_scfg_msi_probe(struct
> platform_device *pdev)
> >  	}
> >  	msi_data->msiir_addr = res->start;
> >
> > -	msi_data->irq = platform_get_irq(pdev, 0);
> > -	if (msi_data->irq <= 0) {
> > -		dev_err(&pdev->dev, "failed to get MSI irq\n");
> > -		return -ENODEV;
> > -	}
> > -
> >  	msi_data->pdev = pdev;
> >  	spin_lock_init(&msi_data->lock);
> >
> > +	msi_data->irqs_num = MSI_IRQS_PER_MSIR *
> > +			     (1 << msi_data->cfg->ibs_shift);
> > +	msi_data->used = devm_kcalloc(&pdev->dev,
> > +				    BITS_TO_LONGS(msi_data->irqs_num),
> > +				    sizeof(*msi_data->used),
> > +				    GFP_KERNEL);
> > +	if (!msi_data->used)
> > +		return -ENOMEM;
> > +	/*
> > +	 * Reserve all the hwirqs
> > +	 * The available hwirqs will be released in ls1_msi_setup_hwirq()
> > +	 */
> > +	bitmap_set(msi_data->used, 0, msi_data->irqs_num);
> > +
> > +	msi_data->msir_num = of_irq_count(pdev->dev.of_node);
> > +	msi_data->msir = devm_kcalloc(&pdev->dev, msi_data->msir_num,
> > +				      sizeof(*msi_data->msir),
> > +				      GFP_KERNEL);
> > +	if (!msi_data->msir)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < msi_data->msir_num; i++)
> > +		ls_scfg_msi_setup_hwirq(msi_data, i);
> > +
> >  	ret = ls_scfg_msi_domains_init(msi_data);
> >  	if (ret)
> >  		return ret;
> >
> > -	irq_set_chained_handler_and_data(msi_data->irq,
> > -					 ls_scfg_msi_irq_handler,
> > -					 msi_data);
> > -
> >  	platform_set_drvdata(pdev, msi_data);
> >
> >  	return 0;
> > @@ -207,8 +304,10 @@ static int ls_scfg_msi_probe(struct
> > platform_device *pdev)  static int ls_scfg_msi_remove(struct
> > platform_device *pdev)  {
> >  	struct ls_scfg_msi *msi_data = platform_get_drvdata(pdev);
> > +	int i;
> >
> > -	irq_set_chained_handler_and_data(msi_data->irq, NULL, NULL);
> > +	for (i = 0; i < msi_data->msir_num; i++)
> > +		ls_scfg_msi_teardown_hwirq(&msi_data->msir[i]);
> >
> >  	irq_domain_remove(msi_data->msi_domain);
> >  	irq_domain_remove(msi_data->parent);
> > @@ -218,14 +317,6 @@ static int ls_scfg_msi_remove(struct
> platform_device *pdev)
> >  	return 0;
> >  }
> >
> > -static const struct of_device_id ls_scfg_msi_id[] = {
> > -	{ .compatible = "fsl,1s1021a-msi", }, /* a typo */
> > -	{ .compatible = "fsl,1s1043a-msi", }, /* a typo */
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ^
> these entries definitely need to be restored.
> 
> Also, please make sure you have a cover letter at the beginning of the series.
> I flag series to review by flagging the cover letter, and I suspect many of us
> are doing something similar. Not doing so is likely to leave your series
> unreviewed...
[Minghuan Lian]  I see. I will add cover letter for this series. And I will
do this for all series of patches.

> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
