From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Oct 2017 13:54:57 +0100
Subject: [PATCH 6/6] kernel/locking: Remove unused union members from struct
 qrwlock
In-Reply-To: <1507208097-825-1-git-send-email-will.deacon@arm.com>
References: <1507208097-825-1-git-send-email-will.deacon@arm.com>
Message-ID: <1507208097-825-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all atomic operations are performed on the full lock word of
the qrwlock, there's no need to define a union type exposing the reader
and writer subcomponents. Remove them.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/qrwlock_types.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index 507f2dc51bba..7f53be31359c 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -9,23 +9,12 @@
  */
 
 typedef struct qrwlock {
-	union {
-		atomic_t cnts;
-		struct {
-#ifdef __LITTLE_ENDIAN
-			u8 wmode;	/* Writer mode   */
-			u8 rcnts[3];	/* Reader counts */
-#else
-			u8 rcnts[3];	/* Reader counts */
-			u8 wmode;	/* Writer mode   */
-#endif
-		};
-	};
+	atomic_t cnts;
 	arch_spinlock_t		wait_lock;
 } arch_rwlock_t;
 
 #define	__ARCH_RW_LOCK_UNLOCKED {		\
-	{ .cnts = ATOMIC_INIT(0), },		\
+	.cnts = ATOMIC_INIT(0),			\
 	.wait_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
 }
 
-- 
2.1.4
