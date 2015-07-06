From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 6 Jul 2015 21:10:35 +0800
Subject: [PATCH v3 2/2] irqchip: dw-apb-ictl: add irq_set_affinity support
In-Reply-To: <alpine.DEB.2.11.1507061228060.3916@nanos>
References: <1436156141-3674-1-git-send-email-jszhang@marvell.com>
 <1436156141-3674-3-git-send-email-jszhang@marvell.com>
 <alpine.DEB.2.11.1507061228060.3916@nanos>
Message-ID: <20150706211035.6676916f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jul 2015 12:30:01 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 6 Jul 2015, Jisheng Zhang wrote:
> > +static int dw_apb_ictl_set_affinity(struct irq_data *d,
> > +				    const struct cpumask *mask_val,
> > +				    bool force)
> > +{
> > +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> > +	struct dw_apb_ictl_priv *priv = gc->private;
> > +	struct irq_chip *chip = irq_get_chip(priv->parent_irq);
> > +	struct irq_data *data = irq_get_irq_data(priv->parent_irq);
> > +
> > +	if (chip && chip->irq_set_affinity)
> > +		return chip->irq_set_affinity(data, mask_val, force);
> 
> This is wrong as it lacks proper locking of the parent irq. That needs
> to be solved at the core code level in a clean way.

Is it acceptable to call irq_set_affinity() or irq_force_affinity() as the
following:

if (force)
	return irq_force_affinity(priv->parent_irq, mask_val);
else
	return irq_set_affinity(priv->parent_irq, mask_val);

Thanks,
Jisheng
