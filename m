From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 29 Aug 2018 17:47:01 +0300
Subject: [PATCH] arm64: dts: add support for SolidRun Clearfog GT 8K
In-Reply-To: <20180829141159.GB22270@lunn.ch>
References: <3276b82491c1eda1e05a0e6b94560cfa451cf8d4.1535544789.git.baruch@tkos.co.il>
 <20180829141159.GB22270@lunn.ch>
Message-ID: <8736uxxmai.fsf@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Thanks for reviewing.

Andrew Lunn writes:

> On Wed, Aug 29, 2018 at 03:13:09PM +0300, Baruch Siach wrote:
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-0 = <&cp0_led0_pins
>> +			     &cp0_led1_pins>;
>> +		pinctrl-names = "default";
>> +		led0 {
>> +			label = "led0";
>
> There is a naming convention of LEDs. Documentation/leds/leds-class.txt:
>
>     LED Device Naming
>     =================
>
>     Is currently of the form:
>
>     "devicename:colour:function"
>
>> +		button_0 {
>> +			/* The rear button */
>> +			label = "Rear Button";
>> +			gpios = <&cp0_gpio2 7 GPIO_ACTIVE_LOW>;
>> +			linux,can-disable;
>> +			linux,code = <BTN_0>;
>> +		};
>
> Is there any label on the PCB or case about what this button is used
> for? It would be nice to have something less generic than BTN_0.

The schematics say "AP Reset Switch". So it is probably meant to be a
software controlled "back to default" button. Is there a suitable
linux,code for that?

>> +
>> +		button_1 {
>> +			/* The wps button */
>> +			label = "WPS Button";
>> +			gpios = <&cp1_gpio1 30 GPIO_ACTIVE_LOW>;
>> +			linux,can-disable;
>> +			linux,code = <BTN_1>;
>
> linux,code = <KEY_WPS_BUTTON>;
>
>> +	cp0_tpm_irq_pins: tpm-irq-pins {
>> +		marvell,pins = "mpp50";
>> +		marvell,function = "gpio";
>> +	};
>
> I didn't realise the board had a TPM. I don't see any mention on
> SolidRun's website. What TPM is it?

It is not assembled here so I could not test. The schematics say SLB9670.

>> +&cp1_mdio {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&cp1_ge_mdio_pins>;
>> +	status = "okay";
>> +
>> +	ge_phy: ethernet-phy at 0 {
>> +		marvell,reg-init = <3 16 0 0x1017>;
>
> This marvell,reg-init is rather black magic. It would be good to
> document what this does.

OK. I'll look in up.

>> +			port at 5 {
>> +				reg = <5>;
>> +				label = "cpu";
>> +				ethernet = <&cp1_eth2>;
>> +			};
>
> No fixed-link? It correctly defaults to 2.5G? I've never tested that.

Seems to work here. There is also a patch from Rabeeh (which I did not
apply while testing) to make it the default:

  https://github.com/SolidRun/openwrt/blob/openwrt-18.06-sr/target/linux/mvebu/patches-4.14/533-fix-88e6141-cpu-max-speed.patch

I plan to upstream this patch.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
