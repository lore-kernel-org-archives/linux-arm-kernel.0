From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 21 Aug 2018 11:08:25 +0200
Subject: [PATCH v4 09/14] irqchip/irq-mvebu-icu: add support for System
 Error Interrupts (SEI)
In-Reply-To: <a88f62c0-7d7c-71da-fa45-487f7573dbb1@arm.com>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
 <20180705124011.7661-10-miquel.raynal@bootlin.com>
 <a88f62c0-7d7c-71da-fa45-487f7573dbb1@arm.com>
Message-ID: <20180821110825.2fbec982@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I'm fine with the rest of the comments, please find just one last
question below.

[...]

> > @@ -133,12 +164,36 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
> >  		return -EINVAL;
> >  	}
> >  
> > -	/* Mask the type to prevent wrong DT configuration */
> > -	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> > +	/*
> > +	 * The ICU receives level-interrupts. MSI SEI are
> > +	 * edge-interrupts while MSI NSR are level-interrupts. Update the type
> > +	 * accordingly for the parent irqchip.
> > +	 */
> > +	if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
> > +		*type = IRQ_TYPE_EDGE_RISING;  
> 
> That's interesting. How is the resampling done here?

I'm not sure to understand the question. What does 'resampling' means
in such context? MSI SEIs are of type "edge" and use the traditional
MSI signalling infrastructure. I'm asking to be sure not to ignore
something wrong in my code.

> 
> >  
> >  	return 0;
> >  }

Thanks,
Miqu?l
