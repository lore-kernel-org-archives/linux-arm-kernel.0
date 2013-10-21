From: balbi@ti.com (Felipe Balbi)
Date: Mon, 21 Oct 2013 07:21:16 -0500
Subject: [PATCH] serial: omap: Add support for optional wake-up interrupt
In-Reply-To: <20131018225606.GT15154@atomide.com>
References: <20131017232820.GG15154@atomide.com> <20131018161916.GF18921@gimli>
 <20131018163740.GP15154@atomide.com>
 <20131018164535.GQ15154@atomide.com>
 <20131018225606.GT15154@atomide.com>
Message-ID: <20131021122116.GL18921@gimli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 03:56:07PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [131018 09:45]:
> > * Tony Lindgren <tony@atomide.com> [131018 09:38]:
> > > * Felipe Balbi <balbi@ti.com> [131018 09:19]:
> > > > > @@ -786,7 +813,10 @@ static void serial_omap_shutdown(struct uart_port *port)
> > > > >  
> > > > >  	pm_runtime_mark_last_busy(up->dev);
> > > > >  	pm_runtime_put_autosuspend(up->dev);
> > > > > -	free_irq(up->port.irq, up);
> > > > > +
> > > > > +	for (i = 0; i < ARRAY_SIZE(up->irqs); i++)
> > > > > +		if (up->irqs[i])
> > > > > +			devm_free_irq(up->port.dev, up->irqs[i], up);
> > > > 
> > > > do you need this at all if you're using devm_* ?
> > > 
> > > So it seems, startup and shutdown are managed by serial_core and
> > > that's what at least clps711x.c serial driver is doing.
> > 
> > And that means devm_* in this case does not really help us
> > here..
> > 
> > I guess we could keep the IRQ requested from probe, but
> > there's probably a reason why it's done in startup/shutdown.
> > 
> > So I'll just drop the devm_* changes for now.
> 
> Here's an updated simplified version. I also got rid of the
> for loops as the wake-up interrupt is optional and it made the
> code a bit of a pain to read.
> 
> Regards,
> 
> Tony
> 
> 
> 8< ----------------------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 16 Oct 2013 10:27:28 -0700
> Subject: [PATCH] serial: omap: Add support for optional wake-up interrupt
> 
> With the recent pinctrl-single changes, omaps can treat
> wake-up events from deeper idle states as interrupts.
> 
> There's a separate "io chain" controller on most omaps
> that stays enabled when the device hits off-idle and the
> regular interrupt controller is powered off.
> 
> Let's add support for the optional second interrupt for
> wake-up events. And then serial-omap can manage the
> wake-up interrupt from it's runtime PM calls to avoid
> spurious interrupts during runtime.
> 
> Note that the wake interrupt is board specific as it
> uses the UART RX pin, and for omap3, there are six pin
> options for UART3 RX pin.
> 
> Also Note that the legacy platform based booting handles
> the wake-ups in the legacy mux driver and does not need to
> pass the wake-up interrupt to the driver.
> 
> And finally, to pass the wake-up interrupt in the dts file,
> either interrupt-map or the pending interrupts-extended
> property needs to be passed. It's probably best to use
> interrupts-extended when it's available.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

looks much nicer

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131021/8a88a95b/attachment-0001.sig>
