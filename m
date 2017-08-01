From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  1 Aug 2017 09:02:56 +0100
Subject: [PATCH v2 3/4] jump_label: Provide hotplug context variants
In-Reply-To: <20170801080257.5056-1-marc.zyngier@arm.com>
References: <20170801080257.5056-1-marc.zyngier@arm.com>
Message-ID: <20170801080257.5056-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As using the normal static key API under the hotplug lock is
pretty much impossible, let's provide a variant of some of them
that require the hotplug lock to have already been taken.

These function are only meant to be used in CPU hotplug callbacks.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/static-keys.txt | 15 +++++++++++++++
 include/linux/jump_label.h    | 11 +++++++++--
 kernel/jump_label.c           | 20 ++++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/static-keys.txt b/Documentation/static-keys.txt
index b83dfa1c0602..6d0a181e74d2 100644
--- a/Documentation/static-keys.txt
+++ b/Documentation/static-keys.txt
@@ -149,6 +149,21 @@ static_branch_inc(), will change the branch back to true. Likewise, if the
 key is initialized false, a 'static_branch_inc()', will change the branch to
 true. And then a 'static_branch_dec()', will again make the branch false.
 
+Note that switching branches results in some locks being taken,
+particularly the CPU hotplug lock (in order to avoid races against
+CPUs being brought in the kernel whilst the kernel is getting
+patched). Calling the static key API from within a hotplug notifier is
+thus a sure deadlock recipe. In order to still allow use of the
+functionnality, the following functions are provided:
+
+	static_key_enable_cpuslocked()
+	static_key_disable_cpuslocked()
+	static_branch_enable_cpuslocked()
+	static_branch_disable_cpuslocked()
+
+These functions are *not* general purpose, and must only be used when
+you really know that you're in the above context, and no other.
+
 Where an array of keys is required, it can be defined as::
 
 	DEFINE_STATIC_KEY_ARRAY_TRUE(keys, count);
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2afd74b9d844..c5e5d2ffce58 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -163,6 +163,8 @@ extern void jump_label_apply_nops(struct module *mod);
 extern int static_key_count(struct static_key *key);
 extern void static_key_enable(struct static_key *key);
 extern void static_key_disable(struct static_key *key);
+extern void static_key_enable_cpuslocked(struct static_key *key);
+extern void static_key_disable_cpuslocked(struct static_key *key);
 
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
@@ -252,6 +254,9 @@ static inline void static_key_disable(struct static_key *key)
 		static_key_slow_dec(key);
 }
 
+#define static_key_enable_cpuslocked(k)		static_key_enable((k))
+#define static_key_disable_cpuslocked(k)	static_key_disable((k))
+
 #define STATIC_KEY_INIT_TRUE	{ .enabled = ATOMIC_INIT(1) }
 #define STATIC_KEY_INIT_FALSE	{ .enabled = ATOMIC_INIT(0) }
 
@@ -413,8 +418,10 @@ extern bool ____wrong_branch_error(void);
  * Normal usage; boolean enable/disable.
  */
 
-#define static_branch_enable(x)		static_key_enable(&(x)->key)
-#define static_branch_disable(x)	static_key_disable(&(x)->key)
+#define static_branch_enable(x)			static_key_enable(&(x)->key)
+#define static_branch_disable(x)		static_key_disable(&(x)->key)
+#define static_branch_enable_cpuslocked(x)	static_key_enable_cpuslocked(&(x)->key)
+#define static_branch_disable_cpuslocked(x)	static_key_disable_cpuslocked(&(x)->key)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 0ab8b35daa54..4e7fa067ca17 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -170,6 +170,26 @@ static void static_key_slow_dec_cpuslocked(struct static_key *key,
 	jump_label_unlock();
 }
 
+void static_key_enable_cpuslocked(struct static_key *key)
+{
+	int count = static_key_count(key);
+
+	WARN_ON_ONCE(count < 0 || count > 1);
+
+	if (!count)
+		static_key_slow_inc_cpuslocked(key);
+}
+
+void static_key_disable_cpuslocked(struct static_key *key)
+{
+	int count = static_key_count(key);
+
+	WARN_ON_ONCE(count < 0 || count > 1);
+
+	if (count)
+		static_key_slow_dec_cpuslocked(key, 0, NULL);
+}
+
 static void __static_key_slow_dec(struct static_key *key,
 				  unsigned long rate_limit,
 				  struct delayed_work *work)
-- 
2.11.0
