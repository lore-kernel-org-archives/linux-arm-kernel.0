From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 19 Jan 2015 17:18:50 +0000
Subject: [PATCH] ARM: kprobes: Eliminate test code's use of BX instruction
 on ARMv4 CPUs
Message-ID: <1421687930.4201.21.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-T variants of ARMv4 CPUs don't support the BX instruction so
eliminate it use.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

This patch applies on top on my kprobe-opt branch [1] for which I plan on
sending a pull request for shortly.

[1] git://git.linaro.org/people/tixy/kernel.git kprobe-opt

 arch/arm/probes/kprobes/test-arm.c  |  2 ++
 arch/arm/probes/kprobes/test-core.c | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/probes/kprobes/test-arm.c b/arch/arm/probes/kprobes/test-arm.c
index e72b07e..5c6e37e 100644
--- a/arch/arm/probes/kprobes/test-arm.c
+++ b/arch/arm/probes/kprobes/test-arm.c
@@ -215,9 +215,11 @@ void kprobe_arm_test_cases(void)
 	TEST_UNSUPPORTED("msr	cpsr_f, lr")
 	TEST_UNSUPPORTED("msr	spsr, r0")
 
+#if (__LINUX_ARM_ARCH__ >= 5) || defined(CONFIG_CPU_32v4T)
 	TEST_BF_R("bx	r",0,2f,"")
 	TEST_BB_R("bx	r",7,2f,"")
 	TEST_BF_R("bxeq	r",14,2f,"")
+#endif
 
 #if __LINUX_ARM_ARCH__ >= 5
 	TEST_R("clz	r0, r",0, 0x0,"")
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index e495127..9775de2 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -236,6 +236,8 @@ static int tests_failed;
 
 #ifndef CONFIG_THUMB2_KERNEL
 
+#define RET(reg)	"mov	pc, "#reg
+
 long arm_func(long r0, long r1);
 
 static void __used __naked __arm_kprobes_test_func(void)
@@ -245,7 +247,7 @@ static void __used __naked __arm_kprobes_test_func(void)
 		".type arm_func, %%function		\n\t"
 		"arm_func:				\n\t"
 		"adds	r0, r0, r1			\n\t"
-		"bx	lr				\n\t"
+		"mov	pc, lr				\n\t"
 		".code "NORMAL_ISA	 /* Back to Thumb if necessary */
 		: : : "r0", "r1", "cc"
 	);
@@ -253,6 +255,8 @@ static void __used __naked __arm_kprobes_test_func(void)
 
 #else /* CONFIG_THUMB2_KERNEL */
 
+#define RET(reg)	"bx	"#reg
+
 long thumb16_func(long r0, long r1);
 long thumb32even_func(long r0, long r1);
 long thumb32odd_func(long r0, long r1);
@@ -494,7 +498,7 @@ static void __naked benchmark_nop(void)
 {
 	__asm__ __volatile__ (
 		"nop		\n\t"
-		"bx	lr"
+		RET(lr)"	\n\t"
 	);
 }
 
@@ -977,7 +981,7 @@ void __naked __kprobes_test_case_start(void)
 		"bic	r0, lr, #1  @ r0 = inline data		\n\t"
 		"mov	r1, sp					\n\t"
 		"bl	kprobes_test_case_start			\n\t"
-		"bx	r0					\n\t"
+		RET(r0)"					\n\t"
 	);
 }
 
-- 
2.1.4
