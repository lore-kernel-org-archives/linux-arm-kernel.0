From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 May 2014 16:13:26 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <53870787.3030202@gmail.com>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <201405091244.02066.arnd@arndb.de>
 <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
 <537E7B83.4020900@gmail.com>
 <CACRpkdap1U19EiULnq11udhY91UnnNu_-5MnLby3idbdjzBj4Q@mail.gmail.com>
 <53870787.3030202@gmail.com>
Message-ID: <CACRpkdYVe+++Qb-CWrWwM1zDHxNqmpE0CFzp959Q40Zqb5sUEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 12:10 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 05/29/2014 11:44 AM, Linus Walleij wrote:

>> Hmmmm well I want to see that code before I believe it ... but
>> I get what you mean.
>
> Well, the register set on Berlin I was thinking about tackles pinctrl,
> padmux, clock, reset and some other freaky stuff I cannot recall. The
> mess in it is that there is no order you can apply to split it up into
> separate nodes. Moreover, the next SoC has some registers just shoved
> into it, moving some other registers.

Berlin hardware engineers seem to be hellbent on complicating
your life.

> The way we will go for it on Berlin is now:
>
> (a) have a single node for the whole chip-ctrl register set
> (b) register clk driver on it (early, as it provides timer clk)
> (c) register one chip-ctrl driver on it that will
>     (d) reserve the iomap,
>     (e) register a regmap-mmio,
>     (f) register platform_devices for {pinctrl,reset,...} that will
>         use regmap-mmio and read their properties from the single
>         node

OK makes perfect sense actually.

> The individual drivers should stay in their respective drivers/ folder,
> but (c) needs a good home. It would have been mach-foo in the past, and
> could be drivers/soc now. In (f), I tend to just lookup regmap by name,
> no DT involved at all.

OK

> BTW, syscon is of no use here at all, once it registers itself as a
> driver for the node, there will be no other drivers registered. That
> would at least require (again subsystem driven) dummy-nodes for
> pinctrl, clk, reset.

Yeah that sucks, we need something more flexible no question
about that.

Will the chipctrl driver be as generic as syscon or a
Berlin-specific thing?

> Also, using some of_xlate as we already have for clk, gpio, pinctrl ...
> would put an end to syscon's syscon_get_regmap_from_{foo,bar,baz,...}
> that gets a new helper every cycle.

This part I don't understand but I guess I will understand it
when I see the code.

Yours,
Linus Walleij
