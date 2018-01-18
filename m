From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 Jan 2018 11:07:45 +0100
Subject: [PATCH 1/1] ARM: dts: sunxi: Add Olimex A20-SOM204-EVB board
In-Reply-To: <1b9667a4-75de-4ece-069d-7ec33b7e2f8d@olimex.com>
References: <1515747666-6597-1-git-send-email-stefan@olimex.com>
 <20180115095031.pzsgrp3tdmemotrs@flea.lan>
 <1b9667a4-75de-4ece-069d-7ec33b7e2f8d@olimex.com>
Message-ID: <20180118100745.y62adzvfnrzqkagd@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Jan 15, 2018 at 12:07:34PM +0200, Stefan Mavrodiev wrote:
> > > +/dts-v1/;
> > > +#include "sun7i-a20.dtsi"
> > > +#include "sunxi-common-regulators.dtsi"
> > > +
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > +#include <dt-bindings/pwm/pwm.h>
> > > +
> > > +/ {
> > > +	model = "Olimex A20-SOM204-EVB";
> > > +	compatible = "olimex,a20-olimex-som204-evb", "allwinner,sun7i-a20";
> > > +
> > > +	aliases {
> > > +		serial0 = &uart0;
> > > +		serial1 = &uart4;
> > > +		serial2 = &uart7;
> > > +		spi0 = &spi1;
> > > +		spi1 = &spi2;
> > > +		ethernet1 = &rtl8723bs;
> >
> > ethernet1? if there's a single network interface, it should be
> > ethernet0.
>
> I think this will conflict the gmac alias defined in sun7i-a20.dtsi:
> 
> aliases {
> ??? ethernet0 = &gmac;
> };

We have that? That's bad, but you're right :)

> > > +		stat {
> > > +			label = "a20-som204:green:stat";
> > > +			gpios = <&pio 8 0 GPIO_ACTIVE_HIGH>;
> > > +			default-state = "on";
> > > +		};
> > > +
> > > +		led1 {
> > > +			label = "a20-som204-evb:green:led1";
> > > +			gpios = <&pio 8 10 GPIO_ACTIVE_HIGH>;
> > > +			default-state = "on";
> > > +		};
> > > +
> > > +		led2 {
> > > +			label = "a20-som204-evb:yellow:led2";
> > > +			gpios = <&pio 8 11 GPIO_ACTIVE_HIGH>;
> > > +			default-state = "on";
> > > +		};
> >
> > You don't have the same prefix between stat and led1/led2. I'm fine
> > with both, but you should be consistent :)
>
> STAT led is on the SOM204 module, while led1/2 on the EVB. Thats why
> they have different prefix.

Still, the user and the system will see it as a single board, and the
documentation states that it should be the board name. I'm not quite
sure what a good rule would be here. Have you looked at how other
boards dealt with it? Chen-Yu, any opinion on this?

> > 
> > > +	};
> > > +
> > > +	mmc2_pwrseq: mmc2_pwrseq {
> > > +		compatible = "mmc-pwrseq-emmc";
> > > +		reset-gpios = <&pio 2 16 GPIO_ACTIVE_LOW>;
> > > +	};
> > This is already declared in the emmc variant, isn't it?
> > 
> > > +	rtl_pwrseq: rtl_pwrseq {
> > > +		compatible = "mmc-pwrseq-simple";
> > > +		reset-gpios = <&pio 6 9 GPIO_ACTIVE_LOW>,
> > > +			      <&pio 1 11 GPIO_ACTIVE_LOW>;
> > > +	};
> >
> > It looks suspicious that you have two reset lines.
>
> RTL8723BS is comblo WiFI/BT module. There is separate reset control
> for each of the systems.

You should tie the reset line to their associated device then. In this
case, you're linking the BT reset line to the wifi device, which in
turn means that if your MMC driver is not loaded / enabled, the BT
part will not work. That's obviously not ideal.

> > > +&spi1 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&spi1_pins_a>,
> > > +		    <&spi1_cs0_pins_a>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&spi2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&spi2_pins_a>,
> > > +		    <&spi2_cs0_pins_a>;
> > > +	status = "okay";
> > > +};
> > What is connected on those buses
>
> As mentioned SPI1/2 are exposed to UEXT1/2.

Ok, please make that a comment.

> > 
> > > +&uart0 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&uart0_pins_a>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&uart3 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&bt_uart_pins>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&uart4 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&uart4_pins_a>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&uart7 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&uart7_pins_a>;
> > > +	status = "okay";
> > > +};
> > Same thing for these three UARTs
>
> Uart3 is used for H5 BT protocol. UART4/7 are exposed to UEXT.

Ok, comments for those as well then :)

yyThanks!
maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/2a834bd3/attachment.sig>
