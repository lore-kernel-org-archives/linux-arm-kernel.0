From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 22 Mar 2018 14:27:05 -0700
Subject: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints with
 clang
Message-ID: <20180322212705.141175-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMCCC v1.1 inline primitive code added by commit f2d3b2e8759a
("arm/arm64: smccc: Implement SMCCC v1.1 inline primitive") uses
register names r0, r1, ... for constraints. This breaks clang builds
for arm64, since clang currently only accepts x0, x1, ... in this
context. Use xN names for register constrains when building for arm64
with clang.

Fixes: f2d3b2e8759a ("arm/arm64: smccc: Implement SMCCC v1.1 inline primitive")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Note: Support for rN in future versions of clang is underway:
  https://bugs.llvm.org/show_bug.cgi?id=36862

 include/linux/arm-smccc.h | 54 ++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index a031897fca76..5c55d9e8c2ef 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -155,6 +155,11 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 
 #define SMCCC_SMC_INST	"smc	#0"
 #define SMCCC_HVC_INST	"hvc	#0"
+#ifndef __clang__
+#define __reg__ "r"
+#else
+#define __reg__ "x"
+#endif
 
 #elif defined(CONFIG_ARM)
 #include <asm/opcodes-sec.h>
@@ -162,6 +167,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 
 #define SMCCC_SMC_INST	__SMC(0)
 #define SMCCC_HVC_INST	__HVC(0)
+#define __reg__ "r"
 
 #endif
 
@@ -187,54 +193,54 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 #define __constraint_read_1
 #define __constraint_read_2
 #define __constraint_read_3
-#define __constraint_read_4	"r" (r4)
-#define __constraint_read_5	__constraint_read_4, "r" (r5)
-#define __constraint_read_6	__constraint_read_5, "r" (r6)
-#define __constraint_read_7	__constraint_read_6, "r" (r7)
+#define __constraint_read_4	__reg__ (r4)
+#define __constraint_read_5	__constraint_read_4, __reg__ (r5)
+#define __constraint_read_6	__constraint_read_5, __reg__ (r6)
+#define __constraint_read_7	__constraint_read_6, __reg__ (r7)
 
 #define __declare_arg_0(a0, res)					\
 	struct arm_smccc_res   *___res = res;				\
-	register u32           r0 asm("r0") = a0;			\
-	register unsigned long r1 asm("r1");				\
-	register unsigned long r2 asm("r2");				\
-	register unsigned long r3 asm("r3")
+	register u32           r0 asm(__reg__"0") = a0;			\
+	register unsigned long r1 asm(__reg__"1");			\
+	register unsigned long r2 asm(__reg__"2");			\
+	register unsigned long r3 asm(__reg__"3")
 
 #define __declare_arg_1(a0, a1, res)					\
 	struct arm_smccc_res   *___res = res;				\
-	register u32           r0 asm("r0") = a0;			\
-	register typeof(a1)    r1 asm("r1") = a1;			\
-	register unsigned long r2 asm("r2");				\
-	register unsigned long r3 asm("r3")
+	register u32           r0 asm(__reg__"0") = a0;			\
+	register typeof(a1)    r1 asm(__reg__"1") = a1;			\
+	register unsigned long r2 asm(__reg__"2");			\
+	register unsigned long r3 asm(__reg__"3")
 
 #define __declare_arg_2(a0, a1, a2, res)				\
 	struct arm_smccc_res   *___res = res;				\
-	register u32           r0 asm("r0") = a0;			\
-	register typeof(a1)    r1 asm("r1") = a1;			\
-	register typeof(a2)    r2 asm("r2") = a2;			\
-	register unsigned long r3 asm("r3")
+	register u32           r0 asm(__reg__"0") = a0;			\
+	register typeof(a1)    r1 asm(__reg__"1") = a1;			\
+	register typeof(a2)    r2 asm(__reg__"2") = a2;			\
+	register unsigned long r3 asm(__reg__"3")
 
 #define __declare_arg_3(a0, a1, a2, a3, res)				\
 	struct arm_smccc_res   *___res = res;				\
-	register u32           r0 asm("r0") = a0;			\
-	register typeof(a1)    r1 asm("r1") = a1;			\
-	register typeof(a2)    r2 asm("r2") = a2;			\
-	register typeof(a3)    r3 asm("r3") = a3
+	register u32           r0 asm(__reg__"0") = a0;			\
+	register typeof(a1)    r1 asm(__reg__"1") = a1;			\
+	register typeof(a2)    r2 asm(__reg__"2") = a2;			\
+	register typeof(a3)    r3 asm(__reg__"3") = a3
 
 #define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
 	__declare_arg_3(a0, a1, a2, a3, res);				\
-	register typeof(a4) r4 asm("r4") = a4
+	register typeof(a4) r4 asm(__reg__"4") = a4
 
 #define __declare_arg_5(a0, a1, a2, a3, a4, a5, res)			\
 	__declare_arg_4(a0, a1, a2, a3, a4, res);			\
-	register typeof(a5) r5 asm("r5") = a5
+	register typeof(a5) r5 asm(__reg__"5") = a5
 
 #define __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res)		\
 	__declare_arg_5(a0, a1, a2, a3, a4, a5, res);			\
-	register typeof(a6) r6 asm("r6") = a6
+	register typeof(a6) r6 asm(__reg__"6") = a6
 
 #define __declare_arg_7(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
 	__declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);		\
-	register typeof(a7) r7 asm("r7") = a7
+	register typeof(a7) r7 asm(__reg__"7") = a7
 
 #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
 #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
-- 
2.17.0.rc0.231.g781580f067-goog
