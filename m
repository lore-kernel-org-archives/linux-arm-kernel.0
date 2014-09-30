From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 13:56:37 +0200
Subject: [PATCH] sched, time: cmpxchg does not work on 64-bit variable
Message-ID: <2547036.UshV4pXvhf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change to update the stime/utime members of task_struct
using atomic cmpxchg broke configurations on 32-bit machines with
CONFIG_VIRT_CPU_ACCOUNTING_GEN set, because that uses 64-bit
nanoseconds, leading to a link-time error:

kernel/built-in.o: In function `cputime_adjust':
:(.text+0x25234): undefined reference to `__bad_cmpxchg'

This reverts the change that caused the problem, I suspect the real fix
is to conditionally use cmpxchg64 instead, but I have not checked if
that will work on all architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: eb1b4af0a64a ("sched, time: Atomically increment stime & utime")
---
found in ARM randconfig builds on linux-next

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 64492dff8a81..e99e7e54131c 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -603,12 +603,9 @@ static void cputime_adjust(struct task_cputime *curr,
 	 * If the tick based count grows faster than the scheduler one,
 	 * the result of the scaling may go backward.
 	 * Let's enforce monotonicity.
-	 * Atomic exchange protects against concurrent cputime_adjust().
 	 */
-	while (stime > (rtime = ACCESS_ONCE(prev->stime)))
-		cmpxchg(&prev->stime, rtime, stime);
-	while (utime > (rtime = ACCESS_ONCE(prev->utime)))
-		cmpxchg(&prev->utime, rtime, utime);
+	prev->stime = max(prev->stime, stime);
+	prev->utime = max(prev->utime, utime);
 
 out:
 	*ut = prev->utime;
