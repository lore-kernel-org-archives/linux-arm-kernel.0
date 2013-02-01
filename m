From: kim.phillips@freescale.com (Kim Phillips)
Date: Thu, 31 Jan 2013 18:37:47 -0600
Subject: [PATCH v4] arm: use built-in byte swap function
In-Reply-To: <1359670248.27468.13.camel@shinybook.infradead.org>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
 <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
 <20130131092801.GV23505@n2100.arm.linux.org.uk>
 <20130131145947.f62474a0600848df86548b96@freescale.com>
 <1359670248.27468.13.camel@shinybook.infradead.org>
Message-ID: <20130131183747.d56289dbd89b165cf12a9d28@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 1490bd8823c05e0dda982524bb70cb6c6427ddf9 Mon Sep 17 00:00:00 2001
From: Kim Phillips <kim.phillips@freescale.com>
Date: Mon, 28 Jan 2013 19:30:33 -0600
Subject: [PATCH] arm: use built-in byte swap function

Enable the compiler intrinsic for byte swapping on arch ARM.  This
allows the compiler to detect and be able to optimize out byte
swappings, e.g. in big endian to big endian moves.

A ARCH_DEFINES_BUILTIN_BSWAP is added to allow an ARCH to select
it when it wants to control HAVE_BUILTIN_BSWAPxx definitions over
those in the generic compiler headers.  It can be dependent on a
combination of byte swapping instruction availability, the
instruction set version, and the state of support in different
compiler versions.

AFAICT, arm gcc got __builtin_bswap{32,64} support in 4.6,
and for the 16-bit version in 4.8.

This has a tiny benefit on vmlinux text size (gcc 4.6.4):

multi_v7_defconfig:
   text    data     bss     dec     hex filename
3135208  188396  203344 3526948  35d124 vmlinux
multi_v7_defconfig with builtin_bswap:
   text    data     bss     dec     hex filename
3135112  188396  203344 3526852  35d0c4 vmlinux

exynos_defconfig:
   text    data     bss     dec     hex filename
4286605  360564  223172 4870341  4a50c5 vmlinux
exynos_defconfig with builtin_bswap:
   text    data     bss     dec     hex filename
4286405  360564  223172 4870141  4a4ffd vmlinux

The savings come mostly from device-tree related code, and some
from drivers.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
akin to: http://comments.gmane.org/gmane.linux.kernel.cross-arch/16016

based on linux-next-20130128.  Depends on commit "compiler-gcc{3,4}.h:
Use GCC_VERSION macro" by Daniel Santos <daniel.santos@pobox.com>,
currently in the akpm branch.

v4:
- undo v2-3's addition of ARCH_DEFINES_BUILTIN_BSWAP per Boris
  and David - patch is much less intrusive :)

v3:
- moved out of uapi swab.h into arch/arm/include/asm/swab.h
- moved ARCH_DEFINES_BUILTIN_BSWAP help text into commit message
- moved GCC_VERSION >= 40800 ifdef into GCC_VERSION >= 40600 block

v2:
- at91 and lpd270 builds fixed by limiting to ARMv6 and above
  (i.e., ARM cores that have support for the 'rev' instruction).
  Otherwise, the compiler emits calls to libgcc's __bswapsi2 on
  these ARMv4/v5 builds (and arch ARM doesn't link with libgcc).
  All ARM defconfigs now have the same build status as they did
  without this patch (some are broken on linux-next).

- move ARM check from generic compiler.h to arch ARM's swab.h.
  - pretty sure it should be limited to __KERNEL__ builds

- add new ARCH_DEFINES_BUILTIN_BSWAP (see Kconfig help).
  - if set, generic compiler header does not set HAVE_BUILTIN_BSWAPxx
  - not too sure about this having to be a new CONFIG_, but it's hard
    to find a place for it given linux/compiler.h doesn't include any
    arch-specific files.

- move new selects to end of CONFIG_ARM's Kconfig select list,
  as is done in David Woodhouse's original patchseries for ppc/x86.

 arch/arm/include/asm/swab.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/swab.h b/arch/arm/include/asm/swab.h
index 537fc9b..e56acff 100644
--- a/arch/arm/include/asm/swab.h
+++ b/arch/arm/include/asm/swab.h
@@ -34,5 +34,13 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 }
 #define __arch_swab32 __arch_swab32
 
+#if GCC_VERSION >= 40600
+#define __HAVE_BUILTIN_BSWAP32__
+#define __HAVE_BUILTIN_BSWAP64__
+#if GCC_VERSION >= 40800
+#define __HAVE_BUILTIN_BSWAP16__
+#endif
+#endif
+
 #endif
 #endif
-- 
1.7.9.7
