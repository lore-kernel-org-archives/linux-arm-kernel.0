From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 30 Nov 2015 22:06:37 +0100
Subject: [PATCH 0/6] pinctrl: pxa: add pxa27x pin control support
In-Reply-To: <CACRpkdaJO6noUd_a5d122G3EiO6-u9bu_gZMg1Tky=PS9O5yUA@mail.gmail.com>
 (Linus Walleij's message of "Mon, 30 Nov 2015 14:05:35 +0100")
References: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
 <CACRpkdaJO6noUd_a5d122G3EiO6-u9bu_gZMg1Tky=PS9O5yUA@mail.gmail.com>
Message-ID: <87lh9f6vtu.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Sat, Nov 21, 2015 at 7:04 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> I've been working on this for some time now, it's time pxa archtecture gets a
>> proper pin control support.
>>
>> This serie provides support for pxa27x architecture, and paves the way to pxa2xx
>> one. I've tested this on my pxa27x board, in both device-tree and non
>> device-tree builds.
>
> So in 2013 Haojian removed PXA3xx, MMP2, PXA168 and PXA910 in favor
> of using pinctrl-single.c shared with OMAP.
>
> See
> commit 62194200e5e383af2085faf35b6f009364446069
> "pinctrl: remove pxa pinctrl driver"
Yes, for MMP2, PXA168 and PXA910. Up to my best understanding this didn't cover
pxa3xx, but I might be wrong.

> What makes the PXA27x so different from its siblings that it still
> warrants its own driver? Why can this one not use pinctrl-single
> as well?
There are several factors I considered, which apply for both pxa25x and pxa27x :
 - pinmuxing
   - the "alternate" function is not dictated by a single register for a given
     pin. The function is dictated by 2 registers : the gpio direction register
     and the alternate function register.
     That means that setting alternate function "MMCLK" for examples implies
     writing to the gpio direction register (GPDR) "output", and writing to the
     alternate function register (GAFR) the function.
     I don't think pinctrl-single can handle this complexity, correct me if I'm
     wrong.

   - MMP2, PXA168 and PXA910 are "post-multi platform" kernel. That means there
     is not "machine code", and that all their boards are described in
     devicetree (correct me Haojian if I'm wrong).
     On the other hand, pxa25x, pxa27x and pxa3xx platform have still a lot of
     machine files (arch/arm/mach-pxa/*.c). The goal of this serie is to remove
     arch/arm/mach-pxa/mfp-*.c files, which predate pin control API, by
     converting these machine files to pin control.
     The long term goal is to have only one code maintained for pxa pinmuxing,
     for both devicetree and platform_data board, and I'd rather have it in
     pinctrl rather than arch/arm/mach-pxa.

   - gpio direction register sharing
     As GPDR is needed for both gpio driver and pinctrl, I'd like to have a
     single point where GPDR is manipulated. As pincontrol cannot be configured
     without it, I was thinking have a pinctrl driver driving GPDR, and
     gpio-pxa.c using it.
     I don't see pinctrl-single enabling that either.

   - non contiguous register ranges
     GPDR and GAFR are not contiguous, ie. you don't have the guarantee that
     GPDR(pin(x+1)) is either GPDR(pin(x)) or GPDR(pin(x)) + 4.
     Or said differently the register sets are sparse, and I don't know if
     pinctrl-single can handle that.

 - pinconf
   - nothing special here, only a register set (sparse AFAIR).
     I don't know if pinctrl-single can handle non contiguous MMIO ranges.

Now for pxa3xx, I think pinctrl-single might be usable, as this architecture has
a proper pincontrol register set. This is something I will look into next, as
long as the legacy platform can use pinctrl-single too (ie. from machine code).

I might remember other reasons in the next days, these ones are the most obvious
which came to my mind.

If you think of another way, I'm all for it, my personal objectives are :
 - removing mfp* files
 - having the same code handle devicetree and platform_data boards
 - having consistency in gpio direction handling
 - having pinctrl debug facilities (I love /sys/kernel/debug/pinctrl**)
 - having pin function names consistency across the boards if possible (ie. if
   MMCLK is used on boardX, then MMCLK must be used in boardY, and not MMCCLK)

Cheers.

-- 
Robert
