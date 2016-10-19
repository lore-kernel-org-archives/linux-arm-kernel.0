From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Oct 2016 11:59:44 +0100
Subject: [PATCH 2/2] arm64: percpu: rewrite ll/sc loops in assembly
In-Reply-To: <1476874784-16214-1-git-send-email-will.deacon@arm.com>
References: <1476874784-16214-1-git-send-email-will.deacon@arm.com>
Message-ID: <1476874784-16214-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writing the outer loop of an LL/SC sequence using do {...} while
constructs potentially allows the compiler to hoist memory accesses
between the STXR and the branch back to the LDXR. On CPUs that do not
guarantee forward progress of LL/SC loops when faced with memory
accesses to the same ERG (up to 2k) between the failed STXR and the
branch back, we may end up livelocking.

This patch avoids this issue in our percpu atomics by rewriting the
outer loop as part of the LL/SC inline assembly block.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/percpu.h | 120 +++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 2fee2f59288c..5394c8405e66 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -44,48 +44,44 @@ static inline unsigned long __percpu_##op(void *ptr,			\
 									\
 	switch (size) {							\
 	case 1:								\
-		do {							\
-			asm ("//__per_cpu_" #op "_1\n"			\
-			"ldxrb	  %w[ret], %[ptr]\n"			\
+		asm ("//__per_cpu_" #op "_1\n"				\
+		"1:	ldxrb	  %w[ret], %[ptr]\n"			\
 			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
-			"stxrb	  %w[loop], %w[ret], %[ptr]\n"		\
-			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
-			  [ptr] "+Q"(*(u8 *)ptr)			\
-			: [val] "Ir" (val));				\
-		} while (loop);						\
+		"	stxrb	  %w[loop], %w[ret], %[ptr]\n"		\
+		"	cbnz	  %w[loop], 1b"				\
+		: [loop] "=&r" (loop), [ret] "=&r" (ret),		\
+		  [ptr] "+Q"(*(u8 *)ptr)				\
+		: [val] "Ir" (val));					\
 		break;							\
 	case 2:								\
-		do {							\
-			asm ("//__per_cpu_" #op "_2\n"			\
-			"ldxrh	  %w[ret], %[ptr]\n"			\
+		asm ("//__per_cpu_" #op "_2\n"				\
+		"1:	ldxrh	  %w[ret], %[ptr]\n"			\
 			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
-			"stxrh	  %w[loop], %w[ret], %[ptr]\n"		\
-			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
-			  [ptr]  "+Q"(*(u16 *)ptr)			\
-			: [val] "Ir" (val));				\
-		} while (loop);						\
+		"	stxrh	  %w[loop], %w[ret], %[ptr]\n"		\
+		"	cbnz	  %w[loop], 1b"				\
+		: [loop] "=&r" (loop), [ret] "=&r" (ret),		\
+		  [ptr]  "+Q"(*(u16 *)ptr)				\
+		: [val] "Ir" (val));					\
 		break;							\
 	case 4:								\
-		do {							\
-			asm ("//__per_cpu_" #op "_4\n"			\
-			"ldxr	  %w[ret], %[ptr]\n"			\
+		asm ("//__per_cpu_" #op "_4\n"				\
+		"1:	ldxr	  %w[ret], %[ptr]\n"			\
 			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
-			"stxr	  %w[loop], %w[ret], %[ptr]\n"		\
-			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
-			  [ptr] "+Q"(*(u32 *)ptr)			\
-			: [val] "Ir" (val));				\
-		} while (loop);						\
+		"	stxr	  %w[loop], %w[ret], %[ptr]\n"		\
+		"	cbnz	  %w[loop], 1b"				\
+		: [loop] "=&r" (loop), [ret] "=&r" (ret),		\
+		  [ptr] "+Q"(*(u32 *)ptr)				\
+		: [val] "Ir" (val));					\
 		break;							\
 	case 8:								\
-		do {							\
-			asm ("//__per_cpu_" #op "_8\n"			\
-			"ldxr	  %[ret], %[ptr]\n"			\
+		asm ("//__per_cpu_" #op "_8\n"				\
+		"1:	ldxr	  %[ret], %[ptr]\n"			\
 			#asm_op " %[ret], %[ret], %[val]\n"		\
-			"stxr	  %w[loop], %[ret], %[ptr]\n"		\
-			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
-			  [ptr] "+Q"(*(u64 *)ptr)			\
-			: [val] "Ir" (val));				\
-		} while (loop);						\
+		"	stxr	  %w[loop], %[ret], %[ptr]\n"		\
+		"	cbnz	  %w[loop], 1b"				\
+		: [loop] "=&r" (loop), [ret] "=&r" (ret),		\
+		  [ptr] "+Q"(*(u64 *)ptr)				\
+		: [val] "Ir" (val));					\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -150,44 +146,40 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
 
 	switch (size) {
 	case 1:
-		do {
-			asm ("//__percpu_xchg_1\n"
-			"ldxrb %w[ret], %[ptr]\n"
-			"stxrb %w[loop], %w[val], %[ptr]\n"
-			: [loop] "=&r"(loop), [ret] "=&r"(ret),
-			  [ptr] "+Q"(*(u8 *)ptr)
-			: [val] "r" (val));
-		} while (loop);
+		asm ("//__percpu_xchg_1\n"
+		"1:	ldxrb	%w[ret], %[ptr]\n"
+		"	stxrb	%w[loop], %w[val], %[ptr]\n"
+		"	cbnz	%w[loop], 1b"
+		: [loop] "=&r"(loop), [ret] "=&r"(ret),
+		  [ptr] "+Q"(*(u8 *)ptr)
+		: [val] "r" (val));
 		break;
 	case 2:
-		do {
-			asm ("//__percpu_xchg_2\n"
-			"ldxrh %w[ret], %[ptr]\n"
-			"stxrh %w[loop], %w[val], %[ptr]\n"
-			: [loop] "=&r"(loop), [ret] "=&r"(ret),
-			  [ptr] "+Q"(*(u16 *)ptr)
-			: [val] "r" (val));
-		} while (loop);
+		asm ("//__percpu_xchg_2\n"
+		"1:	ldxrh	%w[ret], %[ptr]\n"
+		"	stxrh	%w[loop], %w[val], %[ptr]\n"
+		"	cbnz	%w[loop], 1b"
+		: [loop] "=&r"(loop), [ret] "=&r"(ret),
+		  [ptr] "+Q"(*(u16 *)ptr)
+		: [val] "r" (val));
 		break;
 	case 4:
-		do {
-			asm ("//__percpu_xchg_4\n"
-			"ldxr %w[ret], %[ptr]\n"
-			"stxr %w[loop], %w[val], %[ptr]\n"
-			: [loop] "=&r"(loop), [ret] "=&r"(ret),
-			  [ptr] "+Q"(*(u32 *)ptr)
-			: [val] "r" (val));
-		} while (loop);
+		asm ("//__percpu_xchg_4\n"
+		"1:	ldxr	%w[ret], %[ptr]\n"
+		"	stxr	%w[loop], %w[val], %[ptr]\n"
+		"	cbnz	%w[loop], 1b"
+		: [loop] "=&r"(loop), [ret] "=&r"(ret),
+		  [ptr] "+Q"(*(u32 *)ptr)
+		: [val] "r" (val));
 		break;
 	case 8:
-		do {
-			asm ("//__percpu_xchg_8\n"
-			"ldxr %[ret], %[ptr]\n"
-			"stxr %w[loop], %[val], %[ptr]\n"
-			: [loop] "=&r"(loop), [ret] "=&r"(ret),
-			  [ptr] "+Q"(*(u64 *)ptr)
-			: [val] "r" (val));
-		} while (loop);
+		asm ("//__percpu_xchg_8\n"
+		"1:	ldxr	%[ret], %[ptr]\n"
+		"	stxr	%w[loop], %[val], %[ptr]\n"
+		"	cbnz	%w[loop], 1b"
+		: [loop] "=&r"(loop), [ret] "=&r"(ret),
+		  [ptr] "+Q"(*(u64 *)ptr)
+		: [val] "r" (val));
 		break;
 	default:
 		BUILD_BUG();
-- 
2.1.4
