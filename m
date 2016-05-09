From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  9 May 2016 18:39:26 +0100
Subject: [PATCH] arm64: kgdb: Match pstate size with gdbserver protocol
Message-ID: <1462815566-15086-1-git-send-email-daniel.thompson@linaro.org>
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
protocol; gdb-7.8.1, which restored the original behaviour,If was
released on 2014-10-29.

I don't believe it is possible to detect/correct the protocol
incompatiblity which means the kernel must take a view about which
version of the gdb remote protocol is "correct". This patch takes the
view that the original/current version of the protocol is correct
and that version found in gdb-7.7.x and gdb-7.8.0 is anomalous.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Vijaya: I really hope I have the history lesson in the commit
            message correct! I've done a fair bit of archeology to
    	unpick things.

 arch/arm64/include/asm/kgdb.h | 13 +++++--------
 arch/arm64/kernel/kgdb.c      |  7 ++++++-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index f69f69c8120c..326fa8f44da5 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -43,20 +43,17 @@ extern int kgdb_fault_expected;
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
- *
+ *     Total: 32 + 2
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
index b67531a13136..ec62a4e3c190 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -58,7 +58,11 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "x30", 8, offsetof(struct pt_regs, regs[30])},
 	{ "sp", 8, offsetof(struct pt_regs, sp)},
 	{ "pc", 8, offsetof(struct pt_regs, pc)},
-	{ "pstate", 8, offsetof(struct pt_regs, pstate)},
+	{ "pstate", 4, offsetof(struct pt_regs, pstate)
+#ifdef CONFIG_CPU_BIG_ENDIAN
+							+ 4
+#endif
+	},
 	{ "v0", 16, -1 },
 	{ "v1", 16, -1 },
 	{ "v2", 16, -1 },
@@ -128,6 +132,7 @@ sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 	memset((char *)gdb_regs, 0, NUMREGBYTES);
 	thread_regs = task_pt_regs(task);
 	memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
+	dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
 }

 void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
--
2.5.5
