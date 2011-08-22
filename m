From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Aug 2011 15:46:48 +0200
Subject: [PATCH 2/4 v4] pinmux: add a driver for the U300 pinmux
In-Reply-To: <CAGsJ_4wK6V0aQJd7f1geM8XnzQO+3TNCE6Q8_j=VYf_z_gcmpA@mail.gmail.com>
References: <1313747646-32294-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4wK6V0aQJd7f1geM8XnzQO+3TNCE6Q8_j=VYf_z_gcmpA@mail.gmail.com>
Message-ID: <CACRpkdYNjRV5RUsi5hNeKMBHRH6viVfFuqT+cuHoe_4sn3UWvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 3:55 PM, Barry Song <21cnbao@gmail.com> wrote:

>> + ? ? ? if (upmx) {
>
> why do you need to check whether upmx is not NULL. if it is NULL, we
> have failed in probe().
> and it is also impossible to call this remove() twice.

True, removing the if()-clause.

>> +static struct platform_driver u300_pmx_driver = {
>> + ? ? ? .driver = {
>> + ? ? ? ? ? ? ? .name = DRIVER_NAME,
>> + ? ? ? ? ? ? ? .owner = THIS_MODULE,
>> + ? ? ? },
>> + ? ? ? .remove = __exit_p(u300_pmx_remove),
>
> if you want to add deepsleep support(i mean pinmux crl will lose power
> while suspending), what do you plan to add?
> save U300_SYSCON_PMC1LR, U300_SYSCON_PMC1HR, U300_SYSCON_PMC2R,
> U300_SYSCON_PMC3R, U300_SYSCON_PMC4R in suspend and restore them in
> resume?

The U300 does not loose context in deepsleep so this cannot be
used as an example for how to do that, sadly. This platform
retains all contents in sleep.

On the Ux500 this thing is hardware controlled and also in an
always-on power domain.

So I actually don't have the problem on any of my systems,
I was saved by clever hardware designers...

So it looks like this funny problem will hit the first one who
implements something that loose state of their pinmux
when sleeping.

However if I make this driver advanced, it needs to set
some pins to sleepmodes, like specific biasing GND:ing, during
sleep. That is however not part of the muxing, but the other
pinctrl things that are not implemented yet :-P

> it is also a generic issue to pinmux.

It's not even a pinmux-specific issue, but a generic device
driver issue is it not? I think you can use runtime PM possibly
with power domains for this, is that not what it is intended
for?

>> +/*
>> + * Register definitions for the U300 Padmux control registers in the
>> + * system controller
>> + */
>> +
>> +/* PAD MUX Control register 1 (LOW) 16bit (R/W) */
>> +#define U300_SYSCON_PMC1LR ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (0x007C)
> ...
>> +#define U300_SYSCON_PMC4R_APP_MISC_16_EMIF_1_STATIC_CS5_N ? ? ?(0x0200)
>
> do you want these "(" ")" for macros?

Nah, I'll delete them if you like it better that way...

Thanks!
Linus Walleij
