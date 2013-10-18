From: liuj97@gmail.com (Jiang Liu)
Date: Fri, 18 Oct 2013 23:19:56 +0800
Subject: [PATCH v5 2/7] arm64: introduce interfaces to hotpatch kernel and
 module code
In-Reply-To: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
References: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
Message-ID: <1382109602-27432-3-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

Introduce three interfaces to patch kernel and module code:
aarch64_insn_patch_text_nosync():
	patch code without synchronization, it's caller's responsibility
	to synchronize all CPUs if needed.
aarch64_insn_patch_text_sync():
	patch code and always synchronize with stop_machine()
aarch64_insn_patch_text():
	patch code and synchronize with stop_machine() if needed

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/arm64/include/asm/insn.h | 19 ++++++++-
 arch/arm64/kernel/insn.c      | 91 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 7499490..7a69491 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -71,8 +71,25 @@ enum aarch64_insn_hint_op {
 
 bool aarch64_insn_is_nop(u32 insn);
 
-enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
+/*
+ * In ARMv8-A, A64 instructions have a fixed length of 32 bits and are always
+ * little-endian.
+ */
+static __always_inline u32 aarch64_insn_read(void *addr)
+{
+	return le32_to_cpu(*(u32 *)addr);
+}
 
+static __always_inline void aarch64_insn_write(void *addr, u32 insn)
+{
+	*(u32 *)addr = cpu_to_le32(insn);
+}
+
+enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 
+int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
+int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
+int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
+
 #endif	/* __ASM_INSN_H */
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index f5b779f..3879db4 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -16,6 +16,9 @@
  */
 #include <linux/compiler.h>
 #include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/stop_machine.h>
+#include <asm/cacheflush.h>
 #include <asm/insn.h>
 
 static int aarch64_insn_encoding_class[] = {
@@ -88,3 +91,91 @@ bool __kprobes aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn)
 	return __aarch64_insn_hotpatch_safe(old_insn) &&
 	       __aarch64_insn_hotpatch_safe(new_insn);
 }
+
+int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
+{
+	u32 *tp = addr;
+
+	/* A64 instructions must be word aligned */
+	if ((uintptr_t)tp & 0x3)
+		return -EINVAL;
+
+	aarch64_insn_write(tp, insn);
+	flush_icache_range((uintptr_t)tp, (uintptr_t)tp + sizeof(u32));
+
+	return 0;
+}
+
+struct aarch64_insn_patch {
+	void	**text_addrs;
+	u32	*new_insns;
+	int	insn_cnt;
+};
+
+static DEFINE_MUTEX(text_patch_lock);
+static atomic_t text_patch_id;
+
+static int __kprobes aarch64_insn_patch_text_cb(void *arg)
+{
+	int i, ret = 0;
+	struct aarch64_insn_patch *pp = arg;
+
+	if (atomic_read(&text_patch_id) == smp_processor_id()) {
+		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
+			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
+							     pp->new_insns[i]);
+		/* Let other CPU continue */
+		atomic_set(&text_patch_id, -1);
+	} else {
+		while (atomic_read(&text_patch_id) != -1)
+			cpu_relax();
+		isb();
+	}
+
+	return ret;
+}
+
+int __kprobes aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt)
+{
+	int ret;
+	struct aarch64_insn_patch patch = {
+		.text_addrs = addrs,
+		.new_insns = insns,
+		.insn_cnt = cnt,
+	};
+
+	if (cnt <= 0)
+		return -EINVAL;
+
+	mutex_lock(&text_patch_lock);
+	atomic_set(&text_patch_id, smp_processor_id());
+	ret = stop_machine(aarch64_insn_patch_text_cb, &patch, cpu_online_mask);
+	mutex_unlock(&text_patch_lock);
+
+	return ret;
+}
+
+int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
+{
+	int ret;
+	bool safe = false;
+
+	if (cnt == 1)
+		safe = aarch64_insn_hotpatch_safe(aarch64_insn_read(addrs[0]),
+						  insns[0]);
+
+	if (safe) {
+		/*
+		 * ARMv8 architecture doesn't guarantee all CPUs see the new
+		 * instruction after returning from function
+		 * aarch64_insn_patch_text_nosync(). So send a IPI to all other
+		 * CPUs to achieve instruction synchronization.
+		 */
+		ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
+		kick_all_cpus_sync();
+	} else {
+		ret = aarch64_insn_patch_text_sync(addrs, insns, cnt);
+	}
+
+	return ret;
+}
-- 
1.8.1.2
