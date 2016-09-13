From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Sep 2016 08:48:32 +0200
Subject: [PATCH/RFC v3 00/22] soc: renesas: Add R-Car RST driver for
 obtaining mode pin state
In-Reply-To: <20160912221640.GG7243@codeaurora.org>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <20160630201407.GA27880@codeaurora.org>
 <CAMuHMdWu34OQSS6J3bf=0-1TYULc=coiVomBjtBatwGta5F3HQ@mail.gmail.com>
 <20160912221640.GG7243@codeaurora.org>
Message-ID: <CAMuHMdVkmDkMmZ+v9eC_Htxz2J+KpxfAYUHcpSPkMFwjc1bu0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Sep 13, 2016 at 12:16 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/01, Geert Uytterhoeven wrote:
>> On Thu, Jun 30, 2016 at 10:14 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 06/01, Geert Uytterhoeven wrote:
>> >> Currently the R-Car Clock Pulse Generator (CPG) drivers obtains the
>> >> state of the mode pins either by a call from the board code, or directly
>> >> by using a hardcoded register access. This is a bit messy, and creates a
>> >> dependency between driver and platform code.
>> >>
>> >> This RFC patch series converts the various Renesas R-Car clock drivers
>> >> and support code from reading the mode pin states using a hardcoded
>> >> register access to using a new R-Car RST driver.
>> >
>> > Dumb question, can we use the nvmem reading APIs instead of an
>> > SoC specific function to read the modes?
>>
>> Thanks for your suggestion, the nvmem API indeed looks like a suitable API,
>> as it does support read-only nvmems.
>>
>> Unfortunately I also see a few disadvantages:
>>   1. nvmem_init() is a subsys_initcall(), while most of our users (except for
>>      the recent renesas-cpg-mssr driver) are clock drivers using
>>      CLK_OF_DECLARE(), and are thus initialized from of_clk_init() at much
>>      earlier time_init() time.
>>      Of course the mvmem subsystem and/or the clock drivers can be changed, if
>>      deemed useful.
>
> Sounds like this is solvable.

Sure.

>>   2. Using the nvmem DT bindings means we have to add more DT glue from the
>>      nvmem consumer(s) to the nvmem provider. As we need to provide backwards
>>      compatibility with old DTSes, this means we need more C code or DT fixup
>>      code to handle that.
>
> Ah I wasn't aware we were keeping backwards compatibility around.
>
>>   3. The nvmem subsystem may be overkill to provide access to a simple 32-bit
>>      read-only register that never changes value after boot.
>
> The nvmem subsystem is designed to read values from things that
> mostly never change. Overkill may be true, but the nice thing
> about using nvmem APIs is that the driver doesn't have to use
> some platform specific function that duplicates similar
> functionality. It's unfortunate that backwards incompatibility
> limits our ability to move to common linux frameworks when they
> are created after the binding is used.

This is continuing work to support old, current, and new SoCs properly.
When the first support for R-Car Gen2 SoCs was added, many frameworks
didn't have DT support, or didn't even exist.

Unlike in the mobile market, development and life span is much larger than
6 months here...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
