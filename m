From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Jul 2018 17:49:38 +0100
Subject: [PATCH 3/3] rseq/selftests: Add support for arm64
In-Reply-To: <176714835.9396.1530219040151.JavaMail.zimbra@efficios.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
 <1529949285-11013-4-git-send-email-will.deacon@arm.com>
 <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com>
 <20180626151427.GF23375@arm.com>
 <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com>
 <20180628164700.GD10751@arm.com>
 <176714835.9396.1530219040151.JavaMail.zimbra@efficios.com>
Message-ID: <20180702164937.GA23687@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 04:50:40PM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 28, 2018, at 12:47 PM, Will Deacon will.deacon at arm.com wrote:
> > On Tue, Jun 26, 2018 at 12:11:52PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Jun 26, 2018, at 11:14 AM, Will Deacon will.deacon at arm.com wrote:
> >> > On Mon, Jun 25, 2018 at 02:10:10PM -0400, Mathieu Desnoyers wrote:
> >> >> I notice you are using the instructions
> >> >> 
> >> >>   adrp
> >> >>   add
> >> >>   str
> >> >> 
> >> >> to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
> >> >> performance-wise with an approach using a literal pool
> >> >> near the instruction pointer like I did on arm32 ?
> >> > 
> >> > I didn't, no. Do you have a benchmark to hand so I can give this a go?
> >> 
> >> see tools/testing/selftests/rseq/param_test_benchmark --help
> >> 
> >> It's a stripped-down version of param_test, without all the code for
> >> delay loops and testing checks.
> >> 
> >> Example use for counter increment with 4 threads, doing 5G counter
> >> increments per thread:
> >> 
> >> time ./param_test_benchmark -T i -t 4 -r 5000000000
> > 
> > Thanks. I ran that on a few arm64 systems I have access to, with three
> > configurations of the selftest:
> > 
> > 1. As I posted
> > 2. With the abort signature and branch in-lined, so as to avoid the CBNZ
> >   address limitations in large codebases
> > 3. With both the abort handler and the table inlined (i.e. the same thing
> >   as 32-bit).
> > 
> > There isn't a reliably measurable difference between (1) and (2), but I take
> > between 12% and 27% hit between (2) and (3).
> 
> Those results puzzle me. Do you have the actual code snippets of each
> implementation nearby ?

Sure, I've included the diffs for (2) and (3) below. They both apply on top
of my branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git rseq

Will

--->8

diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 599788f74137..954f34671ca6 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -104,11 +104,11 @@ do {										\
 	__rseq_str(label) ":\n"
 
 #define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
-	"	.pushsection	__rseq_failure, \"ax\"\n"			\
-	"	.long 	"	__rseq_str(RSEQ_SIG) "\n"			\
+	"	b	222f\n"							\
+	"	.inst 	"	__rseq_str(RSEQ_SIG) "\n"			\
 	__rseq_str(label) ":\n"							\
 	"	b	%l[" __rseq_str(abort_label) "]\n"			\
-	"	.popsection\n"
+	"222:\n"
 
 #define RSEQ_ASM_OP_STORE(value, var)						\
 	"	str	%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"

--->8

diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 599788f74137..2554aa17acf3 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -80,35 +80,37 @@ do {										\
 #define RSEQ_ASM_TMP_REG	"x15"
 #define RSEQ_ASM_TMP_REG_2	"x14"
 
-#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,		\
+#define __RSEQ_ASM_DEFINE_TABLE(version, flags, start_ip,			\
 				post_commit_offset, abort_ip)			\
-	"	.pushsection	__rseq_table, \"aw\"\n"				\
-	"	.balign	32\n"							\
-	__rseq_str(label) ":\n"							\
 	"	.long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
 	"	.quad	" __rseq_str(start_ip) ", "				\
 			  __rseq_str(post_commit_offset) ", "			\
-			  __rseq_str(abort_ip) "\n"				\
-	"	.popsection\n"
+			  __rseq_str(abort_ip) "\n"
 
-#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
-	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
-				(post_commit_ip - start_ip), abort_ip)
+#define RSEQ_ASM_DEFINE_TABLE(start_ip, post_commit_ip, abort_ip)		\
+	"	.pushsection	__rseq_table, \"aw\"\n"				\
+	"	.balign	32\n"							\
+	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip,				\
+				(post_commit_ip - start_ip), abort_ip)		\
+	"	.popsection\n"
 
-#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
+#define RSEQ_ASM_STORE_RSEQ_CS(label, table_label, rseq_cs)			\
 	RSEQ_INJECT_ASM(1)							\
-	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
-	"	add	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
-			", :lo12:" __rseq_str(cs_label) "\n"			\
+	"	adr	" RSEQ_ASM_TMP_REG ", " __rseq_str(table_label) "\n"	\
 	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(rseq_cs) "]\n"	\
 	__rseq_str(label) ":\n"
 
-#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
-	"	.pushsection	__rseq_failure, \"ax\"\n"			\
-	"	.long 	"	__rseq_str(RSEQ_SIG) "\n"			\
+#define RSEQ_ASM_DEFINE_ABORT(table_label, start_ip, post_commit_ip, label,	\
+			      abort_label)					\
+	"	b	222f\n"							\
+	"	.balign 32\n"							\
+	__rseq_str(table_label) ":\n"						\
+	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip,				\
+				(post_commit_ip - start_ip), label ## f)	\
+	"	.inst 	"	__rseq_str(RSEQ_SIG) "\n"			\
 	__rseq_str(label) ":\n"							\
 	"	b	%l[" __rseq_str(abort_label) "]\n"			\
-	"	.popsection\n"
+	"222:\n"
 
 #define RSEQ_ASM_OP_STORE(value, var)						\
 	"	str	%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"
@@ -181,8 +183,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -191,9 +193,9 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
 #endif
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -230,8 +232,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
@@ -243,9 +245,9 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_OP_R_LOAD(v)
 		RSEQ_ASM_OP_R_STORE(load)
 		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -281,8 +283,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 #ifdef RSEQ_COMPARE_TWICE
@@ -290,9 +292,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 #endif
 		RSEQ_ASM_OP_R_LOAD(v)
 		RSEQ_ASM_OP_R_ADD(count)
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
 		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -324,8 +326,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -336,9 +338,9 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 #endif
 		RSEQ_ASM_OP_STORE(newv2, v2)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -378,8 +380,8 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -390,9 +392,9 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 #endif
 		RSEQ_ASM_OP_STORE(newv2, v2)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -432,8 +434,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -445,9 +447,9 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
 		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
 #endif
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -489,8 +491,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -501,9 +503,9 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -544,8 +546,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -556,9 +558,9 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 #endif
 		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
