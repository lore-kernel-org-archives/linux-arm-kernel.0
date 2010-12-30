From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Dec 2010 11:15:40 +0100
Subject: (arm-)global platform device registration functions
In-Reply-To: <201012301103.31085.arnd@arndb.de>
References: <20101229162512.GI14221@pengutronix.de>
	<201012301103.31085.arnd@arndb.de>
Message-ID: <20101230101540.GX14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Thu, Dec 30, 2010 at 11:03:31AM +0100, Arnd Bergmann wrote:
> On Wednesday 29 December 2010 17:25:12 Uwe Kleine-K?nig wrote:
> > some time ago I started to dynamically allocate platform_devices for
> > arm/plat-mxc.  For that purpose I added many functions, see
> > arch/arm/plat-mxc/include/mach/devices-common.h [1].  Now arm/arch-mxs
> > want to do the same, so I wonder if it would be sensible to do something
> > like this more globally (either for arm or better kernel global).
> 
> Adding platform devices dynamically is definitely the right way forward
> for new platforms, as Greg explained recently. The imx_add_platform_device()
> function you have defined looks useful for this, and I guess it could
> be added globally, next to the existing platform_device_register_resndata,
imx_add_platform_device could be implemented as

	platform_device_register_resndata(NULL, name, id, res, num_resources, data, size_data)

in next[1] the imx variant got support to handle a dmamask.

> platform_device_register_data and platform_device_register_simple functions
> that we already have doing similar things.
> 
> I'm not convinced that the various wrappers you have on imx are the
> best solution, though I have not come up with anything better either ;-)
I came up with those because many machines (sharing the same SoC) share
the same devices.

> This will also get a lot easier once we have the ability to define
> devices in using dtc, because that takes care of the resources.
Well this is a matter of taste, I'm quite happy with the current
approach.

[1]
http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=blob;f=arch/arm/plat-mxc/devices.c;hb=e635401443d9d256a0bfd1ea7864ac56034c6dca
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
