From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Oct 2013 09:45:35 -0700
Subject: [PATCH] serial: omap: Add support for optional wake-up interrupt
In-Reply-To: <20131018163740.GP15154@atomide.com>
References: <20131017232820.GG15154@atomide.com> <20131018161916.GF18921@gimli>
 <20131018163740.GP15154@atomide.com>
Message-ID: <20131018164535.GQ15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131018 09:38]:
> * Felipe Balbi <balbi@ti.com> [131018 09:19]:
> > > @@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart_port *port)
> > >  
> > >  	pm_runtime_mark_last_busy(up->dev);
> > >  	pm_runtime_put_autosuspend(up->dev);
> > > -	free_irq(up->port.irq, up);
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(up->irqs); i++)
> > > +		if (up->irqs[i])
> > > +			devm_free_irq(up->port.dev, up->irqs[i], up);
> > 
> > do you need this at all if you're using devm_* ?
> 
> So it seems, startup and shutdown are managed by serial_core and
> that's what at least clps711x.c serial driver is doing.

And that means devm_* in this case does not really help us
here..

I guess we could keep the IRQ requested from probe, but
there's probably a reason why it's done in startup/shutdown.

So I'll just drop the devm_* changes for now.

Regards,

Tony
