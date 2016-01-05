From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 5 Jan 2016 10:00:30 +0100
Subject: [RFC PATCH] arm64: perf test: Improbe bp_signal
In-Reply-To: <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
References: <20160104165535.GI1616@arm.com>
 <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20160105090030.GC2192@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 04:58:00AM +0000, Wang Nan wrote:

SNIP

> +	 *   - SIGUSR1 is delivered     -> overflows_2 == 1  (nested signal)
> +	 *   - sig_handler_2 return
> +	 *   - sig_handler return
> +	 *   - fd3 event watchpoint hit -> count3 == 1       (wp and bp in one insn)
> +	 *   - SIGIO is delivered       -> overflows == 2
> +	 *   - fd2 event breakpoint hit -> count2 == 2
> +	 *   - SIGUSR1 is delivered     -> overflows_2 == 2
> +	 *   - sig_handler_2 return
> +	 *   - sig_handler return
> +	 *   - fd3 event watchpoint hit -> count3 == 2       (standalone wp)
> +	 *   - SIGIO is delivered       -> overflows = 3
> +	 *   - fd2 event breakpoint hit -> count2 == 3
> +	 *   - SIGUSR1 is delivered     -> overflows_2 == 3
> +	 *   - sig_handler_2 return
> +	 *   - sig_handler return
>  	 *
>  	 * The test case check following error conditions:
>  	 * - we get stuck in signal handler because of debug
> @@ -152,11 +229,13 @@ int test__bp_signal(int subtest __maybe_unused)
>  	 *
>  	 */
>  
> -	fd1 = bp_event(test_function, 1);
> -	fd2 = bp_event(sig_handler, 0);
> +	fd1 = bp_event(__test_function, 1);
> +	fd2 = __xp_event(true, sig_handler, 1, SIGUSR1);
> +	fd3 = wp_event((void *)&the_var, 1);
>  

spent some time to figure this out.. would attached change be more readable?

thanks,
jirka


---
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 0bc4f76c22ca..e5349616ac3f 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -99,7 +99,7 @@ static void sig_handler(int signum __maybe_unused,
 	}
 }
 
-static int __xp_event(bool is_bp, void *addr, int setup_signal, int signal)
+static int __event(bool is_x, void *addr, int signal)
 {
 	struct perf_event_attr pe;
 	int fd;
@@ -109,7 +109,7 @@ static int __xp_event(bool is_bp, void *addr, int setup_signal, int signal)
 	pe.size = sizeof(struct perf_event_attr);
 
 	pe.config = 0;
-	pe.bp_type = is_bp ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
+	pe.bp_type = is_x ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
 	pe.bp_addr = (unsigned long) addr;
 	pe.bp_len = sizeof(long);
 
@@ -128,25 +128,23 @@ static int __xp_event(bool is_bp, void *addr, int setup_signal, int signal)
 		return TEST_FAIL;
 	}
 
-	if (setup_signal) {
-		fcntl(fd, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC);
-		fcntl(fd, F_SETSIG, signal);
-		fcntl(fd, F_SETOWN, getpid());
-	}
+	fcntl(fd, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC);
+	fcntl(fd, F_SETSIG, signal);
+	fcntl(fd, F_SETOWN, getpid());
 
 	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
 
 	return fd;
 }
 
-static int bp_event(void *addr, int setup_signal)
+static int bp_event(void *addr, int signal)
 {
-	return __xp_event(true, addr, setup_signal, SIGIO);
+	return __event(true, addr, signal);
 }
 
-static int wp_event(void *addr, int setup_signal)
+static int wp_event(void *addr, int signal)
 {
-	return __xp_event(false, addr, setup_signal, SIGIO);
+	return __event(false, addr, signal);
 }
 
 static long long bp_count(int fd)
@@ -229,9 +227,9 @@ int test__bp_signal(int subtest __maybe_unused)
 	 *
 	 */
 
-	fd1 = bp_event(__test_function, 1);
-	fd2 = __xp_event(true, sig_handler, 1, SIGUSR1);
-	fd3 = wp_event((void *)&the_var, 1);
+	fd1 = bp_event(__test_function, SIGIO);
+	fd2 = bp_event(sig_handler, SIGUSR1);
+	fd3 = wp_event((void *)&the_var, SIGIO);
 
 	ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
 	ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);
