From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Apr 2018 19:01:10 +0100
Subject: [PATCH v2 03/13] locking/qspinlock/x86: Increase _Q_PENDING_LOOPS
 upper bound
In-Reply-To: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
Message-ID: <1523469680-17699-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On x86, atomic_cond_read_relaxed will busy-wait with a cpu_relax() loop,
so it is desirable to increase the number of times we spin on the qspinlock
lockword when it is found to be transitioning from pending to locked.

According to Waiman Long:

| Ideally, the spinning times should be at least a few times the typical
| cacheline load time from memory which I think can be down to 100ns or
| so for each cacheline load with the newest systems or up to several
| hundreds ns for older systems.

which in his benchmarking corresponded to 512 iterations.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/x86/include/asm/qspinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 5e16b5d40d32..2f09915f4aa4 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -7,6 +7,8 @@
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
 
+#define _Q_PENDING_LOOPS	(1 << 9)
+
 #define	queued_spin_unlock queued_spin_unlock
 /**
  * queued_spin_unlock - release a queued spinlock
-- 
2.1.4
