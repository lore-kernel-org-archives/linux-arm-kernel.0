From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:45 +0800
Subject: [RFC PATCH v4 07/34] early kprobes: init kprobes at very early stage.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-8-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate init_kprobes() into early and late phases, and do most of
initialization after setup_arch(), so we are able to use kprobes at
very early stage.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/kprobes.h |  6 ++++++
 init/main.c             |  2 ++
 kernel/kprobes.c        | 39 ++++++++++++++++++++++++++-------------
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index a3de759..b7cb992 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -491,8 +491,14 @@ static unsigned long __used				\
 	__attribute__((section("_kprobe_blacklist")))	\
 	_kbl_addr_##fname = (unsigned long)fname;
 #define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)
+
+extern void init_kprobes_early(void);
+
 #else
 #define NOKPROBE_SYMBOL(fname)
+
+static inline void init_kprobes_early(void) { return; }
+
 #endif
 
 #endif /* _LINUX_KPROBES_H */
diff --git a/init/main.c b/init/main.c
index 6f0f1c5f..679d49e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -80,6 +80,7 @@
 #include <linux/list.h>
 #include <linux/integrity.h>
 #include <linux/proc_ns.h>
+#include <linux/kprobes.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -518,6 +519,7 @@ asmlinkage __visible void __init start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
+	init_kprobes_early();
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2e728a4..614138c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1521,6 +1521,11 @@ int register_kprobe(struct kprobe *p)
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
 
+#ifndef CONFIG_EARLY_KPROBES
+	if (kprobes_is_early())
+		return -EAGAIN;
+#endif
+
 	/* Adjust probe address from symbol */
 	addr = kprobe_addr(p);
 	if (IS_ERR(addr))
@@ -2161,11 +2166,7 @@ static struct notifier_block kprobe_module_nb = {
 	.priority = 0
 };
 
-/* Markers of _kprobe_blacklist section */
-extern unsigned long __start_kprobe_blacklist[];
-extern unsigned long __stop_kprobe_blacklist[];
-
-static int __init init_kprobes(void)
+void init_kprobes_early(void)
 {
 	int i, err = 0;
 
@@ -2177,14 +2178,6 @@ static int __init init_kprobes(void)
 		raw_spin_lock_init(&(kretprobe_table_locks[i].lock));
 	}
 
-	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
-					__stop_kprobe_blacklist);
-	if (err) {
-		pr_err("kprobes: failed to populate blacklist: %d\n", err);
-		pr_err("Please take care of using kprobes.\n");
-	}
-	kprobes_blacklist_initialized = (err == 0);
-
 	if (kretprobe_blacklist_size) {
 		/* lookup the function address from its name */
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
@@ -2215,6 +2208,26 @@ static int __init init_kprobes(void)
 		err = register_module_notifier(&kprobe_module_nb);
 
 	kprobes_initialized = (err == 0);
+}
+
+static int __init init_kprobes(void)
+{
+	/* Markers of _kprobe_blacklist section */
+	extern unsigned long __start_kprobe_blacklist[];
+	extern unsigned long __stop_kprobe_blacklist[];
+	int err = 0;
+
+	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
+					__stop_kprobe_blacklist);
+	if (err) {
+		pr_err("kprobes: failed to populate blacklist: %d\n", err);
+		pr_err("Please take care of using kprobes.\n");
+	}
+	kprobes_blacklist_initialized = (err == 0);
+
+	err = kprobes_is_early() ? -ENOSYS : 0;
+
+	/* TODO: deal with early kprobes. */
 
 	if (!err)
 		init_test_probes();
-- 
1.8.4
