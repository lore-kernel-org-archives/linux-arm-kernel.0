From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 2 Oct 2018 10:13:41 +0200
Subject: [PATCH v6 06/14] irqchip/irq-mvebu-icu: support ICU subnodes
In-Reply-To: <86k1n1vcgb.wl-marc.zyngier@arm.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
 <20181001141358.31508-7-miquel.raynal@bootlin.com>
 <86k1n1vcgb.wl-marc.zyngier@arm.com>
Message-ID: <20181002101341.1d3442dd@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> wrote on Mon, 01 Oct 2018 17:49:56
+0100:

> On Mon, 01 Oct 2018 15:13:50 +0100,
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > 
> > The ICU can handle several type of interrupt, each of them being handled
> > differently on AP side. On CP side, the ICU should be able to make the
> > distinction between each interrupt group by pointing to the right parent.
> > 
> > This is done through the introduction of new bindings, presenting the ICU
> > node as the parent of multiple ICU sub-nodes, each of them being an
> > interrupt type with a different interrupt parent. ICU interrupt 'clients'
> > now directly point to the right sub-node, avoiding the need for the extra
> > ICU_GRP_* parameter.
> > 
> > ICU subnodes are probed automatically with devm_platform_populate(). If
> > the node as no child, the probe function for NSRs will still be called
> > 'manually' in order to preserve backward compatibility with DT using the
> > old binding.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/irqchip/irq-mvebu-icu.c | 77 ++++++++++++++++++++++++++-------
> >  1 file changed, 61 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> > index d09f220a2701..c79d2cb787a0 100644
> > --- a/drivers/irqchip/irq-mvebu-icu.c
> > +++ b/drivers/irqchip/irq-mvebu-icu.c  
> 
> [...]
> 
> > +static const struct of_device_id mvebu_icu_subset_of_match[] = {
> > +	{
> > +		.compatible = "marvell,cp110-icu-nsr",
> > +	},
> > +	{},
> > +};
> > +
> >  static int mvebu_icu_subset_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *msi_parent_dn;
> > @@ -210,7 +224,14 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
> >  	struct irq_domain *irq_domain;
> >  	struct mvebu_icu *icu;
> >  
> > -	icu = dev_get_drvdata(dev);
> > +	/*
> > +	 * Device data being populated means we are using the legacy bindings.
> > +	 * Using the parent device data means we are using the new bindings.
> > +	 */
> > +	if (dev_get_drvdata(dev))
> > +		icu = dev_get_drvdata(dev);
> > +	else
> > +		icu = dev_get_drvdata(dev->parent);  
> 
> We now have a static key to determine which binding to use, and we
> should certainly have set it correctly by the time we start end up
> here. Why aren't you using it?
> 

Sure, this condition now is checking the static key.

Thanks,
Miqu?l
