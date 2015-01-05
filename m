From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 05 Jan 2015 15:34:51 +0100
Subject: [PATCH 3/3] ARM: mvebu: Add Armada 385 General Purpose Development
 Board support
In-Reply-To: <20141227115029.GD21001@lunn.ch>
References: <1419678035-10658-1-git-send-email-gregory.clement@free-electrons.com>
 <1419678035-10658-4-git-send-email-gregory.clement@free-electrons.com>
 <20141227115029.GD21001@lunn.ch>
Message-ID: <54AAA10B.5040502@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 27/12/2014 12:50, Andrew Lunn wrote:
[...]
>> +
>> +			i2c at 11000 {
>> +				status = "okay";
>> +				clock-frequency = <100000>;
>> +
>> +				pca9555_0: pca9555 at 20 {
> 
> I think Sebastian will come along and ask this is called gpio, not
> pca9555_0. See the review he made of the Seagate Black NAS box.

OK, I was not very inspired when I chose it. I will have a look on
Sebastien review.

> 
>> +					compatible = "nxp,pca9555";
>> +					pinctrl-names = "default";
>> +					pinctrl-0 = <&pca0_pins>;
>> +					interrupt-parent = <&gpio0>;
>> +					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
>> +					gpio-controller;
>> +					#gpio-cells = <2>;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +					reg = <0x20>;
>> +				};
>> +
>> +				pca9555_1: pca9555 at 21 {
>> +					compatible = "nxp,pca9555";
>> +					pinctrl-names = "default";
>> +					interrupt-parent = <&gpio0>;
>> +					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +					gpio-controller;
>> +					#gpio-cells = <2>;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +
> 
> Maybe remove the blank lines here, to make it similar to the previous
> one?

OK
> 
>> +					reg = <0x21>;
>> +				};
>> +
> 
> Maybe remove this blank line?
> 
>> +			};
>> +
>> +			serial at 12000 {
>> +				status = "okay";
>> +			};
> 
> It would be nice if you can document the connector number and the
> pinout of the serial port, if it is not on the silk screen.

The serial port is output through an FTDI on an micro-USB connector, I will
add this information in the comment.

[...]

>> +		gpio-fan {
>> +			compatible = "gpio-fan";
>> +			gpios = <&pca9555_1 3 GPIO_ACTIVE_HIGH>;
>> +			gpio-fan,speed-map = <0 0 3000 1>;
> 
> It would be nice to format this with a newline between the two map
> entries.

I copied and pasted what have been done on armada-370-rd.dts but I have no
problem to change it according to your comment.

[...]

>> +	reg_5v_sata2: v5-sata2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v5.0-sata2";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata2>;
>> +	};
>> +
>> +	reg_12v_sata2: v12-sata2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v12.0-sata2";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata2>;
>> +	};
>> +
>> +	reg_sata3: pwr-sata3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "pwr_en_sata3";
>> +		enable-active-high;
>> +		regulator-always-on;
>> +		gpio = <&pca9555_0 12 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	reg_5v_sata3: v5-sata3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v5.0-sata3";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata3>;
>> +	};
>> +
>> +	reg_12v_sata3: v12-sata3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v12.0-sata3";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata3>;
>> +	};
>> +};
> 
> What is the quality of the power supply? What you often see if that
> SATA drives are spun up sequentially, in order to not strain the power

I don't think it is the case here. What I observed is a global 5V and a global
12 V power supply line, and then for each voltage and for each SATA drive there
is a FDC6330L which is more or less a controlled switch.

> supply with the current draw of them all starting at the same
> time. There is a property, startup-delay-us, which can be used for
> this.

According to the datasheet of the FDC6330L I didn't see any startup delay feature.
Unless this property was not to describe the hardware but to configure it, in this
case it could make sens to use it.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
