From: liuj97@gmail.com (Jiang Liu)
Date: Sun, 13 Oct 2013 22:50:24 +0800
Subject: [PATCH v2 4/7] arm64: introduce aarch64_insn_gen_{nop|branch_imm}()
 helper functions
In-Reply-To: <1381675827-1610-1-git-send-email-liuj97@gmail.com>
References: <1381675827-1610-1-git-send-email-liuj97@gmail.com>
Message-ID: <1381675827-1610-5-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

Introduce aarch64_insn_gen_{nop|branch_imm}() helper functions, which
will be used to implement jump label on ARM64.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/arm64/include/asm/insn.h |  7 +++++++
 arch/arm64/kernel/insn.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 8dc0a91..87c44b2 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -61,6 +61,13 @@ __AARCH64_INSN_FUNCS(nop,	0xFFFFFFFF, 0xD503201F)
 enum aarch64_insn_class aarch64_get_insn_class(u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 				  u32 insn, u64 imm);
+u32 aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
+				bool link);
+static __always_inline u32 aarch64_insn_gen_nop(void)
+{
+	return aarch64_insn_get_nop_value();
+}
+
 u32 aarch64_insn_read(void *addr);
 void aarch64_insn_write(void *addr, u32 insn);
 bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index a0f60cc..66211bb 100644
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
@@ -261,3 +262,29 @@ u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 
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
+	 * instruction. A64 instructions may be word-aligned.
+	 */
+	BUG_ON((pc & 0x3) || (addr & 0x3));
+
+	/* B/BR support [-128M, 128M) offset */
+	offset = ((long)addr - (long)pc) >> 2;
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
