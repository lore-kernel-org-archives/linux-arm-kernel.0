From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Jul 2017 10:37:25 +0100
Subject: [PATCH 1/2] jump_label: Introduce a _nolock version of the static key
 API
In-Reply-To: <20170727093726.30266-1-marc.zyngier@arm.com>
References: <20170727093726.30266-1-marc.zyngier@arm.com>
Message-ID: <20170727093726.30266-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since f2545b2d4ce1 ("jump_label: Reorder hotplug lock and jump_label_lock"),
flipping a static key from within a CPU hotplug callback results in
an unpleasant deadlock, as we try to take the cpu_hotplug_lock
which is already held by the CPU hotplug framework. On the secondary
boot path, calling cpus_read_lock leads to the scheduler exploding
badly...

As a workaround, introduce a *_nolock version of the static key API,
which doesn't try to acquire the lock. This is quite fragile, and
use of this API should be discouraged as much as possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/static-keys.txt | 19 ++++++++++
 include/linux/jump_label.h    | 12 +++++++
 kernel/jump_label.c           | 82 +++++++++++++++++++++++++++++++++++--------
 3 files changed, 98 insertions(+), 15 deletions(-)

diff --git a/Documentation/static-keys.txt b/Documentation/static-keys.txt
index b83dfa1c0602..72398635cf6f 100644
--- a/Documentation/static-keys.txt
+++ b/Documentation/static-keys.txt
@@ -149,6 +149,25 @@ static_branch_inc(), will change the branch back to true. Likewise, if the
 key is initialized false, a 'static_branch_inc()', will change the branch to
 true. And then a 'static_branch_dec()', will again make the branch false.
 
+Note that switching branches results in some locks being taken,
+particularly the CPU hotplug lock (in order to avoid races against
+CPUs being brought in the kernel whilst the kernel is getting
+patched). Calling the static key API from within a hotplug notifier is
+thus a sure deadlock recipe. In order to still allow use of the
+functionnality, the following functions are provided:
+
+	static_key_slow_inc_nolock()
+	static_key_slow_dec_nolock()
+	static_key_enable_nolock()
+	static_key_disable_nolock()
+	static_branch_inc_nolock()
+	static_branch_dec_nolock()
+	static_branch_enable_nolock()
+	static_branch_disable_nolock()
+
+These functions are *not* general purpose, and must only be used when
+you really know that you're in the above context, and no other.
+
 Where an array of keys is required, it can be defined as::
 
 	DEFINE_STATIC_KEY_ARRAY_TRUE(keys, count);
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2afd74b9d844..fbb594e60b8e 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -159,10 +159,14 @@ extern void arch_jump_label_transform_static(struct jump_entry *entry,
 extern int jump_label_text_reserved(void *start, void *end);
 extern void static_key_slow_inc(struct static_key *key);
 extern void static_key_slow_dec(struct static_key *key);
+extern void static_key_slow_inc_nolock(struct static_key *key);
+extern void static_key_slow_dec_nolock(struct static_key *key);
 extern void jump_label_apply_nops(struct module *mod);
 extern int static_key_count(struct static_key *key);
 extern void static_key_enable(struct static_key *key);
 extern void static_key_disable(struct static_key *key);
+extern void static_key_enable_nolock(struct static_key *key);
+extern void static_key_disable_nolock(struct static_key *key);
 
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
@@ -213,12 +217,16 @@ static inline void static_key_slow_inc(struct static_key *key)
 	atomic_inc(&key->enabled);
 }
 
+#define static_key_slow_inc_nolock(k)	static_key_slow_inc((k))
+
 static inline void static_key_slow_dec(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE();
 	atomic_dec(&key->enabled);
 }
 
