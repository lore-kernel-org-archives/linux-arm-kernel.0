From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Mar 2014 02:53:24 +0100
Subject: [PATCH] ARM: cache-tauros2: remove ARMv6 code
In-Reply-To: <CAN1soZz6-+s4bKbCJFXQResa07Ub9s1qfRrf2nDLC8eFVQEDsg@mail.gmail.com>
References: <1589565.fmu2VlFkhj@wuerfel>
 <CAN1soZz6-+s4bKbCJFXQResa07Ub9s1qfRrf2nDLC8eFVQEDsg@mail.gmail.com>
Message-ID: <201403270253.24594.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 March 2014, Haojian Zhuang wrote:
> On Wed, Mar 12, 2014 at 2:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > When building a kernel with support for both ARMv6 and ARMv7 but
> > no MMU, the call from tauros2_internal_init to adjust_cr causes
> > a link error. While that could probably be resolved, we don't
> > actually support cache-tauros2 on ARMv6 any more. All PJ4 CPU
> > implementations support both ARMv6 and ARMv7 and we already assume
> > that we are using them only in ARMv7 mode.
> >
> > Removing the ARMv6 code path reduces the code size and avoids
> > the linker error.
> > -
> >  #ifdef CONFIG_CPU_32v7
> >         /*
> >          * Check whether this CPU has support for the v7 hierarchical
> >
> 
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

I've merged it into next/soc now, since that branch originally
introduced the bug, which now prevents 'allmodconfig' from building.

I had to another oneline change to the patch, see below. This has
no functional impact, but just avoids a few "unused function" warnings
when building with both v6 and v7 enabled. Previously some of the
functions were shared between v5 and v6 code, but the v6 version
is removed now.

	Arnd

diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 7964ef2..b273739 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -33,7 +33,7 @@
  * outer cache operations into the kernel image if the kernel has been
  * configured to support a pre-v7 CPU.
  */
-#if __LINUX_ARM_ARCH__ < 7
+#ifdef CONFIG_CPU_32v5
 /*
  * Low-level cache maintenance operations.
  */
