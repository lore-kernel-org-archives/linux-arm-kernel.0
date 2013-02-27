From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 27 Feb 2013 17:31:27 +0100
Subject: [PATCH 0/5] chipidea-for-v3.10-v1: USB chipidea: make use of
 DT helpers in chipidea driver improve driver
In-Reply-To: <1361974830-3853-1-git-send-email-mkl@pengutronix.de>
References: <1361974830-3853-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20130227163127.GD10491@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 03:20:25PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> this series depends on the series "[PATCH 0/3] otg-for-v3.10-v1: separate phy
> code and add DT helper" (a.k.a. tags/otg-for-v3.10-v1) posted earlier and is
> intended for v3.10. The chipidea driver is converted to make use of the DT
> helper functions.
> 
> regards,
> Marc
> 
> 
> The following changes since commit 8a4c9f8489b2fce9e7bf0eb43fdb160ab51adc2c:
> 
>   USB mxs-phy: Register phy with framework (2013-02-27 13:48:21 +0100)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/mkl/linux.git tags/chipidea-for-v3.10-v1
> 
> for you to fetch changes up to 5d837224ea36da50f3e744a65fb23af1fa0a480d:
> 
>   USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy (2013-02-27 13:49:07 +0100)
> 
> ----------------------------------------------------------------
> USB chipidea: make use of DT helpers in chipidea driver
> 
> Make use of DT helper functions for handling the dr_mode and phy_type property.
> 
> ----------------------------------------------------------------
> Michael Grzeschik (2):
>       USB chipidea: ci13xxx-imx: create dynamic platformdata
>       USB chipidea: add PTW and PTS handling
> 
> Sascha Hauer (3):
>       USB chipidea: introduce dual role mode pdata flags
>       USB chipidea i.MX: introduce dr_mode property
>       USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy
> 
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 ++
>  drivers/usb/chipidea/bits.h                        |   14 +++-
>  drivers/usb/chipidea/ci13xxx_imx.c                 |   67 +++++++++++---------
>  drivers/usb/chipidea/core.c                        |   61 ++++++++++++++++--
>  include/linux/usb/chipidea.h                       |    3 +-
>  5 files changed, 112 insertions(+), 39 deletions(-)
> 
> 
> 
> 

Hi,

with this series plus
        otg-for-v3.9-v1: USB otg: fix usage of try_module_get() and module_put()
	otg-for-v3.10-v1: separate phy code and add DT helper
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
