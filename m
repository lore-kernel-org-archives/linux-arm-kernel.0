From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Sep 2015 10:38:45 -0500
Subject: [PATCH v4 1/3] leds: netxbig: add device tree binding
In-Reply-To: <1442505571-9744-2-git-send-email-simon.guinot@sequanux.org>
References: <1442505571-9744-1-git-send-email-simon.guinot@sequanux.org>
 <1442505571-9744-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <56002485.7030802@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2015 10:59 AM, Simon Guinot wrote:
> This patch adds device tree support for the netxbig LEDs.
> 
> This also introduces a additionnal DT binding for the GPIO extension bus
> (netxbig-gpio-ext) used to configure the LEDs. Since this bus could also
> be used to control other devices, then it seems more suitable to have it
> in a separate DT binding.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
>  .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++++
>  drivers/leds/leds-netxbig.c                        | 258 +++++++++++++++++++--
>  include/dt-bindings/leds/leds-netxbig.h            |  18 ++
>  4 files changed, 369 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
>  create mode 100644 include/dt-bindings/leds/leds-netxbig.h
> 
> Changes for v2:
> - Check timer mode value retrieved from DT.
> - In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
>   timer delay values from DT with function of_property_read_u32_index.
>   Instead, use a temporary u32 variable. This allows to silence a static
>   checker warning.
> - Make timer property optional in the binding documentation. It is now
>   aligned with the driver code.
> 
> Changes for v3:
> - Fix pointer usage with the temporary u32 variable while calling
>   of_property_read_u32_index.
> 
> Changes for v4:
> - In DT binding document netxbig-gpio-ext.txt, detail byte order for
>   registers and latch mechanism for "enable-gpio".
> - In leds-netxbig.c, add some error messages.
> - In leds-netxbig.c, fix some "sizeof" style issues.
> - In leds-netxbig.c, in netxbig_leds_get_of_pdata(), move the
>   of_property_read_string() calls after the error-prone checks.
> - Add some Acked-by.
> 
> diff --git a/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt b/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
> new file mode 100644
> index 000000000000..50ec2e690701
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
> @@ -0,0 +1,22 @@
> +Binding for the GPIO extension bus found on some LaCie/Seagate boards
> +(Example: 2Big/5Big Network v2, 2Big NAS).
> +
> +Required properties:
> +- compatible: "lacie,netxbig-gpio-ext".
> +- addr-gpios: GPIOs representing the address register (LSB -> MSB).
> +- data-gpios: GPIOs representing the data register (LSB -> MSB).
> +- enable-gpio: latches the new configuration (address, data) on raising edge.
> +
> +Example:
> +
> +netxbig_gpio_ext: netxbig-gpio-ext {
> +	compatible = "lacie,netxbig-gpio-ext";
> +
> +	addr-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH
> +		      &gpio1 16 GPIO_ACTIVE_HIGH
> +		      &gpio1 17 GPIO_ACTIVE_HIGH>;
> +	data-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH
> +		      &gpio1 13 GPIO_ACTIVE_HIGH
> +		      &gpio1 14 GPIO_ACTIVE_HIGH>;
> +	enable-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> +};
> diff --git a/Documentation/devicetree/bindings/leds/leds-netxbig.txt b/Documentation/devicetree/bindings/leds/leds-netxbig.txt
> new file mode 100644
> index 000000000000..efadbecbfeb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-netxbig.txt
> @@ -0,0 +1,92 @@
> +Binding for the CPLD LEDs (GPIO extension bus) found on some LaCie/Seagate
> +boards (Example: 2Big/5Big Network v2, 2Big NAS).
> +
> +Required properties:
> +- compatible: "lacie,netxbig-leds".
> +- gpio-ext: Phandle for the gpio-ext bus.

Would being a subnode of gpio-ext work instead?

> +
> +Optional properties:
> +- timers: Timer array. Each timer entry is represented by three integers:
> +  Mode (gpio-ext bus), delay_on and delay_off.
> +
> +Each LED is represented as a sub-node of the netxbig-leds device.
> +
> +Required sub-node properties:
> +- mode-addr: Mode register address on gpio-ext bus.
> +- mode-val: Mode to value mapping. Each entry is represented by two integers:
> +  A mode and the corresponding value on the gpio-ext bus.

I somewhat wonder if this is too low level and should just be in the
driver instead. I guess with only 3 addr and data lines, it is okay. It
wouldn't scale to a large number of registers though.

> +- bright-addr: Brightness register address on gpio-ext bus.
> +- bright-max: Maximum brightness value.

We already have a somewhat standard max-brightness property.
