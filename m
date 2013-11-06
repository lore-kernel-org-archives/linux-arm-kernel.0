From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 10:40:40 +0100
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <5279A319.5060701@broadcom.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <051069C10411E24D9749790C498526FA1BE0B7D7@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYSLxp2M4HghcUdjEYGh-UQ+DaiCGp6yee+Qds6DR9poA@mail.gmail.com>
 <201311050026.56321.heiko@sntech.de>
 <527835FE.2030102@wwwdotorg.org> <5279A319.5060701@broadcom.com>
Message-ID: <CACRpkdaxPv6CLMjab_4umyUvbBVYcazjmwx_LGRK76vxT4VUqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 3:02 AM, Sherman Yin <syin@broadcom.com> wrote:

> If I understand correctly, in Stephen's example, if a certain driver wants
> to configure PINA PINB and PINC, the pin configuration nodes "xxx1", "xxx2",
> and "xxx3" will all have to be selected for the particular pin state.  This
> works fine.  However, I'm just thinking that it would have been easier if we
> could specify just one node:
>
> xxx {
>
>         pins = <PINA>, <PINB>, <PINC>;
>         function = <...>;
>         pull-up = <1 1 0>;
> }

The property is named bias-pull-up, not just pull-up, but whatever.

> When Linus asked me to try using generic pinconf instead, I ran into
> problems with this feature due to how the generic pinconf properties are
> defined differently than my properties - perhaps this feature just doesn't
> work for generic pinconf-based drivers with the (Unless we are ok with using
> 1/0 for boolean properties, but it has already been pointed out that these
> should be valueless.).

Well it seems you would need a way to pass an array of the same
boolean property and that seems a bit more complex and hard to
read than the generic boolean bindings.

You would have to patch the OF core to do something like that:

bias-pull-up = <true true false>;

1/0 isn't so good I think, what should the parser do with e.g. 2?
This is more to the point.

> While I'd love to be able define my pin config nodes this way, if I have to
> use generic pinconf for the driver to be upstreamed, then I'm fine with it.

Well you need to use generic pin config because all the custom
stuff - i.MX comes to mind - is creating a mess. I prefer that we
share bindings and code, as any programmer would...

That said, if you can patch the OF core and the generic pin config
parser to do what you want with lists like that, it's your pick.
It may take some time though.

> Going back to some questions regarding generic pinconf properties - could I
> get some help with these?

Sure...

>>"input disable"
>>This setting disconnects the input (DIN) to the internal logic from >the
>> pin pad. However, the output (DOUT) can still drive the pad.  It
>>seems to match PIN_CONFIG_OUTPUT, but the current generic option is
>>either "output-low" or "output-high" - are these referring to a static
>>output of 0 and 1?
>
> What's the best property to use in this case?

Seems like a new case.

What about you patch include/linux/pinctrl/pinconf-generic.h
to add PIN_CONFIG_INPUT_DISABLE with this semantic
and also patch the generic pinconf parser in drivers/pinctrl/pinconf-generic.c
to handle this?

>>"mode"
>>This controls several aspect of the pin (slew rate, pull up strength,
>>etc) to meet I2C specs for Standard/Fast mode vs High Speed mode.  I
>>think the best way is to map this to slew rate, which would require
>>some explanation because the meaning of slew rate differs depending on
>>what pin function is selected:
>>- When I2C (*_SCL or *_SDA) function is selected for the pin: 0:
>>  Standard (100kbps)
>>  & Fast mode (400kbps), 1: High Speed mode (3.4Mbps)
>>- When IC_DM or IC_DP function is selected, 0: normal slew rate, 1:
>>  fast slew rate
>>- Else: 0: fast slew rate, 1: normal slew rate
>
> Do we agree that the "slew rate" is the best property to use for "mode"?

It seems to be indeed mostly related to slew rate.

However if you want a custom brcm,mode binding that should
be possible too, as well as augmenting the driver to use
*both* generic pinconf *and* some custom config options
on top. That has not been done so far though I think, so you
might need a bit of hacking to do that.

Yours,
Linus Walleij
