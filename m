From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 21:53:53 +0000
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <20130326223748.242f0046@skate>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303262110.15582.arnd@arndb.de> <20130326223748.242f0046@skate>
Message-ID: <201303262153.53698.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> On Tue, 26 Mar 2013 21:10:15 +0000, Arnd Bergmann wrote:
> 
> > > To which children? Only to the main-intc children? If so,
> > > armada_370_xp_mpic_of_init() would be called with a 'device_node *'
> > > that points to the main-intc, correct? Then it would have to go back up
> > > in the Device Tree to find the msi node? It's doable of course, but
> > > sounds strange, no?
> > 
> > I was thinking of registering two init functions as well.
> 
> But then which of the two init functions would do the of_iomap() (or
> whatever ioremap()ing function you use) ?

I agree this is where it get a little fishy, hence my preference to
use a single node.

> Remember, the very reason what we have one driver for both interrupt
> controllers is because the registers are completely mixed. So to me
> it's really the case of one device providing two features, like a
> device that would be both an Ethernet interface and a SPI controller.
> You have a single ->probe() function that gets called when the device
> is detected, and this ->probe() function registers both an Ethernet
> interface and a SPI controller.b
> 
> To me, the case we have here is really identical: we have one single set
> of registers that provide multiple features.

The problem here is that the irq subsystem makes certain assumptions
about one device node being the controller and mapping to a single
irq domain, so you'd have to cheat one way or another. Using the
sub-nodes the way you do in your patch is bending the rules for
the device tree binding, which I think is more problematic than
bending the rules for the code. Regarding the call to of_iomap(),
you could work around it by having a static variable in the driver
that remembers the mmio address and gets set by whichever device node
init function gets called first.

	Arnd
