From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 26 Aug 2013 14:02:01 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <521B1F6A.1090304@keymile.com>
References: <51DD88A4.1030506@keymile.com> <20130731100359.3e789236@skate>
 <51F8CA44.4080802@keymile.com> <20130731110045.2dc84981@skate>
 <20130731205034.GA17615@obsidianresearch.com>
 <20130809140140.GA14990@ulmo> <521B1F6A.1090304@keymile.com>
Message-ID: <20130826120200.GA15842@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 11:27:06AM +0200, Gerlando Falauto wrote:
> Hi guys [particularly Jason and Thierry],
> 
> sorry for the prolonged silence, here I am back again...
> 
> On 08/09/2013 04:01 PM, Thierry Reding wrote:
> >On Wed, Jul 31, 2013 at 02:50:34PM -0600, Jason Gunthorpe wrote:
> >>On Wed, Jul 31, 2013 at 11:00:45AM +0200, Thomas Petazzoni wrote:
> >>
> >>>>Actually, the main reason for trying to use this driver was because I
> >>>>wanted to model a PCIe *device* within the device tree, so to expose its
> >>>>GPIOs and IRQs to be referenced (through phandles) from other device
> >>>>tree nodes. The way I understand it, turns out this is not the way to
> >>>>go, as PCI/PCIe are essentially enumerated busses, so you're not
> >>>>supposed to -and it's not a trivial task to- put any information about
> >>>>real devices within the device tree.
> >>>>Do you have any suggestion about that?
> >>>
> >>>Indeed, PCI/PCIe devices are enumerated dynamically, so they are not
> >>>listed in the Device Tree, so there's no way to "attach" more
> >>>information to them.
> >>>
> >>>Device Tree people, any suggestion about the above question?
> >>
> >>No, that isn't true.
> >>
> >>Device tree can include the discovered PCI devices, you have to use
> >>the special reg encoding and all that weirdness, but it does work. The
> >>of_node will be attached to the struct pci device automatically.
> 
> So you mean that, assuming I knew the topology, I could populate the
> device tree in advance (e.g. statically), so that it already
> includes *devices* which will be further discovered during probing?
> Or else you mean the {firmware,u-boot} can do that prior to starting the OS?
> If either of the above is true, could you please suggest some
> example (or some way to get one)?
> I assume the "reg" property (and the after-"@" node name) will need
> to encode (at least) the device number, is that right?
> 
> I tried reading the "PCI Bus Binding to Open Firmware" but I could
> not make complete sense out of it...

You can find an example of this here:

	https://gitorious.org/thierryreding/linux/commit/b85c03d73288f6e376fc158ceac30f29680b4192

It's been quite some time that I've actually tested that, but it used to
work properly. What you basically need to do is represent the whole bus
hierarchy within the DT. In the above example there's the top-level root
port (pci at 1,0), which provides a bus (1) on which there's a switch named
pci at 0,0. That switch provides another bus (2) on which more devices are
listed (pci@[012345],0). Those are all downstream ports providing
separate busses again and have a single device attached to them.

You can pretty much arbitrarily nest nodes that way to represent any
hierarchy you want. The tricky part is to get the node numbering right
but `lspci -t' helps quite a bit with that.

> >>It is useful for exactly the reason stated - you can describe GPIOs,
> >>I2C busses, etc, etc in DT and then upon load of the PCI driver engage
> >>the DT code to populate and connect all that downstream
> >>infrastructure.
> 
> I'm not 100% sure I made myself clear though.
> What I would like to do is to have *other* parts of the device tree
> be able to reference (i.e., connect to, through phandles) a PCI
> device (because it provides a GPIO, for instance).
> Is that also what you mean?

Yes. In the example above you'll see that there's actually a GPIO
controller (pci at 1,0/pci at 0,0/pci at 2,0/pci at 0,0), so you could simply
associate a phandle with it, as in:

	gpioext: pci at 0,0 {
		...
	};

And then hook up other devices to it using the regular notation:

	foo {
		...
		enable-gpios = <&gpioext 0 0>;
		...
	};

That's not done in this example but I've actually used something very
similar to that on an x86 platform to hook up the reset pin of an I2C
touchscreen controller to a GPIO controller, where both the I2C and
GPIO controllers were on the PCI bus.

I can't find that snippet right now, but I can look more thoroughly if
the above doesn't help you at all.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130826/16513cf2/attachment-0001.sig>
