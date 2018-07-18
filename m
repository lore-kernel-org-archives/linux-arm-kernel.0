From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 18 Jul 2018 10:07:47 +0900
Subject: [PATCH] ARM: vfp: clean up arch/arm/vfp/Makefile
Message-ID: <1531876067-4957-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 799c43415442 ("kbuild: thin archives make default for
all archs"), $(AR) is used instead of $(LD) to combine object files.

The following code in arch/arm/vfp/Makefile:

  LDFLAGS         +=--no-warn-mismatch

... is no longer used.

Also, arch/arm/Makefile already guards arch/arm/vfp/ by a boolean
symbol, CONFIG_VFP, like this:

  core-$(CONFIG_VFP)              += arch/arm/vfp/

So, $(CONFIG_VFP) is always evaluated to y in arch/arm/vfp/Makefile.
There is no point to use pseudo object, vfp.o, which never becomes
a module.  Add all objects to obj-y directly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: v4.18-rc5


 arch/arm/vfp/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
index a81404c..94516c4 100644
--- a/arch/arm/vfp/Makefile
+++ b/arch/arm/vfp/Makefile
@@ -8,8 +8,5 @@
 # asflags-y := -DDEBUG
 
 KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp -mfloat-abi=soft)
-LDFLAGS		+=--no-warn-mismatch
 
-obj-y			+= vfp.o
-
-vfp-$(CONFIG_VFP)	+= vfpmodule.o entry.o vfphw.o vfpsingle.o vfpdouble.o
+obj-y		+= vfpmodule.o entry.o vfphw.o vfpsingle.o vfpdouble.o
-- 
2.7.4
