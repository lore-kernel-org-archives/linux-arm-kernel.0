From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 4 Jul 2011 09:23:06 -0600
Subject: [PATCH 1/2] gpio/mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <20110704092800.GG10245@S2100-06.ap.freescale.net>
References: <1309681017-22970-1-git-send-email-shawn.guo@linaro.org>
	<1309681017-22970-2-git-send-email-shawn.guo@linaro.org>
	<20110704064603.GW6069@pengutronix.de>
	<20110704092800.GG10245@S2100-06.ap.freescale.net>
Message-ID: <20110704152306.GB29977@ponder.secretlab.ca>
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

IMNSHO, this is overkill.  It is fine to identify several common types
and have multiple SoCs use them, although I see Sascha's point that
using imx21-gpio is very odd for the imx3 and imx5 parts.  Certainly
not wrong.  Just odd.

It's fine to be pragmatic here.  Use imx-gpio for most of them, and
have a special value for the special parts; imx21-gpio and imx27-gpio.
This is all completely in-kernel stuff anyway so there is no need to
coordinate with external data.

When you build the DT table, you could lean in the direction of device
families.  Get the driver to match against the first iteration of 'major'
uprevs of the device family, like "fsl,imx1-gpio", "fsl,imx21-gpio",
"fsl,imx31-gpio", "fsl,imx50-gpio", and for the chips that don't fit
the model, don't claim compatibility with the previous version.  That
would give you the following compatible strings in the device tree for
each SoC:

imx1: compatible = "fsl,imx1-gpio";
imx21: compatible = "fsl,imx21-gpio";
imx25: compatible = "fsl,imx25-gpio"; /* NOT compatible with imx21-gpio */
imx27: compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
imx31: compatible = "fsl,imx31-gpio";
imx35: compatible = "fsl,imx37-gpio", "fsl,imx31-gpio";
imx50: compatible = "fsl,imx50-gpio";
imx51: compatible = "fsl,imx51-gpio", "fsl,imx50-gpio";
imx53: compatible = "fsl,imx53-gpio", "fsl,imx50-gpio";

That said, I don't actually care much.  I'm perfectly happy to accept
a binding where the imx3x and 5x device trees claim compatibility with
the imx1-gpio /providing/ that the imx3 and imx5 gpio controllers
truly are register level compatible with the imx1 device.

However, if the imx3 and 5 gpio controllers add new features, then it
is probably wise to use the fsl,imx31-gpio and fsl,imx50-gpio values
so that the driver can detect them generically (even if the driver
doesn't yet support the extra features).

g.
