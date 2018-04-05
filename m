From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Apr 2018 17:59:04 +0100
Subject: [PATCH 07/10] locking/qspinlock: Use smp_cond_load_relaxed to wait
 for next node
In-Reply-To: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
Message-ID: <1522947547-24081-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a locker reaches the head of the queue and takes the lock, a
concurrent locker may enqueue and force the lock holder to spin
whilst its node->next field is initialised. Rather than open-code
a READ_ONCE/cpu_relax() loop, this can be implemented using
smp_cond_load_relaxed instead.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qspinlock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 291e1526d27b..c8b57d375b49 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -475,10 +475,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * contended path; wait for next if not observed yet, release.
 	 */
-	if (!next) {
-		while (!(next = READ_ONCE(node->next)))
-			cpu_relax();
-	}
+	if (!next)
+		next = smp_cond_load_relaxed(&node->next, (VAL));
 
 	arch_mcs_spin_unlock_contended(&next->locked);
 	pv_kick_node(lock, next);
-- 
2.1.4
