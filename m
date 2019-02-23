Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D43C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:12:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEF5206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W37+CIov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEF5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QcAjnGw9/2Tu95jzZwu9Z8H7r0KupdmRiU44Lw9BmtM=; b=W37+CIovNmi/Mt
	kkYgMGNyIYRAvFECEixcNXYcm+RvGgHnY5f+VPHyeDBMYwJGoQqrztciPinexpnDDOrHiYdN6E8pO
	AD09sCOslvJWoFBkGb0LHQs8qtxKTIsZHKP5ltPWqFeVPqXMx/BhDxqwQ2cNmkc2oeFSTMSqJfNVJ
	4j1qNtPOkV7xE8HeSnhQv7u7fcJuU8OQo76vPBaAQ3Zs9NpNd4raflh7JgW1Deq5gJ7R0YO572Gg5
	aVb1/aYcnkfpZSz2L53N+FVsYoySzGtEaipfVajwFl4/tO6vzSjT+kgpPUAZvAVzcldb8GFHlXgid
	r1bHSHZNxl1kYmuG1CfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxW9w-0005De-L5; Sat, 23 Feb 2019 12:12:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxW9s-0005C5-2H
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 12:11:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB881A78;
 Sat, 23 Feb 2019 04:11:49 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EBE23F575;
 Sat, 23 Feb 2019 04:11:47 -0800 (PST)
Date: Sat, 23 Feb 2019 12:11:43 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 3/9] PCI: keystone: Convert to using hierarchy domain
 for legacy interrupts
Message-ID: <20190223121143.14c1f150@why.wild-wind.fr.eu.org>
In-Reply-To: <20190221162413.GA5815@e107981-ln.cambridge.arm.com>
References: <20190221101518.22604-1-kishon@ti.com>
 <20190221101518.22604-4-kishon@ti.com>
 <20190221162413.GA5815@e107981-ln.cambridge.arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_041156_124503_2CA5CBD6 