+#define static_key_slow_dec_nolock(k)	static_key_slow_inc((k))
+
 static inline int jump_label_text_reserved(void *start, void *end)
 {
 	return 0;
@@ -408,6 +416,8 @@ extern bool ____wrong_branch_error(void);
 
 #define static_branch_inc(x)		static_key_slow_inc(&(x)->key)
 #define static_branch_dec(x)		static_key_slow_dec(&(x)->key)
+#define static_branch_inc_nolock(x)	static_key_slow_inc_nolock(&(x)->key)
+#define static_branch_dec_nolock(x)	static_key_slow_dec_nolock(&(x)->key)
 
 /*
  * Normal usage; boolean enable/disable.
@@ -415,6 +425,8 @@ extern bool ____wrong_branch_error(void);
 
 #define static_branch_enable(x)		static_key_enable(&(x)->key)
 #define static_branch_disable(x)	static_key_disable(&(x)->key)
+#define static_branch_enable_nolock(x)	static_key_enable_nolock(&(x)->key)
+#define static_branch_disable_nolock(x)	static_key_disable_nolock(&(x)->key)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d11c506a6ac3..87df22c074a7 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -57,6 +57,11 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 }
 
 static void jump_label_update(struct static_key *key);
+static void static_key_slow_inc_with_lock(struct static_key *key, bool lock);
+static void __static_key_slow_dec_with_lock(struct static_key *key,
+					    bool lock,
+					    unsigned long rate_limit,
+					    struct delayed_work *work);
 
 /*
  * There are similar definitions for the !HAVE_JUMP_LABEL case in jump_label.h.
@@ -79,29 +84,51 @@ int static_key_count(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_count);
 
-void static_key_enable(struct static_key *key)
+static void static_key_enable_with_lock(struct static_key *key, bool lock)
 {
 	int count = static_key_count(key);
 
 	WARN_ON_ONCE(count < 0 || count > 1);
 
 	if (!count)
-		static_key_slow_inc(key);
+		static_key_slow_inc_with_lock(key, lock);
+}
+
+void static_key_enable(struct static_key *key)
+{
+	static_key_enable_with_lock(key, true);
 }
 EXPORT_SYMBOL_GPL(static_key_enable);
 
-void static_key_disable(struct static_key *key)
+void static_key_enable_nolock(struct static_key *key)
+{
+	static_key_enable_with_lock(key, false);
+}
+EXPORT_SYMBOL_GPL(static_key_enable_nolock);
+
+static void static_key_disable_with_lock(struct static_key *key, bool lock)
 {
 	int count = static_key_count(key);
 
 	WARN_ON_ONCE(count < 0 || count > 1);
 
 	if (count)
-		static_key_slow_dec(key);
+		__static_key_slow_dec_with_lock(key, lock, 0, NULL);
+}
+
+void static_key_disable(struct static_key *key)
+{
+	static_key_disable_with_lock(key, true);
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-void static_key_slow_inc(struct static_key *key)
+void static_key_disable_nolock(struct static_key *key)
+{
+	static_key_disable_with_lock(key, false);
+}
+EXPORT_SYMBOL_GPL(static_key_disable_nolock);
+
+static void static_key_slow_inc_with_lock(struct static_key *key, bool lock)
 {
 	int v, v1;
 
@@ -125,7 +152,8 @@ void static_key_slow_inc(struct static_key *key)
 			return;
 	}
 
-	cpus_read_lock();
+	if (lock)
+		cpus_read_lock();
 	jump_label_lock();
 	if (atomic_read(&key->enabled) == 0) {
 		atomic_set(&key->enabled, -1);
@@ -135,14 +163,29 @@ void static_key_slow_inc(struct static_key *key)
 		atomic_inc(&key->enabled);
 	}
 	jump_label_unlock();
-	cpus_read_unlock();
+	if (lock)
+		cpus_read_unlock();
+}
+
+void static_key_slow_inc(struct static_key *key)
+{
+	static_key_slow_inc_with_lock(key, true);
 }
 EXPORT_SYMBOL_GPL(static_key_slow_inc);
 
-static void __static_key_slow_dec(struct static_key *key,
-		unsigned long rate_limit, struct delayed_work *work)
+void static_key_slow_inc_nolock(struct static_key *key)
 {
-	cpus_read_lock();
+	static_key_slow_inc_with_lock(key, false);
+}
+EXPORT_SYMBOL_GPL(static_key_slow_inc_nolock);
+
+static void __static_key_slow_dec_with_lock(struct static_key *key,
+					    bool lock,
+					    unsigned long rate_limit,
+					    struct delayed_work *work)
+{
+	if (lock)
+		cpus_read_lock();
 	/*
 	 * The negative count check is valid even when a negative
 	 * key->enabled is in use by static_key_slow_inc(); a
@@ -153,7 +196,8 @@ static void __static_key_slow_dec(struct static_key *key,
 	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
 		WARN(atomic_read(&key->enabled) < 0,
 		     "jump label: negative count!\n");
-		cpus_read_unlock();
+		if (lock)
+			cpus_read_unlock();
 		return;
 	}
 
@@ -164,27 +208,35 @@ static void __static_key_slow_dec(struct static_key *key,
 		jump_label_update(key);
 	}
 	jump_label_unlock();
-	cpus_read_unlock();
+	if (lock)
+		cpus_read_unlock();
 }
 
 static void jump_label_update_timeout(struct work_struct *work)
 {
 	struct static_key_deferred *key =
 		container_of(work, struct static_key_deferred, work.work);
-	__static_key_slow_dec(&key->key, 0, NULL);
+	__static_key_slow_dec_with_lock(&key->key, true, 0, NULL);
 }
 
 void static_key_slow_dec(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE();
-	__static_key_slow_dec(key, 0, NULL);
+	__static_key_slow_dec_with_lock(key, true, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(static_key_slow_dec);
 
+void static_key_slow_dec_nolock(struct static_key *key)
+{
+	STATIC_KEY_CHECK_USE();
+	__static_key_slow_dec_with_lock(key, false, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(static_key_slow_dec_nolock);
+
 void static_key_slow_dec_deferred(struct static_key_deferred *key)
 {
 	STATIC_KEY_CHECK_USE();
-	__static_key_slow_dec(&key->key, key->timeout, &key->work);
+	__static_key_slow_dec_with_lock(&key->key, true, key->timeout, &key->work);
 }
 EXPORT_SYMBOL_GPL(static_key_slow_dec_deferred);
 
-- 
2.11.0
