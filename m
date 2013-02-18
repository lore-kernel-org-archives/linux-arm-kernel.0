From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:09:07 +0530
Subject: [PATCH v6 06/46] percpu_rwlock: Rearrange the read-lock code to
 fastpath nested percpu readers
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218123907.26245.37550.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are dealing with a nester percpu reader, we can optimize away quite
a few costly operations. Improve that fastpath further, by avoiding the
unnecessary addition and subtraction of 'READER_PRESENT' to reader_refcnt,
by rearranging the code a bit.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 lib/percpu-rwlock.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
index ce7e440..ed36531 100644
--- a/lib/percpu-rwlock.c
+++ b/lib/percpu-rwlock.c
@@ -80,23 +80,21 @@ void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
 	preempt_disable();
 
 	/*
-	 * Let the writer know that a reader is active, even before we choose
-	 * our reader-side synchronization scheme.
-	 */
-	this_cpu_add(pcpu_rwlock->rw_state->reader_refcnt, READER_PRESENT);
-
-	/*
 	 * If we are already using per-cpu refcounts, it is not safe to switch
 	 * the synchronization scheme. So continue using the refcounts.
 	 */
 	if (reader_uses_percpu_refcnt(pcpu_rwlock)) {
 		this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);
-		this_cpu_sub(pcpu_rwlock->rw_state->reader_refcnt,
-			     READER_PRESENT);
 		return;
 	}
 
 	/*
+	 * Let the writer know that a reader is active, even before we choose
+	 * our reader-side synchronization scheme.
+	 */
+	this_cpu_add(pcpu_rwlock->rw_state->reader_refcnt, READER_PRESENT);
+
+	/*
 	 * The write to 'reader_refcnt' must be visible before we read
 	 * 'writer_signal'.
 	 */
