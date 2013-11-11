From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Nov 2013 11:01:02 +0100
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <527C3080.5050202@broadcom.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <051069C10411E24D9749790C498526FA1BE0B7D7@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYSLxp2M4HghcUdjEYGh-UQ+DaiCGp6yee+Qds6DR9poA@mail.gmail.com>
 <201311050026.56321.heiko@sntech.de>
 <527835FE.2030102@wwwdotorg.org> <5279A319.5060701@broadcom.com>
 <CACRpkdaxPv6CLMjab_4umyUvbBVYcazjmwx_LGRK76vxT4VUqA@mail.gmail.com>
 <527C3080.5050202@broadcom.com>
Message-ID: <CACRpkdaf9dVqpE5uFQ5L64n+wXO0AYr5-e1WvYc4rWjVTsTg1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 1:29 AM, Sherman Yin <syin@broadcom.com> wrote:
> [Me]
>> On Wed, Nov 6, 2013 at 3:02 AM, Sherman Yin <syin@broadcom.com> wrote:

>> You would have to patch the OF core to do something like that:
>>
>> bias-pull-up = <true true false>;
>>
>> 1/0 isn't so good I think, what should the parser do with e.g. 2?
>> This is more to the point.
>
> I would imagine that the platform-specific device tree bindings would need
> to clearly explain what the valid values are, as they should.

But this is not a platform-specific binding. These are the
generic pin configuration bindings we're talking about.

> If we're
> using integers, we could either have a) !0 and 0, or b) just 1 and 0, and
> everything else is an error.  Or c) the platform could decide that the value
> provides addition info like pull-up-strength, so 0 = no pull up, >0 = pull
> up enabled and the number is the pull up strength in Ohm (bindings should
> indicate which values are valid), and everything else is an error.

That seems to make sense, I've just not seen any system (using
device tree) that can actually set the pull up/down resistance.

>> That said, if you can patch the OF core and the generic pin config
>> parser to do what you want with lists like that, it's your pick.
>> It may take some time though.
>
> I don't mind patching the generic pin config, and I don't think the core
> needs to change,

If you want arrays of booleans that is a matter for the OF core
parser I think.

>> What about you patch include/linux/pinctrl/pinconf-generic.h
>> to add PIN_CONFIG_INPUT_DISABLE with this semantic
>> and also patch the generic pinconf parser in
>> drivers/pinctrl/pinconf-generic.c
>> to handle this?
>
> Sure, I can add PIN_CONFIG_INPUT_DISABLE.  However I suspect people might be
> confused by this and PIN_CONFIG_OUTPUT.

Just make sure you put in good documentation in that file
right there, it's using kerneldoc and for a good reason...

Yours,
Linus Walleij
