From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 22 Jun 2018 13:41:37 +0200
Subject: [PATCH] [RFC] arm: Replace "multiple platforms" by "common
 platform"
In-Reply-To: <20180622092305.GS17671@n2100.armlinux.org.uk>
References: <20180621155906.12821-1-geert+renesas@glider.be>
 <20180622092305.GS17671@n2100.armlinux.org.uk>
Message-ID: <CAMuHMdUqBhR4Ra=hF0TZKxgQHaE_KBUYh04ZTTmg1pRWtjveoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for your comments!

On Fri, Jun 22, 2018 at 11:23 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Jun 21, 2018 at 05:59:06PM +0200, Geert Uytterhoeven wrote:
> > "ARM multiplatform" has actually two meanings:
> >   1. It groups platforms that follow the "ARM multiplatform" software
> >      framework,
> >   2. It allows to build a single kernel that can be booted on multiple
> >      platforms.
> >
> > Currently support for XIP and/or NOMMU cannot be enabled on platforms
> > that follow the "ARM multiplatform" framework, without duplicating their
> > machine selection logic under a new Kconfig symbol.  As (in theory) all
> > platforms can be used with XIP and/or NOMMU, this is not sustainable.
>
> The reason for that has nothing to do with the way this option is named,
> and even after reading your commit message, I can't come up with any
> reason for this change other than "personally don't like the existing
> wording" which IMHO is not a good enough reason to randomly go around
> rewording stuff in the kernel.
>
> The reason that XIP and NOMMU can't be enabled with a multi-platform
> kernel is that there are often issues with different layouts of the
> physical memory space which can not be taken into account.
>
> Multi-platform works around that by (a) using the MMU to abstract
> away the differences on RAM, and (b) modifying the kernel text to
> adjust the virtual to physical translations.  The latter is not
> possible with XIP, and the former should not be used with NOMMU.
> That means the kernel must be built to accomodate the physical
> layout on the target platform, and so building a kernel supporting
> multiple platforms with differing memory layouts makes no sense.
>
> This is exactly why I really don't like the idea of ARCH_MULTIPLATFORM
> being hijacked for NOMMU/XIP support.

That's multiplatform meaning #2.

But as long as MMU=y and XIP_KERNEL=n, nothing would change.

> We've worked around the issues with "multi-platform" XIP/NOMMU by
> using things such as "ARM_SINGLE_V7M" to cover all V7M platforms
> (which must, by definition) have compatible physical layouts.
> Exactly the same approach should be adopted for other XIP/NOMMU
> platforms, and _not_ reusing ARCH_MULTIPLATFORM, which will lead
> to lots of non-bootable kernels.

So we need ARM_SINGLE_ARMV7A, and let all subarchitectures depend on
ARCH_MULTIPLATFORM || ARM_SINGLE_ARMV7M, to avoid duplicating
their SoC entry?

I had a quick look. So we have e.g. MACH_STM32F746 under ARM_SINGLE_ARMV7M,
and MACH_STM32MP157 under ARCH_MULTI_V7.
But according to stm32mp157c-ed1.dts and stm32746g-eval.dts both have
memory at the same address, so it should be possible to run the same nommu
kernel on the STM32MP157?

MACH_STM32F469 is also under ARM_SINGLE_ARMV7M, but according to
stm32f469-disco.dts, memory may be at a completely different address?
Doesn't that lead to unbootable kernels, too?

> Another problems for NOMMU is that the kernel has to be linked for
> a specific _physical_ address.  When you have ARCH_MULTIPLATFORM
> enabled, there is no facility to select that address.

That can be easily solved with Kconfig symbols that depend on !MMU,
can't it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
