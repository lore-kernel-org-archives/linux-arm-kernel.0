From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 26 Aug 2018 11:05:43 +0900
Subject: [PATCH 6/8] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <20180821215524.23040-7-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
 <20180821215524.23040-7-robh@kernel.org>
Message-ID: <CAK7LNATcYSvwh0BEEdyUuDa_Y9X-AqQAzA5MrbNhOSMmSzqhTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2018-08-22 6:55 GMT+09:00 Rob Herring <robh@kernel.org>:
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
>
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
>
> This change enables support 'dtbs_install' on some arches which were
> missing the target.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-kbuild at vger.kernel.org
> Cc: linux-snps-arc at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: uclinux-h8-devel at lists.sourceforge.jp
> Cc: linux-mips at linux-mips.org
> Cc: nios2-dev at lists.rocketboards.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-xtensa at linux-xtensa.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Makefile                 | 30 ++++++++++++++++++++++++++++++
>  arch/arc/Makefile        |  6 ------
>  arch/arm/Makefile        | 20 +-------------------
>  arch/arm64/Makefile      | 17 +----------------
>  arch/c6x/Makefile        |  2 --
>  arch/h8300/Makefile      | 11 +----------
>  arch/microblaze/Makefile |  4 +---
>  arch/mips/Makefile       | 15 +--------------
>  arch/nds32/Makefile      |  2 +-
>  arch/nios2/Makefile      |  7 -------
>  arch/nios2/boot/Makefile |  4 ----
>  arch/powerpc/Makefile    |  3 ---
>  arch/xtensa/Makefile     | 12 +-----------
>  scripts/Makefile         |  1 -
>  scripts/Makefile.lib     |  2 +-
>  15 files changed, 38 insertions(+), 98 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c13f8b85ba60..6d89e673f192 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1212,6 +1212,30 @@ kselftest-merge:
>                 $(srctree)/tools/testing/selftests/*/config
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
> +# ---------------------------------------------------------------------------
> +# Devicetree files
> +
> +dtstree := $(wildcard arch/$(SRCARCH)/boot/dts)
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE
> +
> +%.dtb %.dtb.S %.dtb.o: | dtc

I think the pipe operator is unnecessary
because Kbuild will descend to $(dtstree) anyway.


> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +
> +PHONY += dtbs
> +dtbs: | dtc

Ditto.


> +       $(Q)$(MAKE) $(build)=$(dtstree)
> +
> +dtbs_install: dtbs
> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> +
> +all: dtbs
> +
> +dtc:
> +       $(Q)$(MAKE) $(build)=scripts/dtc
> +
> +endif
> +


arch/*/boot/dts/ are not only directories that
require dtc.


$ find  drivers/  -name '*.dts'
drivers/staging/mt7621-dts/gbpc1.dts
drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dts
drivers/of/unittest-data/overlay_12.dts
drivers/of/unittest-data/overlay.dts
drivers/of/unittest-data/overlay_5.dts
drivers/of/unittest-data/overlay_bad_symbol.dts
drivers/of/unittest-data/overlay_1.dts
drivers/of/unittest-data/overlay_bad_phandle.dts
drivers/of/unittest-data/overlay_2.dts
drivers/of/unittest-data/overlay_15.dts
drivers/of/unittest-data/overlay_10.dts
drivers/of/unittest-data/testcases.dts
drivers/of/unittest-data/overlay_6.dts
drivers/of/unittest-data/overlay_13.dts
drivers/of/unittest-data/overlay_4.dts
drivers/of/unittest-data/overlay_9.dts
drivers/of/unittest-data/overlay_3.dts
drivers/of/unittest-data/overlay_8.dts
drivers/of/unittest-data/overlay_7.dts
drivers/of/unittest-data/overlay_11.dts
drivers/of/unittest-data/overlay_0.dts
drivers/of/unittest-data/overlay_base.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dts
drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dts





dtc must be built before descending into any directory.





$ git clean -f -x
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  defconfig
drivers/gpu/drm/rcar-du/
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'multi_v7_defconfig'
#
# configuration written to .config
#
scripts/kconfig/conf  --syncconfig Kconfig
  CC      kernel/bounds.s
  CC      arch/arm/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
<stdin>:1332:2: warning: #warning syscall io_pgetevents not implemented [-Wcpp]
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/sortextable
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
  CC      drivers/gpu/drm/rcar-du/rcar_lvds.o
  AR      drivers/gpu/drm/rcar-du/built-in.a
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_crtc.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_drv.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_encoder.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_group.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_kms.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_plane.o
  CC [M]  drivers/gpu/drm/rcar-du/rcar_du_of.o
make[2]: *** No rule to make target
'drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb', needed by
'drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S'.  Stop.
Makefile:1721: recipe for target 'drivers/gpu/drm/rcar-du/' failed
make[1]: *** [drivers/gpu/drm/rcar-du/] Error 2
Makefile:286: recipe for target '__build_one_by_one' failed
make: *** [__build_one_by_one] Error 2








> diff --git a/scripts/Makefile b/scripts/Makefile
> index 61affa300d25..a716a6b10954 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -39,7 +39,6 @@ build_unifdef: $(obj)/unifdef
>  subdir-$(CONFIG_MODVERSIONS) += genksyms
>  subdir-y                     += mod
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
> -subdir-$(CONFIG_DTC)         += dtc
>  subdir-$(CONFIG_GDB_SCRIPTS) += gdb
>
>  # Let clean descend into subdirs


You need to 'dtc' here to clean-up scripts/dtc by "make mrproper".

subdir- += basic kconfig package gcc-plugins dtc







-- 
Best Regards
Masahiro Yamada
