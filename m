From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Jul 2015 08:58:56 +0200
Subject: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
In-Reply-To: <20150710060350.GA3127@piout.net>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150710060350.GA3127@piout.net>
Message-ID: <20150710065856.GZ28632@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 08:03:50AM +0200, Alexandre Belloni wrote:
> >  static const struct of_device_id at91_reset_of_match[] = {
> >  	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
> >  	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
> > +	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
> >  	{ /* sentinel */ }
> >  };
> >  
> > @@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform_device *pdev)
> >  		return -ENODEV;
> >  	}
> >  
> > -	for_each_matching_node(np, at91_ramc_of_match) {
> > -		at91_ramc_base[idx] = of_iomap(np, 0);
> > -		if (!at91_ramc_base[idx]) {
> > -			dev_err(&pdev->dev, "Could not map ram controller address\n");
> > -			return -ENODEV;
> > +	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
> > +	at91_restart_nb.notifier_call = match->data;
> > +
> > +	if (match->data != sama5d3_restart) {
> 
> This doesn't scale well. I would create a structure with a pointer to
> the restart function and a boolean or a bitfield to store whether the
> workaround is needed. Use that structure in your match data. Then, you
> won't need to reorder anything.

Maybe it simply doesn't need to scale (yet).

You have a single exception here. Maybe you will have only this one in
the future, maybe you won't, but for now, that solution looks a bit
overkill.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150710/b2174e07/attachment.sig>
