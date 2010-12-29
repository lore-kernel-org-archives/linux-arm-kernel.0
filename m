From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 22:18:53 +0100
Subject: (arm-)global platform device registration functions
In-Reply-To: <20101229123740.c39238f8.akpm@linux-foundation.org>
References: <20101229162512.GI14221@pengutronix.de>
	<20101229123740.c39238f8.akpm@linux-foundation.org>
Message-ID: <20101229211853.GK14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 12:37:40PM -0800, Andrew Morton wrote:
> On Wed, 29 Dec 2010 17:25:12 +0100
> Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Hello,
> > 
> > some time ago I started to dynamically allocate platform_devices for
> > arm/plat-mxc.  For that purpose I added many functions, see
> > arch/arm/plat-mxc/include/mach/devices-common.h [1].  Now arm/arch-mxs
> > want to do the same, so I wonder if it would be sensible to do something
> > like this more globally (either for arm or better kernel global).
> > 
> 
> Sounds sensible to me, although I don't really understand what you've
> done - didn't platform_device_alloc() already "dynamically allocate
> platform_devices"?
my code is a bit more specialised than platform_device_alloc.

Look for example at arch/arm/plat-mxc/devices/platform-fec.c.  Calling
imx51_add_fec() creates a fec device with the resources needed for
i.MX51 and adds platform data.  (imx_add_platform_device does the same
as platform_device_register_resndata[2])

> If you were to implement this common infrastructure, there may be
> already-existing code which could use it.  How would we locate that?
coccinelle probably could.  For imx51_add_fec it could match for a
struct platform_device with name = "fec".

Best regards
Uwe

[2] actually platform_device_register_resndata was created by me to
substitute imx_add_platform_device, but I need to "fix" the former to
handle dma stuff (not merged yet) before imx_add_platform_device can go
away.
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
