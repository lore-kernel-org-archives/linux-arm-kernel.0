From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 14:34:40 +0000
Subject: [PATCH v2 0/5] Generic PHY Framework
In-Reply-To: <20130219131258.GV23197@arwen.pp.htv.fi>
References: <1361253198-7401-1-git-send-email-kishon@ti.com>
 <201302191233.54677.arnd@arndb.de> <20130219131258.GV23197@arwen.pp.htv.fi>
Message-ID: <201302191434.40495.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013, Felipe Balbi wrote:
> On Tue, Feb 19, 2013 at 12:33:54PM +0000, Arnd Bergmann wrote:
> > > Currently drivers/phy and drivers/net/phy are independent and are not 
> > > related to each other. There are some fundamental differences on how 
> > > these frameworks work. IIUC, the *net* uses bus layer (MDIO bus) to 
> > > match a PHY device with a PHY driver and the Ethernet device uses the 
> > > bus layer to get the PHY.
> > > The Generic PHY Framework however doesn't have any bus layer. The PHY 
> > > should be like any other Platform Devices and Drivers and the framework 
> > > will provide some APIs to register with the framework. And there are 
> > > other APIs which any controller can use to get the PHY (for e.g., in the 
> > > case of dt boot, it can use phandle to get a reference to the PHY).
> > 
> > Hmm, I think the use of a bus_type for a PHY actually sounds quite
> > appropriate. The actual PHY device would then be a child of the
> 
> really ? I'm not so sure, the *bus* used by the PHY is ULPI, UTMI,
> UTMI+, PIP3, I2C, etc... adding another 'fake' bus representation is a
> bit overkill IMO.
> 
> Imagine an I2C-controlled PHY driver like isp1301, that driver will have
> to register i2c_driver and phy_driver, which looks weird to me. If the
> only substitute for class is a bus, we can't drop classes just yet, I'm
> afraid.
> 
> Imagine a regulator bus, a pwm bus, an LED bus etc. They don't make
> sense IMHO.

It's a fine line, but I think a phy is something that resembles a device
more than an LED does. When I read patch 1, I also noticed and commented
on the fact that it does use a 'class'. Now, according to Greg, we should
use 'bus_type' instead of 'class' in new code. I originally disagreed with
that concept, but he's the boss here and it's good if he has a vision
how things should be lined out.

In practice, there is little difference between a 'bus_type' and a 'class',
so just replace any instance of the former with the latter in your head
when reading the code ;-)
I understand that there is not a real common bus here, and the bus_type
infrastructure would basically be used as a way to represent each PHY
in sysfs and provide a way to enumerate and look them up inside of the
kernel.

	Arnd
