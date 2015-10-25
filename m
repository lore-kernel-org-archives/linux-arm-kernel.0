From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 25 Oct 2015 18:38:18 +0100
Subject: Build regressions/improvements in v4.3-rc7
In-Reply-To: <20151025140822.GA32532@n2100.arm.linux.org.uk>
References: <1445767971-22415-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
 <CAMuHMdUkNad7-zHSEfy__rPXKV2t0_7O+MtHiW1hUN=t30KWoA@mail.gmail.com>
 <20151025140822.GA32532@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdVdSa2899nEYq4dg_WghdCWgj4jZqnd_8FE7_221O0CFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2015 at 3:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Oct 25, 2015 at 11:39:15AM +0100, Geert Uytterhoeven wrote:
>> On Sun, Oct 25, 2015 at 11:18 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Sun, Oct 25, 2015 at 11:12 AM, Geert Uytterhoeven
>> > <geert@linux-m68k.org> wrote:
>> >> JFYI, when comparing v4.3-rc7[1] to v4.3-rc6[3], the summaries are:
>> >>   - build errors: +12/-4
>>
>> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
>> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
>> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
>> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN' undeclared (first use in this function):  => 39:2
>> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2
>>
>> Caused by:
>>
>> commit ab0615e2d6fb074764a3e4d05f1326fa2fdb4627
>> Author: Rabin Vincent <rabin@rab.in>
>> Date:   Thu Apr 24 23:28:57 2014 +0200
>>
>>     arm: use fixmap for text patching when text is RO
>>
>> Should the call to set_fixmap() in arch/arm/kernel/patch.c
>> just be protected by #ifdef CONFIG_MMU?
>
> What this shows, time and time again, is that we need better testing for
> !MMU platforms - we need !MMU platforms in the mainline kernel which
> people actually have.
>
> I have an OKI 67001 board (from Simtec), which is the older generation of
> !MMU system, and I have code for it, but arm-soc won't let me put it in
> the mainline kernel - even though it would give me a platform which I can
> add to the boot farm to build and boot a test kernel for.
>
> Consequently, I've little motivation to catch !MMU regressions before
> they hit mainline.
>
> Should we accept old !MMU code into mainline for platforms which kernel
> developers have, in order to aid testing, even though it isn't modern
> platforms and doesn't conform to the latest way of doing stuff.

I think we should have at least one arm-nommu platform in the upstream kernel,
with a suitable defconfig, so 0build will catch regressions.

Alternative, can any of the existing supported arm-mmu platform be used with
a nommu kernel?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
