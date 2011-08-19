From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Aug 2011 14:10:41 +0200
Subject: [PATCH 2/2] pinmux: add a driver for the U300 pinmux
In-Reply-To: <CAGsJ_4wWVTwY_=dQAT+-SGG3nRrwipZfVnaD6pMhDFL0OTX8rA@mail.gmail.com>
References: <1307984311-9813-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4wWVTwY_=dQAT+-SGG3nRrwipZfVnaD6pMhDFL0OTX8rA@mail.gmail.com>
Message-ID: <CACRpkdbTQbeU8MfW4_SobbNf2aV2+UFXFtqaBjXDML2vrckWvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 5:40 AM, Barry Song <21cnbao@gmail.com> wrote:

>> +static const struct u300_pmx_func u300_pmx_funcs[] = {
>> + ? ? ? {
>> + ? ? ? ? ? ? ? .name = "uart0",
>> + ? ? ? ? ? ? ? .pins = uart0_pins,
>> + ? ? ? ? ? ? ? .num_pins = ARRAY_SIZE(uart0_pins),
>> + ? ? ? ? ? ? ? .mask = uart0_mask,
>
> if we build a register address/bit shift/value table for every pinmux
> selection, sometimes we even need to write multiple registers for only
> one selection, for example:
>
> spi0:
> {
> REG ? ? ?SHIFT ? VALUE
> {REG1, ? ?1, ? ? ? ? 5},
> {REG2, ? ?3, ? ? ? ? 2},
> }
>
> we might let the whole enable/disable have common codes in the pinmux
> core but not implemented by every drivers.
> Common Enable:
> for (i = 0; i < MASK_NUM; i++)
> {
> ? ? writel(mask[i].reg, readl(mask[i].reg) | mask[i].val << mask[i].shift);
> }
>
> Common Disable:
> for (i = 0; i < MASK_NUM; i++)
> {
> ? ? writel(mask[i].reg, readl(mask[i].reg) & ~(mask[i].val << mask[i].shift));
> }

OK that problem is not unique to the pinmux subsystem though,
I can think of drivers/gpio/ and drivers/mfd/ etc etc plus platforms
having this need.

> ASoC really define some good macros about register layout for audio
> path, audio volume and son on, so every driver doesn't need to write
> so many details about hardware. they just use those macros to define
> register layout.

Can they be made generic so that *any* subsystem can use them?

> If we have common enable/disable for pinmux, every pinmux driver will
> only need to fill the table. Actually,  engineers just want to check
> the datasheet to figure out the table. And they don't want to repeat
> the enable/disable codes for every possible selection of pinmux.

Not all pinmuxes are the same, and not all are memory-mapped
either. Some are on the other end of an I2C, some (like U300)
need to read and write more than one register to do a specific
pin muxing. In the gpio-nomadik driver there is a special horror
about these registers also, one that cannot be solved easily with
a function like that. So it'd have to be optional.

It's a separate subject I think, no problem to do such things any day
on any subsystem.

Else we'll define and refactor what we need as we go along...

Thanks,
Linus Walleij
