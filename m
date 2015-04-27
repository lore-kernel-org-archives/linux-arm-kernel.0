From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Apr 2015 15:51:54 +0200
Subject: [PATCH v2 1/2] pinctrl: sirf: add sirf atlas7 pinctrl and gpio
 support
In-Reply-To: <1429511930-13462-1-git-send-email-21cnbao@gmail.com>
References: <1429511930-13462-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdaTdLZwQg1+GZ3MsvyxJEk07vvDjt03Xp2rcWVraztqXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 8:38 AM, Barry Song <21cnbao@gmail.com> wrote:
> From: Wei Chen <Wei.Chen@csr.com>

> +CSR SiRFatlas7 GPIO controller bindings
> +
> +Required properties:
> +- compatible   : "sirf,atlas7-gpio"
> +- reg          : Address range of the pinctrl registers
> +- interrupts   : Interrupts used by every GPIO group
> +- gpio-banks   : How many gpio banks on this controller
> +- gpio-controller : Indicates this device is a GPIO controller
> +- interrupt-controller  : Marks the device node as an interrupt controller

This looks nice.

> +The GPIO controller also acts as an interrupt controller. It uses the default
> +two cells specifier as described in Documentation/devicetree/bindings/
> +interrupt-controller/interrupts.txt.
> +
> +Example:
> +
> +       gpio_0: gpio_mediam at 17040000 {
> +               compatible = "sirf,atlas7-gpio";
> +               reg = <0x17040000 0x1000>;
> +               interrupts = <0 13 0>, <0 14 0>;
> +
> +               #gpio-cells = <2>;
> +               #interrupt-cells = <2>;
> +
> +               gpio-controller;
> +               interrupt-controller;
> +
> +               gpio-banks = <2>;
> +               gpio-ranges = <&pinctrl 0 0 0>,
> +                               <&pinctrl 32 0 0>;
> +               gpio-ranges-group-names = "lvds_gpio_grp",
> +                                       "uart_nand_gpio_grp";
> +       };

You are using a few properties that are not documented in your
bindings or referred to general documentation. (ranges)
Please put in the right documenation/references.

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

It seems all the properties are required?

Also, do not use these. Use the generic bindings from
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

select GENERIC_PINCONF
Look in other drivers using generic pinconf.

We have bias-pull-up, with an optional argument specifying pull
strength (which I suspect the pull selector is all about)
as well as drive-strength with an optional argument in mA.

> +                       sirf,pull-selectors = "pull_up", "pull_up", "pull_down",
> +                                       "high_hysteresis", "high_z";

We have bias-pull-up, bias-pull-down, bias-high-impedance (= high Z)
and also input-schmitt-enable which I suspect is equal to high hysteresis.

> +Please refer to pinctrl-bindings.txt in this directory for details of the common
> +pinctrl bindings used by client devices.

So do not deviate from them please.

> +Required subnode-properties:
> +- groups : An array of strings. Each string contains the name of a group.
> +- function: A string containing the name of the function to mux to the
> +  group.
> +
> +  Valid values for group and function names can be found from looking at the
> +  group and function arrays in driver files:
> +  drivers/pinctrl/pinctrl-sirf.c
> +
> +For example, pinctrl might have subnodes like the following:
> +       sd0_pmx: sd0 at 0 {
> +               sd0 {
> +                       groups = "sd0_grp";
> +                       function = "sd0";
> +               };
> +       };
> +
> +       sd1_pmx0: sd1 at 0 {
> +               sd1 {
> +                       groups = "sd1_grp0";
> +                       function = "sd1_m0";
> +               };
> +       };
> +
> +       sd1_pmx1: sd1 at 1 {
> +               sd1 {
> +                       groups = "sd1_grp1";
> +                       function = "sd1_m1";
> +               };
> +       };

This looks *VERY* nice however!

Yours,
Linus Walleij
