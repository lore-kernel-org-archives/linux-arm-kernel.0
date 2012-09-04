From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Sep 2012 17:56:10 +0200
Subject: [PATCH 1/4] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <201209041436.36430.arnd@arndb.de>
References: <1346764004-16332-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1346764004-16332-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201209041436.36430.arnd@arndb.de>
Message-ID: <20120904175610.2c2934f1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Thanks for looking so quickly into this driver!

Le Tue, 4 Sep 2012 14:36:36 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> On Tuesday 04 September 2012, Thomas Petazzoni wrote:
> >  .../devicetree/bindings/net/marvell-neta.txt       |   24 +
> >  drivers/net/ethernet/marvell/Kconfig               |   11 +
> >  drivers/net/ethernet/marvell/Makefile              |    1 +
> >  drivers/net/ethernet/marvell/mvneta.c              | 2732 ++++++++++++++++++++
> >  drivers/net/ethernet/marvell/mvneta.h              |  496 ++++
> >  5 files changed, 3264 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/marvell-neta.txt
> >  create mode 100644 drivers/net/ethernet/marvell/mvneta.c
> >  create mode 100644 drivers/net/ethernet/marvell/mvneta.h
> 
> I usually prefer putting the definitions into the .c file rather
> than a separate header if there is only only file including it
> anyway.

Fine. I hesitated on this one, but since the driver was already quite
long, I thought a separate header would be nicer, but I don't have a
strong opinion, so I'll resubmit with this change.

> > +eth at d0070000 {
> > +               compatible = "marvell,neta";
> > +               reg = <0xd0070000 0x2500>;
> > +               interrupts = <8>;
> > +               device_type = "network";
> > +               clock-frequency = <250000000>;
> > +               status = "okay";
> > +               phy-mode = "sgmii";
> > +               phy-addr = <25>;
> 
> I think we normally put the phy into a separate device node on an
> mdio bus and then use the of_phy_* functions to connect it to
> the ethernet device.

Even though it may not be a convincing argument, none of the existing DT
files in arch/arm/boot/dts seem to instantiate a separate PHY device
and a proper MDIO bus. However, the PowerPC platforms indeed make this
distinction a lot clearer.

However, this network unit has a clever MAC that autonomously queries
the PHY for the link status, and reports changes (link, duplex, speed)
in the form of MAC interrupts and MAC registers. Therefore, for basic
operation, there is no need for a separate PHY driver nor to expose the
MDIO bus in any way. The only thing needed is the PHY address, which is
filled into a register of the MAC so that it can start its automatic
query of the PHY.

Knowing this, would it be acceptable to have this driver without an
explicit MDIO bus in the DT?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
