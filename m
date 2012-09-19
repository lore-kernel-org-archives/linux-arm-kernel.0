From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 19 Sep 2012 12:45:49 +0100
Subject: [PATCH v2 08/13] mfd: Versatile Express system registers driver
In-Reply-To: <201209191117.45316.arnd@arndb.de>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <201209181524.22620.arnd@arndb.de> <1348052009.11116.55.camel@hornet>
 <201209191117.45316.arnd@arndb.de>
Message-ID: <1348055149.11116.63.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-09-19 at 12:17 +0100, Arnd Bergmann wrote:
> On Wednesday 19 September 2012, Pawel Moll wrote:
> > On Tue, 2012-09-18 at 16:24 +0100, Arnd Bergmann wrote:
> > > On Tuesday 18 September 2012, Pawel Moll wrote:
> > 
> > Yes, but I2C devices are created by of_i2c_register_devices() which
> > knows how to interpret the reg property. And here, as these are normal
> > platform devices now (as you suggested), the of_platform_bus_create()
> > will treat it as a normal address, translate it via ranges and create
> > IORESOURCE_MEM out of it... And that's what I wanted to avoid. Maybe
> > unnecessarily?
> 
> You are right, this is a bit nasty, it should not attempt to do this.
> Basically the reg parsing logic has a hack to work around apply PowerMac
> firmware that misses some "ranges" properties.
> 
> I think we should change the DT parsing code to not create those
> resources if there is a bus that can't be translated.

Well, I actually think the current solution is fine - the default bus is
the platform one, I'm creating a platform device, so the code can assume
that reg is a normal address and create an IORESOURCE_MEM from it. It's
just that my platform device is not memory mapped, so I don't really
want this to happen.

One way of working this around would be not using "simple-bus" as the
parent of my config devices, so that normal of_platform_populate() will
not create them, and then have a simple dcc driver that will do nothing
except for creating platform devices in a custom way.

Pawe?
