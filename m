From: kw@fieahl.im (Fieah Lim)
Date: Thu, 13 Sep 2018 18:38:32 +0800
Subject: [PATCH] ARM: Don't disable SRA optimization on recent GCC
Message-ID: <20180913103832.23463-1-kw@fieahl.im>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The issue addressed by
commit a077224fd35b ("ARM: 8429/1: disable GCC SRA optimization")
has been fixed in GCC version 5.4 and later:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932#c33
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=7fa02f018da21445e1b93eb89cd29ecbbb98617f

Since ARM/Linaro is releasing latest GNU Toolchain for ARM
(up to version 8.2.1 till this date), we should only disable this
when compiling with GCC version <= 5.3

This patch add a GCC version check before passing -fno-ipa-sra
and remove two unnecessary # in the comment block.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
 arch/arm/Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fc26c3d7b9b6..1fdd8eab21cd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -54,13 +54,11 @@ AS		+= -EL
 LD		+= -EL
 endif
 
-#
-# The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
-# later may result in code being generated that handles signed short and signed
-# char struct members incorrectly. So disable it.
+# The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 5.3 and
+# earlier may result in code being generated that handles signed short and
+# signed char struct members incorrectly. So disable it.
 # (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932)
-#
-KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
+KBUILD_CFLAGS	+= $(call cc-ifversion, -le, 0503, $(call cc-option,-fno-ipa-sra))
 
 # This selects which instruction set is used.
 # Note that GCC does not numerically define an architecture version
-- 
2.19.0
