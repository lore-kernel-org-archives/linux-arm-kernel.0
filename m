From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 17 Sep 2010 13:54:42 +0900
Subject: [PATCH] ARM: MM: bugfix: initialize spinlock for init_mm.context
Message-ID: <1284699282-22849-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

init_mm used at kernel/sched.c:idle_task_exit() has spin_lock
(init_mm.context.id_lock) that is not initialized when spin_lock/unlock
is called at an ARM machine. Note that mm_struct.context.id_lock is usually
initialized except for the instance of init_mm at linux/arch/arm/mm/context.c

Not initializing this spinlock incurs "BUG: pinlock bad magic" warning when
spinlock debug is enabled. We have observed such instances when testing PM in
S5PC210 machines.


Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/include/asm/mmu.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 68870c7..c18540b 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -13,6 +13,10 @@ typedef struct {
 
 #ifdef CONFIG_CPU_HAS_ASID
 #define ASID(mm)	((mm)->context.id & 255)
+
+/* init_mm.context.id_lock should be initialized. */
+#define INIT_MM_CONTEXT(name)                                                 \
+	.context.id_lock    = __SPIN_LOCK_UNLOCKED(name.context.list_lock),
 #else
 #define ASID(mm)	(0)
 #endif
-- 
1.6.3.3
