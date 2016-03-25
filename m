From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Mar 2016 16:11:05 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160325103253.GA2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <12540712.SXPhdxqg9f@wuerfel> <20160325103253.GA2566@sirena.org.uk>
Message-ID: <4319407.5A4b1VspuB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 March 2016 10:32:53 Mark Brown wrote:
> On Thu, Mar 24, 2016 at 09:07:32PM +0100, Arnd Bergmann wrote:
> > On Thursday 24 March 2016 18:51:53 Stefan Roese wrote:
> 
> > > I see. But with this we are back to statically mapping the MBus
> > > windows that are used. Resulting in potentially multiple windows
> > > per SPI controller, which is not necessary (Andrew and Mark
> > > objected against that).
> 
> > I'm not following here. Do you mean we should set up and tear
> > down the windows in the runtime PM callbacks so they are only
> > present when we actually access a device instead?
> 
> What we're trying to avoid is allocating a window to every single client
> device attached to SPI, the controller can only talk to one device at
> once anyway so having one per device is wasteful when this is a limited
> resource.  Looking at this from the point of view of a SPI driver it
> just seems obviously bad, in order to get the best performance with this
> controller we need to do a special per-device magic binding.  That's not
> good for usability, it's not ideal having to do it per controller but at
> least then it's done for the SoC.
> 
> We also already apparently have some dynamic code for PCIe. 

The PCI implementation is a bit of a layering violation, as the mbus
binding has to know about the special reserved area that is used for
dynamic PCI mappings.

There is nothing magic in the binding if we just do the same thing
the flash driver does, and describe the memory range that is associated
with a chipselect.

> > Among the dts files we ship with the kernel, how many would
> > actually use more than one mapping in practice if we decide to
> > do the static ranges property? I had a quick look and could not
> > even find one that has more than one chip-select connected.
> 
> Do any of these boards have things like expansion connectors?

I think they are basically all consumer products, e.g. NAS systems
or routers that just have a single SPI-NOR flash.

> > Ok, so with the static mapping it could be done very easily, or
> > we need a more complex solution for the dynamic mapping.
> 
> Part of what I personally don't understand is why this is complicated?

I think we'd need to add another special case in the bus driver
for it, which otherwise should be able to handle this in a generic
way: if we just use the existing binding, the spi host driver can
simply call devm_ioremap_resource() to see if there is a map
for a given chipselect and otherwise fall back to the current
mode.

	Arnd
