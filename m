From: syin@broadcom.com (Sherman Yin)
Date: Wed, 13 Nov 2013 15:43:11 -0800
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <CACRpkdaf9dVqpE5uFQ5L64n+wXO0AYr5-e1WvYc4rWjVTsTg1w@mail.gmail.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <051069C10411E24D9749790C498526FA1BE0B7D7@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYSLxp2M4HghcUdjEYGh-UQ+DaiCGp6yee+Qds6DR9poA@mail.gmail.com>
 <201311050026.56321.heiko@sntech.de> <527835FE.2030102@wwwdotorg.org>
 <5279A319.5060701@broadcom.com>
 <CACRpkdaxPv6CLMjab_4umyUvbBVYcazjmwx_LGRK76vxT4VUqA@mail.gmail.com>
 <527C3080.5050202@broadcom.com>
 <CACRpkdaf9dVqpE5uFQ5L64n+wXO0AYr5-e1WvYc4rWjVTsTg1w@mail.gmail.com>
Message-ID: <52840E8F.3060803@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-11-11 02:01 AM, Linus Walleij wrote:
>> I would imagine that the platform-specific device tree bindings would need
>> to clearly explain what the valid values are, as they should.
>
> But this is not a platform-specific binding. These are the
> generic pin configuration bindings we're talking about.

Yes, the properties are generic, but I was under the impression that the 
values can be "custom", such as these:

  * @PIN_CONFIG_INPUT_SCHMITT: this will configure an input pin to run in
  *	schmitt-trigger mode. If the schmitt-trigger has adjustable hysteresis,
  *	the threshold value is given on a custom format as argument when
  *	setting pins to this mode.

and

  * @PIN_CONFIG_SLEW_RATE: if the pin can select slew rate, the argument to
  *	this parameter (on a custom format) tells the driver which alternative
  *	slew rate to use.

>
>> If we're
>> using integers, we could either have a) !0 and 0, or b) just 1 and 0, and
>> everything else is an error.  Or c) the platform could decide that the value
>> provides addition info like pull-up-strength, so 0 = no pull up, >0 = pull
>> up enabled and the number is the pull up strength in Ohm (bindings should
>> indicate which values are valid), and everything else is an error.
>
> That seems to make sense, I've just not seen any system (using
> device tree) that can actually set the pull up/down resistance.
>
>>> That said, if you can patch the OF core and the generic pin config
>>> parser to do what you want with lists like that, it's your pick.
>>> It may take some time though.
>>
>> I don't mind patching the generic pin config, and I don't think the core
>> needs to change,
>
> If you want arrays of booleans that is a matter for the OF core
> parser I think.

I was thinking of just using integers and accepting only 1 and 0, 
everything else is error.

>>> What about you patch include/linux/pinctrl/pinconf-generic.h
>>> to add PIN_CONFIG_INPUT_DISABLE with this semantic
>>> and also patch the generic pinconf parser in
>>> drivers/pinctrl/pinconf-generic.c
>>> to handle this?
>>
>> Sure, I can add PIN_CONFIG_INPUT_DISABLE.  However I suspect people might be
>> confused by this and PIN_CONFIG_OUTPUT.
>
> Just make sure you put in good documentation in that file
> right there, it's using kerneldoc and for a good reason...


Thanks,
Sherman
