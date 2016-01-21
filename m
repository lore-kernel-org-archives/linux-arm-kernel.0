From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 21 Jan 2016 10:21:15 -0500 (EST)
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <3851350.Ox9dssDdWY@wuerfel>
Message-ID: <Pine.LNX.4.44L0.1601211015010.2275-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jan 2016, Arnd Bergmann wrote:

> On Thursday 21 January 2016 17:48:32 Peter Chen wrote:
> > 
> > > 
> > > So two hubs at ports 1 and 2 of the USB controller that integrates
> > > the root hub and shares a device node with it.
> > > 
> > Ok, so the "reg" is the address for certain root hub (HS or SS), not
> > the unity address for the whole controller, if it is, do we really
> > need to add two nodes for one physical port, HS and SS will not be used
> > at the same time. And if the reg is the same, how can we know
> > which node is from current recognized device.
> 
> The "reg" is the address that the parent device uses to talk to the child
> device. If you know which of the two that child is attached to, then I
> think you don't need both, but I think we have to use the entire addressing.
> 
> In Alan's example, there are six HS ports and three SS ports, but as I
> understand it, there is no guarantee that the numbering between the two
> is identical, and that the three SS ports always refer to the three HS
> ports. In particular for devices soldered on-board (rather than connected
> through a standard plug), I would guess that it is possible to connect
> them to separate child devices though I have to admit that I do not
> understand enough of the standard to know for sure.

The spec allows for a lot of flexibility.  It even allows for "tier 
mismatches", in which (for example) the SS connection for a particular 
port is routed directly to the root hub while the HS connection for the 
same port is routed through an intermediate hub!

There is only one major constraint: With the exception of hubs, no USB
device is allowed to use both the SS and the HS buses at the same time.  
A device has to decide on one speed and use only the corresponding bus.  
USB-3 hubs, on the other hand, are required to connect to both buses.  
They appear as two separate logical devices: a SS hub on the SS bus and
a HS hub on the HS bus.

Alan Stern
