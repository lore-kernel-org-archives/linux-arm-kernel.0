From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Aug 2015 08:56:14 -0500
Subject: [PATCH 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <1439427380-2436-2-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-2-git-send-email-eric@anholt.net>
Message-ID: <CAL_JsqKhfQS46NwbTq0PNDpnNuztnRkcK+WDhFMaayE_8dDt3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 7:56 PM, Eric Anholt <eric@anholt.net> wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/gpu/brcm,bcm-vc4.txt       | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>
> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
> new file mode 100644
> index 0000000..2b13e61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
> @@ -0,0 +1,83 @@
> +Broadcom VC4 GPU
> +
> +The VC4 device present on the Raspberry Pi includes a display system
> +with HDMI output and the HVS scaler for compositing display planes.
> +
> +Required properties for VC4:
> +- compatible:  Should be "brcm,vc4"
> +- crtcs:       List of references to pixelvalve scanout engines
> +- hvss:                List of references to HVS video scalers
> +- encoders:    List of references to output encoders (HDMI, SDTV)

Creating these links is what the OF graph binding is for. Please use
it. Plus this is a DRMism in the binding.

> +
> +Required properties for Pixel Valve:
> +- compatible:  Should be "brcm,vc4-pixelvalve"

There's only one version of IP and all chips have the same bugs? You
should have chip names in the compatible strings.

> +- reg:         Physical base address and length of the PV's registers
> +- interrupts:  The interrupt number
> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +
> +Required properties for HVS:
> +- compatible:  Should be "brcm,vc4-hvs"
> +- reg:         Physical base address and length of the HVS's registers
> +- interrupts:  The interrupt number
> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +
> +Required properties for HDMI
> +- compatible:  Should be "brcm,vc4-hdmi"
> +- reg:         Physical base address and length of the two register ranges
> +                 ("HDMI" and "HD")
> +- interrupts:  The interrupt numbers
> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +- ddc:         phandle of the I2C controller used for DDC EDID probing
> +- crtc:                phandle to the pixelvalve CRTC the HDMI encoder is attached to

Same comment about OF graph.

> +
> +Optional properties for HDMI:
> +- hpd-gpio:    The GPIO pin for HDMI hotplug detect (if it doesn't appear
> +                 as an interrupt/status bit in the HDMI controller
> +                 itself).  See bindings/pinctrl/brcm,bcm2835-gpio.txt

Use the hdmi-connector binding. This doesn't belong here. The clue is
your comment in parenthesis.

Rob
