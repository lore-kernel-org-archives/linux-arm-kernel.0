From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Jun 2017 15:30:42 +0200
Subject: [PATCH v4 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <8c085bb8-9bfa-90f7-1dd1-f4f5eb852402@arm.com>
References: <20170620140722.31646-1-thomas.petazzoni@free-electrons.com>
 <20170620140722.31646-5-thomas.petazzoni@free-electrons.com>
 <8c085bb8-9bfa-90f7-1dd1-f4f5eb852402@arm.com>
Message-ID: <20170621153042.05237000@windsurf.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 21 Jun 2017 08:56:24 +0100, Marc Zyngier wrote:

> > +static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> > +{
> > +	struct irq_data *d = irq_get_irq_data(desc->irq);
> > +	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
> > +	struct mvebu_icu *icu = icu_irqd->icu;
> > +	unsigned int icu_int;
> > +
> > +	if (msg->address_lo) {  
> 
> As mention in the previous thread, this needs to check address_hi as well.

Fixed in v5.

> > +	gicp_dn = of_parse_phandle(node, "msi-parent", 0);
> > +	if (!gicp_dn) {
> > +		dev_err(&pdev->dev, "Missing marvell,gicp property.\n");  
> 
> The property name doesn't match here. But overall, there is little point
> in reparsing the msi-parent, since that's what of_msi_get_domain does.
> Instead, consider using:
> 
> 	gicp_dn = irq_domain_get_of_node(pdev->dev.msi_domain);
> 
> which will do the right thing.

Fixed in v5.


> With the two minor changes above, and for patch #3 as well:
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks! Tags added in v5.

> I can either perform the changes when applying the patches, or let you
> do it so that you can test it first (and solve the issue with the DT
> include fine with Gregory).

I've sent a v5 that fixes the different issues you pointed out, and
also fixes the DT include problem. Tested on HW, it still works as
expected.

Thanks again for the review!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
