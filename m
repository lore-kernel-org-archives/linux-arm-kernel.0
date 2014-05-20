From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 20 May 2014 15:17:00 +0900
Subject: [RFC PATCH] of/irq: do irq resolution in platform_get_irq_byname()
In-Reply-To: <20140519125738.GB9466@ulmo>
References: <1400506259-18397-1-git-send-email-grygorii.strashko@ti.com>
 <20140519125738.GB9466@ulmo>
Message-ID: <20140520061700.ED542C41087@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 May 2014 14:57:39 +0200, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, May 19, 2014 at 04:30:59PM +0300, Grygorii Strashko wrote:
> [...]
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> [...]
> >  /**
> > + * of_irq_get_byname - Decode a node's IRQ and return it as a Linux irq number
> > + * @dev: pointer to device tree node
> > + * @name: zero-based index of the irq
> 
> This is a name, not an index.
> 
> > + *
> > + * Returns Linux irq number on success, or -EPROBE_DEFER if the irq domain
> > + * is not yet created, or errorno in case of failure.
> 
> s/errorno/error code/? Also EPROBE_DEFER is also an error code, so I'm
> not sure if it's worth a special case in the description here.
> 
> > + *
> > + */
> > +int of_irq_get_byname(struct device_node *dev, const char *name)
> > +{
> > +	const char *name_irq = NULL;
> > +	int index = 0;
> > +
> > +	if (unlikely(!name))
> > +		return -EINVAL;
> > +
> > +	while (!of_property_read_string_index(dev, "interrupt-names",
> > +					      index, &name_irq))
> > +		if (!strcmp(name, name_irq))
> > +			return of_irq_get(dev, index);
> 
> Isn't this missing an index++ somewhere? Otherwise it seems like this
> would loop infinitely if there was no match on the first entry.

Better yet, use of_property_match_string().

g.

> 
> Thierry
