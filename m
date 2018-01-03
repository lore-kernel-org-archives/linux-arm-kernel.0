From: stefanc@marvell.com (Stefan Chulski)
Date: Wed, 3 Jan 2018 17:00:47 +0000
Subject: [EXT] Re: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable
 the fourth network interface
In-Reply-To: <20180101132520.GB28752@n2100.armlinux.org.uk>
References: <20171228100519.GE2626@kwain>
 <462da70b-ba7d-6299-3e21-b619d3c4c7e6@gmail.com>
 <20171228182739.GH2626@kwain> <20171228184642.GV10595@n2100.armlinux.org.uk>
 <CAPv3WKdNCOB=1BqGXw7gXZNX+bBhOXVfheYPjC4CFZjfiOXyHQ@mail.gmail.com>
 <20171229113850.GX10595@n2100.armlinux.org.uk>
 <CAPv3WKcFT5YgvwEk9QNB5=O0j23ds1jCxaBYnMVhxDHeBZzbDA@mail.gmail.com>
 <20171230173157.GC10595@n2100.armlinux.org.uk>
 <CAPv3WKfn0=51CVtC8V5nWeiM+UV0BhqwFNewwRWUV3wy-9MtUg@mail.gmail.com>
 <616c2f3b0fe64184bc26d2de43442540@IL-EXCH01.marvell.com>
 <20180101132520.GB28752@n2100.armlinux.org.uk>
Message-ID: <0e95e9b20e2d42bc95e04034bd88e781@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > -----Original Message-----
> > > Hi Russell,
> > >
> > > Indeed. RGMII MAC behaves same way, although it shouldn't be named
> > > as 'in- band' to be on par with the specifications. Anyway - this
> > > one is rather a stub for being able to work with ACPI, so once the
> > > MDIO bus works there, this will be out of any concerns.
> >
> > Hi Marcin,
> >
> > This is correct.
> > "in-band" supported only for SGMII mode.
> > IRQ link interrupt depend on "in-band"' auto negation only if "in-band"'
> enabled.
> > But IRQ link interrupt could be triggered with "in-band", "out-band" or with
> specific fixed speed/duplex/flow_contol.
> 
> Hi Stefan,
> 
> How does this work in RGMII mode - is this handled by the PP2 polling the PHY
> to get the speed, duplex and flow control settings?
> 

IRQ interrupt doesn't handled speed, duplex and flow control settings.
It's just raised if number of criterions met:
1) Physical signal detected by MAC
2) MAC auto negotiation succeeded(valid only auto negotiation enabled in MAC and "in-band" bypass disabled)

So if auto negotiation mechanism disabled in MAC or bypassed, link status would changes to up and IRQ interrupt be triggered.

In case of RGMII mode obviously we don't have "in-band" auto negotiation and "out-band" cannot be used in Kernel(due to missed locks).
So auto negotiation should be disabled on MAC level and speed/duplex/flow_contol would be negotiate by PHY. 
phylink/phylib infrastructure should provide speed/duplex/flow_contol(that were agreed between PHY's) to ppv2 driver.

Stefan.
