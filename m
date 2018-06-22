From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2018 12:01:45 +0100
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
Message-ID: <20180622110145.GU17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 12:24:04PM -0400, Nicolas Pitre wrote:
> [ adding linux-kbuild for their input ]
> 
> On Thu, 21 Jun 2018, Geert Uytterhoeven wrote:
> 
> > I'm afraid adding (duplicating) machine entries for nommu support is not a
> > sustainable solutions. Any machine can run a nommu kernel, in theory.
> > 
> > I'm aware of the objection "but you cannot build a nommu kernel that can
> > boot on multiple systems".  That's true (unless RAM/FLASH addresses are the
> > same). So don't do that.
> > 
> > All of the above is true for XIP, too, hence applies with s/nommu/XIP/.
> > One more reason not to have this duplication.
> > 
> > The current "ARM multiplatform" has actually two meanings:
> >   1. It groups platforms that follow the "ARM multiplatform" framework,
> >   2. It allows to build a single kernel that can be booted on multiple
> >      platforms.
> > To avoid the duplication, I think 2 should be relaxed when specialized
> > options like XIP or NOMMU are selected.
> > 
> > I've just sent a patch to do that.
> 
> Your patch isn't wrong per se.  But it is not enough. The issue here 
> would be easily fixed with some kconfig extension so that:
> 
> - If XIP or NOMMU is selected then only one target in the multiplatform 
>   set can be selected, basically turning it into a choice menu.

I don't think that's how it should work.  Consider the V7M case, where
we have better standardisation of the physical address layout than
previous ARM devices.  We have three platforms which are V7M compliant:

- AT91
- iMX
- STM32

These have separate symbols:

menuconfig ARCH_AT91
	bool "AT91/Microchip SoCs"
	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M

menuconfig ARCH_MXC
	bool "Freescale i.MX family"
	depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 || ARM_SINGLE_ARMV7M

menuconfig ARCH_STM32
	bool "STMicroelectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7

With your suggestion, you would become only build a kernel for one of
these, but that is not the case today: it's possible to build a single
kernel which supports all these platforms.

So, I don't think we want your suggestion.

What we have today is flexible enough that we can have the best of
multiplatform vs the restrictions caused by the variance in hardware.
IOW, what we have is a compromise, which I believe is a reasonable,
functional, and good compromise that fits the real world physical
conditions with the least amount of overhead.

Every other suggestion I've seen posted has drawbacks, from artificially
restricting what can be selected (eg, as in your case) to allowing more
platforms to be selected thereby creating non-bootable kernels (eg, as
in Geert's case.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
