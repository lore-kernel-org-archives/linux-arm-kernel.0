From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 May 2016 14:00:35 +0200
Subject: [PATCH 3/3] ARM: dts: clps711x: Add basic Cirrus Logic CDB89712
 Development board
In-Reply-To: <1463138788-5390-4-git-send-email-shc_work@mail.ru>
References: <1463138788-5390-1-git-send-email-shc_work@mail.ru>
 <1463138788-5390-4-git-send-email-shc_work@mail.ru>
Message-ID: <9407200.bOeiVUkGKT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 May 2016 14:26:28 Alexander Shiyan wrote:
> +&bus {
> +	flash: root at 00000000 {
> +		compatible = "cfi-flash";
> +		reg = <0 0x00000000 0x01000000>;
> +		bank-width = <2>;
> +		linux,mtd-name = "physmap-flash.0";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};

I've never seen the linux,mtd-name property before, but I think it's
meant to refer to the name of the flash chip, not the
name of the linux device.

> +	aliases {
> +		gpio0 = &porta;
> +		gpio1 = &portb;
> +		gpio2 = &portc;
> +		gpio3 = &portd;
> +		gpio4 = &porte;
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		spi0 = &spi;
> +		timer0 = &timer1;
> +		timer1 = &timer2;
> +	};

Please move this into the .dts file: not all boards necessarily have
all of the above.

> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&intc>;
> +		ranges;

All child devices seem to be in the 0x80000000-0x90000000
range, maybe set the ranges property accordingly?

> +		clks: clks at 80000000 {
> +			#clock-cells = <1>;
> +			compatible = "cirrus,clps711x-clk";
> +			reg = <0x80000000 0xc000>;
> +			startup-frequency = <73728000>;
> +		};

Please fix the compatible strings for all devices to not
have 'x' for wildcards. Normally you'd use the name of hte
first chip to have this particular IP block.

> +		intc: intc at 80000000 {
> +			compatible = "cirrus,clps711x-intc";
> +			reg = <0x80000000 0x4000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};

Better make the register ranges non-overlapping. This appears
to start at the same place as the 'clks' node.

> +		porta: gpio at 80000000 {
> +			compatible = "cirrus,clps711x-gpio";
> +			reg = <0x80000000 0x1 0x80000040 0x1>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		portb: gpio at 80000001 {
> +			compatible = "cirrus,clps711x-gpio";
> +			reg = <0x80000001 0x1 0x80000041 0x1>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		portc: gpio at 80000002 {
> +			compatible = "cirrus,clps711x-gpio";
> +			reg = <0x80000002 0x1 0x80000042 0x1>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		portd: gpio at 80000003 {
> +			compatible = "cirrus,clps711x-gpio";
> +			reg = <0x80000003 0x1 0x80000043 0x1>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};

These are all just single bytes. My guess is that there is
actually one IP block that contains all the gpios, not
four identical blocks.

> +		bus: bus at 80000180 {
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			compatible = "cirrus,clps711x-bus", "simple-bus";
> +			clocks = <&clks CLPS711X_CLK_BUS>;
> +			reg = <0x80000180 0x80>;

If it has registers, it's not a 'simple-bus'. Is this an external
bus controller perhaps?

	Arnd
