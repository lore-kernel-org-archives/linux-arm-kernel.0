From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:42 +0800
Subject: [RFC PATCH v4 04/34] early kprobes: within_kprobe_blacklist_early()
 early.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-5-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces within_kprobe_blacklist_early(), which will be
used when registering early kprobes.

In init_kprobes(), populate_kprobe_blacklist() is the only function
which rely on memory system so unable to be executed at very early
stage. Following patches will move other parts of init_kprobes() to
early stage and leave populate_kprobe_blacklist() at its original
position. Before populate_kprobe_blacklist(), within_kprobe_blacklist_early()
can be used for checking blacklist.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c90e417..427d761 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -68,6 +68,7 @@
 #endif
 
 static int kprobes_initialized;
+static int kprobes_blacklist_initialized;
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
@@ -1332,12 +1333,41 @@ bool __weak arch_within_kprobe_blacklist(unsigned long addr)
 	       addr < (unsigned long)__kprobes_text_end;
 }
 
+
+static bool within_kprobe_blacklist_early(unsigned long addr)
+{
+	/* Markers of _kprobe_blacklist section */
+	extern unsigned long __start_kprobe_blacklist[];
+	extern unsigned long __stop_kprobe_blacklist[];
+
+	unsigned long *start = __start_kprobe_blacklist;
+	unsigned long *end = __stop_kprobe_blacklist;
+	unsigned long *iter;
+	unsigned long entry, offset = 0, size = 0;
+
+	for (iter = start; iter < end; iter++) {
+		entry = arch_deref_entry_point((void *)*iter);
+
+		if (!kernel_text_address(entry) ||
+		    !kallsyms_lookup_size_offset(entry, &size, &offset))
+			continue;
+		if (addr >= entry && addr < entry + size)
+			return true;
+	}
+
+	return false;
+}
+
 static bool within_kprobe_blacklist(unsigned long addr)
 {
 	struct kprobe_blacklist_entry *ent;
 
 	if (arch_within_kprobe_blacklist(addr))
 		return true;
+
+	if (!kprobes_blacklist_initialized)
+		return within_kprobe_blacklist_early(addr);
+
 	/*
 	 * If there exists a kprobe_blacklist, verify and
 	 * fail any probe registration in the prohibited area
@@ -2147,6 +2177,7 @@ static int __init init_kprobes(void)
 		pr_err("kprobes: failed to populate blacklist: %d\n", err);
 		pr_err("Please take care of using kprobes.\n");
 	}
+	kprobes_blacklist_initialized = (err == 0);
 
 	if (kretprobe_blacklist_size) {
 		/* lookup the function address from its name */
-- 
1.8.4
