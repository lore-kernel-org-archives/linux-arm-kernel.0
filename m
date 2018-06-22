From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 22 Jun 2018 17:33:26 +0200
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <20180622110145.GU17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
Message-ID: <CAMuHMdWZPM3Q9fVXWiw1bMVWNRCYGoQa-XukJka-2xsP-=HmVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, Jun 22, 2018 at 5:26 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 22 Jun 2018, Russell King - ARM Linux wrote:
> > On Thu, Jun 21, 2018 at 12:24:04PM -0400, Nicolas Pitre wrote:
> > > [ adding linux-kbuild for their input ]
> > >
> > > On Thu, 21 Jun 2018, Geert Uytterhoeven wrote:
> > > > I've just sent a patch to do that.
> > >
> > > Your patch isn't wrong per se.  But it is not enough. The issue here
> > > would be easily fixed with some kconfig extension so that:
> > >
> > > - If XIP or NOMMU is selected then only one target in the multiplatform
> > >   set can be selected, basically turning it into a choice menu.
> >
> > I don't think that's how it should work.  Consider the V7M case, where
> > we have better standardisation of the physical address layout than
> > previous ARM devices.  We have three platforms which are V7M compliant:
> >
> > - AT91
> > - iMX
> > - STM32
> >
> > These have separate symbols:
> >
> > menuconfig ARCH_AT91
> >       bool "AT91/Microchip SoCs"
> >       depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
> >
> > menuconfig ARCH_MXC
> >       bool "Freescale i.MX family"
> >       depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 || ARM_SINGLE_ARMV7M
> >
> > menuconfig ARCH_STM32
> >       bool "STMicroelectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
> >
> > With your suggestion, you would become only build a kernel for one of
> > these, but that is not the case today: it's possible to build a single
> > kernel which supports all these platforms.
>
> That is still something that could be accommodated if the kconfig
> language was more accommodating. The problem comes from the fact that
> some options are mutually exclusive, like platforms with conflicting
> memory maps and XIP.
>
> Leaving your example above aside for the moment, let's just pick the
> ARCH_MULTIPLATFORM group which is always the problematic one in
> practice. We need a way to limit platform selection within that set to
> only one platform among them all if XIP_KERNEL is set. And that is
> impossible to express with the kconfig language today.
>
> So, my assertion is that, unless someone volunteers a solution to the
> kconfig language to express mutual exclusion between symbols, this issue
> just can't be fixed properly.

Even that would not be sufficient, as these days the final target platform
selection is not by a Kconfig symbol, but by a DT[SB] file.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
