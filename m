From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2018 10:28:44 +0200
Subject: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
In-Reply-To: <1685755.J6GI985WX3@diego>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <6ffb43dc-55a5-14eb-eb18-3a731cdaf424@t-chip.com.cn>
 <CAL_Jsq+_QEBWdxW=J4oVGWeokc-+nMzxzX_pgCayaxg-ehivfQ@mail.gmail.com>
 <1685755.J6GI985WX3@diego>
Message-ID: <CACRpkdYCdNZ=ASw1uz4zKXC4AMd1EGbvG_G5K5cwSpH5eGPgKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 5:12 PM, Heiko St?bner <heiko@sntech.de> wrote:

> So the gpio controller should definitly also be a subnode.
>
> The gpio in question is called "mute", so I'd think the gpio-syscon driver
> should just define a "rockchip,rk3328-gpio-mute" compatible and contain
> all the register voodoo in the driver itself and not define it in the dt.
>
> So it should probably look like
>
> grf: syscon at ff100000 {
>         compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
>
>         [all the other syscon sub-devices]
>
>         gpio_mute: gpio-mute {
>                 compatible = "rockchip,rk3328-gpio-mute";
>                 gpio-controller;
>                 #gpio-cells = <2>;
>         };

I'm sceptic.

That doesn't sound like "general purpose input output" at all.

It sounds like special purpose, for a mute button.

Does it use IRQ? I would recommend implementing
drivers/input/keyboard/syscon-keys.c in the same vein
as drivers/leds/leds-syscon.c so you can avoid indirection
through GPIO for no good reason at all.

I already have other good uses for such a generic
input driver.

Yours,
Linus Walleij
