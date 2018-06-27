From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 27 Jun 2018 18:06:00 +0200
Subject: [PATCH 1/5] kernel/jump_label: abstract jump_entry member accessors
In-Reply-To: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
Message-ID: <20180627160604.8154-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of allowing architectures to use relative references
in jump_label entries [which can dramatically reduce the memory
footprint], introduce abstractions for references to the 'code' and
'key' members of struct jump_entry.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/jump_label.h | 36 ++++++++++++++++++++
 kernel/jump_label.c        | 36 ++++++++------------
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b46b541c67c4..86ec0652d3b1 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -119,6 +119,42 @@ struct static_key {
 
 #ifdef HAVE_JUMP_LABEL
 #include <asm/jump_label.h>
+
+#ifndef __ASSEMBLY__
+
+struct jump_entry; /* defined by the architecture */
+
+static inline unsigned long jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline unsigned long jump_entry_target(const struct jump_entry *entry)
+{
+	return entry->target;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#endif
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..c3524c9b3004 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -38,10 +38,12 @@ static int jump_label_cmp(const void *a, const void *b)
 	const struct jump_entry *jea = a;
 	const struct jump_entry *jeb = b;
 
-	if (jea->key < jeb->key)
+	if ((unsigned long)jump_entry_key(jea) <
+	    (unsigned long)jump_entry_key(jeb))
 		return -1;
 
-	if (jea->key > jeb->key)
+	if ((unsigned long)jump_entry_key(jea) >
+	    (unsigned long)jump_entry_key(jeb))
 		return 1;
 
 	return 0;
@@ -261,8 +263,8 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit);
 
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
-	if (entry->code <= (unsigned long)end &&
-		entry->code + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	if (jump_entry_code(entry) <= (unsigned long)end &&
+	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
 		return 1;
 
 	return 0;
@@ -321,16 +323,6 @@ static inline void static_key_set_linked(struct static_key *key)
 	key->type |= JUMP_TYPE_LINKED;
 }
 
-static inline struct static_key *jump_entry_key(struct jump_entry *entry)
-{
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
-}
-
-static bool jump_entry_branch(struct jump_entry *entry)
-{
-	return (unsigned long)entry->key & 1UL;
-}
-
 /***
  * A 'struct static_key' uses a union such that it either points directly
  * to a table of 'struct jump_entry' or to a linked list of modules which in
@@ -355,7 +347,7 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool enabled = static_key_enabled(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return enabled ^ branch;
@@ -370,8 +362,8 @@ static void __jump_label_update(struct static_key *key,
 		 * An entry->code of 0 indicates an entry which has been
 		 * disabled because it was in an init text area.
 		 */
-		if (entry->code) {
-			if (kernel_text_address(entry->code))
+		if (!jump_entry_is_module_init(entry)) {
+			if (kernel_text_address(jump_entry_code(entry)))
 				arch_jump_label_transform(entry, jump_label_type(entry));
 			else
 				WARN_ONCE(1, "can't patch jump_label at %pS",
@@ -441,7 +433,7 @@ static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool type = static_key_type(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return type ^ branch;
@@ -565,7 +557,7 @@ static int jump_label_add_module(struct module *mod)
 			continue;
 
 		key = iterk;
-		if (within_module(iter->key, mod)) {
+		if (within_module((unsigned long)key, mod)) {
 			static_key_set_entries(key, iter);
 			continue;
 		}
@@ -615,7 +607,7 @@ static void jump_label_del_module(struct module *mod)
 
 		key = jump_entry_key(iter);
 
-		if (within_module(iter->key, mod))
+		if (within_module((unsigned long)key, mod))
 			continue;
 
 		/* No memory during module load */
@@ -659,8 +651,8 @@ static void jump_label_invalidate_module_init(struct module *mod)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (within_module_init(iter->code, mod))
-			iter->code = 0;
+		if (within_module_init(jump_entry_code(iter), mod))
+			jump_entry_set_module_init(iter);
 	}
 }
 
-- 
2.11.0
