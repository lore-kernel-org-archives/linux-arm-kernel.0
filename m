From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 21 Jan 2015 17:36:05 -0800
Subject: [PATCHv8 1/2] arm64: use fixmap for text patching
In-Reply-To: <1421890566-29883-1-git-send-email-lauraa@codeaurora.org>
References: <1421890566-29883-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1421890566-29883-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kernel text is marked as read only, it cannot be modified directly.
Use a fixmap to modify the text instead in a similar manner to
x86 and arm.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
v8: Included some headers and added BUG_ON for !page case
---
 arch/arm64/include/asm/fixmap.h |  1 +
 arch/arm64/kernel/insn.c        | 47 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 9ef6eca..defa0ff9 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -49,6 +49,7 @@ enum fixed_addresses {
 
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
+	FIX_TEXT_POKE0,
 	__end_of_fixed_addresses
 };
 
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 7e9327a..27d4864 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -17,14 +17,19 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/spinlock.h>
 #include <linux/stop_machine.h>
+#include <linux/types.h>
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
 #include <asm/debug-monitors.h>
+#include <asm/fixmap.h>
 #include <asm/insn.h>
 
 #define AARCH64_INSN_SF_BIT	BIT(31)
@@ -72,6 +77,29 @@ bool __kprobes aarch64_insn_is_nop(u32 insn)
 	}
 }
 
+static DEFINE_SPINLOCK(patch_lock);
+
+static void __kprobes *patch_map(void *addr, int fixmap)
+{
+	unsigned long uintaddr = (uintptr_t) addr;
+	bool module = !core_kernel_text(uintaddr);
+	struct page *page;
+
+	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
+		page = vmalloc_to_page(addr);
+	else
+		page = virt_to_page(addr);
+
+	BUG_ON(!page);
+	set_fixmap(fixmap, page_to_phys(page));
+
+	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
+}
+
+static void __kprobes patch_unmap(int fixmap)
+{
+	clear_fixmap(fixmap);
+}
 /*
  * In ARMv8-A, A64 instructions have a fixed length of 32 bits and are always
  * little-endian.
@@ -88,10 +116,27 @@ int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
 	return ret;
 }
 
+static int __kprobes __aarch64_insn_write(void *addr, u32 insn)
+{
+	void *waddr = addr;
+	unsigned long flags = 0;
+	int ret;
+
+	spin_lock_irqsave(&patch_lock, flags);
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
+
+	patch_unmap(FIX_TEXT_POKE0);
+	spin_unlock_irqrestore(&patch_lock, flags);
+
+	return ret;
+}
+
 int __kprobes aarch64_insn_write(void *addr, u32 insn)
 {
 	insn = cpu_to_le32(insn);
-	return probe_kernel_write(addr, &insn, AARCH64_INSN_SIZE);
+	return __aarch64_insn_write(addr, insn);
 }
 
 static bool __kprobes __aarch64_insn_hotpatch_safe(u32 insn)
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
