From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Nov 2016 15:30:10 -0800
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.10
In-Reply-To: <CAMuHMdUtu9N28rOb+813DumtbyAZJB3G+euD0mwwXD_jCiXrRg@mail.gmail.com>
References: <cover.1479387356.git.horms+renesas@verge.net.au>
 <20161119012836.GA2543@localhost>
 <CAMuHMdXAuDcbr84phfPRpqZYRzAZf2j4vsv+i_Frz0G8ksd_Vg@mail.gmail.com>
 <CAOesGMjk=KWifGT7sugpWVjNJSKhmgxg8gN9Cgi=emGrg66z0w@mail.gmail.com>
 <CAMuHMdUhpeiOj6Mjhgt=9R3yuV-HwOAy5AAsDSTDjagRRDtYCw@mail.gmail.com>
 <CAOesGMj47EZ1Zjc41VV2D-cM5XUsK28PDF-jSHKUkkind32ZRA@mail.gmail.com>
 <CAMuHMdUtu9N28rOb+813DumtbyAZJB3G+euD0mwwXD_jCiXrRg@mail.gmail.com>
Message-ID: <CAOesGMimsQphE4TzrJ7EPpp90VQG23vGP3jVrJK3qQrZgNEd3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 1:56 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Olof,
>
> On Mon, Nov 21, 2016 at 5:35 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Mon, Nov 21, 2016 at 8:27 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Mon, Nov 21, 2016 at 5:19 PM, Olof Johansson <olof@lixom.net> wrote:
>>>> On Mon, Nov 21, 2016 at 1:31 AM, Geert Uytterhoeven
>>>> <geert@linux-m68k.org> wrote:
>>>>> On Sat, Nov 19, 2016 at 2:28 AM, Olof Johansson <olof@lixom.net> wrote:
>>>>>> On Thu, Nov 17, 2016 at 02:34:25PM +0100, Simon Horman wrote:
>>>>>>> Please consider these second round of Renesas ARM based SoC updates for v4.10.
>>>>>
>>>>>>> * Basic support for r8a7745 SoC
>>>>>>>
>>>>>>> ----------------------------------------------------------------
>>>>>>> Sergei Shtylyov (2):
>>>>>>>       ARM: shmobile: r8a7745: basic SoC support
>>>>>>>       ARM: shmobile: document SK-RZG1E board
>>>>>>
>>>>>> Is there a reason you're adding a config option per SoC?
>>>>>>
>>>>>> I think you'd be better off not adding these config options, and just adding
>>>>>> support for the SoCs through compatibles (and adding the drivers to defconfigs,
>>>>>> etc).
>>>>>
>>>>> Yes there is a reason: kernel size.
>>>>> The main offenders are the pinctrl tables, which add ca. 20-50 KiB per
>>>>> supported SoC.
>>>>
>>>> So don't turn on that pinctrl driver unless you have that SoC?
>>>
>>> The enablement of the pinctrl driver (and the clock driver, FWIW) is controlled
>>> by the SoC Kconfig symbol. If you want support for the SoC, you want the
>>> pinctrl driver, too.
>>
>> Oh, that's trivial to fix! Do as almost all other SoCs do, and don't
>> use silent options.
>
> What does that gain us? The ability to enable support for an SoC, without
> enabling the accompanying pinctrl driver, leading to a non-booting system?

It doesn't enable anything new, it just makes it less awkward for you
to add new SoCs in the future without creating dependencies on new
Kconfig symbols in the arch directory.

> As soon as you have any pinctrl properties in the DT, you need the pinctrl
> driver. Unless you disable CONFIG_PINCTRL (it's selected, and not
> user-controlled), and rely on fragile reset state/boot loader.
>
> Pinctrl (and clock and irqchip) on-SoC drivers are special: if you fail to
> include them, the system won't boot.

This isn't about booting without a pinctrl driver. It's about avoiding
adding new config symbols when they're not needed.

I started out comparing your way of using config options with, for
example, Exynos that has a bunch of different SoCs enabled. Having
dependencies described clearly has some value, since it can be hard to
know if you can turn off a driver and still have a bootable system
with some of the other platforms.

That being said, I think you should look at changing how you use your
config options to make it less messy to add new ones:

Looking around a bit, I noticed CLK_RENESAS_CPG_MSTP. This config
option is used awkwardly -- what you should have is a (silent) config
option that it depends on (such as {NEEDS|HAS}_CLK_CPG_MSTP or
similar), that each platform needing this can select. Then
CLK_RENESAS_CPG_MSTP only depends on that. No more need to touch this
config entry for every new SoC that is enabled.

Also, right now drivers/clk/renesas/Makefile is all keyed off of the
SoC config option, when instead you should consider a CLK_* option to
avoid duplication like you have today. For the shared platforms you
can do it just as above with HAS_.* config entries. Again, for some of
these you won't have to touch the clk/ directory at all any more for
new SoCs, the way the rcar2 ones have been made!

pinctrl config seems like it's a bit heavy on boiler plate as well.
Most of the entries do the same things. Many other platforms instead
select the pinctrl driver from the SoC Kconfig entry, maybe this is a
good approach here too, and avoids more boilerplate in the driver
directory. Of course, legacy SH platforms can probably be left alone
as they are though.


-Olof
