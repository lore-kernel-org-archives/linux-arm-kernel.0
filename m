From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Sat, 20 Jan 2018 21:52:46 +0200
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <CAPv3WKcYrbfKjsnwZ39Tyq3HN0aneUQZdbeUzLbFgLUbMc3w8Q@mail.gmail.com>
References: <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell>
 <20180108154243.GA30962@lunn.ch>
 <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
 <20180109101941.GD31502@xora-haswell>
 <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
 <20180109130012.GA27447@lunn.ch>
 <20180118123141.GA2839@e107981-ln.cambridge.arm.com>
 <20180118130026.GG32299@lunn.ch>
 <CAPv3WKcYrbfKjsnwZ39Tyq3HN0aneUQZdbeUzLbFgLUbMc3w8Q@mail.gmail.com>
Message-ID: <20180120195246.GC27654@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 07:07:29PM +0100, Marcin Wojtas wrote:
> Hi Mika,

Hi,

> 2018-01-18 14:00 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
> >> I CC'ed Mika since he is more familiar with handling these bits of ACPI
> >> specs - I wonder whether this is a problem that cropped up on x86
> >> systems too.
> >
> > Hi Lorenzo
> >
> > There is nothing about MDIO, PHYs, Ethernet switches, etc in version
> > 6.2 of the spec. If x86 has this, it must be after 6.2 was released.
> > I would not be too surprised if x86 has none of this. If you look at
> > the typical drives used on x86, i210, e1000e, ixgb, r8169, etc. They
> > are all PCI devices, and hide all this.
> >
> >> I do not think there is one and only answer but there must be a single
> >> set of bindings and if the ACPI specs already cater for some of them
> >> we have to reuse them.
> >
> > Agreed. Due diligence so far suggests there is nothing already
> > defined. But im a newbie to ACPI, so could be looking in the wrong
> > place. I really hope there is somebody like Rob Herring, the DT
> > maintainer, who keeps an eye on all ACPI talk and would tell us if we
> > are heading off in the wrong direction.
> >
> 
> My initial approach with MDIO bus with PHYs as child nodes was super
> easy to describe and handle in Linux - please refer to:
> - typical representation of mdio bus with the phys -
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/mdio.txt?h=v4.15-rc8
> - my patches in the initial series
> However I guess it would be more proper to use the
> GenericSerialBus-based description, as advised in ACPI Spec. The
> question is, whether we should define new type of a bus or not
> (MdioSerialBus, similar to e.g. I2cSerialBus).

I'm not familiar with MDIO bus but an alternative to GeneriSerialBus
would be to follow what SDIO is doing, e.g have the PHY devices listed
below the MDIO controller and use _ADR to describe their "address" on
that bus. You can see how _ADR applies to SDIO bus from ACPI spec.

Of course ACPI spec should then be updated accordingly to describe what
_ADR means for devices on MDIO bus.

> Since I have a code that can be tested and easily modified to use
> different ACPI approaches with real platform MDIO controller
> (mvmdio.c) and NIC (mvpp2.c), in coming weeks I may be able to find
> some time to prepare a proof of concept based on GenericSerialBus.
> Please expect some RFC patches hopefully right after the coming merge
> window is closed.
> 
> Of course, if I come up on some ACPI - specific implementation
> questions, I won't hesitate to ask in this thred. I will also
> appreciate any hints. For now my two main concerns are:
> - The PHY address on the mdio bus - should it be put into _CRS ->
> GenericSerialBus() field or separate _ADR? I'd lean towards first
> option.
> - The PHY type - in Linux it's resolved basing on two generic
> compatible strings
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/phy.txt?h=v4.15-rc8).
> I'd put it as a sort of ID into GenericSerialBus(). If you agree - any
> specific filed that you would try to use?

If you go with the SDIO way then each PHY is described as normal ACPI
device and you can use ACPI _HID/_CID to match the device to the
corresponding driver.

> Do I understand correctly that the MDIO controller node should
> comprise OperationRegion() definition of the GenericSerialBus?

I don't think OpRegions are useful in this case because they are mainly
used to allow BIOS AML code to access the hardware through OS driver.
