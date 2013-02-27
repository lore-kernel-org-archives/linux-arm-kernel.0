From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 27 Feb 2013 17:29:57 +0100
Subject: [PATCH 0/3] otg-for-v3.10-v1: separate phy code and add DT helper
In-Reply-To: <1361974590-21237-1-git-send-email-mkl@pengutronix.de>
References: <1361974590-21237-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20130227162957.GC10491@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 03:16:27PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> this series depends on the bugfix patch "USB otg: use try_module_get in all
> usb_get_phy functions and add missing module_put" (a.k.a tags/otg-for-v3.9-v1)
> posted earlier and is inteded for v3.10. It separates the phy from the otg code
> and adds DT helper functions. Further mxs-phy uses the new usb_add_phy_dev()
> function to register it's phy.
> 
> regards,
> Marc
> 
> 
> The following changes since commit 6bef020b4aebd7886281fb7fb37c788d5a365eea:
> 
>   USB otg: use try_module_get in all usb_get_phy functions and add missing module_put (2013-02-27 12:53:15 +0100)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/mkl/linux.git tags/otg-for-v3.10-v1
> 
> for you to fetch changes up to 8a4c9f8489b2fce9e7bf0eb43fdb160ab51adc2c:
> 
>   USB mxs-phy: Register phy with framework (2013-02-27 13:48:21 +0100)
> 
> ----------------------------------------------------------------
> USB otg, phy: separate phy and add DT helper
> 
> Move phy related code into separate file and add device tree helper functions.
> 
> ----------------------------------------------------------------
> Michael Grzeschik (1):
>       USB: add devicetree helpers for determining dr_mode and phy_type
> 
> Sascha Hauer (2):
>       USB: move bulk of otg/otg.c to phy/phy.c
>       USB mxs-phy: Register phy with framework
> 
>  drivers/usb/otg/mxs-phy.c |    9 +
>  drivers/usb/otg/otg.c     |  427 -------------------------------------------
>  drivers/usb/phy/Makefile  |    2 +
>  drivers/usb/phy/of.c      |   47 +++++
>  drivers/usb/phy/phy.c     |  438 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/usb-common.c  |   37 ++++
>  include/linux/usb/of.h    |   27 +++
>  include/linux/usb/otg.h   |    8 +
>  include/linux/usb/phy.h   |    9 +
>  9 files changed, 577 insertions(+), 427 deletions(-)
>  create mode 100644 drivers/usb/phy/of.c
>  create mode 100644 drivers/usb/phy/phy.c
>  create mode 100644 include/linux/usb/of.h
> 
> 
> 
> 

Hi,

with this series plus
        otg-for-v3.9-v1: USB otg: fix usage of try_module_get() and module_put()
        chipidea-for-v3.10-v1 : USB chipidea: make use of DT helpers in chipidea driver improve driver
        v9: Add tested id switch and vbus connect detect support for Chipidea

and

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 13b7053..1eeff3c 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -907,7 +907,8 @@
                        compatible = "fsl,imx28-usb", "fsl,imx27-usb";
                        reg = <0x80080000 0x10000>;
                        interrupts = <93>;
-                       clocks = <&clks 60>;
+                       clocks = <&clks 60>, <&clks 60>, <&clks 60>;
+                       clock-names = "ipg", "ahb", "per";
                        fsl,usbphy = <&usbphy0>;
                        status = "disabled";
                };
@@ -916,7 +917,8 @@
                        compatible = "fsl,imx28-usb", "fsl,imx27-usb";
                        reg = <0x80090000 0x10000>;
                        interrupts = <92>;
-                       clocks = <&clks 61>;
+                       clocks = <&clks 61>, <&clks 61>, <&clks 61>;
+                       clock-names = "ipg", "ahb", "per";
                        fsl,usbphy = <&usbphy1>;
                        status = "disabled";
                };

I have USB otg+host working on v3.8 on an i.MX28.

So,
        Tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Regards,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
