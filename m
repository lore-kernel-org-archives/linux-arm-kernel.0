From: alchark@gmail.com (Alexey Charkov)
Date: Tue, 13 Jul 2010 16:02:02 +0400
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <AANLkTil8aDUl2T-P1eZIdiLrXc05VyWWvpCg8QmfuZDp@mail.gmail.com>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007122122.32623.arnd@arndb.de>
	<AANLkTilWwclstZiIkpiQQ_CPXgjGD2xz-GEw27hTvAp-@mail.gmail.com>
	<alpine.LFD.2.00.1007121855470.10598@xanadu.home>
	<AANLkTil8aDUl2T-P1eZIdiLrXc05VyWWvpCg8QmfuZDp@mail.gmail.com>
Message-ID: <AANLkTilOcHnZwI5L0X6yozRYLolpSkouoEFMuQAy7T1a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/13 Alexey Charkov <alchark@gmail.com>:
> 2010/7/13 Nicolas Pitre <nico@fluxnic.net>:
>> On Tue, 13 Jul 2010, Alexey Charkov wrote:
>>
>>> Actually, as the devices using these SoC's are mainly generic Chinese
>>> products, I would not expect any consistency in this area. The
>>> bootloader is a modification of an old U-boot, but I could not find
>>> the sources for my version (yes, a GPL violation). It seems to use
>>> some machine IDs in the range of 4000+, but again I would not trust
>>> that. That's why I decided to hardcode the intended target devices
>>> here (which is what some of the other machines do).
>>
>> We try to avoid those as much as possible of course.
>>
>> What U-Boot version is this? ?The mainline U-Boot has had the ability to
>> override the built-in machine ID with an env variable for a while.
>>
>
> When booting, it prints "VT8500 U-Boot 1.2.19.1 (Dec ?4 2009 -
> 17:14:38)". If there is a way to drop a couple of hacks, I would be
> really glad, of course :) A quick grep through U-boot's commit history
> did not provide me with any clue about this feature, though. Need to
> search better...
>

The feature in question is added by commit 3c234efa693 in U-Boot's git
repo (machid env variable). It is dated Thu, 14 Feb 2008, which was in
the 1.3.* release cycle, thus missing from the vendor-provided binary
on my board, unfortunately.

>>> >> +#ifdef CONFIG_MMU
>>> >> +/* macro to get at IO space when running virtually */
>>> >> +#define IO_ADDRESS(x) ((x) | 0xf0000000)
>>> >> +#else
>>> >> +#define IO_ADDRESS(x) (x)
>>> >> +#endif
>>> >
>>> > I don't know yet what the general consensus in the arm world is about this,
>>> > but this looks hacky to me. I'd recommend killing off the IO_ADDRESS macro
>>> > and replacing it with proper calls to ioremap.
>>> >
>>> >
>>>
>>> I just followed the way how some of the other machine code functions:
>>> mach-versatile and mach-realview both define similar macros. If using
>>> ioremap is a better way, I could try to rework it.
>>
>> Versatile and RealView are development boards where things like MMU-less
>> builds of Linux are tested. ?I doubt you'll want to run MMU-less Linux
>> on your target. ?So this macro is most probably irrelevant for your
>> purpose. ?And this is unrelated to whether ioremap is a better solution
>> (obviously on MMU-less systems ioremap is unavailable).
>>
>
> I see the point. Will have to understand better how the whole remapped
> IO works and remove the macro.
>

It seems that other boards (omap2, msm) define separate sets of
registers with physical and virtual addresses. Will it be ok if I
retain only one set (with physical addresses, following the SoC
documentation) and use:

#define IO_ADDRESS(x) ((x) | 0xf0000000)

to refer to virtual addresses as IO_ADDRESS(PHYS_ADDR) when needed?
And should those addresses be accessed through readl/writel only, and
not through pointer dereferencing? Probably any other peculiarities
that I am missing here?

Sorry for a load of questions: I am quite new to all of these but wish
to do things the right way :)

Alexey
