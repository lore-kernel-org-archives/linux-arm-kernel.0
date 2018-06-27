From: nikita.yoush@yandex.ru (Nikita Yushchenko)
Date: Wed, 27 Jun 2018 10:11:40 +0300
Subject: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
In-Reply-To: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
Message-ID: <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	i2c_gpio: i2c-gpio {
> +		compatible = "i2c-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_swi2c>;
> +		i2c-gpio,delay-us = <50>;
> +		status = "okay";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};

You add i2c-gpio node to dtsi file without defining gpios, with reference
to pinctrl not defined inside your dtsi file or it's includes, and without
any usage inside dtsi file.

Saving several text lines that way is a bad idea. Please move it to where
it is fully defined and used.

> +&usb_vbus {
> +	regulator-always-on;

usb_vbus is regilator-fixed, what for is this?

> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};

In your further patches you include this and then revert by marking &uart2 as
disabled. Better to enable it in dts for boards that have it.

Same with ecspi2, ipu and maybe more.

> -	flash at 1 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "atmel,at45db642d", "atmel,at45", "atmel,dataflash";
> -		spi-max-frequency = <25000000>;
> -		reg = <1>;
> -	};

> +	flash at 1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "atmel,at45", "atmel,dataflash";
> +		spi-max-frequency = <25000000>;
> +		reg = <1>;
> +	};

Lost a compatible key?

> -			sysled0 at 3 {
> -				reg = <3>;
> -				label = "system:green:status";
> -				linux,default-trigger = "default-on";
> -			};

> +			sysled3: led3 at 3 {
> +				reg = <3>;
> +				label = "system:red:power";
> +				linux,default-trigger = "default-on";
> +			};

> +&sysled3 {
> +	label = "system:green:status";
 
What for this label games?
Maybe just define things for boards that use it?
