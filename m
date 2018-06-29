From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 29 Jun 2018 14:32:11 +0200
Subject: [PATCH v3 07/17] irqchip/irq-mvebu-icu: make irq_domain local
In-Reply-To: <2f751e0a-857e-22ab-1748-5fd1cb127766@arm.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-8-miquel.raynal@bootlin.com>
 <2f751e0a-857e-22ab-1748-5fd1cb127766@arm.com>
Message-ID: <20180629143211.4b4f827a@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Zyngier <marc.zyngier@arm.com> wrote on Thu, 28 Jun 2018 13:10:05
+0100:

> On 22/06/18 16:14, Miquel Raynal wrote:
> > Make the current MSI irq_domain local to ease the split between ICU
> > platform device code and NSR platform device code.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > ---
> >  drivers/irqchip/irq-mvebu-icu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> > index 3694c0d73c0d..607948870a14 100644
> > --- a/drivers/irqchip/irq-mvebu-icu.c
> > +++ b/drivers/irqchip/irq-mvebu-icu.c
> > @@ -41,7 +41,6 @@
> >  struct mvebu_icu {
> >  	struct irq_chip irq_chip;
> >  	struct regmap *regmap;
> > -	struct irq_domain *domain;
> >  	struct device *dev;
> >  	atomic_t initialized;
> >  };
> > @@ -218,6 +217,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
> >  	struct mvebu_icu *icu;
> >  	struct device_node *node = pdev->dev.of_node;
> >  	struct device_node *gicp_dn;
> > +	struct irq_domain *irq_domain;
> >  	struct resource *res;
> >  	void __iomem *regs;
> >  	int i;
> > @@ -282,11 +282,11 @@ static int mvebu_icu_probe(struct platform_device *pdev)
> >  			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
> >  	}
> >  
> > -	icu->domain =
> > +	irq_domain =
> >  		platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
> >  						  mvebu_icu_write_msg,
> >  						  &mvebu_icu_domain_ops, icu);  
> 
> nit: this really hurts my eyes. Please put the = sign and the function
> call on a single line. I really don't care if it checkpatch is having a
> fit because of that.

I also dislike. Will change.

> 
> > -	if (!icu->domain) {
> > +	if (!irq_domain) {
> >  		dev_err(&pdev->dev, "Failed to create ICU domain\n");
> >  		return -ENOMEM;
> >  	}
> >   
> 
> But looking at the next patch, you might as well fold the two. On its
> own, this patches is pretty pointless.

Most often people ask to split logical changes as much as possible. But
I have no problem squashing these two patches.


Thanks,
Miqu?l
