From: liuj97@gmail.com (Jiang Liu)
Date: Wed, 25 Sep 2013 18:44:24 +0800
Subject: [PATCH v1 4/7] arm64: introduce aarch64_insn_gen_{nop|branch_imm}()
 helper functions
In-Reply-To: <1380105868-31985-1-git-send-email-liuj97@gmail.com>
References: <1380105868-31985-1-git-send-email-liuj97@gmail.com>
Message-ID: <1380105868-31985-5-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

Introduce aarch64_insn_gen_{nop|branch_imm}() helper functions, which
will be used to implement jump label on ARM64.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/arm64/include/asm/insn.h |  6 ++++++
 arch/arm64/kernel/insn.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 0c715c1..28470bc 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -61,6 +61,12 @@ __AARCH64_INSN_FUNCS(nop,	0xFFFFFFFF, 0xD503201F)
 enum aarch64_insn_class aarch64_get_insn_class(u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 				  u32 insn, u64 imm);
+u32 aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
+				bool link);
+static __always_inline u32 aarch64_insn_gen_nop(void)
+{
+	return aarch64_insn_get_nop_value();
+}
 
 bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 int aarch64_insn_patch_text(void *addr, u32 *insns, int cnt);
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 0bae0d9..a96e3a1 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -14,6 +14,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
@@ -210,3 +211,28 @@ u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 
 	return insn;
 }
+
+u32 aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr, bool link)
+{
+	u32 insn;
+	long offset;
+
+	/*
+	 * PC: A 64-bit Program Counter holding the address of the current
+	 * instruction.
+	 */
+	BUG_ON((pc & 0x3) || (addr & 0x3));
+	offset = ((long)addr - (long)pc) >> 2;
+	/* B/BR support [-128M, 128M) offset */
+	if (offset >= BIT(25) || abs(offset) > BIT(25)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	if (link)
+		insn = aarch64_insn_get_bl_value();
+	else
+		insn = aarch64_insn_get_b_value();
+
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_26, insn, offset);
+}
-- 
1.8.1.2
