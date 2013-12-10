From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Dec 2013 14:16:40 -0600
Subject: OMAP still fails - usb phy stuff
In-Reply-To: <20131210192508.GB2464@saruman.home>
References: <20131210130926.GZ4360@n2100.arm.linux.org.uk>
 <20131210183809.GL13171@atomide.com>
 <20131210192508.GB2464@saruman.home>
Message-ID: <20131210201639.GD2464@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 10, 2013 at 01:25:08PM -0600, Felipe Balbi wrote:
> On Tue, Dec 10, 2013 at 10:38:10AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [131210 05:10]:
> > > I still see some OMAP randconfigs failing with this:
> > > 
> > > arch/arm/mach-omap2/built-in.o: In function `usbhs_init_phys':
> > > dss-common.c:(.text+0x1396c): undefined reference to `usb_bind_phy'
> > > arch/arm/mach-omap2/built-in.o: In function `omap_2430sdp_init':
> > > dss-common.c:(.init.text+0x6c90): undefined reference to `usb_bind_phy'
> > > drivers/built-in.o: In function `omap_usb2_remove':
> > > powercap_sys.c:(.text+0x3520): undefined reference to `usb_remove_phy'
> > > drivers/built-in.o: In function `omap_usb_power_off':
> > > powercap_sys.c:(.text+0x3544): undefined reference to `omap_control_usb_phy_power'
> > > drivers/built-in.o: In function `omap_usb_power_on':
> > > powercap_sys.c:(.text+0x3568): undefined reference to `omap_control_usb_phy_power'
> > > drivers/built-in.o: In function `omap_usb2_probe':
> > > powercap_sys.c:(.text+0x3638): undefined reference to `omap_control_usb_phy_power'
> > > powercap_sys.c:(.text+0x36d4): undefined reference to `usb_add_phy_dev'
> > > drivers/built-in.o: In function `omap_usb2_suspend':
> > > powercap_sys.c:(.text+0x37d0): undefined reference to `omap_control_usb_phy_power'
> > > powercap_sys.c:(.text+0x37f4): undefined reference to `omap_control_usb_phy_power'
> > > drivers/built-in.o: In function `omap_usb2_set_comparator':
> > > powercap_sys.c:(.text+0x3844): undefined reference to `usb_get_phy'
> > > drivers/built-in.o: In function `isp1704_charger_remove':
> > > powercap_sys.c:(.text+0x48d5ec): undefined reference to `usb_put_phy'
> > > drivers/built-in.o: In function `isp1704_charger_probe':
> > > powercap_sys.c:(.text+0x48d64c): undefined reference to `usb_get_phy'
> > > powercap_sys.c:(.text+0x48d884): undefined reference to `usb_put_phy'
> > > drivers/built-in.o: In function `twl4030_bci_probe':
> > > powercap_sys.c:(.init.text+0x13fd4): undefined reference to `usb_get_phy'
> > > powercap_sys.c:(.init.text+0x14114): undefined reference to `usb_put_phy'
> > > 
> > > Probably caused by over-use of the damned select statement:
> > > 
> > > warning: (OMAP_USB2 && TWL4030_USB) selects USB_PHY which has unmet direct dependencies (USB_SUPPORT)
> > > warning: (OMAP_USB2) selects OMAP_CONTROL_USB which has unmet direct dependencies (USB_SUPPORT && (ARCH_OMAP2PLUS || COMPILE_TEST))
> > > warning: (OMAP_USB2 && TWL4030_USB) selects USB_PHY which has unmet direct dependencies (USB_SUPPORT)
> > > warning: (OMAP_USB2) selects OMAP_CONTROL_USB which has unmet direct dependencies (USB_SUPPORT && (ARCH_OMAP2PLUS || COMPILE_TEST))
> > > 
> > > You have to wonder why OMAP_USB2 can be enabled when USB_SUPPORT is
> > > disabled.
> > 
> > Yeah this causes constant randconfig errors. Felipe, I thought you
> > had some fixes lined up for these few weeks ago already when we
> > last talked about it?
> 
> For the warnings, yeah. Greg's pull request hasn't been appliet yet
> (need to check again, checked yesterday).
> 
> For the build error, I'll send something today.

this should fix it (checked with RMK's defconfig):

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index a344f3d..d8b1a9a 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -24,9 +24,9 @@ config PHY_EXYNOS_MIPI_VIDEO
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
 	depends on ARCH_OMAP2PLUS
+	depends on OMAP_CONTROL_USB
 	select GENERIC_PHY
 	select USB_PHY
-	select OMAP_CONTROL_USB
 	help
 	  Enable this to support the transceiver that is part of SOC. This
 	  driver takes care of all the PHY functionality apart from comparator.

i'll send it as a proper patch now.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/a084c60b/attachment.sig>
