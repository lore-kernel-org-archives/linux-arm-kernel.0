From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Apr 2016 21:41:02 +0200
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <9424602.Vqb0FY56gH@wuerfel>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <5167289.0a4LBoWhyX@wuerfel> <20160426182335.GE30107@lunn.ch>
 <9424602.Vqb0FY56gH@wuerfel>
Message-ID: <20160426194102.GF30107@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 09:24:34PM +0200, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 20:23:35 Andrew Lunn wrote:
> > > A more complex problem would be having a PHY driver for a device
> > > that can be either an ethernet phy or some other phy.
> > 
> > I doubt that ever happens. You can have up to 32 different devices on
> > an MDIO bus. Since an Ethernet PHY and a "some other sort of PHY" are
> > completely different things, why would a hardware engineer place them
> > on the same address? It is like saying your ATA controller and VGA
> > controller share the same slot on the PCI bus...
> 
> To clarify: what I meant is a device that is designed as a PHY for
> similar hardware (e.g. SATA, USB3 and PCIe) and that has a common
> register set and a single driver, but that driver can operate
> in multiple modes. You typically have multiple instances of
> such hardware, with each instance linked to exactly one host
> device, but one driver for all of them.
> 
> See Documentation/devicetree/bindings/phy/apm-xgene-phy.txt
> and drivers/phy/phy-xgene.c for one such example.

Interesting. Also, that this lists SGMII. I assume this is a phy in
the MAC in order to talk to the Ethernet PHY.

I still don't see it being a big problem if a phy driver implements an
Ethernet PHY. It just needs to call phy_device_create() and
phy_device_register().

	Andrew
