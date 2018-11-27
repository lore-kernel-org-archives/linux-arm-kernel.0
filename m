From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 19:45:01 +0000
Subject: [PATCH 1/2] preempt: Move PREEMPT_NEED_RESCHED definition into arch
 code
In-Reply-To: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
Message-ID: <1543347902-21170-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PREEMPT_NEED_RESCHED is never used directly, so move it into the arch
code where it can potentially be implemented using either a different
bit in the preempt count or as an entirely separate entity.

Cc: Robert Love <rml@tech9.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/s390/include/asm/preempt.h | 2 ++
 arch/x86/include/asm/preempt.h  | 3 +++
 include/linux/preempt.h         | 3 ---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 23a14d187fb1..b5ea9e14c017 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -8,6 +8,8 @@
 
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
 
+/* We use the MSB mostly because its available */
+#define PREEMPT_NEED_RESCHED	0x80000000
 #define PREEMPT_ENABLED	(0 + PREEMPT_NEED_RESCHED)
 
 static inline int preempt_count(void)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 90cb2f36c042..99a7fa9ab0a3 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -8,6 +8,9 @@
 
 DECLARE_PER_CPU(int, __preempt_count);
 
+/* We use the MSB mostly because its available */
+#define PREEMPT_NEED_RESCHED	0x80000000
+
 /*
  * We use the PREEMPT_NEED_RESCHED bit as an inverted NEED_RESCHED such
  * that a decrement hitting 0 means we can and should reschedule.
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index c01813c3fbe9..dd92b1a93919 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -53,9 +53,6 @@
 
 #define SOFTIRQ_DISABLE_OFFSET	(2 * SOFTIRQ_OFFSET)
 
-/* We use the MSB mostly because its available */
-#define PREEMPT_NEED_RESCHED	0x80000000
-
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
-- 
2.1.4
