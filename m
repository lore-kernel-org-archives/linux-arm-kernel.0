From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 16 Jun 2016 16:51:52 +0100
Subject: [PATCH 4.7-rc3 v2] arm64: kgdb: Match pstate size with gdbserver
 protocol
In-Reply-To: <1462815566-15086-1-git-send-email-daniel.thompson@linaro.org>
References: <1462815566-15086-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1466092312-26625-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current versions of gdb do not interoperate cleanly with kgdb on arm64
systems because gdb and kgdb do not use the same register description.
This patch modifies kgdb to work with recent releases of gdb (>= 7.8.1).

Compatibility with gdb (after the patch is applied) is as follows:

  gdb-7.6 and earlier  Ok
  gdb-7.7 series       Works if user provides custom target description
  gdb-7.8(.0)          Works if user provides custom target description
  gdb-7.8.1 and later  Ok

When commit 44679a4f142b ("arm64: KGDB: Add step debugging support") was
introduced it was paired with a gdb patch that made an incompatible
change to the gdbserver protocol. This patch was eventually merged into
the gdb sources:
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=a4d9ba85ec5597a6a556afe26b712e878374b9dd

The change to the protocol was mostly made to simplify big-endian support
inside the kernel gdb stub. Unfortunately the gdb project released
gdb-7.7.x and gdb-7.8.0 before the protocol incompatibility was identified
and reversed:
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=bdc144174bcb11e808b4e73089b850cf9620a7ee

This leaves us in a position where kgdb still uses the no-longer-used
protocol; gdb-7.8.1, which restored the original behaviour, was
released on 2014-10-29.

I don't believe it is possible to detect/correct the protocol
incompatiblity which means the kernel must take a view about which
version of the gdb remote protocol is "correct". This patch takes the
view that the original/current version of the protocol is correct
and that version found in gdb-7.7.x and gdb-7.8.0 is anomalous.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    v2:
     * Lots of new comments to sit in the code (rather than the git history)
       explaining exactly why there is such confusion about how wide the
       SPSR_ELx registers actually are (Will Deacon and Mark Rutland).
    
    Vijaya: I really hope I have the history lesson in the commit message
            correct! I've did a fair bit of archaeology to unpick things
    	and I pretty sure I haven't missed anything important.

 arch/arm64/include/asm/kgdb.h | 45 +++++++++++++++++++++++++++++++++++--------
 arch/arm64/kernel/kgdb.c      | 14 +++++++++++++-
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index f69f69c8120c..da84645525b9 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -38,25 +38,54 @@ extern int kgdb_fault_expected;
 #endif /* !__ASSEMBLY__ */

 /*
- * gdb is expecting the following registers layout.
+ * gdb remote procotol (well most versions of it) expects the following
+ * register layout.
  *
  * General purpose regs:
  *     r0-r30: 64 bit
  *     sp,pc : 64 bit
- *     pstate  : 64 bit
- *     Total: 34
+ *     pstate  : 32 bit
+ *     Total: 33 + 1
  * FPU regs:
  *     f0-f31: 128 bit
- *     Total: 32
- * Extra regs
  *     fpsr & fpcr: 32 bit
- *     Total: 2
+ *     Total: 32 + 2
  *
+ * To expand a little on the "most versions of it"... when the gdb remote
+ * protocol for AArch64 was developed it depended on a statement in the
+ * Architecture Reference Manual that claimed "SPSR_ELx is a 32-bit register".
+ * and, as a result, allocated only 32-bits for the PSTATE in the remote
+ * protocol. In fact this statement is still present in ARM DDI 0487A.i.
+ *
+ * Unfortunately "is a 32-bit register" has a very special meaning for
+ * system registers. It means that "the upper bits, bits[63:32], are
+ * RES0.". RES0 is heavily used in the ARM architecture documents as a
+ * way to leave space for future architecture changes. So to translate a
+ * little for people who don't spend their spare time reading ARM architecture
+ * manuals, what "is a 32-bit register" actually means in this context is
+ * "is a 64-bit register but one with no meaning allocated to any of the
+ * upper 32-bits... *yet*".
+ *
+ * Perhaps then we should not be surprised that this has led to some
+ * confusion. Specifically a patch, influenced by the above translation,
+ * that extended PSTATE to 64-bit was accepted into gdb-7.7 but the patch
+ * was reverted in gdb-7.8.1 and all later releases, when this was
+ * discovered to be an undocumented protocol change.
+ *
+ * So... it is *not* wrong for us to only allocate 32-bits to PSTATE
+ * here even though the kernel itself allocates 64-bits for the same
+ * state. That is because this bit of code tells the kernel how the gdb
+ * remote protocol (well most versions of it) describes the register state.
+ *
+ * Note that if you are using one of the versions of gdb that supports
+ * the gdb-7.7 version of the protocol you cannot use kgdb directly
+ * without providing a custom register description (gdb can load new
+ * protocol descriptions at runtime).
  */

-#define _GP_REGS		34
+#define _GP_REGS		33
 #define _FP_REGS		32
-#define _EXTRA_REGS		2
+#define _EXTRA_REGS		3
 /*
  * general purpose registers size in bytes.
  * pstate is only 4 bytes. subtract 4 bytes
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index b67531a13136..b5f063e5eff7 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -58,7 +58,17 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "x30", 8, offsetof(struct pt_regs, regs[30])},
 	{ "sp", 8, offsetof(struct pt_regs, sp)},
 	{ "pc", 8, offsetof(struct pt_regs, pc)},
-	{ "pstate", 8, offsetof(struct pt_regs, pstate)},
+	/*
+	 * struct pt_regs thinks PSTATE is 64-bits wide but gdb remote
+	 * protocol disagrees. Therefore we must extract only the lower
+	 * 32-bits. Look for the big comment in asm/kgdb.h for more
+	 * detail.
+	 */
+	{ "pstate", 4, offsetof(struct pt_regs, pstate)
+#ifdef CONFIG_CPU_BIG_ENDIAN
+							+ 4
+#endif
+	},
 	{ "v0", 16, -1 },
 	{ "v1", 16, -1 },
 	{ "v2", 16, -1 },
@@ -128,6 +138,8 @@ sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 	memset((char *)gdb_regs, 0, NUMREGBYTES);
 	thread_regs = task_pt_regs(task);
 	memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
+	/* Special case for PSTATE (check comments in asm/kgdb.h for details) */
+	dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
 }

 void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
--
2.5.5
