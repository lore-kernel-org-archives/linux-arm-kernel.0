From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2011 18:36:54 +0000
Subject: [PATCH v7 1/5] ARM: lib: add call_with_stack function for safely
 changing stack
In-Reply-To: <1322505418-24854-1-git-send-email-will.deacon@arm.com>
References: <1322505418-24854-1-git-send-email-will.deacon@arm.com>
Message-ID: <1322505418-24854-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When disabling the MMU, it is necessary to take out a 1:1 identity map
of the reset code so that it can safely be executed with and without
the MMU active. To avoid the situation where the physical address of the
reset code aliases with the virtual address of the active stack (which
cannot be included in the 1:1 mapping), it is desirable to change to a
new stack at a location which is less likely to alias.

This code adds a new lib function, call_with_stack:

	void call_with_stack(void (*fn)(void *), void *arg, void *sp);

which changes the stack to point at the sp parameter, before invoking
fn(arg) with the new stack selected.

Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/lib/Makefile          |    3 +-
 arch/arm/lib/call_with_stack.S |   44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/lib/call_with_stack.S

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index cf73a7f..0ade0ac 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -13,7 +13,8 @@ lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
 		   testchangebit.o testclearbit.o testsetbit.o        \
 		   ashldi3.o ashrdi3.o lshrdi3.o muldi3.o             \
 		   ucmpdi2.o lib1funcs.o div64.o                      \
-		   io-readsb.o io-writesb.o io-readsl.o io-writesl.o
+		   io-readsb.o io-writesb.o io-readsl.o io-writesl.o  \
+		   call_with_stack.o
 
 mmu-y	:= clear_user.o copy_page.o getuser.o putuser.o
 
diff --git a/arch/arm/lib/call_with_stack.S b/arch/arm/lib/call_with_stack.S
new file mode 100644
index 0000000..916c80f
--- /dev/null
+++ b/arch/arm/lib/call_with_stack.S
@@ -0,0 +1,44 @@
+/*
+ * arch/arm/lib/call_with_stack.S
+ *
+ * Copyright (C) 2011 ARM Ltd.
+ * Written by Will Deacon <will.deacon@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * void call_with_stack(void (*fn)(void *), void *arg, void *sp)
+ *
+ * Change the stack to that pointed at by sp, then invoke fn(arg) with
+ * the new stack.
+ */
+ENTRY(call_with_stack)
+	str	sp, [r2, #-4]!
+	str	lr, [r2, #-4]!
+
+	mov	sp, r2
+	mov	r2, r0
+	mov	r0, r1
+
+	adr	lr, BSYM(1f)
+	mov	pc, r2
+
+1:	ldr	lr, [sp]
+	ldr	sp, [sp, #4]
+	mov	pc, lr
+ENDPROC(call_with_stack)
-- 
1.7.4.1
