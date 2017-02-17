From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 17 Feb 2017 08:51:12 -0800
Subject: [PATCH] arm64: traps: Mark __le16, __le32, __user variables properly
Message-ID: <20170217165112.17512-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sparse complains a bit on this file about endian issues and
__user casting:

arch/arm64/kernel/traps.c:87:37: warning: incorrect type in argument 1 (different address spaces)
arch/arm64/kernel/traps.c:87:37:    expected void const volatile [noderef] <asn:1>*<noident>
arch/arm64/kernel/traps.c:87:37:    got unsigned long *<noident>
arch/arm64/kernel/traps.c:116:23: warning: incorrect type in argument 1 (different address spaces)
arch/arm64/kernel/traps.c:116:23:    expected void const volatile [noderef] <asn:1>*<noident>
arch/arm64/kernel/traps.c:116:23:    got unsigned int [usertype] *
arch/arm64/kernel/traps.c:346:25: warning: cast to restricted __le16
arch/arm64/kernel/traps.c:352:34: warning: cast to restricted __le16
arch/arm64/kernel/traps.c:359:25: warning: cast to restricted __le32

Mark the types appropriately, and force the cast in get_user()
when assigning to 0 so sparse doesn't complain. The resulting
object code is the same before and after this commit.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

Noticed while making other changes to this file. There are other issues still
about marking symbols static, but I'm not sure we want to introduce another
header file for the asmlinkage functions?

arch/arm64/kernel/traps.c:429:29: warning: symbol 'do_undefinstr' was not declared. Should it be static?
arch/arm64/kernel/traps.c:529:29: warning: symbol 'do_sysinstr' was not declared. Should it be static?
arch/arm64/kernel/traps.c:544:17: warning: symbol 'do_ni_syscall' was not declared. Should it be static?
arch/arm64/kernel/traps.c:615:17: warning: symbol 'bad_mode' was not declared. Should it be static?
arch/arm64/kernel/traps.c:632:17: warning: symbol 'bad_el0_sync' was not declared. Should it be static?
arch/arm64/kernel/traps.c:722:12: warning: symbol 'early_brk64' was not declared. Should it be static?
arch/arm64/kernel/traps.c:567:10: warning: Initializer entry defined twice
arch/arm64/kernel/traps.c:568:10:   also defined here

 arch/arm64/include/asm/uaccess.h |  2 +-
 arch/arm64/kernel/traps.c        | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 46da3ea638bb..2f5b4ae98ee0 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -287,7 +287,7 @@ do {									\
 	might_fault();							\
 	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?			\
 		__get_user((x), __p) :					\
-		((x) = 0, -EFAULT);					\
+		((x) = (__force __typeof__(*(ptr)))0, -EFAULT);		\
 })
 
 #define __put_user_asm(instr, alt_instr, reg, x, addr, err, feature)	\
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 659b2e6b6cf7..23959cb70ded 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -84,7 +84,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 			if (p >= bottom && p < top) {
 				unsigned long val;
 
-				if (__get_user(val, (unsigned long *)p) == 0)
+				if (__get_user(val, (unsigned long __user *)p) == 0)
 					sprintf(str + i * 17, " %016lx", val);
 				else
 					sprintf(str + i * 17, " ????????????????");
@@ -113,7 +113,7 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
 	for (i = -4; i < 1; i++) {
 		unsigned int val, bad;
 
-		bad = __get_user(val, &((u32 *)addr)[i]);
+		bad = __get_user(val, &((u32 __user *)addr)[i]);
 
 		if (!bad)
 			p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
@@ -340,23 +340,28 @@ static int call_undef_hook(struct pt_regs *regs)
 		return 1;
 
 	if (compat_thumb_mode(regs)) {
+		__le16 tinst;
+
 		/* 16-bit Thumb instruction */
-		if (get_user(instr, (u16 __user *)pc))
+		if (get_user(tinst, (__le16 __user *)pc))
 			goto exit;
-		instr = le16_to_cpu(instr);
+		instr = le16_to_cpu(tinst);
 		if (aarch32_insn_is_wide(instr)) {
-			u32 instr2;
+			__le16 tinstr2;
+			u16 instr2;
 
-			if (get_user(instr2, (u16 __user *)(pc + 2)))
+			if (get_user(tinstr2, (__le16 __user *)(pc + 2)))
 				goto exit;
-			instr2 = le16_to_cpu(instr2);
+			instr2 = le16_to_cpu(tinstr2);
 			instr = (instr << 16) | instr2;
 		}
 	} else {
+		__le32 ainst;
+
 		/* 32-bit ARM instruction */
-		if (get_user(instr, (u32 __user *)pc))
+		if (get_user(ainst, (__le32 __user *)pc))
 			goto exit;
-		instr = le32_to_cpu(instr);
+		instr = le32_to_cpu(ainst);
 	}
 
 	raw_spin_lock_irqsave(&undef_lock, flags);
-- 
2.10.0.297.gf6727b0
