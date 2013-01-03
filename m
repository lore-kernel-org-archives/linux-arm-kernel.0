From: joe@perches.com (Joe Perches)
Date: Wed, 02 Jan 2013 23:45:14 -0800
Subject: [PATCH 1/2] timer: vt8500: Move system timer to clocksource
In-Reply-To: <20130103073540.GB11309@core.coreip.homeip.net>
References: <1357183510-8476-1-git-send-email-linux@prisktech.co.nz>
 <1357183510-8476-2-git-send-email-linux@prisktech.co.nz>
 <20130103073540.GB11309@core.coreip.homeip.net>
Message-ID: <1357199114.25181.48.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-02 at 23:35 -0800, Dmitry Torokhov wrote:
> On Thu, Jan 03, 2013 at 04:25:09PM +1300, Tony Prisk wrote:
> > +static void __init vt8500_timer_init(void)
> > +{
> > +	struct device_node *np;
> > +	int timer_irq;
> > +
> > +	np = of_find_matching_node(NULL, vt8500_timer_ids);
> > +	if (!np) {
> > +		pr_err("%s: Timer description missing from Device Tree\n",
> > +								__func__);
> > +		return;
> > +	}
> > +	regbase = of_iomap(np, 0);
> > +	if (!regbase) {
> > +		pr_err("%s: Missing iobase description in Device Tree\n",
> > +								__func__);
> > +		of_node_put(np);
> > +		return;
> > +	}
> > +	timer_irq = irq_of_parse_and_map(np, 0);
> > +	if (!timer_irq) {
> > +		pr_err("%s: Missing irq description in Device Tree\n",
> > +								__func__);
> > +		of_node_put(np);
> > +		return;
> 
> You are forgetting to unmap the regbase here.

Also I think it'd be nicer to write something like:

	struct device_node *np;
	int timer_irq;
	const char *reason;

	np = of_find_matching_node(NULL, vt8500_timer_ids);
	if (!np) {
		reason = "timer";
	    goto error;
	}
	regbase = of_iomap(np, 0);
	if (!regbase) {
		reason = "iobase";
		goto error_put;
	}
	timer_irq = irq_of_parse_and_map(np, 0);
	if (!timer_irq) {
		reason = "irq";
		goto error_remap;
	}
 
	...

error_remap:
	unmap...;
error_put:
	of_node_put(np);
error:
	pr_err("%s: Missing %s description in Device Tree\n",
	       __func__, reason);
	return;
