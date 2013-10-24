From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Oct 2013 06:19:36 -0700
Subject: [PATCH v2] serial: omap: Add support for optional wake-up
In-Reply-To: <20131024103300.6023FC4039D@trevor.secretlab.ca>
References: <20131022134947.GK15154@atomide.com>
 <20131024103300.6023FC4039D@trevor.secretlab.ca>
Message-ID: <20131024131935.GV15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [131024 03:33]:
> On Tue, 22 Oct 2013 06:49:48 -0700, Tony Lindgren <tony@atomide.com> wrote:
> > @@ -1572,11 +1603,23 @@ static int serial_omap_probe(struct platform_device *pdev)
> >  	struct uart_omap_port	*up;
> >  	struct resource		*mem, *irq;
> >  	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
> > -	int ret;
> > +	int ret, uartirq = 0, wakeirq = 0;
> >  
> > +	/* The optional wakeirq may be specified in the board dts file */
> >  	if (pdev->dev.of_node) {
> > +		uartirq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +		if (!uartirq)
> > +			return -EPROBE_DEFER;
> > +		wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
> >  		omap_up_info = of_get_uart_port_info(&pdev->dev);
> >  		pdev->dev.platform_data = omap_up_info;
> > +	} else {
> > +		irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +		if (!irq) {
> > +			dev_err(&pdev->dev, "no irq resource?\n");
> > +			return -ENODEV;
> > +		}
> > +		uartirq = irq->start;
> 
> Ugh. This is such a hack. platform_get_irq() should just work for DT and
> non-DT. There is no way around it right now, but we need to get the code
> in place to resolve IRQs late so that drivers don't need these special
> cases.

Yes it's pretty messed up. I wrote something about it in the
"Getting rid of subsys_initcall usage?" thread at:

http://www.mail-archive.com/linux-i2c at vger.kernel.org/msg13678.html

And having zero populated in the struct resource as valid IRQ is
not nice at all.

Regards,

Tony
