From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Jan 2016 13:04:47 +0100
Subject: [PATCH] ARM: realview: fix device tree build
Message-ID: <1453377887-23878-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it happens, two obj-$(CONFIG_FOO) += foo.o variables are
above obj-y := core.o, which doesn't work: the += directives
need to add something to the build and doesn't work if obj-y
is not set first, so move the obj-y to be on top and everything
builds nicely again.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC guys, please apply this directly for fixes.
---
 arch/arm/mach-realview/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index 8be6632407d8..dae8d86ef4cc 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -4,10 +4,9 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-versatile/include
 
-
+obj-y					:= core.o
 obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
 obj-$(CONFIG_SMP)			+= platsmp-dt.o
-obj-y					:= core.o
 
 ifdef CONFIG_ATAGS
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
-- 
2.4.3
