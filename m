From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 21 Jun 2011 17:17:39 +0100
Subject: Git pull request: 64-bit atomic user helper
In-Reply-To: <alpine.LFD.2.00.1106202134510.2142@xanadu.home>
References: <alpine.LFD.2.00.1106202134510.2142@xanadu.home>
Message-ID: <20110621161739.GA2519@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 09:54:07PM -0400, Nicolas Pitre wrote:
> Russell, please pull the following for the next merge window:
> 
> 	git://git.linaro.org/people/nico/linux.git cmpxchg64
> 
> This series cleans up the kuser documentation, then it adds 64-bit
> cmpxchg support as needed by some user space applications.
> 
> Tested with the initial libgcc patches relying on this, using a 
> kernel that has this series applied, and another without those 
> patches to verify that the test for the availability of the needed 
> helper does work as intended.

If you like:

Tested-by: Dave Martin <dave.martin@linaro.org>


Here's my silly test program.

It passed on a pandaboard (2-core A9) with
-O3 -DITERATIONS=1000000000ULL -DBITS64

(Really, -O should not make a significant difference, though.)

Since the test just loops around __kuser_cmpxchg64(), if the number
of involuntary preemptions of a thread is non-trivial, some of those
preemptions will occur inside the kuser helper.


# ./tst-kuser 
__kuser_helper_version = 5
iterations * 8696638275910399085 = 7609822085224859648
        Thread 0:            17992 preemptions
        Thread 1:            17636 preemptions
        Thread 2:            17885 preemptions
        Thread 3:            17517 preemptions
OK

--- /dev/null	2011-06-20 16:05:05.019195001 +0000
+++ tst-kuser.c	2011-06-20 17:45:12.000000000 +0000
@@ -0,0 +1,158 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#include "kuser.h"
+
+#ifndef ITERATIONS
+#define ITERATIONS 1000000000ULL
+#endif
+
+#ifndef INCREMENT
+#ifdef BITS64
+/*
+ * So that target visits every value before repeating,
+ * INCREMENT should be an odd number.
+ * So that imperfect atomicity does not go unnoticed,
+ * INCREMENT should have plenty of non-zero bits, so that
+ * many bits of target change each time INCREMENT is added.
+ */
+#define INCREMENT 0x78B0AA6F67B4746DULL
+#else
+#define INCREMENT 0x67B4746DU
+#endif
+#endif
+
+#ifndef THREADS
+#define THREADS 4
+#endif
+
+#ifdef BITS64
+static volatile long long target = 0;
+#else
+static volatile unsigned target = 0;
+#endif
+
+struct thread_struct {
+	pthread_t thread;
+	volatile unsigned preemption_count;
+};
+
+#ifdef BITS64
+static void atomic_inc(long long volatile *p)
+#else
+static void atomic_inc(unsigned volatile *p)
+#endif
+{
+#ifdef BITS64
+	long long i, j;
+#else
+	int i, j;
+#endif
+
+	do {
+
+		i = *p;
+		j = i + INCREMENT;
+#ifdef BITS64
+	} while(__kuser_cmpxchg64(&i, &j, p));
+#else
+	} while(__kuser_cmpxchg(i, j, p));
+#endif
+}
+
+static unsigned thread_involuntary_switches(void)
+{
+	unsigned result = 0;
+	FILE *f = NULL;
+	char buf[80];
+#define FORMAT "/proc/%d/sched"
+	char namebuf[sizeof FORMAT + 10];
+	pid_t tid;
+
+	tid = syscall(__NR_gettid);
+	if(snprintf(namebuf, sizeof namebuf, FORMAT, tid) >= sizeof namebuf)
+		goto error;
+	f = fopen(namebuf, "r");
+	if(!f)
+		goto error;
+
+	while(fgets(buf, sizeof buf, f))
+		if(sscanf(buf, "nr_involuntary_switches : %d", &result))
+			goto done;
+
+error:
+	fprintf(stderr,
+		"Warning: %d: unable to read nr_involuntary_switches count\n",
+		tid);
+done:
+	if(f)
+		fclose(f);
+	return result;
+}
+
+static void *thread_func(void *arg)
+{
+	struct thread_struct *me = arg;
+
+	unsigned i;
+
+	for(i = 0; i < ITERATIONS; i++)
+		atomic_inc(&target);
+
+	me->preemption_count = thread_involuntary_switches();
+
+	return me;
+}
+
+int main(void)
+{
+	unsigned i;
+	struct thread_struct threads[THREADS];
+
+	fprintf(stderr, "__kuser_helper_version = %d\n",
+		__kuser_helper_version);
+#ifdef BTIS64
+	if(__kuser_helper_version < 5) {
+#else
+	if(__kuser_helper_version < 3) {
+#endif
+		fputs("Kernel too old\n", stderr);
+		exit(EXIT_FAILURE);
+	}
+
+	for(i = 0; i < THREADS; i++)
+		pthread_create(&threads[i].thread, NULL,
+			thread_func, &threads[i]);
+
+	for(i = 0; i < THREADS; i++)
+		pthread_join(threads[i].thread, NULL);
+
+	/*
+	 * For now, just leave the signaller threads running.
+	 * They should be harmless.
+	 */
+
+#ifdef BITS64
+	fprintf(stderr, "iterations * %llu = %llu\n", INCREMENT, target);
+#else
+	fprintf(stderr, "iterations * %u = %u\n", INCREMENT, target);
+#endif
+
+	for(i = 0; i < THREADS; i++)
+		fprintf(stderr, "\tThread %u:\t%10u preemptions\n",
+			i, threads[i].preemption_count);	
+
+	if(ITERATIONS * INCREMENT * THREADS != target) {
+		fputs("Error: Wrong final value of target.\n", stderr);
+		return EXIT_FAILURE;
+	} else {
+		fputs("OK\n", stderr);
+		return EXIT_SUCCESS;
+	}
+
+	return 0;
+}
--- /dev/null	2011-06-20 16:05:05.019195001 +0000
+++ kuser.h	2011-06-20 16:44:28.000000000 +0000
@@ -0,0 +1,18 @@
+#ifndef __ARM_KUSER_H
+#define __ARM_KUSER_H
+
+#define __kuser_helper_version (*(int *)0xffff0ffc)
+
+#define __kuser_decl __attribute__ (( __unused__ )) static
+
+__kuser_decl int __kuser_cmpxchg64(const long long *oldval, const long long *newval, volatile long long *ptr)
+{
+	return ((int (*)(const long long *, const long long *, volatile long long *))0xffff0f60)(oldval, newval, ptr);
+}
+
+__kuser_decl int __kuser_cmpxchg(int oldval, int newval, volatile int *ptr)
+{
+	return ((int (*)(int oldval, int newval, volatile int *))0xffff0fc0)(oldval, newval, ptr);
+}
+
+#endif /* __ARM_KUSER_H */
