From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Jul 2011 11:49:21 +0200
Subject: [PATCH 1/2] gpio/mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <20110704092800.GG10245@S2100-06.ap.freescale.net>
References: <1309681017-22970-1-git-send-email-shawn.guo@linaro.org>
	<1309681017-22970-2-git-send-email-shawn.guo@linaro.org>
	<20110704064603.GW6069@pengutronix.de>
	<20110704092800.GG10245@S2100-06.ap.freescale.net>
Message-ID: <20110704094921.GG6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 05:28:01PM +0800, Shawn Guo wrote:
> On Mon, Jul 04, 2011 at 08:46:03AM +0200, Sascha Hauer wrote:
> > On Sun, Jul 03, 2011 at 04:16:56PM +0800, Shawn Guo wrote:
> > > The patch removes all the uses of cpu_is_mx().  Instead, it utilizes
> > > platform_device_id to distinguish the gpio differences among SoCs.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  arch/arm/mach-imx/mm-imx1.c                   |    8 +-
> > >  arch/arm/mach-imx/mm-imx21.c                  |   12 +-
> > >  arch/arm/mach-imx/mm-imx25.c                  |    8 +-
> > >  arch/arm/mach-imx/mm-imx27.c                  |   12 +-
> > >  arch/arm/mach-imx/mm-imx31.c                  |    6 +-
> > >  arch/arm/mach-imx/mm-imx35.c                  |    6 +-
> > >  arch/arm/mach-mx5/mm-mx50.c                   |   12 +-
> > >  arch/arm/mach-mx5/mm.c                        |   22 ++--
> > >  arch/arm/plat-mxc/devices/platform-gpio-mxc.c |    4 +-
> > >  arch/arm/plat-mxc/include/mach/common.h       |    2 +-
> > >  drivers/gpio/gpio-mxc.c                       |  123 +++++++++++++++++++++----
> > >  11 files changed, 151 insertions(+), 64 deletions(-)
> > 
> > 
> > Summarizing the renames up:
> > 
> > i.MX1  -> imx1-gpio
> > i.MX21 -> imx2-gpio
> > i.MX25 -> imx-gpio
> > i.MX27 -> imx2-gpio
> > i.MX31 -> imx-gpio
> > i.MX35 -> imx-gpio
> > i.MX50 -> imx-gpio
> > i.MX51 -> imx-gpio
> > i.MX53 -> imx-gpio
> > 
> > This is not consitent. Please either use the full SoC name for all
> > device ids or use something like imx-gpio-v1, v2...
> > It's not good that the i.MX25 is not a imx2 and that the 'modern'
> > i.MXs only have imx-gpio. We all know that your hardware designers
> > will be creative enough to change the register layout again in the
> > future.
> > 
> Ok, here it is.  It's avoid confusion in machine code, but every
> time we add a new soc we need to change touch this table, even if
> the new soc has a total compatible gpio to IMX_GPIO.  I'm fine with
> either way.

I'm also fine with imx1-gpio, imx21-gpio and imx31-gpio and all others
get a compatible entry with these like you did in the uart driver.
I only want to avoid to have a imx2-gpio when a i.MX25 is incompatible
with this.
When we do so it's probably worth to put this into a comment somewhere
next to the id table. I can imagine people wonder why only such ancient
SoCs are supported.

Sascha

> 
> static struct platform_device_id mxc_gpio_devtype[] = {
>         {
>                 .name = "imx1-gpio",
>                 .driver_data = IMX1_GPIO,
>         }, {
>                 .name = "imx21-gpio",
>                 .driver_data = IMX2_GPIO,
>         }, {
>                 .name = "imx25-gpio",
>                 .driver_data = IMX_GPIO,
>         }, {
>                 .name = "imx27-gpio",
>                 .driver_data = IMX2_GPIO,
>         }, {
>                 .name = "imx31-gpio",
>                 .driver_data = IMX_GPIO,
>         }, {
>                 .name = "imx35-gpio",
>                 .driver_data = IMX_GPIO,
>         }, {
>                 .name = "imx50-gpio",
>                 .driver_data = IMX_GPIO,
>         }, {
>                 .name = "imx51-gpio",
>                 .driver_data = IMX_GPIO,
>         }, {
>                 .name = "imx53-gpio",
>                 .driver_data = IMX_GPIO,
>         }, {
>                 /* sentinel */
>         }
> };
> 
> -- 
> Regards,
> Shawn
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
