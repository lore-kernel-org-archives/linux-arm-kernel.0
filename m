From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 22 Jul 2011 14:43:47 +0200
Subject: [PATCH 3.0] fix compile warnings in plat-iop/cp6.c
Message-ID: <20009.28803.497535.598471@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building 3.0 for an n2100 (plat-iop) results in:

In file included from arch/arm/plat-iop/cp6.c:20:
/tmp/linux-3.0/arch/arm/include/asm/traps.h:12: warning: 'struct pt_regs' declared inside parameter list
/tmp/linux-3.0/arch/arm/include/asm/traps.h:12: warning: its scope is only this definition or declaration, which is probably not what you want
/tmp/linux-3.0/arch/arm/include/asm/traps.h:48: warning: 'struct pt_regs' declared inside parameter list
/tmp/linux-3.0/arch/arm/include/asm/traps.h:48: warning: 'struct task_struct' declared inside parameter list
arch/arm/plat-iop/cp6.c:45: warning: initialization from incompatible pointer type

The pt_regs and incompatible pointer type warnings are fixed by including
<asm/ptrace.h> before <asm/traps.h>.  Nothing here depends on task_struct,
so that warning can be fixed by a forward struct declaration.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
--- linux-3.0/arch/arm/plat-iop/cp6.c.~1~	2011-07-22 12:01:07.000000000 +0200
+++ linux-3.0/arch/arm/plat-iop/cp6.c	2011-07-22 14:26:51.000000000 +0200
@@ -17,8 +17,9 @@
  *
  */
 #include <linux/init.h>
-#include <asm/traps.h>
 #include <asm/ptrace.h>
+struct task_struct;
+#include <asm/traps.h>
 
 static int cp6_trap(struct pt_regs *regs, unsigned int instr)
 {
