From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 16:08:59 -0600
Subject: [PATCH v3 2/3] ARM: bcm281xx: Device Tree bindings for GPIO driver
In-Reply-To: <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
References: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
 <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <51F2F37B.8030306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(CC'ing the DT bindings maintainers hence quoting the binding in full)

On 07/26/2013 02:25 PM, Markus Mayer wrote:

Some kind of patch description is always useful.

>  .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   41 ++++++++++++++++++++
>  arch/arm/boot/dts/bcm11351.dtsi                    |   16 ++++++++

It's more usual to put the DT binding doc change and driver change in
one patch, then "make use of that" in a later separate patch which edits
*.dts and *.dtsi.

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt b/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt

> +Broadcom Kona Family GPIO
> +-------------------------
> +
> +This GPIO driver is used in the following Broadcom SoCs:
> +  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> +
> +The GPIO controller only supports edge, not level triggering.

add "... of interrupts"? This might not be worth mentioning; it's
clearly spelled out in the description of the interrupt cells below.

> +Required properties:
> +  - compatible: "brcm,kona-gpio"
> +  - reg: Physical base address and length of the controller's registers.
> +  - interrupts: The interrupt outputs from the controller.

How many entries are required? I notice there's more than 1 in the
example below.

> +  - #gpio-cells: Should be <2>. The first cell is the pin number, the second
> +    cell is used to specify optional parameters:
> +    - bit 0 specifies polarity (0 for normal, 1 for inverted)
> +  - #interrupt-cells: Should be <2>. The first cell is the GPIO number.
> +    The second cell is used to specify flags:
> +    - trigger type (bits[1:0]):
> +        1 = low-to-high edge triggered.
> +        2 = high-to-low edge triggered.
> +        3 = low-to-high or high-to-low edge triggered
> +        Valid values are 1, 2, 3
> +  - gpio-controller: Marks the device node as a GPIO controller.
> +  - interrupt-controller: Marks the device node as an interrupt controller.
> +
> +Example:
> +	gpio: gpio at 35003000 {
> +		compatible = "brcm,kona-gpio";
> +		reg = <0x35003000 0x800>;
> +		interrupts =
> +		       <0x0 106 0x4
> +			0x0 115 0x4
> +			0x0 114 0x4
> +			0x0 113 0x4
> +			0x0 112 0x4
> +			0x0 111 0x4>;
> +		#gpio-cells = <2>;
> +		#interrupt-cells = <2>;
> +		gpio-controller;
> +		interrupt-controller;
> +	};

> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi

> +	gpio: gpio at 35003000 {
> +		compatible = "brcm,kona-gpio";

In order to enable any later chip-specific quirking requirements, that
compatible property should both specify the IP block and the specific
chip it's included in, so I'd expect to see something like:

		compatible = "brcm,brcm11351-gpio", "brcm,kona-gpio";
