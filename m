From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:44 +0800
Subject: [RFC PATCH v3 11/26] early kprobes: introduce kprobe_is_early for
 futher early kprobe use.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806044-61946-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following early kprobe patches will enable kprobe registering very
early, even before kprobe system initialized. kprobe_is_early() can be
used to check whether we are working on early kprobe.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 include/linux/kprobes.h | 2 ++
 kernel/kprobes.c        | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1ab5475..e1c8307 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -50,6 +50,8 @@
 #define KPROBE_REENTER		0x00000004
 #define KPROBE_HIT_SSDONE	0x00000008
 
+extern int kprobes_is_early(void);
+
 #else /* CONFIG_KPROBES */
 typedef int kprobe_opcode_t;
 struct arch_specific_insn {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c90e417..647c95a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -68,6 +68,12 @@
 #endif
 
 static int kprobes_initialized;
+
+int kprobes_is_early(void)
+{
+	return !kprobes_initialized;
+}
+
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
-- 
1.8.4
