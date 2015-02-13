From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:41:20 +0800
Subject: [RFC PATCH v3 26/26] kprobes: enable 'ekprobe=' cmdline option for
 early kprobes.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806080-62562-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch shows a very rough usage of arly kprobes. By adding
kernel cmdline options such as 'ekprobe=__alloc_pages_nodemask' or
'ekprobe=0xc00f3c2c', early kprobes are installed. When the probed
instructions get hit, a message is printed.

This patch is only a sample. I'll drop it in future

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index edac74b..278b2511 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2835,10 +2835,81 @@ convert_early_kprobes(void)
 		free_aggr_kprobe(&op->kp);
 	}
 };
+
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
+	err = register_kprobe(kp);
+	if (err) {
+		pr_err("early kprobe: register early kprobe %s failed\n", p);
+		ek_free_early_kprobe_setup(kp);
+	}
+	return 0;
+}
 #else
 static inline int register_early_kprobe(struct kprobe *p) { return -ENOSYS; }
 static inline void convert_early_kprobes(void)
 {
 	kprobes_initialized = 1;
 }
+
+static int __init early_kprobe_setup(char *p)
+{
+	return 0;
+}
 #endif
+
+early_param("ekprobe", early_kprobe_setup);
-- 
1.8.4
