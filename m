From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:25:10 +0800
Subject: [RFC PATCH v4 32/34] early kprobes: enable 'ekprobe=' cmdline option
 for early kprobes.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-33-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch shows a very rough usage of arly kprobes. By adding
kernel cmdline options such as 'ekprobe=__alloc_pages_nodemask' or
'ekprobe=0xc00f3c2c', early kprobes are installed. When the probed
instructions get hit, a message is printed.

This patch is only a sample. I'll drop it in future.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 95754f6..56fb8c8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2224,9 +2224,12 @@ static struct notifier_block kprobe_module_nb = {
 	.priority = 0
 };
 
+static LIST_HEAD(cmdline_early_kprobes_list);
+
 void init_kprobes_early(void)
 {
 	int i, err = 0;
+	struct kprobe *early_kp, *tmp;
 
 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
@@ -2270,6 +2273,16 @@ void init_kprobes_early(void)
 	if (!err)
 		init_test_probes();
 #endif
+
+	list_for_each_entry_safe(early_kp, tmp, &cmdline_early_kprobes_list, list) {
+		int ret;
+
+		list_del(&early_kp->list);
+		INIT_LIST_HEAD(&early_kp->list);
+		ret = register_kprobe(early_kp);
+		printk("early kprobe: register early kprobe at %p: result = %d\n",
+				early_kp->addr, ret);
+	}
 }
 
 static int __init init_kprobes(void)
@@ -2724,3 +2737,74 @@ void init_kprobes_on_ftrace(void)
 	convert_early_kprobes_on_ftrace();
 }
 #endif
+
+#ifdef CONFIG_EARLY_KPROBES
+static int early_kprobe_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	const char *sym = NULL;
+	char *modname, namebuf[KSYM_NAME_LEN];
+	unsigned long offset = 0;
+
+	sym = kallsyms_lookup((unsigned long)p->addr, NULL,
+			&offset, &modname, namebuf);
+	if (sym)
+		pr_info("Hit early kprobe at %s+0x%lx%s%s\n",
+				sym, offset,
+				(modname ? " " : ""),
+				(modname ? modname : ""));
+	else
+		pr_info("Hit early kprobe at %p\n", p->addr);
+	return 0;
+}
+
+DEFINE_EKPROBE_ALLOC_OPS(struct kprobe, early_kprobe_setup, static);
+static int __init early_kprobe_setup(char *p)
+{
+	unsigned long long addr;
+	struct kprobe *kp;
+	int len = strlen(p);
+	int err;
+
+	if (len <= 0) {
+		pr_err("early kprobe: wrong param: %s\n", p);
+		return 0;
+	}
+
+	if ((p[0] == '0') && (p[1] == 'x')) {
+		err = kstrtoull(p, 16, &addr);
+		if (err) {
+			pr_err("early kprobe: wrong address: %p\n", p);
+			return 0;
+		}
+	} else {
+		addr = kallsyms_lookup_name(p);
+		if (!addr) {
+			pr_err("early kprobe: wrong symbol: %s\n", p);
+			return 0;
+		}
+	}
+
+	if ((addr < (unsigned long)_text) ||
+			(addr >= (unsigned long)_etext))
+		pr_err("early kprobe: address of %p out of range\n", p);
+
+	kp = ek_alloc_early_kprobe_setup();
+	if (kp == NULL) {
+		pr_err("early kprobe: no enough early kprobe slot\n");
+		return 0;
+	}
+	kp->addr = (void *)(unsigned long)(addr);
+	kp->pre_handler = early_kprobe_pre_handler;
+
+	list_add(&kp->list, &cmdline_early_kprobes_list);
+
+	return 0;
+}
+#else
+static int __init early_kprobe_setup(char *p)
+{
+	return 0;
+}
+#endif
+
+early_param("ekprobe", early_kprobe_setup);
-- 
1.8.4
