From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 27 Nov 2015 21:27:38 +0100
Subject: [PATCH 2/2] ARM: mvebu: kirkwood: add PogoPlug series 4 device
 tree
In-Reply-To: <1448578868-6323-1-git-send-email-linus.walleij@linaro.org>
References: <1448578868-6323-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151127202738.GC32356@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +		stdout-path = &uart0;

Hi Linus

You can append the baud rate etc to uart0, and then don't need
bootargs.

> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_button_eject>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			debounce_interval = <50>;
> +			wakeup-source;
> +			/* KEY_EJECTCD */
> +			linux,code = <161>;

include/dt-bindings/input/linux-event-codes.h and then

	                linux,code = <KEY_EJECTCD>

> +			label = "Eject Button";
> +			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_led_green &pmx_led_red>;
> +		pinctrl-names = "default";
> +
> +		health {
> +			label = "status:green:health";

The convention is that the first part of the label is the machine
name. OpenWRT and others often does something else... So

s/status/pogoplugv4/g
 
> +			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
> +			default-state = "on";
> +		};
> +		fault {
> +			label = "status:red:fault";
> +			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};


> +&i2c0 {
> +	status = "okay";
> +};

Is there something on this i2c bus?

Thanks
	Andrew
