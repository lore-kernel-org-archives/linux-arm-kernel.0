From: drew.richardson@arm.com (Drew Richardson)
Date: Thu, 1 Oct 2015 10:26:47 -0700
Subject: [PATCH] arm: perf: Fix userspace call stack walking
Message-ID: <20151001172643.GA23147@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got some undeliverable responses the first time, sorry if you get this twice

---

The layout of stack frames has changed over time. Testing using a
arm-linux-gnueabi gcc-4.2 from 2007 the original code didn't work but
this new code does. It also works with clang as well as newer versions
of gcc.

gcc has this layout for it's stackframes

caller_fp
caller_lr <- fp

However clang has this layout

caller_fp <- fp
caller_lr

Since the layouts are not compatible use a heuristic to determine for
each stack frame which layout is used.

Signed-off-by: Drew Richardson <drew.richardson@arm.com>
---
 arch/arm/kernel/perf_callchain.c | 86 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 4e02ae5950ff..99acfe9be9b1 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -13,16 +13,12 @@
 
 /*
  * The registers we're interested in are at the end of the variable
- * length saved register structure. The fp points at the end of this
- * structure so the address of this struct is:
- * (struct frame_tail *)(xxx->fp)-1
+ * length saved register structure.
  *
  * This code has been adapted from the ARM OProfile support.
  */
 struct frame_tail {
-	struct frame_tail __user *fp;
-	unsigned long sp;
-	unsigned long lr;
+	void __user *regs[3];
 } __attribute__((packed));
 
 /*
@@ -35,6 +31,8 @@ user_backtrace(struct frame_tail __user *tail,
 {
 	struct frame_tail buftail;
 	unsigned long err;
+	void __user *fp;
+	void __user *lr;
 
 	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
 		return NULL;
@@ -46,16 +44,84 @@ user_backtrace(struct frame_tail __user *tail,
 	if (err)
 		return NULL;
 
-	perf_callchain_store(entry, buftail.lr);
+	/*
+	 * gcc style stackframes
+	 *
+	 * parent_func <- caller_lr?
+	 * ...
+	 * caller_fp  (regs[0]) <- tail
+	 * caller_lr  (regs[1]) <- fp
+	 * other_data (regs[2])
+	 * ...
+	 * caller_stackframe <- caller_fp
+	 * ...
+	 * parent_func <- caller_lr?
+	 *
+	 * clang style stackframes
+	 *
+	 * parent_func <- caller_lr?
+	 * ...
+	 * other_data (regs[0]) <- tail
+	 * caller_fp  (regs[1]) <- fp
+	 * caller_lr  (regs[2])
+	 * ...
+	 * caller_stackframe <- caller_fp
+	 * ...
+	 * parent_func <- caller_lr?
+	 *
+	 * Is buftail.regs[1] the caller_lr or the caller_fp? Assume
+	 * that the previous function does not exist before the
+	 * previous stackframe (ie, caller_lr < tail || caller_lr >
+	 * caller_fp) and that the stack grows downwards towards
+	 * smaller addresses (ie, fp < caller_fp). In the case of
+	 * ambiguity, assume gcc style stackframes.
+	 *
+	 * (caller_lr < tail < caller_fp) || (tail < caller_fp < caller_lr)
+	 *
+	 * gcc style stackframes
+	 *
+	 * (regs[1] < tail < regs[0]) || (tail < regs[0] < regs[1])
+	 * regs[2] is undefined
+	 *
+	 * regs[0] <    tail =         0
+	 * regs[1] <    tail =    0 || 1
+	 * regs[2] <    tail = undefined
+	 * regs[1] < regs[0] =    0 || 1
+	 * regs[2] < regs[0] = undefined
+	 * regs[2] < regs[1] = undefined
+	 *
+	 * clang style stackframes
+	 *
+	 * (regs[2] < tail < regs[1]) || (tail < regs[1] < regs[2])
+	 * regs[0] is undefined
+	 *
+	 * regs[0] <    tail = undefined
+	 * regs[1] <    tail =         0
+	 * regs[2] <    tail =    0 || 1
+	 * regs[1] < regs[0] = undefined
+	 * regs[2] < regs[0] = undefined
+	 * regs[2] < regs[1] =    0 || 1
+	 */
+	if (buftail.regs[0] > (void __user *)tail) {
+		/* gcc style stackframes */
+		fp = buftail.regs[0];
+		lr = buftail.regs[1];
+	} else {
+		/* clang style stackframes */
+		fp = buftail.regs[1];
+		lr = buftail.regs[2];
+	}
+
+	perf_callchain_store(entry, (uintptr_t)lr);
 
 	/*
 	 * Frame pointers should strictly progress back up the stack
 	 * (towards higher addresses).
 	 */
-	if (tail + 1 >= buftail.fp)
+	if ((void __user *)tail + 4 >= fp)
 		return NULL;
 
-	return buftail.fp - 1;
+	return fp - 4;
 }
 
 void
@@ -73,7 +139,7 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 	if (!current->mm)
 		return;
 
-	tail = (struct frame_tail __user *)regs->ARM_fp - 1;
+	tail = (struct frame_tail __user *)(regs->ARM_fp - 4);
 
 	while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
 	       tail && !((unsigned long)tail & 0x3))
-- 
2.1.4
