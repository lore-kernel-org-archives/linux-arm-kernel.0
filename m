From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 7 Mar 2013 20:48:30 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130307174955.GC20840@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
Message-ID: <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 10:49:55AM -0700, Jason Gunthorpe wrote:
> On Thu, Mar 07, 2013 at 09:08:32AM +0100, Thierry Reding wrote:
[...]
> > > Both have various problems, but I think I prefer the first one as it
> > > doesn't conflate the contoller registers and host apertures in a
> > > single ranges..
> > 
> > I think a better alternative would be (and this matches what Thomas has
> > said elsewhere) to use something like the first alternative but move the
> > regs property into the pcie at 0,X nodes. That would save us from having to
> > index a property in the parent. At least from a DT point of view I find
> > that to be a more consistent representation.
> 
> You are thinking a new property 'host-controller-regs' or the like?

Well, something shorter would be nice, but that's the general idea, yes.
As I mentioned before, for Tegra these registers aren't actually any
controller specific registers but rather a window to access the PCI
configuration space for the root ports.

Going via the FPCI mapping of the configuration space doesn't generate
transactions on bus 0, which is why there are extra windows for each
root port. That's why I was arguing about reusing the reg property in
the first place because it actually represents the configuration space.

But this is likely to be unique to Tegra and Marvell hardware doesn't
behave this way, but instead needs the registers for a different
purpose. Something like host-controller-regs might be more appropriate.

> > However that would probably not work out-of-the-box with the current OF
> > core because of_address_to_resource() won't know how to find the new
> > property. The assigned-addresses alternative seems to be the only one
> > that would work on the current OF core and achieve proper address
> > translation. But it doesn't seem like a good solution either since it
> > repurposes the meaning of the property and therefore isn't any better
> > than encoding the same information in the reg property.
> 
> Except that reg is specifically not supposed to be handling CPU bus
> addresses and assigned-addresses is.
> 
> Adding a hidden non-standard BAR to model the hidden non-standard
> memory region associated with the bridge is a stretch, but it is not a
> very big stretch...
> 
> In any event, regs should not be used, and something needs to be
> decided!

I don't think assigned-addresses is a good fit either. The PCI binding
document is equally specific about it as it is about the reg property.
So in my opinion a separate property would be a better choice. The only
big obstacle is that it needs to be somehow hooked up with the OF core
so that proper address translation can be performed.

One possible solution that wouldn't be too hard to implement is to
provide a new function (say of_get_named_address()) similar to
of_get_address() which doesn't get the name of the register property
from the struct of_bus but from a parameter and call that function from
another new function similar to of_address_to_resource() that also gets
the property name from a parameter. I can't think of a better name for
the latter than of_named_address_to_resource(), which is rather long.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/44e758d7/attachment-0001.sig>
