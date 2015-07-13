From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 13 Jul 2015 14:25:52 +0100
Subject: [PATCH v2 05/10] arm64/debug: More consistent naming for the BRK ESR
 template macro
In-Reply-To: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1436793967-7138-6-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The naming of DBG_ESR_VAL_BRK is inconsistent with the way other
similar macros are named.

This patch makes the naming more consistent, and appends "64"
as a reminder that this ESR pattern only matches from AArch64
state.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |    5 +++--
 arch/arm64/kernel/kgdb.c                |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index ff09058..bb97e9d 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -46,8 +46,9 @@
 /*
  * ESR values expected for dynamic and compile time BRK instruction
  */
-#define DBG_ESR_VAL_BRK(x) \
-	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL | ((x) & 0xffff))
+#define ESR_ELx_VAL_BRK64(imm)					\
+	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL |	\
+	 ((imm) & 0xffff))
 
 /*
  * #imm16 values used for BRK instruction generation
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index a0d10c5..a5a838e 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -235,13 +235,13 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 
 static struct break_hook kgdb_brkpt_hook = {
 	.esr_mask	= 0xffffffff,
-	.esr_val	= DBG_ESR_VAL_BRK(KGDB_DYN_DBG_BRK_IMM),
+	.esr_val	= ESR_ELx_VAL_BRK64(KGDB_DYN_DBG_BRK_IMM),
 	.fn		= kgdb_brk_fn
 };
 
 static struct break_hook kgdb_compiled_brkpt_hook = {
 	.esr_mask	= 0xffffffff,
-	.esr_val	= DBG_ESR_VAL_BRK(KGDB_COMPILED_DBG_BRK_IMM),
+	.esr_val	= ESR_ELx_VAL_BRK64(KGDB_COMPILED_DBG_BRK_IMM),
 	.fn		= kgdb_compiled_brk_fn
 };
 
-- 
1.7.10.4
