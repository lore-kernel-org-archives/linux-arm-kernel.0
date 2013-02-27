From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 27 Feb 2013 17:29:21 +0100
Subject: [PATCH] otg-for-v3.9-v1: USB otg: fix usage of
 try_module_get() and module_put()
In-Reply-To: <1361974273-17087-1-git-send-email-mkl@pengutronix.de>
References: <1361974273-17087-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20130227162921.GB10491@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 03:11:12PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> this patch is intended for v3.9 and applies to Greg's usb/master tree. If fixes
> the use of try_module_get() and module_put() in all usb_get_phy functions.
> 
> regards,
> Marc
> 
> 
> The following changes since commit 74e1a2a39355b2d3ae8c60c78d8add162c6d7183:
> 
>   Merge tag 'usb-3.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2013-02-21 12:20:00 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.pengutronix.de/git/mkl/linux.git tags/otg-for-v3.9-v1
> 
> for you to fetch changes up to 6bef020b4aebd7886281fb7fb37c788d5a365eea:
> 
>   USB otg: use try_module_get in all usb_get_phy functions and add missing module_put (2013-02-27 12:53:15 +0100)
> 
> ----------------------------------------------------------------
> USB otg: add missing try_module_get and module_put
> 
> Add try_module_get() to usb_get_phy() and usb_get_phy_dev().  Further the
> missing module_put() is added to usb_put_phy()
> 
> ----------------------------------------------------------------
> Marc Kleine-Budde (1):
>       USB otg: use try_module_get in all usb_get_phy functions and add missing module_put
> 
>  drivers/usb/otg/otg.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> 
> 
> 

Hi,

with this series plus
        otg-for-v3.10-v1: separate phy code and add DT helper
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
