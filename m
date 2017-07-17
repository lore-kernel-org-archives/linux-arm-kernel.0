From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Jul 2017 09:54:34 +0200
Subject: [PATCH] ARM: dts: Add DTS file for D-Link DIR-685
In-Reply-To: <20170715170511.16312-1-linus.walleij@linaro.org>
References: <20170715170511.16312-1-linus.walleij@linaro.org>
Message-ID: <CAMuHMdXmCOOuM_s1MS8o1RcAnV5mVfOwtj9DEuVisnQAT1tCVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 15, 2017 at 7:05 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds a device tree file for the Gemini-based D-Link DIR-685
> router, supporting all devices that are currently supported in
> the main DTSI SoC file.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> --- /dev/null
> +++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> @@ -0,0 +1,190 @@
> +/*
> + * Device Tree file for D-Link DIR-685 Xtreme N Storage Router
> + */
> +
> +/dts-v1/;
> +
> +#include "gemini.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +       model = "D-Link DIR-685 Xtreme N Storage Router";
> +       compatible = "dlink,dir-685", "cortina,gemini";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       memory {
> +               /* 128 MB SDRAM in 2 x Hynix HY5DU121622DTP-D43 */
> +               device_type = "memory";
> +               reg = <0x00000000 0x8000000>;
> +       };
> +
> +       chosen {
> +               bootargs = "console=ttyS0,19200n8";

I think you can drop bootargs, as stdout-path is present.

> +               stdout-path = &uart0;

stdout-path = "uart0:115200n8";

> +       };
> +
> +       gpio_keys {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               button at 8 {

unit address without reg property ("make dtbs W=1 should tell you").

button-esc { ... } ?

> +                       debounce_interval = <50>;
> +                       wakeup-source;
> +                       linux,code = <KEY_ESC>;
> +                       label = "reset";
> +                       gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
> +               };
> +               button at 13 {

button-eject { ... } ?

> +                       debounce_interval = <50>;
> +                       wakeup-source;
> +                       linux,code = <KEY_EJECTCD>;
> +                       label = "unmount";
> +                       gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               led at 7 {

unit address without reg property ("make dtbs W=1 should tell you").

led-wps?

> +                       label = "dir685:blue:WPS";
> +                       gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
> +                       default-state = "on";
> +                       linux,default-trigger = "heartbeat";
> +               };
> +               /*
> +                * These two LEDs are on the side of the device.
> +                * For electrical reasons, both LEDs cannot be active
> +                * at the same time so only blue or orange can on at
> +                * one time. Enabling both makes the LED go dark.
> +                */
> +               led at 11 {

led-blue? (does it have a label on the box? HD1?)

> +                       label = "dir685:blue:HD";

Looks like a legacy platform device name, not a DT label.

> +                       gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
> +                       default-state = "off";
> +               };
> +               led at 12 {

led-orange? (does it have a label on the box? HD2?)

> +                       label = "dir685:orange:HD";

Looks like a legacy platform device name, not a DT label.

> +                       gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +                       default-state = "off";
> +               };
> +       };

> +       gpio-i2c {
> +               compatible = "i2c-gpio";
> +               gpios = <&gpio0 5 0>, /* SDA */
> +                       <&gpio0 6 0>; /* SCL */

The i2c-gpio DT bindings really should be amended to support (optional)
gpio-names.

> +       soc {
> +               flash at 30000000 {

Would be easier to notice this is an override if the flash node in
gemini.dtsi had a label.

> +                       status = "okay";
> +                       /* 32MB of flash */
> +                       reg = <0x30000000 0x02000000>;
> +
> +                       /*
> +                        * This "RedBoot" is the Storlink derivative.
> +                        */
> +                       partition at 0 {

Shouldn't partitions be in a subnode named "partitions"?

> +                               label = "RedBoot";
> +                               reg = <0x00000000 0x00040000>;
> +                               read-only;
> +                       };

> +               sata: sata at 46000000 {

"&sata {", and move outside hierarchy.

> +                       cortina,gemini-ata-muxmode = <0>;
> +                       cortina,gemini-enable-sata-bridge;
> +                       status = "okay";
> +               };
> +
> +               pci at 50000000 {

Add "pci" label to gemini.dtsi, "&pci {", and move outside hiearchy.

> +                       status = "okay";

> +               ata at 63000000 {

Add "ata" label to gemini.dtsi, "&pci {", and move outside hiearchy.

> +                       status = "okay";
> +               };
> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
