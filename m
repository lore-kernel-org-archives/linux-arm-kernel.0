From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 31 Jul 2014 21:40:25 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DA9709.10602@suse.de>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com> <53DA9709.10602@suse.de>
Message-ID: <53DA9BA9.60808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On 31.07.2014 21:20, Andreas F?rber wrote:
> Am 31.07.2014 21:05, schrieb Tomasz Figa:
>> On 31.07.2014 18:08, Andreas F?rber wrote:
>>> Adds initial support for the HP Chromebook 11.
>>
>> [snip]
>>
>>> +	gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&power_key_irq>, <&lid_irq>;
>>> +
>>> +		power {
>>> +			label = "Power";
>>> +			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
>>> +			linux,code = <KEY_POWER>;
>>
>> I assume the key is debounced in hardware, so there is no need for
>> debounce-interval here. Is this correct?
> 
> You're asking the wrong person... This is copied from
> -cros-common/-snow. Downstream 3.8 does not have a debounce-interval
> property.

Doug, Vincent?

> 
>>
>>> +			gpio-key,wakeup;
>>> +		};

[snip]

>>> +
>>> +	usb at 12110000 {
>>
>> Since this is a brand new dts file, it should use the reference based
>> syntax, which would be something like
>>
>> &usbhost {
>> 	...
>> };
>>
>> below the / { ... }; block.
> 
> You will find that I already did that for all nodes that have a label.
> Since there are lots of usb nodes, please suggest specific label names.
> 
> I originally tried to stay out of existing code, then I was asked to fix
> -cros-common, clean up -snow too, now the SoC, ... ;)

Well, adding labels should be pretty trivial and IMHO could be squashed
into this patch. For usb at 1211000 the right label would be "ehci".

> 
>>> +		samsung,vbus-gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
>>> +	};
>>> +
>>> +	usb-hub {
>>> +		compatible = "smsc,usb3503a";
>>> +		reset-gpios = <&hsic_reset>;
>>
>> Hmm, why a -gpios property points to a pinctrl node? Shouldn't there be
>> a phandle to GPIO bank + GPIO specifier instead?
> 
> Dunno, can change it. Can I just copy the gpio property from the
> regulator above?

Reading what Vincent posted earlier I would consider this as the right
thing to do and it might even let you remove the fake regulator node.

> 
>>> +	};
>>> +
>>> +	fixed-rate-clocks {
>>> +		xxti {
>>> +			compatible = "samsung,clock-xxti";
>>> +			clock-frequency = <24000000>;
>>> +		};
>>> +	};
>>
>> This is also referencing a node from higher level, so it should be done
>> using a reference.
>>
>>> +
>>> +	hdmi {
>>> +		hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&hdmi_hpd_irq>;
>>> +		phy = <&hdmiphy>;
>>> +		ddc = <&i2c_2>;
>>> +		hdmi-en-supply = <&s5m_ldo8_reg>;
>>> +		vdd-supply = <&s5m_ldo8_reg>;
>>> +		vdd_osc-supply = <&s5m_ldo10_reg>;
>>> +		vdd_pll-supply = <&s5m_ldo8_reg>;
>>> +	};
>>
>> Ditto.
> 
> hdmi?

Sounds good.

> 
>>
>>> +
>>> +	fimd at 14400000 {
>>> +		status = "okay";
>>> +		samsung,invert-vclk;
>>> +	};
>>
>> Ditto.
> 
> fimd?

OK.

> 
>>
>>> +
>>> +	dp-controller at 145B0000 {
>>> +		status = "okay";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&dp_hpd>;
>>> +		samsung,color-space = <0>;
>>> +		samsung,dynamic-range = <0>;
>>> +		samsung,ycbcr-coeff = <0>;
>>> +		samsung,color-depth = <1>;
>>> +		samsung,link-rate = <0x0a>;
>>> +		samsung,lane-count = <1>;
>>> +		samsung,hpd-gpio = <&gpc3 0 GPIO_ACTIVE_HIGH>;
>>> +	};
>>
>> Ditto.
> 
> dp_controller? display_port_controller?

dp?

> 
>>
>>> +};
>>> +
>>> +&dp_hpd {
>>> +	samsung,pins = "gpc3-0";
>>> +	samsung,pin-function = <0>;
>>> +	samsung,pin-pud = <3>;
>>> +	samsung,pin-drv = <0>;
>>> +};
>>
>> Hmm, what node is this referencing? I believe this should rather
>> reference the pin controller and add a new board-specific pinconf/pinmux
>> group instead....
> 
> It's a -pinctrl node. See v3->v4 change log and discussion on v3.
> 

Well, this is clearly a board specific node anyway, because it does not
refer to a special function, but simply an input/interrupt GPIO. If it
somehow has landed in generic pinctrl dtsi then it should be removed
from there and this patch should simply introduce its own instance of
dp_hpd node, so you did the right thing in v3.

>>> +
>>> +&i2c_0 {
>>> +	status = "okay";
>>> +	samsung,i2c-sda-delay = <100>;
>>> +	samsung,i2c-max-bus-freq = <378000>;
>>
>> [snip]
>>
>>> +/*
>>> + * Disabled pullups since external part has its own pullups and
>>> + * double-pulling gets us out of spec in some cases.
>>> + */
>>> +&i2c2_bus {
>>> +	samsung,pin-pud = <0>;
>>> +};
>>
>> OK, here overriding a generic pinconf group is justified and nicely
>> explained by a comment.
> 
> You seem to assume that I actually understand these things. ;)
> Just copied from -cros-common/-snow.
> 

It is good if those things are being done with some level of
understanding. The DT mechanics are quite well documented in
Documentation/devicetree/bindings, while for HW-specific bits I believe
Chromium guys could give you a hand.

>>> +
>>> +&i2c_2 {
>>> +	status = "okay";
>>> +	samsung,i2c-sda-delay = <100>;
>>> +	samsung,i2c-max-bus-freq = <66000>;
>>> +
>>> +	hdmiddc at 50 {
>>> +		compatible = "samsung,exynos4210-hdmiddc";
>>> +		reg = <0x50>;
>>> +	};
>>
>> I don't think this matches current Exynos HDMI bindings, which I believe
>> have been changed to just take a phandle to i2c bus instead.
> 
> Copied from -cros-common/-snow.
> 

This means that somebody probably forgot to update -cros-common/-snow
dts(i). Not the first and I guess probably not the last time...

>>> +};
>>> +
>>> +&i2c_3 {
>>> +	status = "okay";
>>> +	samsung,i2c-sda-delay = <100>;
>>> +	samsung,i2c-max-bus-freq = <66000>;
>>> +};
>>
>> [snip]
>>
>>> +&sd1_clk {
>>> +	samsung,pin-drv = <0>;
>>> +};
>>> +
>>> +&sd1_cmd {
>>> +	samsung,pin-pud = <3>;
>>> +	samsung,pin-drv = <0>;
>>> +};
>>> +
>>> +&sd1_cd {
>>> +	samsung,pin-drv = <0>;
>>> +};
>>> +
>>> +&sd1_bus4 {
>>> +	samsung,pin-drv = <0>;
>>> +};
>>
>> Here generic settings are being overridden, so it might be a good idea
>> to explain why, like with i2c pull-up above.
> 
> Snow does not have an explanation either, so please suggest what comment
> you'd like to see. Consider me just a user with no specs. :)

Doug, Vincent, someone else?

Best regards,
Tomasz
