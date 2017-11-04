From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sat,  4 Nov 2017 13:31:21 +0900
Subject: [PATCH -next 2/2] arm: kprobes: Remove jprobe test case
In-Reply-To: <150976982219.2012.12861503668350308669.stgit@devbox>
References: <150976982219.2012.12861503668350308669.stgit@devbox>
Message-ID: <150976988105.2012.13618117383683725047.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove jprobe test case because jprobe is deprecated
feature. We must not use it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/probes/kprobes/test-core.c |   57 -----------------------------------
 1 file changed, 57 deletions(-)

diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 9c3ceba69015..9ed0129bed3c 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -227,7 +227,6 @@ static bool test_regs_ok;
 static int test_func_instance;
 static int pre_handler_called;
 static int post_handler_called;
-static int jprobe_func_called;
 static int kretprobe_handler_called;
 static int tests_failed;
 
@@ -370,50 +369,6 @@ static int test_kprobe(long (*func)(long, long))
 	return 0;
 }
 
-static void __kprobes jprobe_func(long r0, long r1)
-{
-	jprobe_func_called = test_func_instance;
-	if (r0 == FUNC_ARG1 && r1 == FUNC_ARG2)
-		test_regs_ok = true;
-	jprobe_return();
-}
-
-static struct jprobe the_jprobe = {
-	.entry		= jprobe_func,
-};
-
-static int test_jprobe(long (*func)(long, long))
-{
-	int ret;
-
-	the_jprobe.kp.addr = (kprobe_opcode_t *)func;
-	ret = register_jprobe(&the_jprobe);
-	if (ret < 0) {
-		pr_err("FAIL: register_jprobe failed with %d\n", ret);
-		return ret;
-	}
-
-	ret = call_test_func(func, true);
-
-	unregister_jprobe(&the_jprobe);
-	the_jprobe.kp.flags = 0; /* Clear disable flag to allow reuse */
-
-	if (!ret)
-		return -EINVAL;
-	if (jprobe_func_called != test_func_instance) {
-		pr_err("FAIL: jprobe handler function not called\n");
-		return -EINVAL;
-	}
-	if (!call_test_func(func, false))
-		return -EINVAL;
-	if (jprobe_func_called == test_func_instance) {
-		pr_err("FAIL: probe called after unregistering\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int __kprobes
 kretprobe_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
@@ -468,18 +423,6 @@ static int run_api_tests(long (*func)(long, long))
 	if (ret < 0)
 		return ret;
 
-	pr_info("    jprobe\n");
-	ret = test_jprobe(func);
-#if defined(CONFIG_THUMB2_KERNEL) && !defined(MODULE)
-	if (ret == -EINVAL) {
-		pr_err("FAIL: Known longtime bug with jprobe on Thumb kernels\n");
-		tests_failed = ret;
-		ret = 0;
-	}
-#endif
-	if (ret < 0)
-		return ret;
-
 	pr_info("    kretprobe\n");
 	ret = test_kretprobe(func);
 	if (ret < 0)
