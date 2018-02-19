From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Feb 2018 13:38:00 +0000
Subject: [PATCH v2] arm64: uaccess: Formalise types for access_ok()
Message-ID: <ed526fc307d05ddf58bbda1655339351d58c91bc.1519047448.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In converting __range_ok() into a static inline, I inadvertently made
it more type-safe, but without considering the ordering of the relevant
conversions. This leads to quite a lot of Sparse noise about the fact
that we use __chk_user_ptr() after addr has already been converted from
a user pointer to an unsigned long.

Rather than just adding another cast for the sake of shutting Sparse up,
it seems reasonable to rework the types to make logical sense (although
the resulting codegen for __range_ok() remains identical). The only
callers this affects directly are our compat traps where the inferred
"user-pointer-ness" of a register value now warrants explicit casting.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Also cover SWP emulation, which was somehow disabled in my config
    previously. This time I've build-tested allyesconfig with both a
    sensible modern toolchain and Ubuntu's antique GCC 4.8.

 arch/arm64/include/asm/uaccess.h     | 12 ++++++------
 arch/arm64/kernel/armv8_deprecated.c |  4 +++-
 arch/arm64/kernel/sys_compat.c       |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 543e11f0f657..e66b0fca99c2 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -72,15 +72,15 @@ static inline void set_fs(mm_segment_t fs)
  * This is equivalent to the following test:
  * (u65)addr + (u65)size <= (u65)current->addr_limit + 1
  */
-static inline unsigned long __range_ok(unsigned long addr, unsigned long size)
+static inline unsigned long __range_ok(const void __user *addr, unsigned long size)
 {
-	unsigned long limit = current_thread_info()->addr_limit;
+	unsigned long ret, limit = current_thread_info()->addr_limit;
 
 	__chk_user_ptr(addr);
 	asm volatile(
 	// A + B <= C + 1 for all A,B,C, in four easy steps:
 	// 1: X = A + B; X' = X % 2^64
-	"	adds	%0, %0, %2\n"
+	"	adds	%0, %3, %2\n"
 	// 2: Set C = 0 if X > 2^64, to guarantee X' > C in step 4
 	"	csel	%1, xzr, %1, hi\n"
 	// 3: Set X' = ~0 if X >= 2^64. For X == 2^64, this decrements X'
@@ -92,9 +92,9 @@ static inline unsigned long __range_ok(unsigned long addr, unsigned long size)
 	//    testing X' - C == 0, subject to the previous adjustments.
 	"	sbcs	xzr, %0, %1\n"
 	"	cset	%0, ls\n"
-	: "+r" (addr), "+r" (limit) : "Ir" (size) : "cc");
+	: "=&r" (ret), "+r" (limit) : "Ir" (size), "0" (addr) : "cc");
 
-	return addr;
+	return ret;
 }
 
 /*
@@ -104,7 +104,7 @@ static inline unsigned long __range_ok(unsigned long addr, unsigned long size)
  */
 #define untagged_addr(addr)		sign_extend64(addr, 55)
 
-#define access_ok(type, addr, size)	__range_ok((unsigned long)(addr), size)
+#define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index c33b5e4010ab..68450e954d47 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -370,6 +370,7 @@ static unsigned int __kprobes aarch32_check_condition(u32 opcode, u32 psr)
 static int swp_handler(struct pt_regs *regs, u32 instr)
 {
 	u32 destreg, data, type, address = 0;
+	const void __user *user_ptr;
 	int rn, rt2, res = 0;
 
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
@@ -401,7 +402,8 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
 		aarch32_insn_extract_reg_num(instr, A32_RT2_OFFSET), data);
 
 	/* Check access in reasonable access range for both SWP and SWPB */
-	if (!access_ok(VERIFY_WRITE, (address & ~3), 4)) {
+	user_ptr = (const void __user *)(unsigned long)(address & ~3);
+	if (!access_ok(VERIFY_WRITE, user_ptr, 4)) {
 		pr_debug("SWP{B} emulation: access to 0x%08x not allowed!\n",
 			address);
 		goto fault;
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 8b8bbd3eaa52..a382b2a1b84e 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -57,7 +57,7 @@ do_compat_cache_op(unsigned long start, unsigned long end, int flags)
 	if (end < start || flags)
 		return -EINVAL;
 
-	if (!access_ok(VERIFY_READ, start, end - start))
+	if (!access_ok(VERIFY_READ, (const void __user *)start, end - start))
 		return -EFAULT;
 
 	return __do_compat_cache_op(start, end);
-- 
2.16.1.dirty
