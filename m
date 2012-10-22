From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 16:44:15 -0600
Subject: [PATCH v2 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <1350922139-3693-6-git-send-email-haojian.zhuang@gmail.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
 <1350922139-3693-6-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <5085CC3F.30708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 10:08 AM, Haojian Zhuang wrote:
> Add comments with pinconf & gpio range in the document of
> pinctrl-single.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-single.txt |   52 ++++++++++++++++++++
>  arch/arm/boot/dts/pxa910.dtsi                      |    1 -
>  2 files changed, 52 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> index 2c81e45..6da2f13 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> @@ -17,6 +17,36 @@ Optional properties:
>  - pinctrl-single,bit-per-mux : boolean to indicate that one register controls
>    more than one pin
>  
> +- pinctrl-single,gpio-ranges : gpio range list
> +
> +- pinctrl-single,gpio : array with gpio range start, size & register
> +  offset
> +
> +- pinctrl-single,gpio-func : gpio function value in the pinmux register

Some more explanation is needed here; some questions/comments:

1) Looking at the example, pinctrl-single,gpio-ranges is a property
within the main pinctrl node, whereas pinctrl-single,gpio and
pinctrl-single,gpio-func are properties within some other node. There's
no explanation of this in the binding description itself, only in the
example. Related to this, the documentation for
pinctrl-single,gpio-ranges doesn't say what it's a list of; it needs to
say that it's a list of phandles.

2) pinctrl-single,gpio is listed as optional. Presumably it's not; every
GPIO range node must have this property?

3) Why is pinctrl-single,gpio-func optional? Presumably you always need
to program the pinmux HW to select the GPIO function. Yet, the driver
code in an earlier patch seems to deliberately do nothing if this
property is missing. Shouldn't the DT parsing return an error instead?

4) I'm a little confused re: the data model. Is the idea that if
pinctrl-single,gpio-ranges is specified, then the node describes a
combined pin controller and GPIO HW? Are the pin IDs of the pin
controller expected to match the pin IDs of the GPIO HW? I'm left
wondering exactly which numbering space the values in
pinctrl-single,gpio are; do they describe the pin controller IDs that
this GPIO range describes, or do they describe the GPIO IDs that this
range describes and attempt to map them back to pin controller IDs?
Similarly, I'm not sure why there's a register offset here rather than
say a pin controller pin ID number. Shouldn't the property be a list of
<pin-controller-pin-ID GPIO-controller-GPIO-ID number-of-GPIOs>

> +- pinctrl-single,power-source-mask : mask of setting power source in
> +  the pinmux register
> +
> +- pinctrl-single,power-source : value of setting power source field
> +  in the pinmux register
> +
> +- pinctrl-single,bias-mask : mask of setting bias value in the pinmux
> +  register
> +
> +- pinctrl-single,bias-disable : value of disabling bias in the pinmux
> +  register
> +
> +- pinctrl-single,bias-pull-down : value of setting bias pull down in
> +  the pinmux register
> +
> +- pinctrl-single,bias-pull-up : value of setting bias pull up in the
> +  pinmux register
> +
> +- pinctrl-single,bias : value of setting bias in the pinmux register
> +
> +- pinctrl-single,input-schmitt-mask : mask of setting input schmitt
> +  in the pinmux register

I suppose it's OK that a generic pin controller binding would use the
generic pin configuration config options. I'm still not convinced that
the semantics of generic pin control make sense. Maybe if they're just
arbitrary names for SoC-specific things it's fine though.

Do these patches expose /all/ generic pin configuration options? It
doesn't seem worth exposing only some of them and ignoring others.

> +/* third controller instance for pins in gpio domain */
> +pmx_gpio: pinmux at d401e000 {
> +	compatible = "pinctrl-single";
> +	reg = <0xd401e000 0x0330>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;

#gpio-cells would be needed here for a GPIO controller.

> diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi

> -				pinctrl-single,gpio-mask = <7>;

I assume that's a mistake; the line shouldn't be removed in this
documentation patch?
