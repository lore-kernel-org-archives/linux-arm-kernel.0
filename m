From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 4 Feb 2017 19:43:15 +0100
Subject: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
In-Reply-To: <2695922.yyinjvNuJK@wuerfel>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-2-linus.walleij@linaro.org> <2695922.yyinjvNuJK@wuerfel>
Message-ID: <CACRpkdb=BqihykWo3egtNW1VKE2-FV+nJQQVYOc2GdCvh1fMng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday, January 28, 2017 9:48:37 PM CET Linus Walleij wrote:

>> +     /* No clue what these do */
>> +     pcibios_min_io = 0x100;
>> +     pcibios_min_mem = 0;
>
> Don't touch these

OK I have a clue why this is there now, atleast the first one.

The first 0x100 in the IOspace is actually configuration registers
for the bridge. That is why we have this:

reg = <0x50000000 0x100>;
(...)
/* PCI ranges mappings */
                        ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
                         <0x01000000 0 0          0x50000000 0 0x00100000>,

This is in all the vendor code I have located too.

So the pcibios_min_io is manipulated to avoid touching that
sensitive area. But I also see that arch/arm/mm/iomap.c
sets it to 0x1000, according to the commit because you said
it's the only valid value :D

I tried setting the IO range to <0x50000100 0x000FFF00>
instead of <0x50000000 0x00100000>
but predictably that doesn't work. Maybe it should, I don't
know really.

Yours,
Linus Walleij
