From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 15:12:58 +0200
Subject: [PATCH v2 0/5] Generic PHY Framework
In-Reply-To: <201302191233.54677.arnd@arndb.de>
References: <1361253198-7401-1-git-send-email-kishon@ti.com>
 <201302191044.28653.arnd@arndb.de> <512361F0.1070500@ti.com>
 <201302191233.54677.arnd@arndb.de>
Message-ID: <20130219131258.GV23197@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 19, 2013 at 12:33:54PM +0000, Arnd Bergmann wrote:
> On Tuesday 19 February 2013, kishon wrote:
> > On Tuesday 19 February 2013 04:14 PM, Arnd Bergmann wrote:
> > > On Tuesday 19 February 2013, Kishon Vijay Abraham I wrote:
> > >> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> > >> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> > >> the PHY with or without using phandle. To obtain a reference to the PHY
> > >> without using phandle, the platform specfic intialization code (say from board
> > >> file) should have already called phy_bind with the binding information. The
> > >> binding information consists of phy's device name, phy user device name and an
> > >> index. The index is used when the same phy user binds to mulitple phys.
> > >>
> > >> This framework will be of use only to devices that uses external PHY (PHY
> > >> functionality is not embedded within the controller).
> > >>
> > >> The intention of creating this framework is to bring the phy drivers spread
> > >> all over the Linux kernel to drivers/phy to increase code re-use and to
> > >> increase code maintainability.
> > >>
> > >> Comments to make PHY as bus wasn't done because PHY devices can be part of
> > >> other bus and making a same device attached to multiple bus leads to bad
> > >> design.
> > >
> > > How does this relate to the generic PHY interfaces in drivers/net/phy?
> > 
> > Currently drivers/phy and drivers/net/phy are independent and are not 
> > related to each other. There are some fundamental differences on how 
> > these frameworks work. IIUC, the *net* uses bus layer (MDIO bus) to 
> > match a PHY device with a PHY driver and the Ethernet device uses the 
> > bus layer to get the PHY.
> > The Generic PHY Framework however doesn't have any bus layer. The PHY 
> > should be like any other Platform Devices and Drivers and the framework 
> > will provide some APIs to register with the framework. And there are 
> > other APIs which any controller can use to get the PHY (for e.g., in the 
> > case of dt boot, it can use phandle to get a reference to the PHY).
> 
> Hmm, I think the use of a bus_type for a PHY actually sounds quite
> appropriate. The actual PHY device would then be a child of the

really ? I'm not so sure, the *bus* used by the PHY is ULPI, UTMI,
UTMI+, PIP3, I2C, etc... adding another 'fake' bus representation is a
bit overkill IMO.

Imagine an I2C-controlled PHY driver like isp1301, that driver will have
to register i2c_driver and phy_driver, which looks weird to me. If the
only substitute for class is a bus, we can't drop classes just yet, I'm
afraid.

Imagine a regulator bus, a pwm bus, an LED bus etc. They don't make
sense IMHO.

> platform_device (or something else) that gets probed by its parent
> bus or the DT. The operations that you define for the PHY
> actually mirror some of the things that we have for a 'struct device',
> so I think it would be quite logical to do it the same way.
> 
> Note that MDIO has both a 'bus' and a 'class', and what we want here is more
> like what the 'class' was meant for, except that for new classes, we
> should actually use a 'bus', since the long-term plan is to kill off
> the concept of a 'class'. I hope that was not too confusing. :)

:)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/5701ebe3/attachment-0001.sig>
