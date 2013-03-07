From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 7 Mar 2013 09:08:32 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130306180946.GA2433@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
Message-ID: <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 11:09:46AM -0700, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2013 at 01:11:19PM +0100, Thierry Reding wrote:
> 
> > I agree here. It seems that back at the time when the PCI DT bindings
> > were devised no hardware existed with these properties. So I think that
> > maybe it needs to be revised to take into account some of these new
> > requirements. Just adding a bunch of properties to work around
> > shortcomings in the specification doesn't seem very desirable to me.
> 
> Well, all the PCI hosts should use the same mechanism, and it should
> make sense in the context of the rest of the spec. So I think some
> approval/comment on this specific issue by Grant/Rob/Arnd is important
> at this point.
> 
> The way the spec is written, 'reg' in a 'device_type = pci' context is
> the device's config address - it is like 'reg' in a CPU block, or I2C
> bus - the value has nothing to do with CPU mappable memory.
> 
> > space. According to the PCI DT specification this isn't allowed, but it
> > works on Linux and quite frankly I don't see why it shouldn't be
> > allowed.
> 
> AFAIK, this only works because you are not using 'device_type = pci'.
> 
> IMHO, 'device_type = pci' is not optional, so you need to come up with
> something that works under those conditions, and it changes how the OF
> core handles 'reg' and the like.

Actually I do use device_type = "pciex" for the pci at 1,0 and pci at 2,0
nodes which was suggested back when I first posted this series. Yet the
address translation still works properly. And it should since they are
translated to the parent bus which is used to access the configuration
space window for each root port.

Looking at the code it looks indeed like the OF core only matches on
"pci" (and "vci"), but not "pciex". Perhaps I should change both nodes
to device_type = "pci" and see what the results are.

> As I said before, the two best options to me seem to be:
> 
> pcie-controller {
>  compatible = "marvell,armada-370-xp-pcie";
> 
>   // Index by marvell,pcie-port/reg-names/etc
>   regs = <0xd0040000 0x00002000
>           0xd0080000 0x00002000>;
> 
>   ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
>             0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchable memory */
> 
>   pcie at 0,0 {
>        device_type = "pci";
>        reg = <0x0800 0 0 0>; // 00:01.0  (????)
>        marvell,pcie-port = <0>;
>   };
> }
> 
> or:
> 
> pcie-controller {
>   compatible = "marvell,armada-370-xp-pcie";
> 
>   ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
>             0x82000000 0 0  0xc1000000  0 0x08000000   /* non-prefetchable memory */
>             // Mapping for per-port host controller registers
>             0x82000000 0x10000000 0xd0040000  0xd0040000  0 0x2000>;
> 
>   pcie at 0,0 {
>        device_type = "pci";
>        reg = <0x0800 0 0 0>; // 00:01.0  (????)
>        marvell,pcie-port = <0>;
>        
>        assigned-addresses = <0 0 0  0 0 // BAR 0 of the bridge, unused
>        			     0 0 0  0 0 // BAR 1 of the bridge, unused
>                              0x82000000 0x10000000 0xd0040000  0 0x2000>; // Extended
> 
>   };
> }
> 
> Both have various problems, but I think I prefer the first one as it
> doesn't conflate the contoller registers and host apertures in a
> single ranges..

I think a better alternative would be (and this matches what Thomas has
said elsewhere) to use something like the first alternative but move the
regs property into the pcie at 0,X nodes. That would save us from having to
index a property in the parent. At least from a DT point of view I find
that to be a more consistent representation.

However that would probably not work out-of-the-box with the current OF
core because of_address_to_resource() won't know how to find the new
property. The assigned-addresses alternative seems to be the only one
that would work on the current OF core and achieve proper address
translation. But it doesn't seem like a good solution either since it
repurposes the meaning of the property and therefore isn't any better
than encoding the same information in the reg property.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/989c145c/attachment.sig>
