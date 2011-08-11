From: balbi@ti.com (Felipe Balbi)
Date: Thu, 11 Aug 2011 21:54:09 +0300
Subject: [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor driver
In-Reply-To: <CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
	<20110811141248.GK28500@legolas.emea.dhcp.ti.com>
	<CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
Message-ID: <20110811185408.GB15970@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 11, 2011 at 08:02:55PM +0530, J, KEERTHY wrote:
> On Thu, Aug 11, 2011 at 7:42 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Aug 11, 2011 at 06:30:04PM +0530, J, KEERTHY wrote:
> >> >> >> diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/omap_temp_sensor.c
> >> >> >> new file mode 100644
> >> >> >> index 0000000..15e2559
> >> >> >> --- /dev/null
> >> >> >> +++ b/drivers/hwmon/omap_temp_sensor.c
> >> >> >> @@ -0,0 +1,950 @@
> >> >> >> +/*
> >> >> >> + * OMAP4 Temperature sensor driver file
> >> >> >> + *
> >> >> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> >> >> >> + * Author: J Keerthy <j-keerthy@ti.com>
> >> >> >> + * Author: Moiz Sonasath <m-sonasath@ti.com>
> >> >> >> + *
> >> >> >> + * This program is free software; you can redistribute it and/or
> >> >> >> + * modify it under the terms of the GNU General Public License
> >> >> >> + * version 2 as published by the Free Software Foundation.
> >> >> >> + *
> >> >> >> + * This program is distributed in the hope that it will be useful, but
> >> >> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the GNU
> >> >> >> + * General Public License for more details.
> >> >> >> + *
> >> >> >> + * You should have received a copy of the GNU General Public License
> >> >> >> + * along with this program; if not, write to the Free Software
> >> >> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> >> >> >> + * 02110-1301 USA
> >> >> >> + *
> >> >> >> + */
> >> >> >> +
> >> >> >> +#include <linux/interrupt.h>
> >> >> >> +#include <linux/clk.h>
> >> >> >
> >> >> > why ??
> >> >>
> >> >> Clock rate setting functions.
> >> >
> >> > you shouldn't need in drivers.
> >>
> >> It is a one time setting of the rate so keeping it in drivers.
> >
> > you need some other way to handle this. Why do you need to manually set
> > the rate rather than having hwmod handle this for you ?
> >
> > your argument that "it's a one time setting" is not enough to have this
> > in the driver. Drivers should not care about clocks anymore, this should
> > have been done on another layer.
> 
> Hwmod will have no idea on the rate required.

does the rate need to change ? Also, I have not mentioned hwmod anytime
simply because I'm not sure where this should be placed, but hopefully
not in the driver.

If the clock doesn't need to change after you set the correct rate, then
there's really no point in adding complexity to the driver.

Tony, would you have any comment here ?

> >> >> >> +#include <plat/temperature_sensor.h>
> >> >> >
> >> >>
> >> >> It is the header file with the structure definitions
> >> >> used in the driver.
> >> >
> >> > why don't you put in <linux/platform_data/....> ??
> >>
> >> I saw many omap specific header files in plat-omap/include/plat.
> >> Any specific reason behind placing the header in linux/platform_data?
> >
> > because it's not a good idea to perpetuate the failure.
> 
> May be Tony can give some inputs on where the OMAP specific header
> should be placed.

it's not omap-specific. It's specific to your driver and considering
it's platform_data, it should sit under include/linux/platform_data.h.
That directory was created (fairly recently) to hold platform_data...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110811/af6058f5/attachment.sig>
