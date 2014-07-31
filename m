From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 31 Jul 2014 21:20:41 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DA936E.9060004@gmail.com>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com>
Message-ID: <53DA9709.10602@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

Am 31.07.2014 21:05, schrieb Tomasz Figa:
> Hi Andreas,
> 
> Sorry for joining the party a bit late, but there were patches with less
> people involved so I preferred to review them first.
> 
> You can find my comments inline.
> 
> On 31.07.2014 18:08, Andreas F?rber wrote:
>> Adds initial support for the HP Chromebook 11.
> 
> [snip]
> 
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&power_key_irq>, <&lid_irq>;
>> +
>> +		power {
>> +			label = "Power";
>> +			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
>> +			linux,code = <KEY_POWER>;
> 
> I assume the key is debounced in hardware, so there is no need for
> debounce-interval here. Is this correct?

You're asking the wrong person... This is copied from
-cros-common/-snow. Downstream 3.8 does not have a debounce-interval
property.

> 
>> +			gpio-key,wakeup;
>> +		};
>> +
>> +		lid-switch {
>> +			label = "Lid";
>> +			gpios = <&gpx3 5 GPIO_ACTIVE_LOW>;
>> +			linux,input-type = <5>; /* EV_SW */
>> +			linux,code = <0>; /* SW_LID */
>> +			debounce-interval = <1>;
>> +			gpio-key,wakeup;
>> +		};
>> +	};
>> +
>> +	usb3_vbus_reg: regulator-usb3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "P5.0V_USB3CON";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		gpio = <&gpe1 0 GPIO_ACTIVE_LOW>;
>> +		enable-active-high;
>> +	};
>> +
>> +	usb at 12110000 {
> 
> Since this is a brand new dts file, it should use the reference based
> syntax, which would be something like
> 
> &usbhost {
> 	...
> };
> 
> below the / { ... }; block.

You will find that I already did that for all nodes that have a label.
Since there are lots of usb nodes, please suggest specific label names.

I originally tried to stay out of existing code, then I was asked to fix
-cros-common, clean up -snow too, now the SoC, ... ;)

>> +		samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	usb-hub {
>> +		compatible = "smsc,usb3503a";
>> +		reset-gpios = <&hsic_reset>;
> 
> Hmm, why a -gpios property points to a pinctrl node? Shouldn't there be
> a phandle to GPIO bank + GPIO specifier instead?

Dunno, can change it. Can I just copy the gpio property from the
regulator above?

>> +	};
>> +
>> +	fixed-rate-clocks {
>> +		xxti {
>> +			compatible = "samsung,clock-xxti";
>> +			clock-frequency = <24000000>;
>> +		};
>> +	};
> 
> This is also referencing a node from higher level, so it should be done
> using a reference.
> 
>> +
>> +	hdmi {
>> +		hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hdmi_hpd_irq>;
>> +		phy = <&hdmiphy>;
>> +		ddc = <&i2c_2>;
>> +		hdmi-en-supply = <&s5m_ldo8_reg>;
>> +		vdd-supply = <&s5m_ldo8_reg>;
>> +		vdd_osc-supply = <&s5m_ldo10_reg>;
>> +		vdd_pll-supply = <&s5m_ldo8_reg>;
>> +	};
> 
> Ditto.

hdmi?

> 
>> +
>> +	fimd at 14400000 {
>> +		status = "okay";
>> +		samsung,invert-vclk;
>> +	};
> 
> Ditto.

fimd?

> 
>> +
>> +	dp-controller at 145B0000 {
>> +		status = "okay";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&dp_hpd>;
>> +		samsung,color-space = <0>;
>> +		samsung,dynamic-range = <0>;
>> +		samsung,ycbcr-coeff = <0>;
>> +		samsung,color-depth = <1>;
>> +		samsung,link-rate = <0x0a>;
>> +		samsung,lane-count = <1>;
>> +		samsung,hpd-gpio = <&gpc3 0 GPIO_ACTIVE_HIGH>;
>> +	};
> 
> Ditto.

dp_controller? display_port_controller?

> 
>> +};
>> +
>> +&dp_hpd {
>> +	samsung,pins = "gpc3-0";
>> +	samsung,pin-function = <0>;
>> +	samsung,pin-pud = <3>;
>> +	samsung,pin-drv = <0>;
>> +};
> 
> Hmm, what node is this referencing? I believe this should rather
> reference the pin controller and add a new board-specific pinconf/pinmux
> group instead....

It's a -pinctrl node. See v3->v4 change log and discussion on v3.

>> +
>> +&i2c_0 {
>> +	status = "okay";
>> +	samsung,i2c-sda-delay = <100>;
>> +	samsung,i2c-max-bus-freq = <378000>;
> 
> [snip]
> 
>> +/*
>> + * Disabled pullups since external part has its own pullups and
>> + * double-pulling gets us out of spec in some cases.
>> + */
>> +&i2c2_bus {
>> +	samsung,pin-pud = <0>;
>> +};
> 
> OK, here overriding a generic pinconf group is justified and nicely
> explained by a comment.

You seem to assume that I actually understand these things. ;)
Just copied from -cros-common/-snow.

>> +
>> +&i2c_2 {
>> +	status = "okay";
>> +	samsung,i2c-sda-delay = <100>;
>> +	samsung,i2c-max-bus-freq = <66000>;
>> +
>> +	hdmiddc at 50 {
>> +		compatible = "samsung,exynos4210-hdmiddc";
>> +		reg = <0x50>;
>> +	};
> 
> I don't think this matches current Exynos HDMI bindings, which I believe
> have been changed to just take a phandle to i2c bus instead.

Copied from -cros-common/-snow.

>> +};
>> +
>> +&i2c_3 {
>> +	status = "okay";
>> +	samsung,i2c-sda-delay = <100>;
>> +	samsung,i2c-max-bus-freq = <66000>;
>> +};
> 
> [snip]
> 
>> +&sd1_clk {
>> +	samsung,pin-drv = <0>;
>> +};
>> +
>> +&sd1_cmd {
>> +	samsung,pin-pud = <3>;
>> +	samsung,pin-drv = <0>;
>> +};
>> +
>> +&sd1_cd {
>> +	samsung,pin-drv = <0>;
>> +};
>> +
>> +&sd1_bus4 {
>> +	samsung,pin-drv = <0>;
>> +};
> 
> Here generic settings are being overridden, so it might be a good idea
> to explain why, like with i2c pull-up above.

Snow does not have an explanation either, so please suggest what comment
you'd like to see. Consider me just a user with no specs. :)

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
