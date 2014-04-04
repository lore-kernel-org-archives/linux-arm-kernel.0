From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Apr 2014 17:43:41 +0200
Subject: [PATCH v1 6/8] ARM: hisi: add hip04 SoC support
In-Reply-To: <7hd2gxywf3.fsf@paris.lan>
References: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
 <1396339430-21084-7-git-send-email-haojian.zhuang@linaro.org>
 <7hd2gxywf3.fsf@paris.lan>
Message-ID: <8340307.jkTP7h04Ur@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 April 2014 07:57:36 Kevin Hilman wrote:
> Haojian Zhuang <haojian.zhuang@linaro.org> writes:
> 
> > Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
> > Cortex A15 Core. And HiP04 supports LPAE to support large memory.
> >
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> 
> [...]
> 
> > diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
> > index da16efd..707abfe 100644
> > --- a/arch/arm/mach-hisi/Kconfig
> > +++ b/arch/arm/mach-hisi/Kconfig
> > @@ -19,6 +19,16 @@ config ARCH_HI3xxx
> >       help
> >         Support for Hisilicon Hi36xx/Hi37xx processor family
> >  
> > +config ARCH_HIP04
> > +     bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
> > +     select ARM_LPAE
> 
> Presumably this SoC can support non-LPAE also, correct?  If so, LPAE
> should't be selected here, or else it will force LPAE on in a multi_v7
> build also.

Actually even if it doesn't support non-LPAE, using "select" is still
wrong for the same reason.

I think we should actually extend the CPU selection phase for multiplatform,
so we have separate symbols for ARCH_MULTI_V7 (non-LPAE) and
ARCH_MULTI_V7_LPAE. These would still be selectable at the same time,
but you should only be able to turn on CONFIG_LPAE if ARCH_MULTI_V7
is disabled.

A platform that cannot run without LPAE conversely would have to depend
on (ARCH_MULTI_V7_LPAE && !ARCH_MULTI_V7 && !ARCH_MULTI_V6). Once it
does this, it can 'select LPAE' without breaking other platforms.

	Arnd
