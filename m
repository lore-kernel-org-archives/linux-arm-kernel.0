From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Sun, 4 Sep 2016 22:13:22 +0200
Subject: [PATCH 1/1] ARM: dts: sun8i: Add dts file for the NanoPi NEO SBC
In-Reply-To: <1472701734-1837-1-git-send-email-james@innovum.com.au>
References: <1472701734-1837-1-git-send-email-james@innovum.com.au>
Message-ID: <20160904201322.ec4rovp24fxp2dn5@x1-6-00-0f-9f-c6-3e-90.cpe.webspeed.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 01:48:54PM +1000, james at innovum.com.au wrote:

> +#include <dt-bindings/input/input.h>

You don't seem to use anything from that header file.

> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
> +/ {
> +	model = "FriendlyARM NanoPi NEO";
> +	compatible = "friendlyarm,nanopi-neo", "allwinner,sun8i-h3";

It is good practice to add new vendor prefixes to the list in
Documentation/devicetree/bindings/vendor-prefixes.txt (sorted alphabetially
by vendor prefix).

> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_opc>, <&leds_r_opc>;
> +
> +		pwr_led {
> +			label = "nanopi:green:pwr";
> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +
> +		status_led {
> +			label = "nanopi:blue:status";
> +			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
> +		};
> +	};

Node names should not have underscores in them. [1][2]
IMHO the _led suffix is unnecessary inside leds { }.
I think you should add a comment with the name of the GPIO pin like you
did with &mmc0/cd-gpios.

> +&pio {
> +	leds_opc: led_pins at 0 {
> +		allwinner,pins = "PA10";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +};

Use hyphens instead of underscores in node names. Also, unit addresses and
reg properties go together. Either you have both or you have neither. So
drop the @0 part of the node name. You'll get warnings about this sort of
mismatch when your device tree is compiled as part of Das U-Boot.

> +&r_pio {
> +	leds_r_opc: led_pins at 0 {

Likewise.

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
[2] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html

-- 
Rask Ingemann Lambertsen
