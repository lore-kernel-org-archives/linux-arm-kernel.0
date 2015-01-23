From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Jan 2015 14:31:12 +0100
Subject: [PATCH v12 00/15] arm: Fix DEBUG_LL for multi-platform kernels
 (without PL01X)
In-Reply-To: <20150123130837.GE26493@n2100.arm.linux.org.uk>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
 <1822066.pI6QN22RDx@wuerfel>
 <CAMuHMdUpNtL+K28DdC8xJ3vUPZGmviWcYGOVUNuhKQoobdL00Q@mail.gmail.com>
 <20150123130837.GE26493@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdV4eHJC6UEwUma=vEmEf3xBmW2L5006k+Ebe_qVFwtb2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jan 23, 2015 at 2:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 23, 2015 at 02:05:22PM +0100, Geert Uytterhoeven wrote:
>> On Fri, Oct 24, 2014 at 5:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > There is still a related bug that we should also fix, but I'd say let's
>> > take your current patches first and then add whatever is missing
>> > on top. Specifically, a snippet like this
>> >
>> >         default 0xd4017000 if DEBUG_MMP_UART2
>> >         default 0xd4018000 if DEBUG_MMP_UART3
>> >         default 0xe0000000 if ARCH_SPEAR13XX
>> >         default 0xe4007000 if DEBUG_HIP04_UART
>> >         default 0xf0000be0 if ARCH_EBSA110
>> >
>> > still means you get the wrong default when you build a multiplatform
>> > kernel that you want to boot on HIP04 and you set DEBUG_HIP04_UART
>> > but you happen to also have ARCH_SPEAR13XX enabled.
>> >
>> > I have a patch that I use locally for randconfig builds that tries
>> > to fix this. It has some overlaps with your work but most parts are
>> > distinct. See below.
>>
>> This is still desperately needed for anyone who wants to enable DEBUG_LL
>> on other platforms using multi_v7_defconfig.
>
> I'd actually prefer to kill all these defaults and let people enter the
> value they want - for exactly this reason.
>
> However, I realise that would not be popular, because removing them
> means that people have to refer to some kind of documentation to find
> the correct value, and that's hassle.
>
> So, the existing defaulting behaviour is my compromise, but as I say,
> I'd much prefer the unpopular move of killing the entire set of defaults.

I have no problems with the default addresses.

I do have a problem with default addresses that depend on a non-debug
symbol that is set is multi_v7_defconfig (e.g. CONFIG_ARCH_SPEAR13XX),
as there's no way to disable that without editing arch/arm/Kconfig.debug.
I do want to find out why multi_v7_defconfig doesn't work on a board
without disabling e.g. CONFIG_ARCH_SPEAR13XX.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
