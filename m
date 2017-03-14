From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 14 Mar 2017 08:05:03 -0700
Subject: [PATCH] ARM: dts: imx: add Gateworks Ventana GW5904 support
In-Reply-To: <20170314105517.GP3618@dragon>
References: <1489178411-6559-1-git-send-email-tharvey@gateworks.com>
 <20170314105517.GP3618@dragon>
Message-ID: <CAJ+vNU2V4R1qEdowBkyS5OKk15iOEq0vvtW-RwRnHskdb861tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 3:55 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Fri, Mar 10, 2017 at 12:40:11PM -0800, Tim Harvey wrote:
<snip>
>> @@ -0,0 +1,19 @@
>> +/*
>> + * Copyright 2017 Gateworks Corporation
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>
> For new dts files, GPL/X11 dual licence is recommended.  There are
> plenty of examples in arch/arm/boot/dts.

Shawn,

Thanks for the review. I will incorporate all of your comments in a v2
but do have a few points worth discussion below

<snip>
>> +&ldb {
>> +     status = "okay";
>> +
>> +     lvds-channel at 0 {
>> +             fsl,data-mapping = "spwg";
>> +             fsl,data-width = <18>;
>> +             status = "okay";
>> +
>> +             display-timings {
>> +                     native-mode = <&timing0>;
>> +                     timing0: hsd100pxn1 {
>> +                             clock-frequency = <65000000>;
>> +                             hactive = <1024>;
>> +                             vactive = <768>;
>> +                             hback-porch = <220>;
>> +                             hfront-porch = <40>;
>> +                             vback-porch = <21>;
>> +                             vfront-porch = <7>;
>> +                             hsync-len = <60>;
>> +                             vsync-len = <10>;
>> +                     };
>> +             };
>> +     };
>
> Take a look at commit 4dc633e9b019 ("ARM: dts: sabrelite: use
> simple-panel instead of display-timings for LVDS0"), and consider to use
> simple-panel?

I haven't moved to simple-panel yet because I have bootloader code
that allows choosing/altering display timings with the goal being
users don't need to recompile their device-tree or kernel to use a
display with different timings. It seems to me that moving to
simple-panel would make this even more difficult as while the
bootloader could find and alter the panel's compatible property (in
the case the kernel has a supported simple-panel compiled in) it no
longer has access to the raw timings (in case the kernel doesn't have
a simple-panel driver built-in already).

I do like the way simple-panel combines display timings with
backlight, power supplies, dc bus, and a gpio enable but it doesn't
encapsulate touch controller or expose timings to device-tree for easy
manipulation.

What are you thoughts on this?

>
<snip>
>> +
>> +&pwm2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_pwm2>; /* MX6_DIO1 */
>> +     status = "disabled";
>> +};
>> +
>> +&pwm3 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_pwm3>; /* MX6_DIO2 */
>> +     status = "disabled";
>> +};
>
> Why do you have these two devices but disable them?

This is because I have a bootloader configuration that allows the user
to choose between GPIO and PWM for the non-backlight PWM pins. I
should probably add a comment to those nodes specifying that firmware
modifies the status property.

Thanks,

Tim
