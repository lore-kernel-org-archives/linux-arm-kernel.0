From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Oct 2017 09:43:40 +0200
Subject: [PATCH v3 12/12] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when
 used as LDOs
In-Reply-To: <8be22e47-8071-be4c-0bd4-38fa51cbe3ff@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-13-quentin.schulz@free-electrons.com>
 <CACRpkdZYcSuhvn0b0qa0k1PQHoyXjNyjoyhR2sPme_t1pF12Dg@mail.gmail.com>
 <20171003144737.rhgtp3uwckhvoqdw@flea>
 <CAGb2v64=XL34x7iGJcEmmVnmzkA5wmyZJd-g827bY=kdHcZOMA@mail.gmail.com>
 <8be22e47-8071-be4c-0bd4-38fa51cbe3ff@free-electrons.com>
Message-ID: <CACRpkdbjHZ7=m1-6vOw3ru+XkoCfSvHJSEFtCtHo5LkB4cPyhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 9:35 AM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

> Just to be a little more precise,
>      - 0: drive low
>      - 1: drive high
>      - 2: input with interrupt triggering
>      - 3: LDO on
>      - 4: LDO off
>      - 5~7: floating (or ADC)
>
> for AXP813, and
>      - 0: drive low
>      - 1: drive high
>      - 2: input with interrupt triggering
>      - 3: LDO on
>      - 4: ADC
>      - 5~7: floating

Fair enough, it's mux modes that the pin supports, no big surprises.

> So I think what you suggested Linus is not really relevant here as the
> regulator framework will take care of disabling the regulator when
> needed (for AXP813 via the ldo_off "muxing" selected by the regulator
> framework).

I think I see why I got confused.

The point is that your mode for setting it to "LDO on" should have the
pin control state connected to the relevant device.

It should be connected to the regulator and nothing else, so if there is a fixed
regulator or whatever in the device tree, it should have pinctrl-0
and pinctrl-names = ".."; here is is for some obscure reason connected
to the GPIO controller (!) instead, and the actual consumer of this state
is NOT the GPIO controller, but quite obviously the regulator, so
put the pinctrl business in that regulator node instead.

"default" mode is OK on a regulator, as that can be expected to make the
pin precisely a regulator pin. Forget my ramblings about a "regulator"
state.

Yours,
Linus Walleij