X-CRM114-Status: GOOD (  33.63  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 21 Feb 2019 16:24:14 +0000
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Thu, Feb 21, 2019 at 03:45:12PM +0530, Kishon Vijay Abraham I wrote:
> > K2G provides separate IRQ lines for each of the four legacy interrupts.
> > Model this using hierarchy domain instead of linear domain with chained
> > IRQ handler.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  drivers/pci/controller/dwc/pci-keystone.c | 205 +++++++++++++---------
> >  1 file changed, 118 insertions(+), 87 deletions(-)  
> 
> Hi Kishon,
> 
> I CC'ed Marc because you are actually re-writing an interrupt controller
> driver so I would be happier to merge this refactoring if Marc can have
> a look and he is satisfied with it - more so because most of the code can
> be reused by other host bridge drivers with similar behaviour.

Cheers Lorenzo.

It doesn't look too bad, but there is a couple of points I'd like to see
clarified. Comments below.

> 
> I will have a look too, unfortunately it is becoming a bit tight for
> v5.1 but let's see how it goes.
> 
> Thanks,
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 47f0dcf638f2..7f1648453f54 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -61,6 +61,7 @@
> >  
> >  #define IRQ_STATUS(n)			(0x184 + ((n) << 4))
> >  #define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
> > +#define IRQ_ENABLE_CLR(n)		(0x18C + ((n) << 4))
> >  #define INTx_EN				BIT(0)
> >  
> >  #define ERR_IRQ_STATUS			0x1c4
> > @@ -87,7 +88,6 @@ struct keystone_pcie {
> >  	struct dw_pcie		*pci;
> >  	/* PCI Device ID */
> >  	u32			device_id;
> > -	int			legacy_host_irqs[PCI_NUM_INTX];
> >  	struct			device_node *legacy_intc_np;
> >  
> >  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
> > @@ -96,7 +96,6 @@ struct keystone_pcie {
> >  	struct phy		**phy;
> >  	struct device_link	**link;
> >  	struct			device_node *msi_intc_np;
> > -	struct irq_domain	*legacy_irq_domain;
> >  	struct device_node	*np;
> >  
> >  	int error_irq;
> > @@ -199,26 +198,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
> >  	return dw_pcie_allocate_domains(pp);
> >  }
> >  
> > -static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
> > -				      int offset)
> > -{
> > -	struct dw_pcie *pci = ks_pcie->pci;
> > -	struct device *dev = pci->dev;
> > -	u32 pending;
> > -	int virq;
> > -
> > -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
> > -
> > -	if (BIT(0) & pending) {
> > -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> > -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> > -		generic_handle_irq(virq);
> > -	}
> > -
> > -	/* EOI the INTx interrupt */
> > -	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
> > -}
> > -
> >  static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
> >  {
> >  	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
> > @@ -256,39 +235,117 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -static void ks_pcie_ack_legacy_irq(struct irq_data *d)
> > +void ks_pcie_irq_eoi(struct irq_data *data)
> >  {
> > +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
> > +	irq_hw_number_t hwirq = data->hwirq;
> > +
> > +	ks_pcie_app_writel(ks_pcie, IRQ_EOI, hwirq);
> > +	irq_chip_eoi_parent(data);
> >  }
> >  
> > -static void ks_pcie_mask_legacy_irq(struct irq_data *d)
> > +void ks_pcie_irq_enable(struct irq_data *data)
> >  {
> > +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
> > +	irq_hw_number_t hwirq = data->hwirq;
> > +
> > +	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(hwirq), INTx_EN);
> > +	irq_chip_enable_parent(data);
> >  }
> >  
> > -static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
> > +void ks_pcie_irq_disable(struct irq_data *data)
> >  {
> > +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
> > +	irq_hw_number_t hwirq = data->hwirq;
> > +
> > +	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_CLR(hwirq), INTx_EN);
> > +	irq_chip_disable_parent(data);
> >  }
> >  
> >  static struct irq_chip ks_pcie_legacy_irq_chip = {
> > -	.name = "Keystone-PCI-Legacy-IRQ",
> > -	.irq_ack = ks_pcie_ack_legacy_irq,
> > -	.irq_mask = ks_pcie_mask_legacy_irq,
> > -	.irq_unmask = ks_pcie_unmask_legacy_irq,
> > +	.name			= "Keystone-PCI-Legacy-IRQ",
> > +	.irq_enable		= ks_pcie_irq_enable,
> > +	.irq_disable		= ks_pcie_irq_disable,
> > +	.irq_eoi		= ks_pcie_irq_eoi,
> > +	.irq_mask		= irq_chip_mask_parent,
> > +	.irq_unmask		= irq_chip_unmask_parent,
> > +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> > +	.irq_set_type		= irq_chip_set_type_parent,
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> >  };
> >  
> > -static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
> > -				       unsigned int irq,
> > -				       irq_hw_number_t hw_irq)
> > +static int ks_pcie_legacy_irq_domain_alloc(struct irq_domain *domain,
> > +					   unsigned int virq,
> > +					   unsigned int nr_irqs, void *data)
> >  {
> > -	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
> > -				 handle_level_irq);
> > -	irq_set_chip_data(irq, d->host_data);
> > +	struct keystone_pcie *ks_pcie = domain->host_data;
> > +	struct device_node *np = ks_pcie->legacy_intc_np;
> > +	struct irq_fwspec parent_fwspec, *fwspec = data;
> > +	struct of_phandle_args out_irq;
> > +	int ret, i;
> > +
> > +	if (nr_irqs != 1)
> > +		return -EINVAL;
> > +
> > +	ret = of_irq_parse_one(np, fwspec->param[0], &out_irq);
> > +	if (ret < 0) {
> > +		pr_err("Failed to parse interrupt node\n");
> > +		return ret;
> > +	}

What it this trying to do? Fishing out the interrupts from DT based on
the legacy pin? This looks at best obscure. I wonder why you don't do
that at probe time instead. Anyway, this requires documenting.

> > +
> > +	parent_fwspec.fwnode = &out_irq.np->fwnode;
> > +	parent_fwspec.param_count = out_irq.args_count;
> > +
> > +	for (i = 0; i < out_irq.args_count; i++)
> > +		parent_fwspec.param[i] = out_irq.args[i];

This feels like a duplicate of of_phandle_args_to_fwspec(). If you need
such a helper, please export it from the irqdomain code.

