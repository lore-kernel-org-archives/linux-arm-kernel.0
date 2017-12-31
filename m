From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 31 Dec 2017 17:14:54 +0100 (CET)
Subject: [PATCH] ARM: dts: bcm2837-rpi-3-b: fix pwm1 pin
In-Reply-To: <da85c22315e08c7dc4dfdebae983278909cfee83.1514733168.git.baruch@tkos.co.il>
References: <da85c22315e08c7dc4dfdebae983278909cfee83.1514733168.git.baruch@tkos.co.il>
Message-ID: <726612883.202327.1514736894033@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 31. Dezember 2017 um 16:12 geschrieben:
> 
> 
> Raspberry Pi 3 uses GPIO45 for I2C SCL0. pwm1 is on GPIO41. Update the
> DT description accordingly. Fix the following error that shows when
> GPIO44 and GPIO45 are configured to I2C:
> 
> [    1.751563] pinctrl-bcm2835 3f200000.gpio: pin gpio45 already requested by 3f205000.i2c; cannot claim for 3f20c000.pwm
> [    1.762474] pinctrl-bcm2835 3f200000.gpio: pin-45 (3f20c000.pwm) status -22
> [    1.775176] pinctrl-bcm2835 3f200000.gpio: could not request pin 45 (gpio45) from group gpio45  on device pinctrl-bcm2835
> [    1.786344] bcm2835-pwm 3f20c000.pwm: Error applying setting, reverse things back
> [    1.793980] bcm2835-pwm: probe of 3f20c000.pwm failed with error -22
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index a8844d033b3f..b44b3b5af00d 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -60,3 +60,9 @@
>  	status = "okay";
>  	bus-width = <4>;
>  };
> +
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio41>;
> +	status = "okay";
> +};

thanks for addressing this old issue. Unfortunately this is only a part of the solution. The real problem is the definition of pinctrl in a very common dtsi file (bcm2835-rpi.dtsi). Based on the Firmware dt-blob i created a pin usage map [1], which also shows a potential conflict on RPI Zero W.

So i think we should remove the pwm part from bcm2835-rpi.dtsi and define it on board level like in your patch, but also for the other boards. My suggestion would be the following (based on Firmware):

A Plus -> PWM on pin 40,45
A -> PWM on pin 40,45
B Plus -> PWM on pin 40,45
B Rev 2 -> PWM on pin 40,45
B -> PWM on pin 40,45
2 b -> PWM on pin 40,45
3 b -> PWM on pin 40,41
Zero -> No PWM
Zero W -> No PWM

But i think we should wait for Eric's opinion.

Regards
Stefan

[1] - https://github.com/raspberrypi/firmware/wiki/Pin-usage-reference
