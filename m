From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 21 Sep 2016 16:19:55 +0900
Subject: [PATCH v2] arm64: kgdb: handle read-only text / modules
Message-ID: <20160921071955.21792-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle read-only cases (CONFIG_DEBUG_RODATA/CONFIG_DEBUG_SET_MODULE_RONX)
by using aarch64_insn_write() instead of probe_kernel_write().
See how this works:
    commit 2f896d586610 ("arm64: use fixmap for text patching")

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: <stable@vger.kernel.org> # 3.18-3.19: 2f896d5: arm64: use fixmap
Cc: <stable@vger.kernel.org> # 4.0-
---
 arch/arm64/include/asm/debug-monitors.h |  2 --
 arch/arm64/kernel/kgdb.c                | 36 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 4b6b3f7..b71420a 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -61,8 +61,6 @@
 
 #define AARCH64_BREAK_KGDB_DYN_DBG	\
 	(AARCH64_BREAK_MON | (KGDB_DYN_DBG_BRK_IMM << 5))
-#define KGDB_DYN_BRK_INS_BYTE(x)	\
-	((AARCH64_BREAK_KGDB_DYN_DBG >> (8 * (x))) & 0xff)
 
 #define CACHE_FLUSH_IS_SAFE		1
 
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 6732a27..b06a7a2 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/bug.h>
 #include <linux/cpumask.h>
 #include <linux/irq.h>
 #include <linux/irq_work.h>
@@ -26,6 +27,8 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 #include <linux/percpu.h>
+#include <asm/debug-monitors.h>
+#include <asm/insn.h>
 #include <asm/ptrace.h>
 #include <asm/traps.h>
 
@@ -370,15 +373,24 @@ void kgdb_arch_exit(void)
 	unregister_die_notifier(&kgdb_notifier);
 }
 
-/*
- * ARM instructions are always in LE.
- * Break instruction is encoded in LE format
- */
-struct kgdb_arch arch_kgdb_ops = {
-	.gdb_bpt_instr = {
-		KGDB_DYN_BRK_INS_BYTE(0),
-		KGDB_DYN_BRK_INS_BYTE(1),
-		KGDB_DYN_BRK_INS_BYTE(2),
-		KGDB_DYN_BRK_INS_BYTE(3),
-	}
-};
+struct kgdb_arch arch_kgdb_ops;
+
+int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
+{
+	int err;
+
+	BUILD_BUG_ON(AARCH64_INSN_SIZE != BREAK_INSTR_SIZE);
+
+	err = aarch64_insn_read((void *)bpt->bpt_addr, (u32 *)bpt->saved_instr);
+	if (err)
+		return err;
+
+	return aarch64_insn_write((void *)bpt->bpt_addr,
+			(u32)AARCH64_BREAK_KGDB_DYN_DBG);
+}
+
+int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
+{
+	return aarch64_insn_write((void *)bpt->bpt_addr,
+			*(u32 *)bpt->saved_instr);
+}
-- 
2.10.0
