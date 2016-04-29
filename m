From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Apr 2016 10:52:32 +0200
Subject: [PATCH] sched/core: don't include asm/mmu_context from drivers
Message-ID: <1461919995-21001-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of switch_mm_irqs_off() brought back an old bug
regarding the use of preempt_enable_no_resched:

As part of 62b94a08da1b ("sched/preempt: Take away
preempt_enable_no_resched() from modules"), the definition of
preempt_enable_no_resched() is only available in built-in code,
not in loadable modules, so we can't generally use it from header
files. However, the ARM version of finish_arch_post_lock_switch()
calls preempt_enable_no_resched() and is defined as a static
inline function in asm/mmu_context.h. This in turn means we cannot
include asm/mmu_context.h from modules.

With today's tip tree, asm/mmu_context.h gets included from
linux/mmu_context.h, which is normally the exact pattern one would
expect, but unfortunately, linux/mmu_context.h can be included from
the vhost driver that is a loadable module, now causing this compile
time error:

In file included from ../include/linux/mmu_context.h:4:0,
                 from ../drivers/vhost/vhost.c:18:
../arch/arm/include/asm/mmu_context.h: In function 'finish_arch_post_lock_switch':
../arch/arm/include/asm/mmu_context.h:88:3: error: implicit declaration of function 'preempt_enable_no_resched' [-Werror=implicit-function-declaration]
   preempt_enable_no_resched();

Andy already tried to fix the bug by including linux/preempt.h
from asm/mmu_context.h, but that obviously didn't help.

This reverts the earlier fix attempt and works around the problem
by including both linux/mmu_context.h and asm/mmu_context.h from
kernel/sched/core.c. This is not a good solution but seems less
hacky than the alternatives.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f98db6013c55 ("sched/core: Add switch_mm_irqs_off() and use it in the scheduler")
Reverts: 88f10e37e150 ("sched/core, ARM: Include linux/preempt.h from asm/mmu_context.h")
---
 arch/arm/include/asm/mmu_context.h | 1 -
 include/linux/mmu_context.h        | 2 --
 kernel/sched/core.c                | 1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index ed73babc0dc9..fa5b42d44985 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -15,7 +15,6 @@
 
 #include <linux/compiler.h>
 #include <linux/sched.h>
-#include <linux/preempt.h>
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
 #include <asm/proc-fns.h>
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index a4441784503b..88d270706792 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -1,8 +1,6 @@
 #ifndef _LINUX_MMU_CONTEXT_H
 #define _LINUX_MMU_CONTEXT_H
 
-#include <asm/mmu_context.h>
-
 struct mm_struct;
 
 void use_mm(struct mm_struct *mm);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c82ca6eccfec..baa2a5152658 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -78,6 +78,7 @@
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
 #include <asm/irq_regs.h>
+#include <asm/mmu_context.h>
 #include <asm/mutex.h>
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
-- 
2.7.0
