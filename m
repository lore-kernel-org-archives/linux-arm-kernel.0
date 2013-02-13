From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 13 Feb 2013 11:04:39 -0700
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130213095701.0d9f9f20@skate>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130213095701.0d9f9f20@skate>
Message-ID: <20130213180439.GB1601@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 09:57:01AM +0100, Thomas Petazzoni wrote:

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
> I am not sure to understand how this would work. Given a pcie at X,Y node,
> how would I find the address of the internal registers (i.e the ones at
> 0xd0040000, 0xd0080000) ?

> You seem to propose a global regs = <...> property under
> pcie-controller, but indexing using marvell,pcie-port cannot work. PCIe
> interfaces are identified by two values (port,lane), so we have 0.0,
> 0.1, 0.2, 0.3, 1.0, 1.1, 1.2, 1.3, 2.0 and 3.0 on MV78460. I really
> would like to avoid having bizarre computations to find which entry in
> this big regs = <...> array correspond to a given PCIe interface.

Well, using the 'global' regs is an easy way to avoid the complexity with
address translation and 'assigned-addresses'. So some way to translate
between link # and regs index is necessary. How about using the PCI
device number? Device number 1 is regs entry 0, 2 is regs entry 1, etc.

The code flow would be then to iterate over DT children, extract the
bus/dev/function from 'reg', ensure bus ==0, and index the global regs
by device-1.

The other option is to try to make assigned-addresses work, Thierry
had some comments on that, it is a bit convoluted too, IMHO.

Also note setting the device_type = "pci";

Jason
