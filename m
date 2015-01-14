From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Jan 2015 11:22:14 +0100
Subject: [PATCH 1/2] pinctrl: sirf: add sirf atlas7 pinctrl and gpio
 support
In-Reply-To: <1419496216-4765-1-git-send-email-21cnbao@gmail.com>
References: <1419496216-4765-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdZwj7mwWJQGA3crJQT7XTwQbjCq35OYybNOwBKztCUbZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 25, 2014 at 9:30 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Wei Chen <Wei.Chen@csr.com>
>
> The Pinctrl module (ioc) controls the Pad's function select
> (each pad can have 8 functions), Pad's Drive Strength, Pad's
> Pull Select and Pad's Input Disable status.
>
> The ioc has two modules, ioc_top & ioc_rtc. Both of these two
> modules have function select/clear, Pull select and Drive
> Strength registers. But only ioc_rtc has input-disable
> registers. The Pads on ioc_top have to access ioc_rtc to set
> their input-disable status and intpu-disable-value.
>
> So have to use one ioc driver instance to drive these two
> ioc modules at the same time, and each ioc module will be
> treat as one bank on the "IOC Device".
>
> The GPIO Controller controls the GPIO status if the Pad has
> been config as GPIO by Pinctrl already. Includes the GPIO
> Input/output, Interrupt type, Interrupt Status, and Set/Get
> Values.
> The GPIO pull up/down are controlled by Pinctrl.
>
> There are 7 GPIO Groups and splited into 3 MACROs in atlas7.
> The GPIO Groups in one MACRO share one GPIO controllers, each
> GPIO Group are treated as one GPIO bank.
>
> For example:
> In VDIFM macro, there is one GPIO Controller, it has 3 banks
> to control 3 gpio groups. Its gpio name space is from 0 to 95.
>
> The Device Tree can be written as following:
>
> gpio-ranges = <&pinctrl 0 0 0>,
> <&pinctrl 32 0 0>,
> <&pinctrl 64 0 0>;
>
> gpio-ranges-group-names = "gnss_gpio_grp",
> "lcd_vip_gpio_grp",
> "sdio_i2s_gpio_grp";
>
> bank#0 is from 0~31, the pins are from pinctrl's "gnss_gpio_grp".
> bank#2 is from 32~63, the pins are from pinctrl's "lcd_vip_gpio_grp".
> bank#3 is from 64~95, the pins are from pinctrl's "sdio_i2s_gpio_grp".
>
> Signed-off-by: Wei Chen <Wei.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

(...)

> +++ b/Documentation/devicetree/bindings/gpio/gpio-atlas7.txt
> @@ -0,0 +1,51 @@
> +CSR SiRFatlas7 GPIO controller bindings
> +
> +Required properties:
> +- compatible   : "sirf,atlas7-gpio"
> +- reg          : Address range of the pinctrl registers
> +- interrupts   : Interrupts used by every GPIO group
> +- gpio-banks   : How many gpio banks on this controller
> +- gpio-controller : Indicates this device is a GPIO controller
> +- interrupt-controller  : Marks the device node as an interrupt controller
> +
> +Optional properties:
> +- sirf,gpio-pullups : if n-th bit of m-th bank is set, set a pullup on GPIO-n of bank m
> +- sirf,gpio-pulldowns : if n-th bit of m-th bank is set, set a pulldown on GPIO-n of bank m

NAK.

Pull up/down is pin config business. It should not be done from
the GPIO controller *at all*, instead use pin control hogs or
whatever.

Notice that pin control and GPIO usecases are orthogonal so it
is perfectly legal for the pin controller to hog and bias a pin,
which is later used as GPIO.

Better still: put the config into the device node of the device
requiring that certain biasing.

See for example
arch/arm/boot/dts/ste-nomadik-nhk15.dts
where the cascaded STMPE2401 gpio chips use
GPIOs from the primary SoC GPIO controller and
also uses pin config on the affected pins to set
up the lines for IRQ.

> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt
> @@ -0,0 +1,104 @@
> +CSR SiRFatlas7 pinmux controller
> +
> +Required properties:
> +- compatible   : "sirf,atlas7-ioc"
> +- reg          : Address range of the pinctrl registers
> +
> +- sirf,pull-pins: An array of string that describe the pins that
> +  have pull selector.
> +
> +- sirf,pull-selectors: An array of string that describe the pull
> +  selector of sirf,pull-pins specified pins.
> +
> +- sirf,drive-strength-pins:An array of string that describe the pins that
> +  have drive strength selector.
> +
> +- sirf,drive-strength-selectors: An array of string that describe the
> +  drive strength selector of drive-strength-pins specified pins.
> +
> +For example, pinctrl might have properties like the following:
> +       pinctrl: ioc at 18880000 {
> +                       compatible = "sirf,atlas7-ioc";
> +                       reg = <0x18880000 0x1000>;
> +
> +                       a_ac97_pmx: ac97 at 0 {
> +                               ac97 {
> +                                       sirf,pins = "audio_ac97_grp";
> +                                       sirf,function = "audio_ac97";

These custom "sirf,pins" (really groups) and "sirf,function" are
unfortunate now that I just merged generic support for using
"function" and "groups" attributes for this.

Please check if you can migrate to the generic bindings from
this pin controller and going forward.

(...)
> +Required subnode-properties:
> +- sirf,pins : An array of strings. Each string contains the name of a group.
> +- sirf,function: A string containing the name of the function to mux to the
> +  group.

i.e. renaming these to "groups" and "pins" and referring to the
pinctrl-bindings.txt document.

Yours,
Linus Walleij