> > +
> > +	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
> > +	if (ret < 0) {
> > +		pr_err("Failed to allocate parent irq %u: %d\n",
> > +		       parent_fwspec.param[0], ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[0],
> > +					    &ks_pcie_legacy_irq_chip, ks_pcie);
> > +	if (ret < 0) {
> > +		pr_err("Failed to set hwirq and chip\n");
> > +		goto err_set_hwirq_and_chip;
> > +	}
> >  
> >  	return 0;
> > +
> > +err_set_hwirq_and_chip:
> > +	irq_domain_free_irqs_parent(domain, virq, 1);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ks_pcie_irq_domain_translate(struct irq_domain *domain,
> > +					struct irq_fwspec *fwspec,
> > +					unsigned long *hwirq,
> > +					unsigned int *type)
> > +{
> > +	if (is_of_node(fwspec->fwnode)) {

If you don't plan to support ACPI, you can drop this.

> > +		if (fwspec->param_count != 2)
> > +			return -EINVAL;

From the DT binding:

pcie_intc: Interrupt controller device node for Legacy IRQ chip
        interrupt-cells: should be set to 1

So why do we have 2 cells here?

> > +
> > +		if (fwspec->param[0] >= PCI_NUM_INTX)
> > +			return -EINVAL;

Most of the OF code assumes that the pin number describing the legacy
interrupt is 1-based, while you obviously treat it as 0-based. How does
it work?

> > +
> > +		*hwirq = fwspec->param[0];
> > +		*type = fwspec->param[1];

As far as I remember, PCI legacy interrupts are level triggered, so
there should be no need to advertise the trigger (which is consistent
with the way the binding is written).

> > +
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> >  }
> >  
> >  static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
> > -	.map = ks_pcie_init_legacy_irq_map,
> > -	.xlate = irq_domain_xlate_onetwocell,
> > +	.alloc		= ks_pcie_legacy_irq_domain_alloc,
> > +	.free		= irq_domain_free_irqs_common,
> > +	.translate	= ks_pcie_irq_domain_translate,
> >  };
> >  
> >  /**
> > @@ -572,35 +629,6 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
> >  	chained_irq_exit(chip, desc);
> >  }
> >  
> > -/**
> > - * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
> > - * @irq: IRQ line for legacy interrupts
> > - * @desc: Pointer to irq descriptor
> > - *
> > - * Traverse through pending legacy interrupts and invoke handler for each. Also
> > - * takes care of interrupt controller level mask/ack operation.
> > - */
> > -static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
> > -{
> > -	unsigned int irq = irq_desc_get_irq(desc);
> > -	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> > -	struct dw_pcie *pci = ks_pcie->pci;
> > -	struct device *dev = pci->dev;
> > -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> > -	struct irq_chip *chip = irq_desc_get_chip(desc);
> > -
> > -	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
> > -
> > -	/*
> > -	 * The chained irq handler installation would have replaced normal
> > -	 * interrupt driver handler so we need to take care of mask/unmask and
> > -	 * ack operation.
> > -	 */
> > -	chained_irq_enter(chip, desc);
> > -	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> > -	chained_irq_exit(chip, desc);
> > -}
> > -
> >  static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
> >  {
> >  	struct device *dev = ks_pcie->pci->dev;
> > @@ -655,14 +683,33 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
> >  	struct device *dev = ks_pcie->pci->dev;
> >  	struct irq_domain *legacy_irq_domain;
> >  	struct device_node *np = ks_pcie->np;
> > +	struct irq_domain *parent_domain;
> > +	struct device_node *parent_node;
> >  	struct device_node *intc_np;
> > -	int irq_count, irq, ret = 0, i;
> > +	int irq_count, ret = 0;
> >  
> >  	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
> >  	if (!intc_np) {
> >  		dev_warn(dev, "legacy-interrupt-controller node is absent\n");
> >  		return -EINVAL;
> >  	}
> > +	ks_pcie->legacy_intc_np = intc_np;
> > +
> > +	parent_node = of_irq_find_parent(intc_np);
> > +	if (!parent_node) {
> > +		dev_err(dev, "unable to obtain parent node\n");
> > +		ret = -ENXIO;
> > +		goto err;
> > +	}
> > +
> > +	parent_domain = irq_find_host(parent_node);
> > +	if (!parent_domain) {
> > +		dev_err(dev, "unable to obtain parent domain\n");
> > +		ret = -ENXIO;
> > +		goto err;
> > +	}
> > +
> > +	of_node_put(parent_node);
> >  
> >  	irq_count = of_irq_count(intc_np);
> >  	if (!irq_count) {
> > @@ -671,31 +718,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
> >  		goto err;
> >  	}
> >  
> > -	for (i = 0; i < irq_count; i++) {
> > -		irq = irq_of_parse_and_map(intc_np, i);
> > -		if (!irq) {
> > -			ret = -EINVAL;
> > -			goto err;
> > -		}
> > -		ks_pcie->legacy_host_irqs[i] = irq;
> > -
> > -		irq_set_chained_handler_and_data(irq,
> > -						 ks_pcie_legacy_irq_handler,
> > -						 ks_pcie);
> > -	}
> > -
> >  	legacy_irq_domain =
> > -		irq_domain_add_linear(intc_np, PCI_NUM_INTX,
> > -				      &ks_pcie_legacy_irq_domain_ops, NULL);
> > +		irq_domain_add_hierarchy(parent_domain, 0, PCI_NUM_INTX,
> > +					 intc_np,
> > +					 &ks_pcie_legacy_irq_domain_ops,
> > +					 ks_pcie);
> >  	if (!legacy_irq_domain) {
> >  		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
> >  		ret = -EINVAL;
> > -		goto err;
> >  	}
> > -	ks_pcie->legacy_irq_domain = legacy_irq_domain;
> > -
> > -	for (i = 0; i < PCI_NUM_INTX; i++)
> > -		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
> >  
> >  err:
> >  	of_node_put(intc_np);
> > -- 
> > 2.17.1
> >   

The structure of the code otherwise looks good. I trust you'd be able
to shed some light on the questions I have.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
