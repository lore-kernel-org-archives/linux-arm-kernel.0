From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 5 Jul 2011 11:01:22 +0800
Subject: [PATCH 1/2] gpio/mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <20110704164457.GJ6069@pengutronix.de>
References: <1309681017-22970-1-git-send-email-shawn.guo@linaro.org>
	<1309681017-22970-2-git-send-email-shawn.guo@linaro.org>
	<20110704064603.GW6069@pengutronix.de>
	<20110704092800.GG10245@S2100-06.ap.freescale.net>
	<20110704094921.GG6069@pengutronix.de>
	<20110704102008.GH10245@S2100-06.ap.freescale.net>
	<20110704164457.GJ6069@pengutronix.de>
Message-ID: <20110705030121.GB10594@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 06:44:57PM +0200, Sascha Hauer wrote:
> On Mon, Jul 04, 2011 at 06:20:09PM +0800, Shawn Guo wrote:
> > On Mon, Jul 04, 2011 at 11:49:21AM +0200, Sascha Hauer wrote:
> > > On Mon, Jul 04, 2011 at 05:28:01PM +0800, Shawn Guo wrote:
> > > > On Mon, Jul 04, 2011 at 08:46:03AM +0200, Sascha Hauer wrote:
> > > > > On Sun, Jul 03, 2011 at 04:16:56PM +0800, Shawn Guo wrote:
> > > > > > The patch removes all the uses of cpu_is_mx().  Instead, it utilizes
> > > > > > platform_device_id to distinguish the gpio differences among SoCs.
> > > > > > 
> > > > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > ---
> > > > > >  arch/arm/mach-imx/mm-imx1.c                   |    8 +-
> > > > > >  arch/arm/mach-imx/mm-imx21.c                  |   12 +-
> > > > > >  arch/arm/mach-imx/mm-imx25.c                  |    8 +-
> > > > > >  arch/arm/mach-imx/mm-imx27.c                  |   12 +-
> > > > > >  arch/arm/mach-imx/mm-imx31.c                  |    6 +-
> > > > > >  arch/arm/mach-imx/mm-imx35.c                  |    6 +-
> > > > > >  arch/arm/mach-mx5/mm-mx50.c                   |   12 +-
> > > > > >  arch/arm/mach-mx5/mm.c                        |   22 ++--
> > > > > >  arch/arm/plat-mxc/devices/platform-gpio-mxc.c |    4 +-
> > > > > >  arch/arm/plat-mxc/include/mach/common.h       |    2 +-
> > > > > >  drivers/gpio/gpio-mxc.c                       |  123 +++++++++++++++++++++----
> > > > > >  11 files changed, 151 insertions(+), 64 deletions(-)
> > > > > 
> > > > > 
> > > > > Summarizing the renames up:
> > > > > 
> > > > > i.MX1  -> imx1-gpio
> > > > > i.MX21 -> imx2-gpio
> > > > > i.MX25 -> imx-gpio
> > > > > i.MX27 -> imx2-gpio
> > > > > i.MX31 -> imx-gpio
> > > > > i.MX35 -> imx-gpio
> > > > > i.MX50 -> imx-gpio
> > > > > i.MX51 -> imx-gpio
> > > > > i.MX53 -> imx-gpio
> > > > > 
> > > > > This is not consitent. Please either use the full SoC name for all
> > > > > device ids or use something like imx-gpio-v1, v2...
> > > > > It's not good that the i.MX25 is not a imx2 and that the 'modern'
> > > > > i.MXs only have imx-gpio. We all know that your hardware designers
> > > > > will be creative enough to change the register layout again in the
> > > > > future.
> > > > > 
> > > > Ok, here it is.  It's avoid confusion in machine code, but every
> > > > time we add a new soc we need to change touch this table, even if
> > > > the new soc has a total compatible gpio to IMX_GPIO.  I'm fine with
> > > > either way.
> > > 
> > > I'm also fine with imx1-gpio, imx21-gpio and imx31-gpio and all others
> > > get a compatible entry with these like you did in the uart driver.
> > > I only want to avoid to have a imx2-gpio when a i.MX25 is incompatible
> > > with this.
> > > When we do so it's probably worth to put this into a comment somewhere
> > > next to the id table. I can imagine people wonder why only such ancient
> > > SoCs are supported.
> > > 
> > So I'm going to do the following to address your concern.  Please let
> > me know if you still do not buy it.
> > 
> > static struct platform_device_id mxc_gpio_devtype[] = {
> >         {
> >                 .name = "imx1-gpio",
> >                 .driver_data = IMX1_GPIO,
> >         }, {
> >                 .name = "imx21-gpio",
> >                 .driver_data = IMX2_GPIO,
> >         }, {
> >                 .name = "imx25-gpio",
> >                 .driver_data = IMX_GPIO,
> >         }, {
> >                 .name = "imx27-gpio",
> >                 .driver_data = IMX2_GPIO,
> >         }, {
> >                 .name = "imx-gpio",
> >                 .driver_data = IMX_GPIO,
> >         }, {
> >                 /* sentinel */
> >         }
> > };
> 
> Read again. We have three different types of gpio irq controllers, they
> are first seen in the imx1, imx21 and imx31. So all others can be made
> compatible with these three. No need for imx-gpio, imx25-gpio and
> imx27-gpio. The mxc_gpio_devtype would look like this:
> 
> static struct platform_device_id mxc_gpio_devtype[] = {
> 	{
> 		.name = "imx1-gpio",
> 		.driver_data = IMX1_GPIO,
> 	}, {
> 		.name = "imx21-gpio",
> 		.driver_data = IMX21_GPIO,
> 	}, {
> 		.name = "imx31-gpio",
> 		.driver_data = IMX31_GPIO,
> 	}, {
> 	}
> };
> 
This is really what I want to do with dt match table.  But before we
totally remove platform device probe and switch it over to dt, I'm
unsure we want to do this.  It will require the following changes on
platform device code registration right now.  I guess this is
something you do not want, right?

diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index 1e0c956..ba3009e 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -86,10 +86,10 @@ static struct sdma_platform_data imx25_sdma_pdata __initdata = {

 void __init imx25_soc_init(void)
 {
-       mxc_register_gpio(0, MX25_GPIO1_BASE_ADDR, SZ_16K, MX25_INT_GPIO1, 0);
-       mxc_register_gpio(1, MX25_GPIO2_BASE_ADDR, SZ_16K, MX25_INT_GPIO2, 0);
-       mxc_register_gpio(2, MX25_GPIO3_BASE_ADDR, SZ_16K, MX25_INT_GPIO3, 0);
-       mxc_register_gpio(3, MX25_GPIO4_BASE_ADDR, SZ_16K, MX25_INT_GPIO4, 0);
+       mxc_register_gpio("imx31-gpio", 0, MX25_GPIO1_BASE_ADDR, SZ_16K, MX25_INT_GPIO1, 0);
+       mxc_register_gpio("imx31-gpio", 1, MX25_GPIO2_BASE_ADDR, SZ_16K, MX25_INT_GPIO2, 0);
+       mxc_register_gpio("imx31-gpio", 2, MX25_GPIO3_BASE_ADDR, SZ_16K, MX25_INT_GPIO3, 0);
+       mxc_register_gpio("imx31-gpio", 3, MX25_GPIO4_BASE_ADDR, SZ_16K, MX25_INT_GPIO4, 0);

        imx_add_imx_sdma(MX25_SDMA_BASE_ADDR, MX25_INT_SDMA, &imx25_sdma_pdata);
 }

diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 944e02d..81a7870 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -77,12 +77,12 @@ void __init mx27_init_irq(void)

 void __init imx27_soc_init(void)
 {
-       mxc_register_gpio(0, MX27_GPIO1_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-       mxc_register_gpio(1, MX27_GPIO2_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-       mxc_register_gpio(2, MX27_GPIO3_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-       mxc_register_gpio(3, MX27_GPIO4_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-       mxc_register_gpio(4, MX27_GPIO5_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
-       mxc_register_gpio(5, MX27_GPIO6_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+       mxc_register_gpio("imx21-gpio", 0, MX27_GPIO1_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+       mxc_register_gpio("imx21-gpio", 1, MX27_GPIO2_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+       mxc_register_gpio("imx21-gpio", 2, MX27_GPIO3_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+       mxc_register_gpio("imx21-gpio", 3, MX27_GPIO4_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+       mxc_register_gpio("imx21-gpio", 4, MX27_GPIO5_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+       mxc_register_gpio("imx21-gpio", 5, MX27_GPIO6_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);

        imx_add_imx_dma();
 }

diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
index da530ca..8b98205 100644
--- a/arch/arm/mach-imx/mm-imx35.c
+++ b/arch/arm/mach-imx/mm-imx35.c
@@ -95,9 +95,9 @@ void __init imx35_soc_init(void)
 {
        int to_version = mx35_revision() >> 4;

-       mxc_register_gpio(0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
-       mxc_register_gpio(1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
-       mxc_register_gpio(2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
+       mxc_register_gpio("imx31-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
+       mxc_register_gpio("imx31-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
+       mxc_register_gpio("imx31-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);

        if (to_version == 1) {
                strncpy(imx35_sdma_pdata.fw_name, "sdma-imx35-to1.bin",
diff --git a/arch/arm/mach-mx5/mm-mx50.c b/arch/arm/mach-mx5/mm-mx50.c
index 28c3f60..5c20b33 100644
--- a/arch/arm/mach-mx5/mm-mx50.c
+++ b/arch/arm/mach-mx5/mm-mx50.c
@@ -62,10 +62,10 @@ void __init mx50_init_irq(void)

 void __init imx50_soc_init(void)
 {
-       mxc_register_gpio(0, MX50_GPIO1_BASE_ADDR, SZ_16K, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH);
-       mxc_register_gpio(1, MX50_GPIO2_BASE_ADDR, SZ_16K, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH);
-       mxc_register_gpio(2, MX50_GPIO3_BASE_ADDR, SZ_16K, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH);
-       mxc_register_gpio(3, MX50_GPIO4_BASE_ADDR, SZ_16K, MX50_INT_GPIO4_LOW, MX50_INT_GPIO4_HIGH);
-       mxc_register_gpio(4, MX50_GPIO5_BASE_ADDR, SZ_16K, MX50_INT_GPIO5_LOW, MX50_INT_GPIO5_HIGH);
-       mxc_register_gpio(5, MX50_GPIO6_BASE_ADDR, SZ_16K, MX50_INT_GPIO6_LOW, MX50_INT_GPIO6_HIGH);
+       mxc_register_gpio("imx31-gpio", 0, MX50_GPIO1_BASE_ADDR, SZ_16K, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH);
+       mxc_register_gpio("imx31-gpio", 1, MX50_GPIO2_BASE_ADDR, SZ_16K, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH);
+       mxc_register_gpio("imx31-gpio", 2, MX50_GPIO3_BASE_ADDR, SZ_16K, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH);
+       mxc_register_gpio("imx31-gpio", 3, MX50_GPIO4_BASE_ADDR, SZ_16K, MX50_INT_GPIO4_LOW, MX50_INT_GPIO4_HIGH);
+       mxc_register_gpio("imx31-gpio", 4, MX50_GPIO5_BASE_ADDR, SZ_16K, MX50_INT_GPIO5_LOW, MX50_INT_GPIO5_HIGH);
+       mxc_register_gpio("imx31-gpio", 5, MX50_GPIO6_BASE_ADDR, SZ_16K, MX50_INT_GPIO6_LOW, MX50_INT_GPIO6_HIGH);
 }

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 1b7059f..82ad5be 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -142,23 +142,23 @@ static struct sdma_platform_data imx53_sdma_pdata __initdata = {

 void __init imx51_soc_init(void)
 {
-       mxc_register_gpio(0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO1_LOW, MX51_MXC_INT_GPIO1_HIGH);
-       mxc_register_gpio(1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO2_LOW, MX51_MXC_INT_GPIO2_HIGH);
-       mxc_register_gpio(2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH);
-       mxc_register_gpio(3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH);
+       mxc_register_gpio("imx31-gpio", 0, MX51_GPIO1_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO1_LOW, MX51_MXC_INT_GPIO1_HIGH);
+       mxc_register_gpio("imx31-gpio", 1, MX51_GPIO2_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO2_LOW, MX51_MXC_INT_GPIO2_HIGH);
+       mxc_register_gpio("imx31-gpio", 2, MX51_GPIO3_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH);
+       mxc_register_gpio("imx31-gpio", 3, MX51_GPIO4_BASE_ADDR, SZ_16K, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH);

        imx_add_imx_sdma(MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
 }

 void __init imx53_soc_init(void)
 {
-       mxc_register_gpio(0, MX53_GPIO1_BASE_ADDR, SZ_16K, MX53_INT_GPIO1_LOW, MX53_INT_GPIO1_HIGH);
-       mxc_register_gpio(1, MX53_GPIO2_BASE_ADDR, SZ_16K, MX53_INT_GPIO2_LOW, MX53_INT_GPIO2_HIGH);
-       mxc_register_gpio(2, MX53_GPIO3_BASE_ADDR, SZ_16K, MX53_INT_GPIO3_LOW, MX53_INT_GPIO3_HIGH);
-       mxc_register_gpio(3, MX53_GPIO4_BASE_ADDR, SZ_16K, MX53_INT_GPIO4_LOW, MX53_INT_GPIO4_HIGH);
-       mxc_register_gpio(4, MX53_GPIO5_BASE_ADDR, SZ_16K, MX53_INT_GPIO5_LOW, MX53_INT_GPIO5_HIGH);
-       mxc_register_gpio(5, MX53_GPIO6_BASE_ADDR, SZ_16K, MX53_INT_GPIO6_LOW, MX53_INT_GPIO6_HIGH);
-       mxc_register_gpio(6, MX53_GPIO7_BASE_ADDR, SZ_16K, MX53_INT_GPIO7_LOW, MX53_INT_GPIO7_HIGH);
+       mxc_register_gpio("imx31-gpio", 0, MX53_GPIO1_BASE_ADDR, SZ_16K, MX53_INT_GPIO1_LOW, MX53_INT_GPIO1_HIGH);
+       mxc_register_gpio("imx31-gpio", 1, MX53_GPIO2_BASE_ADDR, SZ_16K, MX53_INT_GPIO2_LOW, MX53_INT_GPIO2_HIGH);
+       mxc_register_gpio("imx31-gpio", 2, MX53_GPIO3_BASE_ADDR, SZ_16K, MX53_INT_GPIO3_LOW, MX53_INT_GPIO3_HIGH);
+       mxc_register_gpio("imx31-gpio", 3, MX53_GPIO4_BASE_ADDR, SZ_16K, MX53_INT_GPIO4_LOW, MX53_INT_GPIO4_HIGH);
+       mxc_register_gpio("imx31-gpio", 4, MX53_GPIO5_BASE_ADDR, SZ_16K, MX53_INT_GPIO5_LOW, MX53_INT_GPIO5_HIGH);
+       mxc_register_gpio("imx31-gpio", 5, MX53_GPIO6_BASE_ADDR, SZ_16K, MX53_INT_GPIO6_LOW, MX53_INT_GPIO6_HIGH);
+       mxc_register_gpio("imx31-gpio", 6, MX53_GPIO7_BASE_ADDR, SZ_16K, MX53_INT_GPIO7_LOW, MX53_INT_GPIO7_HIGH);

        imx_add_imx_sdma(MX53_SDMA_BASE_ADDR, MX53_INT_SDMA, &imx53_sdma_pdata);
 }

-- 
Regards,
Shawn
