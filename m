From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Sep 2018 10:41:50 -0500
Subject: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
Message-ID: <20180928154150.GA25013@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2018 at 06:31:14AM -0400, Masahiro Yamada wrote:
> 2018-09-13 11:51 GMT-04:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> > Hi Yamada-san,
> >
> > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> 2018-09-12 0:40 GMT+09:00 Rob Herring <robh@kernel.org>:
> >> > On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
> >> >> There is nothing arch specific about building dtb files other than their
> >> >> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> >> >> The dependencies and supported targets are all slightly different.
> >> >> Also, a cross-compiler for each arch is needed, but really the host
> >> >> compiler preprocessor is perfectly fine for building dtbs. Move the
> >> >> build rules to a common location and remove the arch specific ones. This
> >> >> is done in a single step to avoid warnings about overriding rules.
> >> >>
> >> >> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> >> >> These pull in several dependencies some of which need a target compiler
> >> >> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> >> >> All that is really needed is dtc, so adjust the dependencies to only be
> >> >> dtc.
> >> >>
> >> >> This change enables support 'dtbs_install' on some arches which were
> >> >> missing the target.
> >> >
> >> > [...]
> >> >
> >> >> @@ -1215,6 +1215,33 @@ kselftest-merge:
> >> >>                 $(srctree)/tools/testing/selftests/*/config
> >> >>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >> >>
> >> >> +# ---------------------------------------------------------------------------
> >> >> +# Devicetree files
> >> >> +
> >> >> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> >> >> +dtstree := arch/$(SRCARCH)/boot/dts
> >> >> +endif
> >> >> +
> >> >> +ifdef CONFIG_OF_EARLY_FLATTREE
> >> >
> >> > This can be true when dtstree is unset. So this line should be this
> >> > instead to fix the 0-day reported error:
> >> >
> >> > ifneq ($(dtstree),)
> >> >
> >> >> +
> >> >> +%.dtb : scripts_dtc
> >> >> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> >> >> +
> >> >> +PHONY += dtbs dtbs_install
> >> >> +dtbs: scripts_dtc
> >> >> +       $(Q)$(MAKE) $(build)=$(dtstree)
> >> >> +
> >> >> +dtbs_install: dtbs
> >> >> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> >> >> +
> >> >> +all: dtbs
> >> >> +
> >> >> +endif
> >>
> >>
> >> Ah, right.
> >> Even x86 can enable OF and OF_UNITTEST.
> >>
> >>
> >>
> >> Another solution might be,
> >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> >>
> >>
> >>
> >> This is actually what ACPI does.
> >>
> >> menuconfig ACPI
> >>         bool "ACPI (Advanced Configuration and Power Interface) Support"
> >>         depends on ARCH_SUPPORTS_ACPI
> >>          ...
> >
> > ACPI is a real platform feature, as it depends on firmware.
> >
> > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> > even if it has ACPI ;-)
> >
> 
> OK, understood.

Any other comments on this? I'd like to get the series into linux-next 
soon.

There was one other problem 0-day reported when building with 
CONFIG_OF=n while setting CONFIG_OF_ALL_DTBS=y on the kernel command 
line. The problem is dtc is not built as setting options on the command 
line doesn't invoke kconfig select(s). This can be fixed by also 
adding CONFIG_DTC=y to the command line, always building dtc regardless 
of Kconfig, or making 'all' conditionally dependent on 'dtbs'. I've gone 
with the last option as that is how this problem was avoided before. 

So the hunk in question with the 2 fixes now looks like this:

@@ -1215,6 +1215,35 @@ kselftest-merge:
                $(srctree)/tools/testing/selftests/*/config
        +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
+# 
---------------------------------------------------------------------------
+# Devicetree files
+
+ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
+dtstree := arch/$(SRCARCH)/boot/dts
+endif
+
+ifneq ($(dtstree),)
+
+%.dtb : scripts_dtc
+       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
+
+PHONY += dtbs dtbs_install
+dtbs: scripts_dtc
+       $(Q)$(MAKE) $(build)=$(dtstree)
+
+dtbs_install: dtbs
+       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
+
+ifdef CONFIG_OF_EARLY_FLATTREE
+all: dtbs
+endif
+
+endif
+
+PHONY += scripts_dtc
+scripts_dtc: scripts_basic
+       $(Q)$(MAKE) $(build)=scripts/dtc
+
 # 
---------------------------------------------------------------------------
 # Modules
 
