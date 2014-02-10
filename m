From: dave.long@linaro.org (David Long)
Date: Mon, 10 Feb 2014 02:38:57 -0500
Subject: [PATCH v6 06/14] ARM: Disable jprobes test when built into thumb-mode
 kernel
In-Reply-To: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
References: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
Message-ID: <1392017945-4507-7-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Jon Medhurst (Tixy)" <tixy@linaro.org>

For now the jprobes tests fail on ARM for when built into a kernel compiled
in thumb mode. They work fine for ARM kernels, and when built as a loadable
module.

Signed-off-by: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Acked-by: Jon Medhurst <tixy@linaro.org>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/kprobes-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 0cd63d0..65230b2 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -221,6 +221,7 @@ static int pre_handler_called;
 static int post_handler_called;
 static int jprobe_func_called;
 static int kretprobe_handler_called;
+static int tests_failed;
 
 #define FUNC_ARG1 0x12345678
 #define FUNC_ARG2 0xabcdef
@@ -457,6 +458,13 @@ static int run_api_tests(long (*func)(long, long))
 
 	pr_info("    jprobe\n");
 	ret = test_jprobe(func);
+#if defined(CONFIG_THUMB2_KERNEL) && !defined(MODULE)
+	if (ret == -EINVAL) {
+		pr_err("FAIL: Known longtime bug with jprobe on Thumb kernels");
+		tests_failed = ret;
+		ret = 0;
+	}
+#endif
 	if (ret < 0)
 		return ret;
 
@@ -1667,6 +1675,8 @@ static int __init run_all_tests(void)
 
 out:
 	if (ret == 0)
+		ret = tests_failed;
+	if (ret == 0)
 		pr_info("Finished kprobe tests OK\n");
 	else
 		pr_err("kprobe tests failed\n");
-- 
1.8.1.2
