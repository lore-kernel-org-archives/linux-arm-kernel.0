From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:13 +0100
Subject: [PATCH 07/14] arm64: compat: correct register concatenation for
 syscall wrappers
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-8-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 port contains wrappers for arm32 syscalls that pass 64-bit
values. These wrappers concatenate the two registers to hold a 64-bit
value in a single X register. On BE, however, the lower and higher
words are swapped.

Create a new assembler macro, regs_to_64, that when on BE systems
swaps the registers in the orr instruction.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm64/include/asm/assembler.h |   12 ++++++++++++
 arch/arm64/kernel/sys32.S          |   22 +++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 5aceb83..381b935 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -115,3 +115,15 @@ lr	.req	x30		// link register
 	.align	7
 	b	\label
 	.endm
+/*
+ * Define a macro that constructs a 64-bit value by concatenating two
+ * 32-bit registers. Note that on big endian systems the order of the
+ * registers is swapped.
+ */
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	.macro	regs_to_64, rd, lbits, hbits
+#else
+	.macro	regs_to_64, rd, hbits, lbits
+#endif
+	orr	\rd, \lbits, \hbits, lsl #32
+	.endm
diff --git a/arch/arm64/kernel/sys32.S b/arch/arm64/kernel/sys32.S
index a1b19ed..423a5b3 100644
--- a/arch/arm64/kernel/sys32.S
+++ b/arch/arm64/kernel/sys32.S
@@ -59,48 +59,48 @@ ENDPROC(compat_sys_fstatfs64_wrapper)
  * extension.
  */
 compat_sys_pread64_wrapper:
-	orr	x3, x4, x5, lsl #32
+	regs_to_64	x3, x4, x5
 	b	sys_pread64
 ENDPROC(compat_sys_pread64_wrapper)
 
 compat_sys_pwrite64_wrapper:
-	orr	x3, x4, x5, lsl #32
+	regs_to_64	x3, x4, x5
 	b	sys_pwrite64
 ENDPROC(compat_sys_pwrite64_wrapper)
 
 compat_sys_truncate64_wrapper:
-	orr	x1, x2, x3, lsl #32
+	regs_to_64	x1, x2, x3
 	b	sys_truncate
 ENDPROC(compat_sys_truncate64_wrapper)
 
 compat_sys_ftruncate64_wrapper:
-	orr	x1, x2, x3, lsl #32
+	regs_to_64	x1, x2, x3
 	b	sys_ftruncate
 ENDPROC(compat_sys_ftruncate64_wrapper)
 
 compat_sys_readahead_wrapper:
-	orr	x1, x2, x3, lsl #32
+	regs_to_64	x1, x2, x3
 	mov	w2, w4
 	b	sys_readahead
 ENDPROC(compat_sys_readahead_wrapper)
 
 compat_sys_fadvise64_64_wrapper:
 	mov	w6, w1
-	orr	x1, x2, x3, lsl #32
-	orr	x2, x4, x5, lsl #32
+	regs_to_64	x1, x2, x3
+	regs_to_64	x2, x4, x5
 	mov	w3, w6
 	b	sys_fadvise64_64
 ENDPROC(compat_sys_fadvise64_64_wrapper)
 
 compat_sys_sync_file_range2_wrapper:
-	orr	x2, x2, x3, lsl #32
-	orr	x3, x4, x5, lsl #32
+	regs_to_64	x2, x2, x3
+	regs_to_64	x3, x4, x5
 	b	sys_sync_file_range2
 ENDPROC(compat_sys_sync_file_range2_wrapper)
 
 compat_sys_fallocate_wrapper:
-	orr	x2, x2, x3, lsl #32
-	orr	x3, x4, x5, lsl #32
+	regs_to_64	x2, x2, x3
+	regs_to_64	x3, x4, x5
 	b	sys_fallocate
 ENDPROC(compat_sys_fallocate_wrapper)
 
-- 
1.7.9.5
