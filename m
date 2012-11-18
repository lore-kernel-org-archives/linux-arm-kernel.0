From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 18 Nov 2012 18:12:46 -0500
Subject: [PATCH] Dove: Fix irq_to_pmu()
In-Reply-To: <20121118230805.GA3290@n2100.arm.linux.org.uk>
References: <20121118162944.GV3290@n2100.arm.linux.org.uk>
 <20121118163932.GW3290@n2100.arm.linux.org.uk>
 <50A9304C.9010006@mvista.com>
 <20121118203815.GY3290@n2100.arm.linux.org.uk>
 <20121118210229.GV22106@titan.lakedaemon.net>
 <20121118223125.GZ3290@n2100.arm.linux.org.uk>
 <20121118230805.GA3290@n2100.arm.linux.org.uk>
Message-ID: <20121118231246.GZ22106@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

adding relevant folks to the CC:

On Sun, Nov 18, 2012 at 11:08:05PM +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 18, 2012 at 10:31:25PM +0000, Russell King - ARM Linux wrote:
> > And there's yet another bug... this time in the kirkwood audio driver:
> > 
> > static irqreturn_t kirkwood_dma_irq(int irq, void *dev_id)
> > {
> >         struct kirkwood_dma_priv *prdata = dev_id;
> >         struct kirkwood_dma_data *priv = prdata->data;
> >         unsigned long mask, status, cause;   
> >         
> >         mask = readl(priv->io + KIRKWOOD_INT_MASK);
> >         status = readl(priv->io + KIRKWOOD_INT_CAUSE) & mask;
> > 
> >         cause = readl(priv->io + KIRKWOOD_ERR_CAUSE);
> >         if (unlikely(cause)) {
> >                 printk(KERN_WARNING "%s: got err interrupt 0x%lx\n",
> >                                 __func__, cause);
> >                 writel(cause, priv->io + KIRKWOOD_ERR_CAUSE);
> >                 return IRQ_HANDLED;
> >         }
> > 
> > What happens here if an underrun (0x20) interrupt happens?  Well, the
> > kernel log looks something like this:
> 
> Actually, it's _far_ worse.  This interrupt handler is hooked into the
> _normal_ I2S IRQ (21) - errors are reported via a separate IRQ (22).
> 
> So what happens is a normal IRQ (in INT_CAUSE) gets signalled.  It's at
> that point we notice that an error occured... and clear the error,
> leaving the normal interrupt set in INT_CAUSE, and return lying that
> we'd serviced the interrupt.
> 
> The result is... IRQ21 is still pending, and ends up being the higher
> priority interrupt, so we service IRQ21 again... and find that the
> error cause bit has been set again... and return yet again IRQ_HANDLED
> without actually servicing the interrupt...
> 
> I think we're far better off ripping out this "error handling".  If we
> want to have this, then we should hook the _proper_ error interrupt, and
> have some kind of back-off on it (which I think is the right solution).
> Or if we merely want to report that an error occurred, then just get rid
> of that "return IRQ_HANDLED" there.

thx,

Jason.
