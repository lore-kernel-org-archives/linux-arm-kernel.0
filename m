From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2016 23:04:04 +0200
Subject: [PATCH] ARM: Kirkwood: fix kirkwood_pm_init() declaration/type
In-Reply-To: <1465473432-24323-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465473432-24323-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <9408643.5tV7esCl2a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 9, 2016 12:57:12 PM CEST Ben Dooks wrote:
> The kirkwood-pm.c was missing the include of kirkwood-pm.h to
> define the kirkwood_pm_init() function. However once this is
> included, the types do not match.
> 
> Fixup the include, and then the prototype to avoid the following
> warning:
> 
> arch/arm/mach-mvebu/kirkwood-pm.c:69:12: warning: symbol 'kirkwood_pm_init' was not declared. Should it be static?
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

You found another bug, when building with CONFIG_PM:

../arch/arm/mach-mvebu/kirkwood-pm.c:70:13: error: redefinition of 'kirkwood_pm_init'
 void __init kirkwood_pm_init(void)
             ^~~~~~~~~~~~~~~~
In file included from ../arch/arm/mach-mvebu/kirkwood-pm.c:21:0:
../arch/arm/mach-mvebu/kirkwood-pm.h:23:20: note: previous definition of 'kirkwood_pm_init' was here
 static inline void kirkwood_pm_init(void) {};

I guess we have to make the kirkwood-pm.c file conditional on CONFIG_PM too,
but I'm unsure whether we should do the same for pm.c and pm-board.c.

Would the patch below seem reasonable, or do we actually want to call
mvebu_armada_pm_init() when CONFIG_PM is disabled? Does the machine even
boot without CONFIG_PM?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 568863e1513c..6c6497e80a7b 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -6,9 +6,15 @@ CFLAGS_pmsu.o			:= -march=armv7-a
 obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
-obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o pm.o pm-board.o
+obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o
+
+obj-$(CONFIG_PM)		 += pm.o pm-board.o
 obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
 endif
 
 obj-$(CONFIG_MACH_DOVE)		 += dove.o
-obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
+
+ifeq ($(CONFIG_MACH_KIRKWOOD),y)
+obj-y				 += kirkwood.o
+obj-$(CONFIG_PM)		 += kirkwood-pm.o
+endif
