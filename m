From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 6 Mar 2013 13:11:19 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130306105441.4d24033e@skate>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
Message-ID: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 10:54:41AM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Tue, 12 Feb 2013 15:35:11 -0700, Jason Gunthorpe wrote:
> 
> > > +	pcie at 0,0 {
> > > +		device_type = "pciex";
> > > +		reg = <0x0800 0 0xd0040000 0 0x2000>;
> > 
> > It would be great to get this sorted as per my prior comments.. Maybe
> > like this is easy?
> > 
> > pcie-controller {
> >  compatible = "marvell,armada-370-xp-pcie";
> > 
> >  // Index by marvell,pcie-port ?
> >  regs = <0xd0040000 0x00002000
> >          0xd0080000 0x00002000>;
> > 
> >  ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
> >            0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchable memory */
> > 
> >  pcie at 0,0 {
> >       device_type = "pci";
> >       reg = <0x0800 0 0 0>; // 00:01.0  (????)
> >       marvell,pcie-port = <0>;
> >  };
> > }
> > 
> > It is abusive to map the device internal per-port registers through
> > '0x00000800 0 0xd0040000' and 'reg' - that is not really the intent of
> > the OF spec.
> 
> The Device Tree would really look odd. We have one register range for
> each PCIe interface, but instead of nicely putting them inside the
> pcie at X,Y subnodes, we have a global regs = <..> property at the
> pcie-controller level? I can do that if you want, but it really sounds
> like the standard PCI DT bindings are horrible. Those register ranges
> are *per* PCIe interface, so any logical person would expect them
> inside the pcie at X,Y node...

I agree here. It seems that back at the time when the PCI DT bindings
were devised no hardware existed with these properties. So I think that
maybe it needs to be revised to take into account some of these new
requirements. Just adding a bunch of properties to work around
shortcomings in the specification doesn't seem very desirable to me.

That said, on Tegra there's an additional argument in favour of this
because the addresses mapped through the ranges/reg properties are
actually used to access the device's configuration space, which the
'ss' field in the first cell specifies. Quoting the DTS:

	pcie-controller {
		...
		ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00001000   /* port 0 registers */
			  0x00001000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers */
			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
			  0x82000000 0 0          0xa0000000 0 0x10000000   /* non-prefetchable memory */
			  0xc2000000 0 0          0xb0000000 0 0x10000000>; /* prefetchable memory */
		...
		pci at 1,0 {
			...
			reg = <0x000800 0 0x80000000 0 0x1000>;
			...
		};

		pci at 2,0 {
			...
			reg = <0x001000 0 0x80001000 0 0x1000>;
			...
		};
	};

So we're actually mapping the configuration space of pci at 1,0 and pci at 2,0
to the 0x80000000 and 0x80001000 addresses of the CPU physical address
space. According to the PCI DT specification this isn't allowed, but it
works on Linux and quite frankly I don't see why it shouldn't be
allowed.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/543b0f8a/attachment.sig>
