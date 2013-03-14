From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 23:01:35 +0100
Subject: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
Message-ID: <7534695.eTHcH0enMV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-4.7 and higher add a lot of false positive warnings about
potential uses of uninitialized warnings, but only when optimizing
for size (-Os). This is the default when building allyesconfig,
which turns on CONFIG_CC_OPTIMIZE_FOR_SIZE.

In order to avoid getting a lot of patches that initialize such
variables and accidentally hide real errors along the way, let's
just turn off this warning on the respective gcc versions
when building with size optimizations. The -Wmaybe-uninitialized
option was introduced in the same gcc version (4.7) that is now
causing the false positives, so there is no effect on older compilers.

A side effect is that when building with CONFIG_CC_OPTIMIZE_FOR_SIZE,
we might now see /fewer/ warnings about possibly uninitialized
warnings than with -O2, but that is still much better than seeing
warnings known to be bogus.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable at vger.kernel.org
--
I'd like to merge this for 3.9 and also for the stable kernels,
if people agree this is a good idea.

diff --git a/Makefile b/Makefile
index 10fb6c7..caea2d1 100644
--- a/Makefile
+++ b/Makefile
@@ -570,7 +570,7 @@ endif # $(dot-config)
 all: vmlinux
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-KBUILD_CFLAGS	+= -Os
+KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
 else
 KBUILD_CFLAGS	+= -O2
 endif
