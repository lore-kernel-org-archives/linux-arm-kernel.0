From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 3 Mar 2015 13:09:03 +0800
Subject: [PATCH 1/3] early kprobes: make kprobes_on_ftrace_initialized public
 available.
In-Reply-To: <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
 <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425359345-38714-2-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That var is useful for x86 recover_probed_instruction() for recovering
ftraced instructions, to make it possible to determine whether the
instruction has been converted to nop by ftrace.

I will merge this patch into next version of early kprobe series.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/kprobes.h | 3 +++
 kernel/kprobes.c        | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 2d78bbb..24eac73 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -288,6 +288,8 @@ extern const unsigned char *arch_kprobe_on_ftrace_get_old_insn(struct kprobe *kp
 		const unsigned char *ftrace_nop, unsigned char *dest, size_t insn_size);
 
 extern void init_kprobes_on_ftrace(void);
+extern bool kprobes_on_ftrace_initialized __read_mostly;
+
 extern bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *rec);
 extern const unsigned char *kprobe_on_ftrace_get_old_insn(struct dyn_ftrace *rec,
 		const unsigned char *ftrace_nop, unsigned char *dest, size_t insn_size);
@@ -295,6 +297,7 @@ extern const unsigned char *kprobe_on_ftrace_get_old_insn(struct dyn_ftrace *rec
 static inline void init_kprobes_on_ftrace(void)
 {
 }
+#define kprobes_on_ftrace_initialized	true
 
 static inline bool kprobe_fix_ftrace_make_nop(struct dyn_ftrace *_unused)
 {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1ec8e6e..2d4e671 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -70,9 +70,7 @@
 static int kprobes_initialized;
 static int kprobes_blacklist_initialized;
 #if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
-static bool kprobes_on_ftrace_initialized __read_mostly = false;
-#else
-# define kprobes_on_ftrace_initialized	false
+bool kprobes_on_ftrace_initialized __read_mostly = false;
 #endif
 
 bool kprobes_is_early(void)
-- 
1.8.4
