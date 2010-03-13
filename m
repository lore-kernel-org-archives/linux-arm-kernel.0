From: rabin@rab.in (Rabin Vincent)
Date: Sat, 13 Mar 2010 12:19:39 +0530
Subject: [PATCH 02/10] ARM: ftrace: document mcount formats
In-Reply-To: <1268462987-8271-1-git-send-email-rabin@rab.in>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
Message-ID: <1268462987-8271-3-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a comment describing the mcount variants and how the callsites look
like.

Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
v2: Reword/expand comment.

 arch/arm/kernel/entry-common.S |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 0b042bd..f05a35a 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -92,6 +92,42 @@ ENDPROC(ret_from_fork)
 #define CALL(x) .long x
 
 #ifdef CONFIG_FUNCTION_TRACER
+/*
+ * When compiling with -pg, gcc inserts a call to the mcount routine at the
+ * start of every function.  In mcount, apart from the function's address (in
+ * lr), we need to get hold of the function's caller's address.
+ *
+ * Older GCCs (pre-4.4) inserted a call to a routine called mcount like this:
+ *
+ *	bl	mcount
+ *
+ * These versions have the limitation that in order for the mcount routine to
+ * be able to determine the function's caller's address, an APCS-style frame
+ * pointer (which is set up with something like the code below) is required.
+ *
+ *	mov     ip, sp
+ *	push    {fp, ip, lr, pc}
+ *	sub     fp, ip, #4
+ *
+ * With EABI, these frame pointers are not available unless -mapcs-frame is
+ * specified, and if building as Thumb-2, not even then.
+ *
+ * Newer GCCs (4.4+) solve this problem by introducing a new version of mcount,
+ * with call sites like:
+ *
+ *	push	{lr}
+ *	bl	__gnu_mcount_nc
+ *
+ * With these compilers, frame pointers are not necessary.
+ *
+ * mcount can be thought of as a function called in the middle of a subroutine
+ * call.  As such, it needs to be transparent for both the caller and the
+ * callee: the original lr needs to be restored when leaving mcount, and no
+ * registers should be clobbered.  (In the __gnu_mcount_nc implementation, we
+ * clobber the ip register.  This is OK because the ARM calling convention
+ * allows it to be clobbered in subroutines and doesn't use it to hold
+ * parameters.)
+ */
 #ifdef CONFIG_DYNAMIC_FTRACE
 ENTRY(mcount)
 	stmdb	sp!, {r0-r3, lr}
-- 
1.7.0
