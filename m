From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 20 Aug 2014 18:20:38 -0700
Subject: [PATCHv3 6/7] arm64: use fixmap for text patching when text is RO
In-Reply-To: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1408584039-12735-7-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kernel text is marked as read only, it cannot be modified directly.
Use a fixmap to modify the text instead in a similar manner to
x86 and arm.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
I think there were some questions on spinlocks for the arm version, not
sure if similar concerns apply here.
---
 arch/arm64/include/asm/fixmap.h |  1 +
 arch/arm64/include/asm/insn.h   |  2 ++
 arch/arm64/kernel/insn.c        | 74 +++++++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/jump_label.c  |  2 +-
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index db26a2f2..2cd4b0d 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -48,6 +48,7 @@ enum fixed_addresses {
 
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
+	FIX_TEXT_POKE0,
 	__end_of_fixed_addresses
 };
 
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index dc1f73b..07ac29b 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -92,6 +92,7 @@ bool aarch64_insn_is_nop(u32 insn);
 
 int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
+int aarch64_insn_write_early(void *addr, u32 insn);
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 				  u32 insn, u64 imm);
@@ -103,6 +104,7 @@ u32 aarch64_insn_gen_nop(void);
 bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
+int __aarch64_insn_patch_text_nosync(void *addr, u32 insn, bool early);
 int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 92f3683..b25f8db 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -17,10 +17,13 @@
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/spinlock.h>
 #include <linux/stop_machine.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/fixmap.h>
 #include <asm/insn.h>
 
 static int aarch64_insn_encoding_class[] = {
@@ -65,6 +68,36 @@ bool __kprobes aarch64_insn_is_nop(u32 insn)
 	}
 }
 
+static DEFINE_SPINLOCK(patch_lock);
+
+static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
+{
+	unsigned long uintaddr = (uintptr_t) addr;
+	bool module = !core_kernel_text(uintaddr);
+	struct page *page;
+
+	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
+		page = vmalloc_to_page(addr);
+	else if (!module && IS_ENABLED(CONFIG_DEBUG_RODATA))
+		page = virt_to_page(addr);
+	else
+		return addr;
+
+	if (flags)
+		spin_lock_irqsave(&patch_lock, *flags);
+
+	set_fixmap(fixmap, page_to_phys(page));
+
+	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
+}
+
+static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
+{
+	clear_fixmap(fixmap);
+
+	if (flags)
+		spin_unlock_irqrestore(&patch_lock, *flags);
+}
 /*
  * In ARMv8-A, A64 instructions have a fixed length of 32 bits and are always
  * little-endian.
@@ -81,10 +114,36 @@ int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
 	return ret;
 }
 
+static int __kprobes __aarch64_insn_write(void *addr, u32 insn, bool patch)
+{
+	void *waddr = addr;
+	unsigned long flags;
+	int ret;
+
+	if (patch)
+		waddr = patch_map(addr, FIX_TEXT_POKE0, &flags);
+
+	ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
+
+	if (waddr != addr) {
+		__flush_dcache_area(waddr, AARCH64_INSN_SIZE);
+		patch_unmap(FIX_TEXT_POKE0, &flags);
+	}
+
+	return ret;
+}
+
 int __kprobes aarch64_insn_write(void *addr, u32 insn)
 {
 	insn = cpu_to_le32(insn);
-	return probe_kernel_write(addr, &insn, AARCH64_INSN_SIZE);
+	return __aarch64_insn_write(addr, insn, true);
+}
+
+int __kprobes aarch64_insn_write_early(void *addr, u32 insn)
+{
+	insn = cpu_to_le32(insn);
+	return __aarch64_insn_write(addr, insn, false);
+
 }
 
 static bool __kprobes __aarch64_insn_hotpatch_safe(u32 insn)
@@ -117,7 +176,7 @@ bool __kprobes aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn)
 	       __aarch64_insn_hotpatch_safe(new_insn);
 }
 
-int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
+int __kprobes __aarch64_insn_patch_text_nosync(void *addr, u32 insn, bool early)
 {
 	u32 *tp = addr;
 	int ret;
@@ -126,7 +185,11 @@ int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 	if ((uintptr_t)tp & 0x3)
 		return -EINVAL;
 
-	ret = aarch64_insn_write(tp, insn);
+	if (early)
+		ret = aarch64_insn_write_early(tp, insn);
+	else
+		ret = aarch64_insn_write(tp, insn);
+
 	if (ret == 0)
 		flush_icache_range((uintptr_t)tp,
 				   (uintptr_t)tp + AARCH64_INSN_SIZE);
@@ -134,6 +197,11 @@ int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 	return ret;
 }
 
+int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
+{
+	return __aarch64_insn_patch_text_nosync(addr, insn, false);
+}
+
 struct aarch64_insn_patch {
 	void		**text_addrs;
 	u32		*new_insns;
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index 263a166..9ac30bb 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -38,7 +38,7 @@ static void __arch_jump_label_transform(struct jump_entry *entry,
 	}
 
 	if (is_static)
-		aarch64_insn_patch_text_nosync(addr, insn);
+		__aarch64_insn_patch_text_nosync(addr, insn, true);
 	else
 		aarch64_insn_patch_text(&addr, &insn, 1);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
