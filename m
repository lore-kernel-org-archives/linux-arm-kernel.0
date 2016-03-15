From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Mar 2016 23:00:05 +0100
Subject: [OpenWrt-Devel] ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <CAKv+Gu-jHrnpkhE-TzA9FXd_tfm0kLKihXH9SpUcexsqEtmsWQ@mail.gmail.com>
References: <201603101013.04618.arnd@arndb.de> <16727306.4g6uRjH7LT@wuerfel>
 <CAKv+Gu-jHrnpkhE-TzA9FXd_tfm0kLKihXH9SpUcexsqEtmsWQ@mail.gmail.com>
Message-ID: <6978344.h5qhGc4ZP2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 March 2016 21:26:08 Ard Biesheuvel wrote:
> On 15 March 2016 at 16:59, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 11 March 2016 17:56:12 Hans Ulli Kroll wrote:
> >> On Fri, 11 Mar 2016, Roman Yeryomin wrote:
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 9fb3fee0e908..3c312d37a83a 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -19,6 +19,11 @@ LDFLAGS_vmlinux      += --be8
> >  LDFLAGS_MODULE += --be8
> >  endif
> >
> > +ifeq ($(CONFIG_CPU_32v4),y)
> > +LDFLAGS_vmlinux        += $(call ld-option,--fix-v4bx)
> > +LDFLAGS_MODULE += $(call ld-option,--fix-v4bx)
> 
> Does this have any effect on partial linking? I would expect the
> module loader to handle the R_ARM_V4BX relocation in this case

I have checked that the recursive linking stages don't need it for
the built-in files, only the final link step for vmlinux does.

For loadable modules, the loader indeed applies the same fix,
and apparently also does this on ARMv4T and ARMv5 machines even
when it's not needed there. I think for consistency it makes
sense to set the flag for both vmlinux and modules (as we
do for --be8).

	Arnd
