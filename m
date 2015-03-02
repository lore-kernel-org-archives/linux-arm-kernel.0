From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:05 +0800
Subject: [RFC PATCH v4 27/34] early kprobes on ftrace:
 kprobe_on_ftrace_get_old_insn()
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-28-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newly introduced function kprobe_on_ftrace_get_old_insn() will be
called by ftrace when ftrace generating call instruction. It is for
retriving probed instructions which original nops are replaced by
kprobe. FTRACE_FL_EARLY_KPROBES bit in rec->flags is cleared, so after
calling kprobe_on_ftrace_get_old_insn() an ftrace record will not be
treated as early kprobed.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/kprobes.h |  9 +++++++++
 kernel/kprobes.c        | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 5a5290f..2d78bbb 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -289,6 +289,8 @@ extern const unsigned char *arch_kprobe_on_ftrace_get_old_insn(struct kprobe *kp
 
 extern void init_kprobes_on_ftrace(void);
 extern bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *rec);
+extern const unsigned char *kprobe_on_ftrace_get_old_insn(struct dyn_ftrace *rec,
+		const unsigned char *ftrace_nop, unsigned char *dest, size_t insn_size);
 #else
 static inline void init_kprobes_on_ftrace(void)
 {
@@ -299,6 +301,13 @@ static inline bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *_unused)
 
 	return false;
 }
+
+static inline const unsigned char *
+kprobe_on_ftrace_get_old_insn(struct dyn_ftrace *_unused,
+		const unsigned char *ftrace_nop, unsigned char *_unused2, size_t _unused3)
+{
+	return ftrace_nop;
+}
 #endif // CONFIG_EARLY_KPROBES && CONFIG_KPROBES_ON_FTRACE
 
 #ifdef CONFIG_EARLY_KPROBES
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 20b6ab8..c504c1c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2623,6 +2623,40 @@ bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *rec)
 	return true;
 }
 
+/* NOTE: caller must ensure holding kprobe_mutex */
+const unsigned char *
+kprobe_on_ftrace_get_old_insn(struct dyn_ftrace *rec,
+		const unsigned char *ftrace_nop,
+		unsigned char *dest, size_t insn_size)
+{
+	const unsigned char *ret;
+	struct kprobe *kp;
+	void *addr;
+
+	if (!(rec->flags & FTRACE_FL_EARLY_KPROBES))
+		return ftrace_nop;
+
+	addr = (void *)rec->ip;
+
+	/*
+	 * Note that get_kprobe always get the kprobe on table, for it
+	 * KPROBE_FLAG_OPTIMIZED is reliable.
+	 */
+	kp = get_kprobe(addr);
+
+	if (!kp || !(kp->flags & KPROBE_FLAG_FTRACE_EARLY)) {
+		mutex_unlock(&kprobe_mutex);
+		return ftrace_nop;
+	}
+
+	ret = arch_kprobe_on_ftrace_get_old_insn(kp, ftrace_nop,
+			dest, insn_size);
+
+	/* Only give one chance for kprobe to retrive old insn. */
+	rec->flags &= ~FTRACE_FL_EARLY_KPROBES;
+	return ret;
+}
+
 void init_kprobes_on_ftrace(void)
 {
 	kprobes_on_ftrace_initialized = true;
-- 
1.8.4
