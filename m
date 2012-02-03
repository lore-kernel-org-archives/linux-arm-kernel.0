From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 19:40:51 +0000
Subject: [PATCH v4 1/2] pxa/hx4700: Add PCMCIA/CF support
In-Reply-To: <1328297727.57229.YahooMailClassic@web29009.mail.ird.yahoo.com>
References: <20120203090559.GH889@n2100.arm.linux.org.uk>
 <1328297727.57229.YahooMailClassic@web29009.mail.ird.yahoo.com>
Message-ID: <20120203194051.GG14129@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 07:35:27PM +0000, Paul Parsons wrote:
> --- On Fri, 3/2/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > irq_set_irq_type(gpio_to_irq(GPIOD4_CF_nCD),
> > IRQ_TYPE_EDGE_BOTH);
> > 
> > You shouldn't need to set the IRQ type for this.
> 
> If I don't set the IRQ type then it doesn't get set before the interrupt
> is unmasked in request_irq(). On the hx4700 the default IRQ type is level
> triggered low level detect, which is exactly the signal present on the
> (active low) CF card detect GPIO at boot. Consequently the interrupt
> handler is called repeatedly, resulting in some breakage.

That's rather unfortunate.

> I can fix this by setting the IRQ type elsewhere in the hx4700 platform
> beforehand. But wouldn't it be better for soc_pcmcia_hw_init() (or
> whatever) to set the IRQ type before it calls request_irq() ?

The big problem I have against this is: what if request_irq() returns
-EBUSY because someone else is using the interrupt?  Having the core
call irq_set_irq_type() on these IRQs before it's claimed it would be
asking for trouble.  request_irq() is the resource allocation function
for interrupts - as part of its operation, it ensures exclusivity to
the interrupt.

It's unfortunate that genirq got rid of my 'request an interrupt but
don't enable it' facility which we had in the ARM IRQ code...

I think we'll just have to live with it where you've placed it, but
please ensure that you add a comment about _why_ it's needed.  In
years to come, the reason you've put it there will have been forgotten
and it's the kind of thing which will get easily broken without such
a comment.
