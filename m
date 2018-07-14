From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 Jul 2018 22:15:45 +0200
Subject: [PATCH 2/2] ARM: dts: pxa: add mioa701 board description
In-Reply-To: <CAL_JsqJU2jyfN3PyvXRCTO4xXQmUbU3tJ0uLok10KONULpJwXg@mail.gmail.com>
 (Rob Herring's message of "Mon, 9 Jul 2018 12:00:26 -0600")
References: <20180702055733.18578-1-robert.jarzmik@free.fr>
 <20180702055733.18578-2-robert.jarzmik@free.fr>
 <CAL_JsqJU2jyfN3PyvXRCTO4xXQmUbU3tJ0uLok10KONULpJwXg@mail.gmail.com>
Message-ID: <87lgada80e.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh+dt@kernel.org> writes:

Hi Rob,

>> +       /* compatible = "mitac,mioa701"; */
>> +       compatible = "marvell,pxa270";
>
> Why the comment?
Leftover, I'll remove it.

>> +                       pstore_region:region at 0xa2000000 {
>
> Drop the 0x
Done.

>> +                               compatible = "linux,contiguous-memory-region";
>> +                               reg = <0xa2000000 1048576>;
>
> Use hex for the size.
Ok.

>> +               ffuart: uart at 40100000 {
>
> Should be "serial at ...". You'll have to fix in the base dtsi.
Ok for all of these.
>> +               pxai2c1: i2c at 40301680 {
>> +                       mrvl,i2c-fast-mode;
>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&pinctrl_i2c_default>;
>> +                       status = "okay";
>> +
>> +                       mt9m111: camera at 5d {
>> +                               compatible = "micron,mt9m111";
>> +                               reg = <0x5d>;
>> +                               gpios = <&gpio 56 GPIO_ACTIVE_HIGH>;
>> +
>> +                               remote = <&pxa_camera>;
>
> Not needed with the graph:
I don't understand that, do you mean the port node is not needed ?

>
>> +                               port {
>> +                                       mt9m111_1: endpoint {
>> +                                               bus-width = <8>;
>> +                                               remote-endpoint = <&pxa_camera>;
>> +                                       };
>> +                               };
>> +                       };
>> +               };
>> +               gpio-keys {
>> +                       compatible = "gpio-keys";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       autorepeat;
>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&pinctrl_gpiokeys_default>;
>> +                       status = "okay";
>
> Don't need status here? It shouldn't be defined in the base dtsi.
Heuh what ? The status is just above, and gpio-keys is not defined in any dtsi.

>> +
>> +                       button at 0 {
>
> If you have unit-address there should also be a reg property. Just
> drop and name the node 'power' or 'power-button'. And similarly for
> the rest.
Ok.

>> +
>> +       regulators {
>> +               compatible = "simple-bus";
>
> Drop this and move children to the top level. This is not an mmio bus.
Ok.

>> +       docg3: flash at 0 {
>
> This probably should be a child of the bus controller.
Most certainly yes.

>
>> +               compatible = "m-systems,diskonchip-g3";
>> +               reg = <0x0 0x2000>;
>> +       };
>> +
>> +       panel {
>> +               compatible = "toshiba,ltm0305a776";
>> +               lcd-type = "color-tft";
>
> This should be implied by the compatible.
Mmm no. Actually, this is used by the framebuffer controller, ie. pxafb to set
it up. And I don't think adding a list of panel compatibles in pxafb is a good
idea.
The corresponding code is in : drivers/video/fbdev/pxafb.c, see
"static const char * const lcd_types[]".

>> +               display-timings {
>> +                       native-mode = <&timing0>;
>
> We generally imply this from the compatible (i.e. use simple-panel).
But you suppose there is an actual driver for the panel, right ? But there is
none.

> Could use another level of indentation.
Sure.

>> +       ac_charger: charger at 1 {
>
> Drop the unit-address.
Ok.

Thanks for the review.

-- 
Robert
