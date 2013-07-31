From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 31 Jul 2013 13:14:47 +0200
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <20130728050021.4370E3E0A24@localhost>
References: <1624911.6TtmtVmU1T@avalon> <1681089.qGWOhLKTTo@avalon>
 <20130728050021.4370E3E0A24@localhost>
Message-ID: <26968517.tbY84mICFD@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Saturday 27 July 2013 23:00:21 Grant Likely wrote:
> On Thu, 25 Jul 2013 15:22:29 +0200, Laurent Pinchart wrote:
> > On Thursday 25 July 2013 14:15:56 Mark Brown wrote:
> > > On Thu, Jul 25, 2013 at 11:45:33AM +0200, Laurent Pinchart wrote:
> > > > The two devices are independent, so there's no real parent/child
> > > > relationship. However, as Grant proposed, I could list all the
> > > > interrupts associated with GPIOs in the GPIO controller DT node. I
> > > > would then just call irq_of_parse_and_map() in the .to_irq() handler
> > > > to magically translate the GPIO number to a mapped IRQ number.
> > > > 
> > > > The number of interrupts can be pretty high (up to 58 in the worst
> > > > case so far), so an alternative would be to specify the interrupt-
> > > > parent only, and call irq_create_of_mapping() directly. What solution
> > > > would you prefer ?
> > > 
> > > Are the interrupts in a contiguous block in the controller so you can
> > > just pass around the controller and a base number?
> > 
> > In two of the three SoCs I need to fix they are. I've just realized that
> > in the last one the interrupts are in two contiguous blocks in two
> > different parents. I will thus need at least a list of <parent-phandle
> > base count>.
> >
> > Our standard interrupt bindings don't seem to support multiple parents,
>
> You can actually do it by using a dummy node with interrupt-map and
> interrupt-map-mask properties, but it is a pretty ugly solution in my
> opinion.
> 
> > is that something that we want to fix or should I go for custom bindings ?
> 
> Yes, I think it is something that we want to fix. Jean-Christophe was going
> to propose an alternative to the interrupts property which allows an array
> of <phandle interrupt-specifier> tuples, but I've not seen anything yet. Go
> ahead and make a proposal.

More work, great :-)

A bit of bikeshedding here, as the "interrupts" property is already used, how 
should I name the new property ?

> You could try to encode a base+count variant, but honestly I don't think it
> would be a good idea because it only would work with a very narrow set of
> use cases. Consider if #interrupt-cells was set to 2. Which cell gets
> incremented in the range of interrupts specified? Better I think to merely
> have an array of fully specified irqs. Support for that property could be
> transparently baked into the core interrupt parsing functions.

I agree, I'll try that.

-- 
Regards,

Laurent Pinchart
