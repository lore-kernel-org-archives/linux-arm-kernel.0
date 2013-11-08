From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Nov 2013 10:45:01 +0100
Subject: [PATCH v6 4/8] ARM: dts: imx27 pinctrl
In-Reply-To: <CAHCPf3sz6eOYrnNDfOTo5Z5dZP2U9+GtQMKYZEb-1WfuXepa6A@mail.gmail.com>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <1382950843-26066-5-git-send-email-mpa@pengutronix.de>
 <CAHCPf3sz6eOYrnNDfOTo5Z5dZP2U9+GtQMKYZEb-1WfuXepa6A@mail.gmail.com>
Message-ID: <CACRpkdazhujHpjVuOhee9UXfi=zV3Z7TjbxzQ_3H+gmFrgDmWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 11:43 PM, Matt Sealey <neko@bakuhatsu.net> wrote:
> On Mon, Oct 28, 2013 at 4:00 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>>
>> +                       iomuxc: iomuxc at 10015000 {
>> +                               compatible = "fsl,imx27-iomuxc";
>> +                               reg = <0x10015000 0x600>;
>> +
>> +                       };
>> +
>>                         gpio1: gpio at 10015000 {
>>                                 compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
>>                                 reg = <0x10015000 0x100>;
>
> Linus,
>
> Case in point, you can't have two nodes which overlap registers.
>
> Probably the most reasonable way to effect this is to keep the GPIO
> bindings, put pinctrl definitions in there (there's no reason pinctrl
> and gpio drivers can't probe the same compatible property) and use
> regmap internally on that single node.

If the I/O region is tightly coupled across two subsystems like
that we usually merge the driver into one combined
pinctrl+gpio driver and put it into drivers/pinctrl/*.

This often solves more problems and make the code
simpler too.

An alternative if address 0x10015000- 0x100150ff is
really only used for GPIO is to map the pinctrl like
that:

reg = <0x10015100 0x500>

and rewrite all the base offset handling in the driver.

Yours,
Linus Walleij
