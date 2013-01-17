From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Jan 2013 15:20:29 +0900
Subject: [PATCH 1/8] SH: intc: Add support OF for INTC
In-Reply-To: <20130110015651.GJ21832@verge.net.au>
References: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
 <1357713007-4005-2-git-send-email-horms+renesas@verge.net.au>
 <20130109115352.GB7337@e106331-lin.cambridge.arm.com>
 <201301091911.04513.arnd@arndb.de>
 <20130110015651.GJ21832@verge.net.au>
Message-ID: <20130117062029.GA26725@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:56:51AM +0900, Simon Horman wrote:
> On Wed, Jan 09, 2013 at 07:11:04PM +0000, Arnd Bergmann wrote:
> > On Wednesday 09 January 2013, Mark Rutland wrote:
> > > Hi,
> > > 
> > > Thanks for updating the text, this is far easier to read than previously.
> > > 
> > > However, I'm still concerned by how complex the binding seems. As I don't have
> > > any familiarity with the device, I don't know whether that's just an artifact
> > > of the hardware or something that can be cleared up.
> > > 
> > > I think the approach used by the binding needs some serious review before this
> > > should be merged. It seems far more complex than any existing interrupt
> > > controller binding. Without a dts example for a complete board (complete with
> > > devices wired up to the interrupt controller), it's difficult to judge how this
> > > will work in practice.
> > > 
> > > I've added Arnd to Cc in case he has any thoughts on the matter.
> > 
> > Sorry for having been absent from this discussion for so long. I didn't
> > realize there were 9 versions of this patch set.
> > 
> > I tend to agree with your interpretation above, but I may be missing
> > important facts from the previous review rounds.
> > 
> > For all I can tell, the binding is an attempt to describe the
> > entire drivers/sh/intc capabilities, which is probably not the
> > best way to approach things. The sh intc driver is not just an
> > irqchip driver, but rather a framework to describe arbitrary
> > irqchips, which is what makes this so hard.
> > 
> > When I first looked at the situation last year, I suggested doing
> > a new irqchip driver with a much simpler binding that can only
> > handle the irq chips from shmobile, rather than the whole thing.
> > 
> > I am not sure if the binding in the current form is already the
> > "simplified" version, or if it actually implements all the
> > capabilities of the intc driver.
> 
> I think its more on the side of implementing the capabilities of
> the intc driver than being simplified.
> 
> Although some effort has gone into this patchset my primary
> aim is to provide something that provides the basis for supporting
> the INTC controller on all existing boards.
> 
> I more than open to concrete ideas of how this can be achieved in agreeable way.
> 
> > > > +       intca: interrupt-controller at 0 {
> > > > +               compatible = "renesas,sh_intc";
> > > > +               interrupt-controller;
> > > > +               #address-cells = <1>;
> > > > +               #size-cells = <1>;
> > > > +               #interrupt-cells = <1>;
> > > > +               ranges;
> > > > +
> > > > +               reg = <0xe6940000 0x200>, <0xe6950000 0x200>;
> > > > +               group_size = <19>;
> > > > +
> > > > +               DIRC: intsrc1 { vector = <0x0560>; };
> > > > +               ATAPI: intsrc2 { vector = <0x05E0>; };
> > > 
> > > This looks suspiciously like a way of encoding a device's interrupt information
> > > into the interrupt controller's device node. That strikes me as being the wrong
> > > way round.
> > 
> > Agreed, it would be simpler to have e.g. #interrupt-cells = <4>, to describe
> > the various offsets when needed (I forgot how many are actually required
> > in practice, rather than being computable from the other numbers), and
> > possibly a global interrupt-map/interrupt-map-mask property pair to map
> > this into a flat number space.
> 
> I'm not sure that I see what you are getting at here.
> 
> > I need to take some more time to understand the actual requirements again,
> > but IIRC it would be possible to do something much simpler than the
> > proposed binding.

Ping
