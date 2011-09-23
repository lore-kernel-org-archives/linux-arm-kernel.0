From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 22 Sep 2011 23:02:55 -0600
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110922234737.05dff9f8@lxorguk.ukuu.org.uk>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110922212909.49966cf4@lxorguk.ukuu.org.uk>
	<4E7BA661.7070903@cavium.com>
	<20110922234737.05dff9f8@lxorguk.ukuu.org.uk>
Message-ID: <20110923050255.GB24631@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 11:47:37PM +0100, Alan Cox wrote:
> > How would a given driver know that something else is waiting for it?  Or 
> > would we add the explicit kick to each and every driver in the tree?
> 
> I think there are very very few drivers that have this property and don't
> already implicitly cause a probe by creating a new bus or device.
> 
> Those drivers that set something up for another device really should
> know what is going on because they are making a guarantee that they are
> ready for the other device to call into them or whatever is going on at
> some point, either explicitly in the kick or implicitly in returning from
> their probe method.

I disagree.  There are lots of situations we're hitting where the
providing driver and the consuming driver don't have any details about
each other except for the name/reference of the resource (be it gpio,
phy, clock, regulator; each with a different API).

Example 1: ALSA SoC complex.  A codec sitting on an i2c bus that gets
bound to an i2c_driver and attached to a memory-mapped I2S controller
driven by a platform_driver.  The sound device cannot be created until
both the i2c codec and the i2s controller are bound to their drivers.

Example 2: an SDHCI controller which uses a couple of GPIO lines for
card detect and write protect, but the board designer may choose to
use any available gpio line, such as on an spi gpio expander.

Example 3: An Ethernet controller attached to a phy on a completely
independent MDIO bus.  The Ethernet driver uses the phylib api to
access the phy, but cannot do so until after the phy device is bound
to a driver.

These are three very quickly off the top of my head.  I can easily
come up with a lot more.

The whole point is that the consumers *don't* and *should not* know anything
how its required resources are provided. The consumer only knows how
to request them.  Similarly, providers don't know anything about which
devices are going to be requesting resources from them.  They can only
publish what they provide.

Now, if I'm understanding what you're suggesting, we could cause the
re-probe to be triggered only when new gpio banks, phys, clocks,
regulators, audio codecs, audio busses, interrupt controllers, and dma
engines are registered.  This means adding the trigger call to all the
registration paths we think are relevant.  Personally, I really don't
think this is going to be worth it given the projected order of
complexity.  It is because the dependencies could be any interface
provided by another driver, I don't want to start with limitations on
exactly which interfaces can use probe deferral.

g.
