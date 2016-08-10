From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 10 Aug 2016 11:02:54 +0800
Subject: [PATCH v5 6/6] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB
 property
In-Reply-To: <57AA684F.4020004@gmail.com>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
 <1470646331-23227-7-git-send-email-peter.chen@nxp.com>
 <57AA684F.4020004@gmail.com>
Message-ID: <20160810030254.GD1879@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 04:33:35PM -0700, Joshua Clayton wrote:
> Hi Peter,
> 
> On 08/08/2016 01:52 AM, Peter Chen wrote:
> > The current dts describes USB HUB's property at USB controller's
> > entry, it is improper. The USB HUB should be the child node
> > under USB controller, and power sequence properties are under
> > it.
> >
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-udoo.dtsi | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> > index 3bee2f9..f29a72c2f 100644
> > --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> > @@ -9,6 +9,8 @@
> >   *
> >   */
> >  
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> >  / {
> >  	aliases {
> >  		backlight = &backlight;
> > @@ -58,17 +60,6 @@
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> >  
> > -		reg_usb_h1_vbus: regulator at 0 {
> > -			compatible = "regulator-fixed";
> > -			reg = <0>;
> > -			regulator-name = "usb_h1_vbus";
> > -			regulator-min-microvolt = <5000000>;
> > -			regulator-max-microvolt = <5000000>;
> > -			enable-active-high;
> > -			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
> > -			gpio = <&gpio7 12 0>;
> > -		};
> > -
> >  		reg_panel: regulator at 1 {
> >  			compatible = "regulator-fixed";
> >  			reg = <1>;
> > @@ -259,9 +250,18 @@
> >  &usbh1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_usbh>;
> > -	vbus-supply = <&reg_usb_h1_vbus>;
> > -	clocks = <&clks IMX6QDL_CLK_CKO>;
> >  	status = "okay";
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> Assuming they are needed,
> #address-cells and #size-cells should go in imx6qdl.dtsi,
> rather than in board dts files, shouldn't they?

Yes, you are right. All imx USB controller has only one port.


> > +	usb2415: hub at 1 {
> > +		compatible = "usb424,2514";
> > +		reg = <1>;
> Does <reg>  have any effect?
> I couldn't find any reference to it in the patches.
> (so apologies if it is in core code)
> Does it matter?

Please see 69bec7259853 ("USB: core: let USB device know device node")
for detail.

> Would it be possible to connect
> more than one hub to the same usb phy?

No possible for current imx, but possible for other SoCs.

-- 

Best Regards,
Peter Chen
