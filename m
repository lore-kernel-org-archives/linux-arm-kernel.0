From: tixy@yxit.co.uk (Tixy)
Date: Mon, 29 Aug 2011 13:34:08 +0100
Subject: [PATCH 09/10] ARM: kprobes: Add some benchmarking to test module
In-Reply-To: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
References: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1314621249-958-10-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These benchmarks show the basic speed of kprobes and verify the success
of optimisations done to the emulation of typical function entry
instructions (i.e. push/stmdb).

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-test.c |  169 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 169 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 89758a8..ec41ead 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -185,6 +185,9 @@
 #include "kprobes-test.h"
 
 
+#define BENCHMARKING	1
+
+
 /*
  * Test basic API
  */
@@ -444,6 +447,165 @@ static int run_api_tests(long (*func)(long, long))
 
 
 /*
+ * Benchmarking
+ */
+
+#if BENCHMARKING
+
+static void __naked benchmark_nop(void)
+{
+	__asm__ __volatile__ (
+		"nop		\n\t"
+		"bx	lr"
+	);
+}
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define wide ".w"
+#else
+#define wide
+#endif
+
+static void __naked benchmark_pushpop1(void)
+{
+	__asm__ __volatile__ (
+		"stmdb"wide"	sp!, {r3-r11,lr}  \n\t"
+		"ldmia"wide"	sp!, {r3-r11,pc}"
+	);
+}
+
+static void __naked benchmark_pushpop2(void)
+{
+	__asm__ __volatile__ (
+		"stmdb"wide"	sp!, {r0-r8,lr}  \n\t"
+		"ldmia"wide"	sp!, {r0-r8,pc}"
+	);
+}
+
+static void __naked benchmark_pushpop3(void)
+{
+	__asm__ __volatile__ (
+		"stmdb"wide"	sp!, {r4,lr}  \n\t"
+		"ldmia"wide"	sp!, {r4,pc}"
+	);
+}
+
+static void __naked benchmark_pushpop4(void)
+{
+	__asm__ __volatile__ (
+		"stmdb"wide"	sp!, {r0,lr}  \n\t"
+		"ldmia"wide"	sp!, {r0,pc}"
+	);
+}
+
+
+#ifdef CONFIG_THUMB2_KERNEL
+
+static void __naked benchmark_pushpop_thumb(void)
+{
+	__asm__ __volatile__ (
+		"push.n	{r0-r7,lr}  \n\t"
+		"pop.n	{r0-r7,pc}"
+	);
+}
+
+#endif
+
+static int __kprobes
+benchmark_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	return 0;
+}
+
+static int benchmark(void(*fn)(void))
+{
+	int t, n;
+	for (n = 1000; ; n *= 2) {
+		struct timeval before;
+		struct timeval after;
+		int i;
+
+		do_gettimeofday(&before);
+
+		for (i = n; i > 0; --i)
+			fn();
+
+		do_gettimeofday(&after);
+		t = after.tv_usec - before.tv_usec;
+		if (t < 0)
+			t += 1000000; /* Adjust time if it wrapped */
+		if (t >= 250000)
+			break; /* Stop once we took more than 0.25 seconds */
+	}
+	return t / (n / 1000); /* Return time in nano-seconds */
+};
+
+static int kprobe_benchmark(void(*fn)(void), unsigned offset)
+{
+	struct kprobe k = {
+		.addr		= (kprobe_opcode_t *)((uintptr_t)fn + offset),
+		.pre_handler	= benchmark_pre_handler,
+	};
+
+	int ret = register_kprobe(&k);
+	if (ret < 0) {
+		pr_err("FAIL: register_kprobe failed with %d\n", ret);
+		return ret;
+	}
+
+	ret = benchmark(fn);
+
+	unregister_kprobe(&k);
+	return ret;
+};
+
+struct benchmarks {
+	void		(*fn)(void);
+	unsigned	offset;
+	const char	*title;
+};
+
+static int run_benchmarks(void)
+{
+	int ret;
+	struct benchmarks list[] = {
+		{&benchmark_nop, 0, "nop"},
+		/*
+		 * benchmark_pushpop{1,3} will have the optimised
+		 * instruction emulation, whilst benchmark_pushpop{2,4} will
+		 * be the equivalent unoptimised instructions.
+		 */
+		{&benchmark_pushpop1, 0, "stmdb	sp!, {r3-r11,lr}"},
+		{&benchmark_pushpop1, 4, "ldmia	sp!, {r3-r11,pc}"},
+		{&benchmark_pushpop2, 0, "stmdb	sp!, {r0-r8,lr}"},
+		{&benchmark_pushpop2, 4, "ldmia	sp!, {r0-r8,pc}"},
+		{&benchmark_pushpop3, 0, "stmdb	sp!, {r4,lr}"},
+		{&benchmark_pushpop3, 4, "ldmia	sp!, {r4,pc}"},
+		{&benchmark_pushpop4, 0, "stmdb	sp!, {r0,lr}"},
+		{&benchmark_pushpop4, 4, "ldmia	sp!, {r0,pc}"},
+#ifdef CONFIG_THUMB2_KERNEL
+		{&benchmark_pushpop_thumb, 0, "push.n	{r0-r7,lr}"},
+		{&benchmark_pushpop_thumb, 2, "pop.n	{r0-r7,pc}"},
+#endif
+		{0}
+	};
+
+	struct benchmarks *b;
+	for (b = list; b->fn; ++b) {
+		ret = kprobe_benchmark(b->fn, b->offset);
+		if (ret < 0)
+			return ret;
+		pr_info("    %dns for kprobe %s\n", ret, b->title);
+	}
+
+	pr_info("\n");
+	return 0;
+}
+
+#endif /* BENCHMARKING */
+
+
+/*
  * Decoding table self-consistency tests
  */
 
@@ -1526,6 +1688,13 @@ static int __init run_all_tests(void)
 		goto out;
 	}
 
+#if BENCHMARKING
+	pr_info("Benchmarks\n");
+	ret = run_benchmarks();
+	if (ret)
+		goto out;
+#endif
+
 #if __LINUX_ARM_ARCH__ >= 7
 	/* We are able to run all test cases so coverage should be complete */
 	if (coverage_fail) {
-- 
1.7.2.5
