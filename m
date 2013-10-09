From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 16:14:15 +0200
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <20131009134529.GH25034@n2100.arm.linux.org.uk>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
 <20131009124425.GG25034@n2100.arm.linux.org.uk>
 <CACRpkda3J4cCTnFaQFrmZ=box6EeJ8WQZpuQpi2p_BFX+W2vuw@mail.gmail.com>
 <20131009134529.GH25034@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaZra5HASUzL4uUb-xgCY665SQmDMHmxrDQzuNDy=mBbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 9, 2013 at 3:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Right, so that means doing this:
>
>                         pinctrl_usdhc1_1: usdhc1grp-1 {
>                                 fsl,pins = <
> ...
>                                         MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
> ...
>                                 >;
>                         };
>
>                         pinctrl_usdhc1_1_dat3cd: usdhc1grp-3 {
>                                 fsl,pins = <
>                                         MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059
>                                 >;
>                         };
>
> and then:
>
>         pinctrl-0 = <&pinctrl_usdhc1_1 &pinctrl_usdhc1_1_dat3cd>;
>
> can result in either "MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059" or
> "MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059" being the final configuration
> for that pin.

I'm uncertain about the device tree case. I guess it is indeed
an array of handles indexed [0,1], the framework will only
send that array down to the driver, no strings attached.

> What that means is that for any pinctrl setting, pins to be configured
> must be mentioned exactly once and once only.

Either that (and the above does seem very ambigous) or the driver
need to combine and handle the conflicting configurations,
maintaining a state for the pin and so on ...

This seems like two *complete* configs fighting over the same pin
rather than two complementary configs that we could | together
and write, and that is indeed ambigous. The array passed to
the config function is supposed to be individual settings like
[ pull-up, schmitt-trigger ] not two complete sets of config.

The generic pin config binding is luckily  more clear than this
i.MX-specific handling.

Yours,
Linus Walleij
