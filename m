From: tixy@linaro.org (Jon Medhurst)
Date: Mon, 12 May 2014 12:31:32 +0100
Subject: [PATCH RESEND 1/3] ARM: kprobes: Prevent known test failures stopping
 other tests running
In-Reply-To: <1399894294-4144-1-git-send-email-tixy@linaro.org>
References: <1399894294-4144-1-git-send-email-tixy@linaro.org>
Message-ID: <1399894294-4144-2-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a long-standing issue with Thumb symbol lookup [1] the jprobes
tests fail when built into a kernel compiled as Thumb mode. (They work
fine for ARM mode kernels or for Thumb when built as a loadable module.)

Rather than have this problem terminate testing prematurely lets instead
emit an error message and carry on with the main kprobes tests, delaying
the final failure report until the end.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/063026.html

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm/kernel/kprobes-test.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 3796399..08d7312 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -225,6 +225,7 @@ static int pre_handler_called;
 static int post_handler_called;
 static int jprobe_func_called;
 static int kretprobe_handler_called;
+static int tests_failed;
 
 #define FUNC_ARG1 0x12345678
 #define FUNC_ARG2 0xabcdef
@@ -461,6 +462,13 @@ static int run_api_tests(long (*func)(long, long))
 
 	pr_info("    jprobe\n");
 	ret = test_jprobe(func);
+#if defined(CONFIG_THUMB2_KERNEL) && !defined(MODULE)
+	if (ret == -EINVAL) {
+		pr_err("FAIL: Known longtime bug with jprobe on Thumb kernels\n");
+		tests_failed = ret;
+		ret = 0;
+	}
+#endif
 	if (ret < 0)
 		return ret;
 
@@ -1672,6 +1680,8 @@ static int __init run_all_tests(void)
 
 out:
 	if (ret == 0)
+		ret = tests_failed;
+	if (ret == 0)
 		pr_info("Finished kprobe tests OK\n");
 	else
 		pr_err("kprobe tests failed\n");
-- 
1.7.10.4
