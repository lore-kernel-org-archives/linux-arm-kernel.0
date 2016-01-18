From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 18 Jan 2016 11:46:30 -0500 (EST)
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <20160118081510.GF8150@shlinux2>
Message-ID: <Pine.LNX.4.44L0.1601181139150.25155-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jan 2016, Peter Chen wrote:

> On Sat, Jan 16, 2016 at 11:40:32AM -0500, Alan Stern wrote:
> > On Sat, 16 Jan 2016, Arnd Bergmann wrote:
> > 
> > > > This leaves the question of whether OF will always use the same node to
> > > > represent the host controller and the root hub.  In other words, if a
> > > > motherboard has a fixed device plugged into a fixed root-hub port, will
> > > > the DT description make that device a child of the host controller?  
> > > > Or will there be a node in between (to represent the root hub)?
> > > 
> > > Good question. I'm sure the answer is somewhere in this document
> > > 
> > > http://www.firmware.org/1275/bindings/usb/usb-1_0.ps
> > > 
> > > but unfortunately I don't understand USB addressing well enough
> > > to answer this. I think the key sentence is the definition of the
> > > "reg" property:
> > > 
> > > | prop-encoded-array: one integer, encoded as with encode-int.
> > > | The "reg" property for a device node shall consist of the number of the
> > > | USB hub port or the USB host controller port to which this USB device
> > > | is attached. As specified in [2] section 11.11.2.1, port numbers range
> > > | from 1 to 255.
> > > 
> > > Does the root hub have a port number relative to the host controller,
> > > or is it identical to the host controller from the addressing
> > > perspective?
> > 
> > The root hub does not have a port number relative to the host
> > controller.  In a sense, the root hub is _part_ of the host controller;
> > it represents the controller's connection to the USB bus (whereas the
> > logical device we commonly associate with the host controller
> > represents the controller's connection to the upstream PCI/whatever
> > bus).
> > 
> > You can also ask whether port numbers relative to the root hub are
> > the same as the port numbers relative to the controller.  Under normal
> > circumstances they are the same.  However, it is possible that they
> > will be different for USB-3 host controllers (!).
> > 
> > This is because USB-3 uses two buses per controller: the legacy
> > Low-Speed/Full-Speed/High-Speed bus compatible with USB-1.1 and USB-2
> > devices, and the new SuperSpeed bus compatible with USB-3 devices.  
> > Even though there's only the one controller, each bus has its own root
> > hub and the ports for each root hub are numbered starting from 1.  
> > Thus, for example, an xHCI controller with 6 LS/FS/HS ports and 3 SS
> > ports would have a USB-2 root hub with ports 1-6 and a USB-3 root hub
> > with ports 1-3.  However, xHCI treats the controller as a single entity
> > and numbers all the ports sequentially; thus the controller would have
> > ports 1-9.  (Even though the three SS ports would be the same physical
> > objects as three of the LS/FS/HS ports -- USB-3 ports literally contain
> > two independent sets of signal wires.)
> 
> Sorry, I have not USB-3 platform now.
> I have several questions:
> 
> - For USB-3, how many times hub_configure() will be called for root hub?
> One or two?

Two times.  Once for the legacy bus's root hub and once for the 
SuperSpeed bus's root hub.

If you have a PC with an xHCI controller, you can see this easily by
running "lsusb -v" or looking at /sys/kernel/debug/usb/devices.  There
will be two root hubs listed for the same controller, one with bcdUSB
set to 2.0 (or maybe 2.1) and one with bcdUSB set to 3.0.

> - Which the value of hub->descriptor->bNbrPorts for root hub?

In the example above, the legacy root hub would have bNbrPorts set to 6 
and the SS root hub would have bNbrPorts set to 3.

Alan Stern
