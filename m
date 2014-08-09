From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 9 Aug 2014 13:44:33 +0200
Subject: [PATCH] ARM: dts: Gateworks GW5520 support (i.MX6)
In-Reply-To: <1407572602-14017-1-git-send-email-tharvey@gateworks.com>
References: <1407572602-14017-1-git-send-email-tharvey@gateworks.com>
Message-ID: <CABxcv=kSfVoPgdDsodSPMSC7u_B6YiVuqHsh5T_Y4eucU6bQWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tim,

On Sat, Aug 9, 2014 at 10:23 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> +/*
> + * Copyright 2014 Gateworks Corporation
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */

There was a discussion [0] recently about what license(s) should be
used for Device Tree source files. It seems that we have been using
GPLv2-only just because is the Linux kernel license but unlike other
source files, the DTS could be used verbatim in other operating
systems / bootloaders so we have to better think the implications of
the licensing.

Of course this shouldn't hold your patch, I'm just mentioning so you
can keep an eye in case an agreement is made while you are pushing
this.

> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +       /* these are used by bootloader for disabling nodes */
> +       aliases {
> +               led0 = &led0;
> +               led1 = &led1;
> +               led2 = &led2;
> +               nand = &gpmi;
> +               usb0 = &usbh1;
> +               usb1 = &usbotg;
> +       };
> +
> +       chosen {
> +               bootargs = "console=ttymxc1,115200";
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +               led0: user1 {
> +                       label = "user1";
> +                       gpios = <&gpio4 6 0>; /* MX6_PANLEDG */

You are already including <dt-bindings/gpio/gpio.h> so please use the
GPIO constants instead of magic numbers (e.g: GPIO_ACTIVE_HIGH in this
case). Same for others gpios properties.

> +                       default-state = "on";
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               led1: user2 {
> +                       label = "user2";
> +                       gpios = <&gpio4 7 0>; /* MX6_PANLEDR */
> +                       default-state = "off";
> +               };
> +
> +               led2: user3 {
> +                       label = "user3";
> +                       gpios = <&gpio4 15 1>; /* MX6_LOCLED# */
> +                       default-state = "off";
> +               };
> +       };
> +

Overall, looks good to me. After the changes mentioned above:

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

[0]: http://www.spinics.net/lists/devicetree/msg44439.html
