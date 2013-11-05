From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Nov 2013 09:22:01 +0100
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <527816AE.1080508@wwwdotorg.org>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <1704730.RnIqE1USnv@wuerfel> <527816AE.1080508@wwwdotorg.org>
Message-ID: <201311050922.01970.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 November 2013, Stephen Warren wrote:
> On 11/04/2013 01:43 PM, Arnd Bergmann wrote:
> > int devm_probe_gpio(struct device *dev, const struct devm_probe *probe)
> ...
> > #define DEVM_GPIO(_struct, _member, _index) {				 \
> ...
> > #define DEVM_GPIO_NAMED(_struct, _member, _name) { 			 \
> 
> Should those save the GPIO flags too? Or, do we assume that gpiod-based
> GPIOs already handle the flags inside the gpiod API?

The latter. I would certainly hope to get away with assigning just one
structure field per callback function.
 
> > /*
> >  * this lists all properties we access from the driver. The list
> >  * is interpreted by devm_probe() and can be programmatically
> >  * verified to match the binding.
> >  */
> > static const struct devm_probe foo_probe_list[] = {
> > 	DEVM_ALLOC(foo_priv),
> > 	DEVM_IOMAP(foo_priv, regs, 0, 0),
> > 	DEVM_PROP_BOOL(foo_priv, oldstyle_dma, "foo,oldstyle-dma"),
> 
> I wonder if it makes sense to handle pure data here, or whether this
> only makes sense for resources/services that are provided by some other
> device?
> 
> I guess it's nice for all resources and configuration to come through to
> probe() in the same way, but I rather wonder how we'd handle bindings
> that have large custom (driver-specific) tables of data. Would be simply
> defer such things to custom code in probe()? If so, it feels slightly
> inconsistent to handle some data in the probe_list[] and some in code in
> probe(). Still, I guess there's something to be said for keeping the
> simple cases simple.

Right, and I didn't intend to solve all cases in a completely generic way.
Thinking about it some more, a driver could actually add a custom callback
for some properties, but I don't know if that adds any value over just
interpreting them from the regular probe() function.

> > 	DEVM_DMA_SLAVE(foo_priv, rxdma, "rx");
> > 	DEVM_DMA_SLAVE(foo_priv, txdma, "tx");
> > 	DEVM_GPIO(foo_priv, gpio, 0);
> > 	DEVM_IRQ_NAMED(foo_priv, irq, foo_irq_handler, "fifo", IRQF_SHARED),
> 
> What about the case where some resources are optional, or only required
> based on the values of certain other properties? I suppose that probe()
> could call devm_probe() multiple times, with different probe_list[]s,
> based on whatever algorithm they need.

That's one open question that I haven't found the best solution for yet.
My first take on that was to add another field in struct devm_probe to
mark a property as optional, but that would increase the overall
complexity. I'd first want to do a survey of what kinds of properties
are typically optional. If it's only a few of them, we could have
something like

DEVM_DMA_SLAVE_OPTIONAL()

for the cases that need it, with a variant of the callback function.

	Arnd
