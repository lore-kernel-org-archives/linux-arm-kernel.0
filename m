From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:12 +0100
Subject: [PATCH 06/14] arm64: compat: add support for big-endian (BE8) AArch32
 binaries
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-7-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

This patch adds support for BE8 AArch32 tasks to the compat layer.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/compat.h    |   14 ++++++++++++++
 arch/arm64/include/asm/elf.h       |    5 +++++
 arch/arm64/include/asm/processor.h |    5 +++++
 arch/arm64/include/asm/ptrace.h    |    1 +
 4 files changed, 25 insertions(+)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 899af80..93bd6b7 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -26,7 +26,11 @@
 #include <linux/ptrace.h>
 
 #define COMPAT_USER_HZ		100
+#ifdef __AARCH64EB__
+#define COMPAT_UTS_MACHINE      "armv8b\0\0"
+#else
 #define COMPAT_UTS_MACHINE	"armv8l\0\0"
+#endif
 
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
@@ -73,13 +77,23 @@ struct compat_timeval {
 };
 
 struct compat_stat {
+#ifdef __AARCH64EB__
+	short		st_dev;
+	short		__pad1;
+#else
 	compat_dev_t	st_dev;
+#endif
 	compat_ino_t	st_ino;
 	compat_mode_t	st_mode;
 	compat_ushort_t	st_nlink;
 	__compat_uid16_t	st_uid;
 	__compat_gid16_t	st_gid;
+#ifdef __AARCH64EB__
+	short		st_rdev;
+	short		__pad2;
+#else
 	compat_dev_t	st_rdev;
+#endif
 	compat_off_t	st_size;
 	compat_off_t	st_blksize;
 	compat_off_t	st_blocks;
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a3e4a55..d42b82f 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -162,7 +162,12 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #define arch_randomize_brk arch_randomize_brk
 
 #ifdef CONFIG_COMPAT
+
+#ifdef __AARCH64EB__
+#define COMPAT_ELF_PLATFORM             ("v8b")
+#else
 #define COMPAT_ELF_PLATFORM		("v8l")
+#endif
 
 #define COMPAT_ELF_ET_DYN_BASE		(randomize_et_dyn(2 * TASK_SIZE_32 / 3))
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ab239b2..4ad8fec 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -107,6 +107,11 @@ static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
 	regs->pstate = COMPAT_PSR_MODE_USR;
 	if (pc & 1)
 		regs->pstate |= COMPAT_PSR_T_BIT;
+
+#ifdef __AARCH64EB__
+        regs->pstate |= COMPAT_PSR_E_BIT;
+#endif
+
 	regs->compat_sp = sp;
 }
 #endif
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 0dacbbf..0e7fa49 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -42,6 +42,7 @@
 #define COMPAT_PSR_MODE_UND	0x0000001b
 #define COMPAT_PSR_MODE_SYS	0x0000001f
 #define COMPAT_PSR_T_BIT	0x00000020
+#define COMPAT_PSR_E_BIT	0x00000200
 #define COMPAT_PSR_F_BIT	0x00000040
 #define COMPAT_PSR_I_BIT	0x00000080
 #define COMPAT_PSR_A_BIT	0x00000100
-- 
1.7.9.5
