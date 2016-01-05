From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 5 Jan 2016 04:58:00 +0000
Subject: [RFC PATCH] arm64: perf test: Improbe bp_signal
In-Reply-To: <20160104165535.GI1616@arm.com>
References: <20160104165535.GI1616@arm.com>
Message-ID: <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon [1] has some question on patch [2]. This patch improves
test__bp_signal so we can test:

 1. A watchpoint and a breakpoint that fire on the same instruction
 2. Nested signals

For detail of this patch see the comment in patch body.

Test result:

 On both x86_64:

 # ./perf test -v signal
 17: Test breakpoint overflow signal handler                  :
 --- start ---
 test child forked, pid 10213
 count1 1, count2 3, count3 2, overflow 3, overflows_2 3
 test child finished with 0
 ---- end ----
 Test breakpoint overflow signal handler: Ok

So at least 2 cases Will doubted are handled correctly.

[1] http://lkml.kernel.org/g/20160104165535.GI1616 at arm.com
[2] http://lkml.kernel.org/g/1450921362-198371-1-git-send-email-wangnan0 at huawei.com

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 114 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index fb80c9e..0bc4f76 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -29,14 +29,55 @@
 
 static int fd1;
 static int fd2;
+static int fd3;
 static int overflows;
+static int overflows_2;
+
+volatile long the_var;
+
+
+#if defined (__x86_64__)
+extern void __test_function(volatile long *ptr);
+asm (
+	".globl __test_function\n"
+	"__test_function:\n"
+	"incq (%rdi)\n"
+	"ret\n");
+#elif defined (__aarch64__)
+extern void __test_function(volatile long *ptr);
+asm (
+	".globl __test_function\n"
+	"__test_function:\n"
+	"str x30, [x0]\n"
+	"ret\n");
+
+#else
+static void __test_function(volatile long *ptr)
+{
+	*ptr++;
+}
+#endif
 
 __attribute__ ((noinline))
 static int test_function(void)
 {
+	__test_function(&the_var);
+	the_var++;
 	return time(NULL);
 }
 
+static void sig_handler_2(int signum __maybe_unused,
+			  siginfo_t *oh __maybe_unused,
+			  void *uc __maybe_unused)
+{
+	overflows_2++;
+	if (overflows_2 > 10) {
+		ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0);
+		ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0);
+		ioctl(fd3, PERF_EVENT_IOC_DISABLE, 0);
+	}
+}
+
 static void sig_handler(int signum __maybe_unused,
 			siginfo_t *oh __maybe_unused,
 			void *uc __maybe_unused)
@@ -54,10 +95,11 @@ static void sig_handler(int signum __maybe_unused,
 		 */
 		ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0);
 		ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0);
+		ioctl(fd3, PERF_EVENT_IOC_DISABLE, 0);
 	}
 }
 
-static int bp_event(void *fn, int setup_signal)
+static int __xp_event(bool is_bp, void *addr, int setup_signal, int signal)
 {
 	struct perf_event_attr pe;
 	int fd;
@@ -67,8 +109,8 @@ static int bp_event(void *fn, int setup_signal)
 	pe.size = sizeof(struct perf_event_attr);
 
 	pe.config = 0;
-	pe.bp_type = HW_BREAKPOINT_X;
-	pe.bp_addr = (unsigned long) fn;
+	pe.bp_type = is_bp ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
+	pe.bp_addr = (unsigned long) addr;
 	pe.bp_len = sizeof(long);
 
 	pe.sample_period = 1;
@@ -88,7 +130,7 @@ static int bp_event(void *fn, int setup_signal)
 
 	if (setup_signal) {
 		fcntl(fd, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC);
-		fcntl(fd, F_SETSIG, SIGIO);
+		fcntl(fd, F_SETSIG, signal);
 		fcntl(fd, F_SETOWN, getpid());
 	}
 
@@ -97,6 +139,16 @@ static int bp_event(void *fn, int setup_signal)
 	return fd;
 }
 
