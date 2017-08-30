From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Aug 2017 12:22:49 +0300
Subject: [RFC PATCH] arm64: move  THREAD_* definitions to separated header
Message-ID: <20170830092249.20638-1-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, all.

In patch 'dbc9344a68e506f19f8 ("arm64: clean up THREAD_* definitions")'
you move THREAD_* definitions from arch/arm64/include/asm/thread_info.h
to asm/memory.h. After that asm/thread_info.h starts to depend on
asm/memory.h.

When I try to apply ilp32 series on top of it [1], it causes circular
dependencies like this one:

In file included from ./arch/arm64/include/asm/memory.h:30:0,
                 from ./arch/arm64/include/asm/thread_info.h:30,
                 from ./include/linux/thread_bits.h:20,
                 from ./include/linux/thread_info.h:13,
                 from ./include/asm-generic/preempt.h:4,
                 from ./arch/arm64/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:80,
                 from ./include/linux/rcupdate.h:40,
                 from ./include/linux/rculist.h:10,
                 from ./include/linux/pid.h:4,
                 from ./include/linux/sched.h:13,
                 from arch/arm64/kernel/asm-offsets.c:21:
./arch/arm64/include/asm/is_compat.h: In function ?is_a32_compat_task?:
./arch/arm64/include/asm/is_compat.h:25:9: error: implicit declaration of function ?test_thread_flag? [-Werror=implicit-function-declaration]
  return test_thread_flag(TIF_32BIT);
         ^~~~~~~~~~~~~~~~

The problem is that asm/memory.h depends on asm/is_compat.h to define
TASK_SIZE, which in turn requires asm/thread_info.h.

The most obvious solution for it is to create is_compat.c file and make
is_*_compat() real functions. The other option is to move THREAD_*
definitions to separated macro. I would prefer 2nd one because of following
reasons:
 - TASK_SIZE macro is used many times in kernel, including hot paths;
 - asm/memory.h is included widely, as well as asm/thread_info.h, and it's
   better not to make them depend one from another;
 - THREAD_SIZE etc are not memory-related definitions.
 
In this patch THREAD_* definitions moved to separated asm/thread_size.h
header. It's enough to resolve dependency above.

If you find this approach useful, I can prepare other patch that moves
TASK_* definitions from asm/memory.h to new header to remove the dependency
from asm/is_compat.h.

Also, arch/arm64/kernel/entry.S and arch/arm64/kernel/hibernate-asm.S
#includes list is cleaned.

[1] https://github.com/norov/linux/tree/ilp32-next (still in progress)

CC: Will Deacon <will.deacon@arm.com>
CC: Laura Abbott <labbott@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/memory.h      | 30 +-------------------
 arch/arm64/include/asm/thread_info.h |  2 +-
 arch/arm64/include/asm/thread_size.h | 53 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry.S            |  2 +-
 arch/arm64/kernel/hibernate-asm.S    |  1 -
 5 files changed, 56 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/include/asm/thread_size.h

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0c3ee6afda5b..bc7ec1930659 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -21,6 +21,7 @@
 #ifndef __ASM_MEMORY_H
 #define __ASM_MEMORY_H
 
+#include <asm/thread_size.h>
 #include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/types.h>
@@ -105,35 +106,6 @@
 #define KASAN_SHADOW_SIZE	(0)
 #endif
 
-#define MIN_THREAD_SHIFT	14
-
-/*
- * VMAP'd stacks are allocated at page granularity, so we must ensure that such
- * stacks are a multiple of page size.
- */
-#if defined(CONFIG_VMAP_STACK) && (MIN_THREAD_SHIFT < PAGE_SHIFT)
-#define THREAD_SHIFT		PAGE_SHIFT
-#else
-#define THREAD_SHIFT		MIN_THREAD_SHIFT
-#endif
-
-#if THREAD_SHIFT >= PAGE_SHIFT
-#define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
-#endif
-
-#define THREAD_SIZE		(UL(1) << THREAD_SHIFT)
-
-/*
- * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
- * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
- * assembly.
- */
-#ifdef CONFIG_VMAP_STACK
-#define THREAD_ALIGN		(2 * THREAD_SIZE)
-#else
-#define THREAD_ALIGN		THREAD_SIZE
-#endif
-
 #define IRQ_STACK_SIZE		THREAD_SIZE
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 5d889c645321..6267ba7bd0e4 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -27,7 +27,7 @@
 
 struct task_struct;
 
-#include <asm/memory.h>
+#include <asm/thread_size.h>
 #include <asm/stack_pointer.h>
 #include <asm/types.h>
 
diff --git a/arch/arm64/include/asm/thread_size.h b/arch/arm64/include/asm/thread_size.h
new file mode 100644
index 000000000000..dd0b8906f9de
--- /dev/null
+++ b/arch/arm64/include/asm/thread_size.h
@@ -0,0 +1,53 @@
+/*
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_THREAD_SIZE_H
+#define __ASM_THREAD_SIZE_H
+
+#ifdef __KERNEL__
+
+#include <asm/page-def.h>
+#include <linux/const.h>
+
+#define MIN_THREAD_SHIFT	14
+
+/*
+ * VMAP'd stacks are allocated at page granularity, so we must ensure that such
+ * stacks are a multiple of page size.
+ */
+#if defined(CONFIG_VMAP_STACK) && (MIN_THREAD_SHIFT < PAGE_SHIFT)
+#define THREAD_SHIFT		PAGE_SHIFT
+#else
+#define THREAD_SHIFT		MIN_THREAD_SHIFT
+#endif
+
+#if THREAD_SHIFT >= PAGE_SHIFT
+#define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
+#endif
+
+#define THREAD_SIZE		(_AC(1, UL) << THREAD_SHIFT)
+
+/*
+ * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
+ * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
+ * assembly.
+ */
+#ifdef CONFIG_VMAP_STACK
+#define THREAD_ALIGN		(2 * THREAD_SIZE)
+#else
+#define THREAD_ALIGN		THREAD_SIZE
+#endif
+
+#endif /* __KERNEL__ */
+#endif /*__ASM_THREAD_SIZE_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 84b9f1d235ba..43f8ea210bb3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -28,7 +28,7 @@
 #include <asm/errno.h>
 #include <asm/esr.h>
 #include <asm/irq.h>
-#include <asm/memory.h>
+#include <asm/thread_size.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index e56d848b6466..46b91702ea26 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -22,7 +22,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/cputype.h>
-#include <asm/memory.h>
 #include <asm/page.h>
 #include <asm/virt.h>
 
-- 
2.11.0
