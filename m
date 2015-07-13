From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 13 Jul 2015 14:25:54 +0100
Subject: [PATCH v2 07/10] arm64/debug: Simplify BRK insn opcode declarations
In-Reply-To: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1436793967-7138-8-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The way the KGDB_DYN_BRK_INS_BYTEx macros are declared is more
complex than it needs to be.  Also, the macros are only used in one
place, which is arch-specific anyway.

This patch refactors the macros to simplify them, and exposes an
argument so that we can have a single macro instead of 4.

As a side effect, this patch also fixes some anomalous spellings of
"KGDB".

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |   23 ++++-------------------
 arch/arm64/kernel/kgdb.c                |    8 ++++----
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index e28b1dd..6a17fb8 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -66,25 +66,10 @@
  */
 #define AARCH64_BREAK_FAULT	(AARCH64_BREAK_MON | (FAULT_BRK_IMM << 5))
 
-/*
- * Extract byte from BRK instruction
- */
-#define KGDB_DYN_DBG_BRK_INS_BYTE(x) \
-	((((AARCH64_BREAK_MON) & 0xffe0001f) >> (x * 8)) & 0xff)
-
-/*
- * Extract byte from BRK #imm16
- */
-#define KGBD_DYN_DBG_BRK_IMM_BYTE(x) \
-	(((((KGDB_DYN_DBG_BRK_IMM) & 0xffff) << 5) >> (x * 8)) & 0xff)
-
-#define KGDB_DYN_DBG_BRK_BYTE(x) \
-	(KGDB_DYN_DBG_BRK_INS_BYTE(x) | KGBD_DYN_DBG_BRK_IMM_BYTE(x))
-
-#define  KGDB_DYN_BRK_INS_BYTE0  KGDB_DYN_DBG_BRK_BYTE(0)
-#define  KGDB_DYN_BRK_INS_BYTE1  KGDB_DYN_DBG_BRK_BYTE(1)
-#define  KGDB_DYN_BRK_INS_BYTE2  KGDB_DYN_DBG_BRK_BYTE(2)
-#define  KGDB_DYN_BRK_INS_BYTE3  KGDB_DYN_DBG_BRK_BYTE(3)
+#define AARCH64_BREAK_KGDB_DYN_DBG	\
+	(AARCH64_BREAK_MON | (KGDB_DYN_DBG_BRK_IMM << 5))
+#define KGDB_DYN_BRK_INS_BYTE(x)	\
+	((AARCH64_BREAK_KGDB_DYN_DBG >> (8 * (x))) & 0xff)
 
 #define CACHE_FLUSH_IS_SAFE		1
 
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index a5a838e..4f78b8a 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -328,9 +328,9 @@ void kgdb_arch_exit(void)
  */
 struct kgdb_arch arch_kgdb_ops = {
 	.gdb_bpt_instr = {
-		KGDB_DYN_BRK_INS_BYTE0,
-		KGDB_DYN_BRK_INS_BYTE1,
-		KGDB_DYN_BRK_INS_BYTE2,
-		KGDB_DYN_BRK_INS_BYTE3,
+		KGDB_DYN_BRK_INS_BYTE(0),
+		KGDB_DYN_BRK_INS_BYTE(1),
+		KGDB_DYN_BRK_INS_BYTE(2),
+		KGDB_DYN_BRK_INS_BYTE(3),
 	}
 };
-- 
1.7.10.4
