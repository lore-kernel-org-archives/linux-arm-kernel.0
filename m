From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 5 Nov 2013 09:13:45 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <5277B417.2030506@keymile.com>
References: <20130731100359.3e789236@skate> <51F8CA44.4080802@keymile.com>
 <20130731110045.2dc84981@skate>
 <20130731205034.GA17615@obsidianresearch.com>
 <20130809140140.GA14990@ulmo> <521B1F6A.1090304@keymile.com>
 <20130826120200.GA15842@ulmo> <521B6AF3.9070909@keymile.com>
 <20130826191615.GA20192@obsidianresearch.com>
 <5277B417.2030506@keymile.com>
Message-ID: <20131105081344.GA1088@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 03:49:59PM +0100, Gerlando Falauto wrote:
> Hi folks,
> 
> thank you for your patience...
> 
> So, thanks to Thierry's example:
> 
> > https://gitorious.org/thierryreding/linux/commit/b85c03d73288f6e376fc158ceac30f29680b4192
> 
> and Jason's explanation:
> 
> > The reg must encode the bus number according to the OF format:
> >
> >                 33222222 22221111 11111100 00000000
> >                 10987654 32109876 54321098 76543210
> >   phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
> > phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
> >   phys.lo cell: llllllll llllllll llllllll llllllll
> >
> > bbbbbbbb is the 8-bit Bus Number
> > ddddd is the 5-bit Device Number
> > fff is the 3-bit Function Number
> >
> > Others are 0.
> 
> I'm finally starting to make some sense out of this, and I checked
> that Jason's statement is indeed true, at least on 3.10:
> 
> > Device tree can include the discovered PCI devices, you have to use
> > the special reg encoding and all that weirdness, but it does work. The
> > of_node will be attached to the struct pci device automatically.
> 
> [Hi latency was also due to other activities, not just the low
> throughput of my brain cells] ;-)
> 
> I have one last question for Thierry though: what's the point of
> things such as
> 
> +					pci at 0,0 {
> +						compatible = "opencores,spi";
> 
> (apart from clarity, of course)?
> I mean, wouldn't the driver be bound to the device through its PCI
> vendor ID / device ID?
> Are we also supposed to register a platform driver based on a
> compatible string instead?

I think that compatible property is completely bogus. Or at least the
value is. The primary reason why I included them was for descriptive
purposes.

According to section 2.5 of the PCI Bus Binding to Open Firmware[0] this
should be something like:

	compatible = "pciVVVV,DDDD";

where VVVV is the vendor ID and DDDD is the device ID, both in
hexadecimal. Section 2.5 lists a few more, but I'm not sure exactly
which would really be required.

I'm not even sure that they really are required at all. The drivers will
certainly be able to bind to them via the standard vendor and device ID
matching as you say. And no, no platform driver required.

Thierry

[0]: http://www.openfirmware.org/1275/bindings/pci/pci2_1.pdf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131105/3402da29/attachment.sig>
