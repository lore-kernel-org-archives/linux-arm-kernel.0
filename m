From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 5 May 2012 00:40:57 +0100
Subject: Handling of modular boards
In-Reply-To: <20120504225514.GM897@n2100.arm.linux.org.uk>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <20120504225514.GM897@n2100.arm.linux.org.uk>
Message-ID: <20120504234056.GV14230@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 11:55:14PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 04, 2012 at 07:58:51PM +0100, Mark Brown wrote:

> > I'm just starting to put some stuff together for this so I was wondering
> > if anyone had been thinking about this and had any bright ideas for how
> > to handle it, and also if people think that MFD is a good fit for this
> > or if we should split the silicon MFDs from these PCBs.

> I don't think its true to say that there's no support for this kind of
> thing.

> If you're thinking about a motherboard with separate add-on cards, then
> you can view the cards as their own separate platform device.  Your
> platform device driver would be a "whole board driver" responsible
> for creating and registering the specific devices found on the board
> in its probe function, and unregistering them in the remove function.

Oh, absolutely - there's support there at that level and several boards
doing some or all of this in mainline already.  It's not that you can't
do it, it's that there's a bunch of generic stuff to do with how you map
the resources through to the devices on the modules and describe the
chips that are on the modules for which there's no infrastructure so
everything needs to be hand coded on a per board basis.  The board
identification bits are board specific but the remapping and subdevice
instantiation bits seem like they shouldn't be.

> It also helps to give the right model to the power management support,
> because you're automatically arranging the child devices below the
> board-level device, which means all the child devices should be
> suspended before the board level device, and the board level device
> should be resumed before the child devices.

Yes, I'd anticipate that we'd have a device for the board which should
help with this sort of stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120505/3a0e6d0b/attachment.sig>
