From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 22 Jul 2011 16:28:01 +0200
Subject: [PATCH 3.0] fix compile warnings in plat-iop/cp6.c
In-Reply-To: <20110722132721.GA25947@n2100.arm.linux.org.uk>
References: <20009.28803.497535.598471@pilspetsen.it.uu.se>
	<20110722132721.GA25947@n2100.arm.linux.org.uk>
Message-ID: <20009.35057.432746.47293@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Fri, Jul 22, 2011 at 02:43:47PM +0200, Mikael Pettersson wrote:
 > > Building 3.0 for an n2100 (plat-iop) results in:
 > > 
 > > In file included from arch/arm/plat-iop/cp6.c:20:
 > > /tmp/linux-3.0/arch/arm/include/asm/traps.h:12: warning: 'struct pt_regs' declared inside parameter list
 > > /tmp/linux-3.0/arch/arm/include/asm/traps.h:12: warning: its scope is only this definition or declaration, which is probably not what you want
 > > /tmp/linux-3.0/arch/arm/include/asm/traps.h:48: warning: 'struct pt_regs' declared inside parameter list
 > > /tmp/linux-3.0/arch/arm/include/asm/traps.h:48: warning: 'struct task_struct' declared inside parameter list
 > > arch/arm/plat-iop/cp6.c:45: warning: initialization from incompatible pointer type
 > > 
 > > The pt_regs and incompatible pointer type warnings are fixed by including
 > > <asm/ptrace.h> before <asm/traps.h>.  Nothing here depends on task_struct,
 > > so that warning can be fixed by a forward struct declaration.
 > 
 > Why not add a forward declaration of struct pt_regs and task_struct
 > to asm/traps.h ?

Sure, that works too.  Revised patch below.  Only tested on n2100 so far.

Building kernel 3.0 for an n2100 (plat-iop) results in:

In file included from arch/arm/plat-iop/cp6.c:20:
/tmp/linux-3.0/arch/arm/include/asm/traps.h:12: warning: 'struct pt_regs' declared inside parameter list
/tmp/linux-3.0/arch/arm/include/asm/traps.h:12: warning: its scope is only this definition or declaration, which is probably not what you want
/tmp/linux-3.0/arch/arm/include/asm/traps.h:48: warning: 'struct pt_regs' declared inside parameter list
/tmp/linux-3.0/arch/arm/include/asm/traps.h:48: warning: 'struct task_struct' declared inside parameter list
arch/arm/plat-iop/cp6.c:45: warning: initialization from incompatible pointer type

Nothing here depends on the layout of pt_regs or task_struct, so this
can be fixed by adding forward struct declarations to asm/traps.h.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
--- linux-3.0/arch/arm/include/asm/traps.h.~1~	2011-05-19 06:06:34.000000000 +0200
+++ linux-3.0/arch/arm/include/asm/traps.h	2011-07-22 16:14:50.000000000 +0200
@@ -3,6 +3,9 @@
 
 #include <linux/list.h>
 
+struct pt_regs;
+struct task_struct;
+
 struct undef_hook {
 	struct list_head node;
 	u32 instr_mask;
