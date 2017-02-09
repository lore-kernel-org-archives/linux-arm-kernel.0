From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Feb 2017 15:19:18 +0000
Subject: [PATCH 1/4] arm64: ptrace: add XZR-safe regs accessors
In-Reply-To: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
References: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1486653561-22357-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In A64, XZR and the SP share the same encoding (31), and whether an
instruction accesses XZR or SP for a particular register parameter
depends on the definition of the instruction.

We store the SP in pt_regs::regs[31], and thus when emulating
instructions, we must be careful to not erroneously read from or write
back to the saved SP. Unfortunately, we often fail to be this careful.

In all cases, instructions using a transfer register parameter Xt use
this to refer to XZR rather than SP. This patch adds helpers so that we
can more easily and consistently handle these cases.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/ptrace.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 513daf0..11403fd 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -194,6 +194,26 @@ static inline u64 regs_get_register(struct pt_regs *regs, unsigned int offset)
 	return val;
 }
 
+/*
+ * Read a register given an architectural register index r.
+ * This handles the common case where 31 means XZR, not SP.
+ */
+static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
+{
+	return (r == 31) ? 0 : regs->regs[r];
+}
+
+/*
+ * Write a register given an architectural register index r.
+ * This handles the common case where 31 means XZR, not SP.
+ */
+static inline void pt_regs_write_reg(struct pt_regs *regs, int r,
+				     unsigned long val)
+{
+	if (r != 31)
+		regs->regs[r] = val;
+}
+
 /* Valid only for Kernel mode traps. */
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
-- 
1.9.1
