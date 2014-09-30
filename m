From: riel@redhat.com (Rik van Riel)
Date: Tue, 30 Sep 2014 15:59:47 -0400
Subject: [PATCH v2] sched, time: fix build error with 64 bit cputime_t on 32
 bit systems
In-Reply-To: <20140930133749.GD4241@worktop.programming.kicks-ass.net>
References: <2547036.UshV4pXvhf@wuerfel> <542AA33E.2050008@redhat.com>
 <20140930133749.GD4241@worktop.programming.kicks-ass.net>
Message-ID: <20140930155947.070cdb1f@annuminas.surriel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> That code is only ever used on x86 and ia64, most other archs have
> managed to not mess up their clocks quite as bad.

OK, lets try this again...

Gcc generated an error with the previous patch, because it evaluated
the branch that it was eliminating.  That means we cannot use a
sizeof directed branch, and have to fall back to simply defining which
cmpxchg to call for each cputime_t declaration.

---8<---

Subject: sched,time: fix build error with 64 bit cputime_t on 32 bit systems

On 32 bit systems cmpxchg cannot handle 64 bit values, so
some additional magic is required to allow a 32 bit system
with CONFIG_VIRT_CPU_ACCOUNTING_GEN enabled to build.

Make sure the correct cmpxchg function is used when doing
an atomic swap of a cputime_t.

Signed-off-by: Rik van Riel <riel@redhat.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/cputime.h    |  2 ++
 arch/s390/include/asm/cputime.h       |  2 ++
 include/asm-generic/cputime_jiffies.h |  2 ++
 include/asm-generic/cputime_nsecs.h   |  2 ++
 kernel/sched/cputime.c                | 29 +++++++++++++++++++----------
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 607559a..6c840ce 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -32,6 +32,8 @@ static inline void setup_cputime_one_jiffy(void) { }
 typedef u64 __nocast cputime_t;
 typedef u64 __nocast cputime64_t;
 
+#define cmpxchg_cputime(ptr, old, new) cmpxchg(ptr, old, new)
+
 #ifdef __KERNEL__
 
 /*
diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index f65bd36..3001887 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -18,6 +18,8 @@
 typedef unsigned long long __nocast cputime_t;
 typedef unsigned long long __nocast cputime64_t;
 
+#define cmpxchg_cputime(ptr, old, new) cmpxchg64(ptr, old, new)
+
 static inline unsigned long __div(unsigned long long n, unsigned long base)
 {
 #ifndef CONFIG_64BIT
diff --git a/include/asm-generic/cputime_jiffies.h b/include/asm-generic/cputime_jiffies.h
index d5cb78f5..fe386fc 100644
--- a/include/asm-generic/cputime_jiffies.h
+++ b/include/asm-generic/cputime_jiffies.h
@@ -3,6 +3,8 @@
 
 typedef unsigned long __nocast cputime_t;
 
+#define cmpxchg_cputime(ptr, old, new) cmpxchg(ptr, old, new)
+
 #define cputime_one_jiffy		jiffies_to_cputime(1)
 #define cputime_to_jiffies(__ct)	(__force unsigned long)(__ct)
 #define cputime_to_scaled(__ct)		(__ct)
diff --git a/include/asm-generic/cputime_nsecs.h b/include/asm-generic/cputime_nsecs.h
index 4e81760..0419485 100644
--- a/include/asm-generic/cputime_nsecs.h
+++ b/include/asm-generic/cputime_nsecs.h
@@ -21,6 +21,8 @@
 typedef u64 __nocast cputime_t;
 typedef u64 __nocast cputime64_t;
 
+#define cmpxchg_cputime(ptr, old, new) cmpxchg64(ptr, old, new)
+
 #define cputime_one_jiffy		jiffies_to_cputime(1)
 
 #define cputime_div(__ct, divisor)  div_u64((__force u64)__ct, divisor)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 64492df..8394b1e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -555,6 +555,23 @@ static cputime_t scale_stime(u64 stime, u64 rtime, u64 total)
 }
 
 /*
+ * Atomically advance counter to the new value. Interrupts, vcpu
+ * scheduling, and scaling inaccuracies can cause cputime_advance
+ * to be occasionally called with a new value smaller than counter.
+ * Let's enforce atomicity.
+ *
+ * Normally a caller will only go through this loop once, or not
+ * at all in case a previous caller updated counter the same jiffy.
+ */
+static void cputime_advance(cputime_t *counter, cputime_t new)
+{
+	cputime_t old;
+
+	while (new > (old = ACCESS_ONCE(*counter)))
+		cmpxchg_cputime(counter, old, new);
+}
+
+/*
  * Adjust tick based cputime random precision against scheduler
  * runtime accounting.
  */
@@ -599,16 +616,8 @@ static void cputime_adjust(struct task_cputime *curr,
 		utime = rtime - stime;
 	}
 
-	/*
-	 * If the tick based count grows faster than the scheduler one,
-	 * the result of the scaling may go backward.
-	 * Let's enforce monotonicity.
-	 * Atomic exchange protects against concurrent cputime_adjust().
-	 */
-	while (stime > (rtime = ACCESS_ONCE(prev->stime)))
-		cmpxchg(&prev->stime, rtime, stime);
-	while (utime > (rtime = ACCESS_ONCE(prev->utime)))
-		cmpxchg(&prev->utime, rtime, utime);
+	cputime_advance(&prev->stime, stime);
+	cputime_advance(&prev->utime, utime);
 
 out:
 	*ut = prev->utime;
