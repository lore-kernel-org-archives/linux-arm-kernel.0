From: marex@denx.de (Marek Vasut)
Date: Wed, 4 Nov 2015 22:29:33 +0100
Subject: [PATCH V2] ARM: at91/dt: sama5d4: Add support for DENX MA5D4 SoM
 and EVK
In-Reply-To: <5639C836.5010603@atmel.com>
References: <1446585537-10621-1-git-send-email-marex@denx.de>
 <5639C836.5010603@atmel.com>
Message-ID: <201511042229.33256.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 04, 2015 at 09:56:22 AM, Nicolas Ferre wrote:
> Le 03/11/2015 22:18, Marek Vasut a ?crit :
> > Add support for the DENX MA5D4 SoM and MA5D4EVK board. The system
> > consists of a SoM with eMMC, SPI NOR for booting, 2x SPI CAN chip
> > and an EVK with microSD slot, 2x UART, 2x CAN port, 3x USB port,
> > LEDs and expansion headers.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Hi Marek,
> 
> I'm delighted to see this board submitted: thanks!

Hi Nicolas,

thanks for the review :)

[...]

> > +			i2c0: i2c at f8014000 {
> 
> We tend to sort node by ascending addresses, but for sure, it's
> absolutely up to you to sort them in whichever order you choose (and I
> admit it sometimes led us to strange numbering schemes: so we might
> reconsider this (soft) constrain in the future for our own boards)...

Oh, this is a good point. I used to sort them by the reference, but here
I missed the ADC anyway, so I can as well sort them by the address.

> > +				status = "okay";
> > +			};

[...]

> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&hlcdc_pwm 0 50000 0>;
> > +		brightness-levels = <0 4 8 16 32 64 128 255>;
> > +		default-brightness-level = <6>;
> 
> Nit: I don't see "6" in the levels just above...

That's to be expected, see

Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt

quote:

11   - default-brightness-level: the default brightness level (index into the
12       array defined by the "brightness-levels" property)

So the default brighness is set to 128, which is is 50% brightness.

> > +		status = "okay";
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		status = "okay";
> > +
> > +		user1 {
> > +			label = "user1";
> > +			gpios = <&pioD 28 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +
> > +		user2 {
> > +			label = "user2";
> > +			gpios = <&pioD 29 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +
> > +		user3 {
> > +			label = "user3";
> > +			gpios = <&pioD 30 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> 
> So all the 3 leds are blinking at "heartbeat" ? Disco party time!

Hehe :-) It's probably the best way to check if they work and demonstrate
that they do something.

> > +		};
> > +	};
> > +
> > +	panel: panel {
> > +		/* Actually Ampire 800480R2 */
> > +		compatible = "foxlink,fl500wvr00-a0t", "simple-panel";
> > +		backlight = <&backlight>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		status = "okay";
> > +
> > +		port at 0 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			panel_input: endpoint at 0 {
> > +				reg = <0>;
> > +				remote-endpoint = <&hlcdc_panel_output>;
> > +			};
> > +		};
> > +	};
> > +
> > +	vcc_mmc1_reg: fixedregulator at 2 {
> > +		compatible = "regulator-fixed";
> > +		gpio = <&pioE 17 GPIO_ACTIVE_LOW>;
> > +		regulator-name = "VDD MCI1";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		vin-supply = <&vcc_3v3_reg>;
> > +	};
> > +};
> 
> Apart form the little remarks, I'm absolutely fine with the patch:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Thanks Marek, it will probably go into kernel 4.5 ; we have to build the
> at91-4.5-dt branch once the merge window is closed. It will then show up
> in at91-next which is pulled by Stephen.

Cool, thanks!
