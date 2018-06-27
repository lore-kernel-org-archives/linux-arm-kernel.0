From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 27 Jun 2018 18:06:01 +0200
Subject: [PATCH 2/5] kernel/jump_label: implement generic support for relative
 references
In-Reply-To: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
Message-ID: <20180627160604.8154-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To reduce the size taken up by absolute references in jump label
entries themselves and the associated relocation records in the
.init segment, add support for emitting them as 32-bit relative
references instead.

Note that this requires some extra care in the sorting routine, given
that the offsets change when entries are moved around in the jump_entry
table.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig               |  3 +++
 include/linux/jump_label.h | 28 ++++++++++++++++++++
 kernel/jump_label.c        | 20 +++++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2b8b70820002..22fa3792626e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -348,6 +348,9 @@ config HAVE_PERF_USER_STACK_DUMP
 config HAVE_ARCH_JUMP_LABEL
 	bool
 
+config HAVE_ARCH_JUMP_LABEL_RELATIVE
+	bool
+
 config HAVE_RCU_TABLE_FREE
 	bool
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 86ec0652d3b1..aa203dffe72c 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -121,6 +121,32 @@ struct static_key {
 #include <asm/jump_label.h>
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
+
+struct jump_entry {
+	int code;
+	int target;
+	int key;
+};
+
+static inline unsigned long jump_entry_code(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->code + entry->code;
+}
+
+static inline unsigned long jump_entry_target(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->target + entry->target;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	unsigned long key = (unsigned long)&entry->key + entry->key;
+
+	return (struct static_key *)(key & ~1UL);
+}
+
+#else
 
 struct jump_entry; /* defined by the architecture */
 
@@ -139,6 +165,8 @@ static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 	return (struct static_key *)((unsigned long)entry->key & ~1UL);
 }
 
+#endif
+
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
 {
 	return (unsigned long)entry->key & 1UL;
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index c3524c9b3004..285eff13ecd1 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -49,6 +49,22 @@ static int jump_label_cmp(const void *a, const void *b)
 	return 0;
 }
 
+static void jump_label_swap(void *a, void *b, int size)
+{
+	long delta = (unsigned long)a - (unsigned long)b;
+	struct jump_entry *jea = a;
+	struct jump_entry *jeb = b;
+	struct jump_entry tmp = *jea;
+
+	jea->code	= jeb->code - delta;
+	jea->target	= jeb->target - delta;
+	jea->key	= jeb->key - delta;
+
+	jeb->code	= tmp.code + delta;
+	jeb->target	= tmp.target + delta;
+	jeb->key	= tmp.key + delta;
+}
+
 static void
 jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 {
@@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 
 	size = (((unsigned long)stop - (unsigned long)start)
 					/ sizeof(struct jump_entry));
-	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
+	sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
+	     IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
+							      : NULL);
 }
 
 static void jump_label_update(struct static_key *key);
-- 
2.11.0
