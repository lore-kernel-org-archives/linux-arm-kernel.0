From: info@lategoodbye.de (Stefan Wahren)
Date: Wed, 19 Aug 2015 22:38:35 +0200
Subject: [PATCH v2 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <1439934848-7196-2-git-send-email-eric@anholt.net>
References: <1439934848-7196-1-git-send-email-eric@anholt.net>
 <1439934848-7196-2-git-send-email-eric@anholt.net>
Message-ID: <55D4E94B.8080103@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Am 18.08.2015 um 23:54 schrieb Eric Anholt:
> VC4 is the GPU (display and 3D) subsystem present on the 2835 and some
> other Broadcom SoCs.
>
> This binding follows the model of msm, imx, sti, and others, where
> there is a subsystem node for the whole GPU, with nodes for the
> individual HW components within it.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: Extend the commit message, fix several nits from Stephen Warren.
>
>   .../devicetree/bindings/gpu/brcm,bcm-vc4.txt       | 79 ++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>
> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
> new file mode 100644
> index 0000000..1b9fedc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
> @@ -0,0 +1,79 @@
> +Broadcom VC4 GPU
> +
> +The VC4 device present on the Raspberry Pi includes a display system
> +with HDMI output and the HVS scaler for compositing display planes.
> +
> +Required properties for VC4:
> +- compatible:	Should be "brcm,vc4"
> +- crtcs:	List of phandles of pixelvalve scanout engines
> +- hvss:		List of phandles of HVS video scalers
> +- encoders:	List of phandles of output encoders (HDMI, SDTV)
> +
> +Required properties for Pixel Valve:
> +- compatible:	Should be "brcm,vc4-pixelvalve"
> +- reg:		Physical base address and length of the PV's registers
> +- interrupts:	The interrupt number
> +		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +
> +Required properties for HVS:
> +- compatible:	Should be "brcm,vc4-hvs"
> +- reg:		Physical base address and length of the HVS's registers
> +- interrupts:	The interrupt number
> +		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +
> +Required properties for HDMI
> +- compatible:	Should be "brcm,vc4-hdmi"
> +- reg:		Physical base address and length of the two register ranges
> +		  ("HDMI" and "HD", in that order)
> +- interrupts:	The interrupt numbers
> +		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +- ddc:		phandle of the I2C controller used for DDC EDID probing
> +- crtc:		phandle to the pixelvalve CRTC the HDMI encoder is attached to
> +
> +Optional properties for HDMI:
> +- hpd-gpio:	The GPIO pin for HDMI hotplug detect (if it doesn't appear
> +		  as an interrupt/status bit in the HDMI controller
> +		  itself).  See bindings/pinctrl/brcm,bcm2835-gpio.txt
> +
> +Example:
> +pv0: brcm,vc4-pixelvalve at 7e206000 {

AFAIK the DT node name should describe the function and usually don't 
have a vendor prefix. Here some possible suggestions without deeper 
knowledge of the hardware function:

pv0: pixelvalve

> +	compatible = "brcm,vc4-pixelvalve";
> +	reg = <0x7e206000 0x100>;
> +	interrupts = <2 13>; /* pwa2 */
> +};
> +
> +pv1: brcm,vc4-pixelvalve at 7e207000 {

pv1: pixelvalve

> +	compatible = "brcm,vc4-pixelvalve";
> +	reg = <0x7e207000 0x100>;
> +	interrupts = <2 14>; /* pwa1 */
> +};
> +
> +pv2: brcm,vc4-pixelvalve at 7e807000 {

pv2: pixelvalve

> +	compatible = "brcm,vc4-pixelvalve";
> +	reg = <0x7e807000 0x100>;
> +	interrupts = <2 10>; /* pixelvalve */
> +};
> +
> +hvs: brcm,hvs at 7e400000 {

hvs: hvs

> +	compatible = "brcm,vc4-hvs";
> +	reg = <0x7e400000 0x6000>;
> +	interrupts = <2 1>;
> +};
> +
> +hdmi: brcm,vc4-hdmi at 7e902000 {

hdmi: hdmi

> +	compatible = "brcm,vc4-hdmi";
> +	reg = <0x7e902000 0x600>,
> +	      <0x7e808000 0x100>;
> +	interrupts = <2 8>, <2 9>;
> +	ddc = <&i2c2>;
> +	hpd-gpio = <&gpio 46 GPIO_ACTIVE_HIGH>;
> +	crtc = <&pv2>;
> +};
> +
> +vc4: vc4 at 0x7e4c0000 {

vc4: gpu

Regards
Stefan

> +	compatible = "brcm,vc4";
> +
> +	crtcs = <&pv0>, <&pv1>, <&pv2>;
> +	encoders = <&hdmi>;
> +	hvss = <&hvs>;
> +};
>
