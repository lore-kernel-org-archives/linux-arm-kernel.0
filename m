From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 May 2014 14:35:28 +0200
Subject: [PATCH 2/2] mtd: orion-nand: fix build error with ARMv4
In-Reply-To: <4645786.pJABUgPlCA@wuerfel>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <20140509220915.GA391@arch.cereza>
 <20140513205548.GC22907@obsidianresearch.com>
 <4645786.pJABUgPlCA@wuerfel>
Message-ID: <CAMuHMdXD7HhG_jGJdz8hCR847tKcRC-tQnHp=xtTDYVKBc6yQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 1:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Sure, but did anyone (Arnd?) have thoughts on a better way to do this:
>>
>> +#ifdef CONFIG_64BIT
>> +               buf64[i++] = readq_relaxed(io_base);
>> +#else
>> +               buf64[i++] = *(const volatile u64 __force *)io_base;
>> +#endif
>>
>> IMHO, readq should exist on any platform that can issue a 64 bit bus
>> transaction, and I expect many ARM's qualify.
>
> Well, the original problem happened specifically for the case that doesn't
> have a 64-bit bus transaction (building for ARMv4). If we define
> readq_relaxed, it has to be an inline assembly, in order to work for
> drivers that require an atomic transaction, so that would have the
> same problem. We are a bit inconsistent here though: most 32-bit
> architectures have no readq, parisc has one that does two 32-bit accesses,
> sh relies on the compiler, and tile apparently has a native instruction.
>
> It seems reasonable to replace the inline assembly in this driver with
> a new function as a cleanup, but then how do you want to solve the case
> of building a combined armv4/v5 kernel?

Provide two helper functions, one for v4, one for v5, and call
them through a function pointer that's set up during driver probe?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
