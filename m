From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Jul 2011 11:31:04 +0300
Subject: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
In-Reply-To: <20110715082012.GR5783@atomide.com>
References: <1310554738.18446.12.camel@lws-weitzel>
	<1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
	<4E1D8BCD.5060901@ru.mvista.com>
	<1310561772.18446.14.camel@lws-weitzel>
	<20110714073445.GL5783@atomide.com>
	<1310632792.4008.3.camel@lws-weitzel>
	<20110715075024.GO5783@atomide.com>
	<20110715075825.GB2611@legolas.emea.dhcp.ti.com>
	<20110715082012.GR5783@atomide.com>
Message-ID: <20110715083103.GF2611@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 15, 2011 at 01:20:12AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110715 00:53]:
> > Hi,
> > 
> > On Fri, Jul 15, 2011 at 12:50:24AM -0700, Tony Lindgren wrote:
> > > * Jan Weitzel <J.Weitzel@phytec.de> [110714 01:34]:
> > > > Am Donnerstag, den 14.07.2011, 00:34 -0700 schrieb Tony Lindgren:
> > > > > * Jan Weitzel <J.Weitzel@phytec.de> [110713 05:51]:
> > > > > > Am Mittwoch, den 13.07.2011, 16:13 +0400 schrieb Sergei Shtylyov:
> > > > > > 
> > > > > > > 
> > > > > > >     Have you added that 'i' at the end intentionally?
> > > > > > > 
> > > > > > Thank you. It was a tribute to vim.
> > > > > 
> > > > > :i)
> > > > > 
> > > > > I'll fold the fixed patch into your original patch. Will also
> > > > > keep the new board files in testing-board because of the code
> > > > > coalescing and device tree conversion effort.
> > > > 
> > > > So there is no way to get the board mainline yet?
> > > 
> > > Well we can add it even before device tree support if it makes
> > > sense from code coalescing point of view. In this case it would
> > > mean creating board-panda-common.c or similar so the code can
> > > be shared amongst the panda variants.
> > > 
> > > It seems that some GPIO pins are different and there are some
> > > difference in devices connected, but big parts of the code can be
> > > shared.
> > 
> > isn't it easier than to just add a few if (machine_is_xxxx()) checks and
> > another MACHINE_START() to board-omap4panda.c rather than creating a new
> > file, shuffling code around and then adding a new board file ??
> 
> That works too if the init_machine does not get too complicated.

possibly something like this (still missing MACHINE_START a few more
things):

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 0cfe200..dff174c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -681,20 +681,44 @@ void omap4_panda_display_init(void)
        omap_display_init(&omap4_panda_dss_data);
 }
 
+static struct omap_smsc911x_platform_data board_smsc911x_data __initdata = {
+       .cs             = OMAP4_SMSC911X_ETH_CS,
+       .gpio_irq       = OMAP4_SMSC911X_ETH_GPIO_IRQ,
+       .gpio_reset     = -EINVAL,
+       .flags          = SMSC911X_USE_16BIT,
+};
+
+static void __init omap4_panda_smsc91xx_init(void)
+{
+       if (!machine_is_pcm049())
+               return;
+
+       omap_mux_init_gpio(OMAP4_PCM049_ETH_GPIO_IRQ, OMAP_PIN_INPUT);
+       gpmc_smsc911x_init(&board_smsc911x_data);
+}
+
 static void __init omap4_panda_init(void)
 {
        int package = OMAP_PACKAGE_CBS;
 
        if (omap_rev() == OMAP4430_REV_ES1_0)
                package = OMAP_PACKAGE_CBL;
+
        omap4_mux_init(board_mux, NULL, package);
 
-       if (wl12xx_set_platform_data(&omap_panda_wlan_data))
-               pr_err("error setting wl12xx data\n");
+       if (machine_is_omap4panda()) {
+               int             ret;
+
+               ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
+               if (ret)
+                       pr_err("error setting wl12xx data\n");
+
+               platform_device_register(&omap_vwlan_device);
+       }
 
+       omap4_panda_smsc91xx_init();
        omap4_panda_i2c_init();
        platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
-       platform_device_register(&omap_vwlan_device);
        board_serial_init();
        omap4_twl6030_hsmmc_init(mmc);

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110715/d0fbe0d4/attachment.sig>