+static int bp_event(void *addr, int setup_signal)
+{
+	return __xp_event(true, addr, setup_signal, SIGIO);
+}
+
+static int wp_event(void *addr, int setup_signal)
+{
+	return __xp_event(false, addr, setup_signal, SIGIO);
+}
+
 static long long bp_count(int fd)
 {
 	long long count;
@@ -114,7 +166,7 @@ static long long bp_count(int fd)
 int test__bp_signal(int subtest __maybe_unused)
 {
 	struct sigaction sa;
-	long long count1, count2;
+	long long count1, count2, count3;
 
 	/* setup SIGIO signal handler */
 	memset(&sa, 0, sizeof(struct sigaction));
@@ -126,6 +178,12 @@ int test__bp_signal(int subtest __maybe_unused)
 		return TEST_FAIL;
 	}
 
+	sa.sa_sigaction = (void *) sig_handler_2;
+	if (sigaction(SIGUSR1, &sa, NULL) < 0) {
+		pr_debug("failed setting up signal handler 2\n");
+		return TEST_FAIL;
+	}
+
 	/*
 	 * We create following events:
 	 *
@@ -133,7 +191,11 @@ int test__bp_signal(int subtest __maybe_unused)
 	 *       signal configured. We should get signal
 	 *       notification each time the breakpoint is hit
 	 *
-	 * fd2 - breakpoint event on sig_handler without SIGIO
+	 * fd2 - breakpoint event on sig_handler with SIGUSR1
+	 *       configured. We should get SIGUSR1 each time when
+	 *       breakpoint is hit
+	 *
+	 * fd3 - watchpoint event on test_function with SIGIO
 	 *       configured.
 	 *
 	 * Following processing should happen:
@@ -141,6 +203,21 @@ int test__bp_signal(int subtest __maybe_unused)
 	 *   - fd1 event breakpoint hit -> count1 == 1
 	 *   - SIGIO is delivered       -> overflows == 1
 	 *   - fd2 event breakpoint hit -> count2 == 1
+	 *   - SIGUSR1 is delivered     -> overflows_2 == 1  (nested signal)
+	 *   - sig_handler_2 return
+	 *   - sig_handler return
+	 *   - fd3 event watchpoint hit -> count3 == 1       (wp and bp in one insn)
+	 *   - SIGIO is delivered       -> overflows == 2
+	 *   - fd2 event breakpoint hit -> count2 == 2
+	 *   - SIGUSR1 is delivered     -> overflows_2 == 2
+	 *   - sig_handler_2 return
+	 *   - sig_handler return
+	 *   - fd3 event watchpoint hit -> count3 == 2       (standalone wp)
+	 *   - SIGIO is delivered       -> overflows = 3
+	 *   - fd2 event breakpoint hit -> count2 == 3
+	 *   - SIGUSR1 is delivered     -> overflows_2 == 3
+	 *   - sig_handler_2 return
+	 *   - sig_handler return
 	 *
 	 * The test case check following error conditions:
 	 * - we get stuck in signal handler because of debug
@@ -152,11 +229,13 @@ int test__bp_signal(int subtest __maybe_unused)
 	 *
 	 */
 
-	fd1 = bp_event(test_function, 1);
-	fd2 = bp_event(sig_handler, 0);
+	fd1 = bp_event(__test_function, 1);
+	fd2 = __xp_event(true, sig_handler, 1, SIGUSR1);
+	fd3 = wp_event((void *)&the_var, 1);
 
 	ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
 	ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);
+	ioctl(fd3, PERF_EVENT_IOC_ENABLE, 0);
 
 	/*
 	 * Kick off the test by trigering 'fd1'
@@ -166,15 +245,18 @@ int test__bp_signal(int subtest __maybe_unused)
 
 	ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0);
 	ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0);
+	ioctl(fd3, PERF_EVENT_IOC_DISABLE, 0);
 
 	count1 = bp_count(fd1);
 	count2 = bp_count(fd2);
+	count3 = bp_count(fd3);
 
 	close(fd1);
 	close(fd2);
+	close(fd3);
 
-	pr_debug("count1 %lld, count2 %lld, overflow %d\n",
-		 count1, count2, overflows);
+	pr_debug("count1 %lld, count2 %lld, count3 %lld, overflow %d, overflows_2 %d\n",
+		 count1, count2, count3, overflows, overflows_2);
 
 	if (count1 != 1) {
 		if (count1 == 11)
@@ -183,12 +265,18 @@ int test__bp_signal(int subtest __maybe_unused)
 			pr_debug("failed: wrong count for bp1%lld\n", count1);
 	}
 
-	if (overflows != 1)
+	if (overflows != 3)
 		pr_debug("failed: wrong overflow hit\n");
 
-	if (count2 != 1)
+	if (overflows_2 != 3)
+		pr_debug("failed: wrong overflow_2 hit\n");
+
+	if (count2 != 3)
 		pr_debug("failed: wrong count for bp2\n");
 
-	return count1 == 1 && overflows == 1 && count2 == 1 ?
+	if (count3 != 2)
+		pr_debug("failed: wrong count for bp3\n");
+
+	return count1 == 1 && overflows == 3 && count2 == 3 && overflows_2 == 3 && count3 == 2 ?
 		TEST_OK : TEST_FAIL;
 }
-- 
1.8.3.4
