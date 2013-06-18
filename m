From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 20:22:08 +0200
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device tree
 nodes
In-Reply-To: <20130618192154.4c1530cc@skate>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306181918.59046.arnd@arndb.de> <20130618192154.4c1530cc@skate>
Message-ID: <201306182022.08927.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Thomas Petazzoni wrote:
> On Tue, 18 Jun 2013 19:18:58 +0200, Arnd Bergmann wrote:
> 
> > > >                        ranges =
> > > >                               <0x82000000 0 0x40000    0xffff0001 0x40000 0 0x00002000
> > > >                                0x82000000 0 0x80000    0xffff0001 0x80000 0 0x00002000
> > > >                                0x82000000 1 0 MBUS_ID(0x12, 0x34) 0  1 0
> > > >                                0x82000000 2 0 MBUS_ID(0x13, 0x34) 0  1 0
> > > >                                0x81000000 1 0 MBUS_ID(0x12, 0x35) 0 0 0x10000;
> > > >                                0x81000000 2 0 MBUS_ID(0x13, 0x35) 0 0 0x10000>;
> > > > 
> > > > The MBUS_ID numbers above are made up since I don't know them, but this way you can
> > > > describe how the entire 4GB MMIO address space of the PCI bus is mapped into the
> > > > MBUS address space.
> > > 
> > > This is NOT possible because we don't know in advance how much memory
> > > space and I/O space each PCIe device will require.
> > > 
> > > Arnd, we've discussed this at length with you while getting the PCIe
> > > driver merged, and we've explained this to you numerous times. Could
> > > you please understand that any of your proposal that suggests writing
> > > down static windows for PCIe devices will not work?
> > 
> > Where did I suggest static windows for PCIe devices?
> 
> Where does your new proposal buys us anything useful compared to the
> existing PCIe DT binding that has been discussed at length with you?

I'm pretty sure I explained the idea above originally and was ignored.
Jason Gunthorpe might remember better, but I think he liked it when I
originally proposed doing it this way.

The main differences are:

* It unifies the binding for the PCIe case and all other registers. There is no
  need to treat PCIe special in the binding this way, which is more future-proof
  and more consistent.

* Since the host physical address for the PCIe memory space window is set up
  dynamically anyway, there is no reason to hardcode it in DT. We want it to
  be as large as possible, and this way the mbus driver can just pick the largest
  free area itself after setting up all the other mappings from the ranges
  property.

* The binding actually allows the PCIe translation to be discontiguous, so if
  we want to improve the code in the future, we can fill all the holes in the
  mbus space with PCIe windows without changing the binding.

* It separates hardware description (in the PCIe node) from policy (in the mbus
  node), just like we do for all the other mbus children.

	Arnd
