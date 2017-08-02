From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 2 Aug 2017 16:37:48 +0200
Subject: [PATCH v2 3/4] jump_label: Provide hotplug context variants
In-Reply-To: <20170801080257.5056-4-marc.zyngier@arm.com>
References: <20170801080257.5056-1-marc.zyngier@arm.com>
 <20170801080257.5056-4-marc.zyngier@arm.com>
Message-ID: <20170802143748.dmthd3hvbq5pbelt@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 09:02:56AM +0100, Marc Zyngier wrote:
> As using the normal static key API under the hotplug lock is
> pretty much impossible, let's provide a variant of some of them
> that require the hotplug lock to have already been taken.
> 
> These function are only meant to be used in CPU hotplug callbacks.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/static-keys.txt | 15 +++++++++++++++
>  include/linux/jump_label.h    | 11 +++++++++--
>  kernel/jump_label.c           | 20 ++++++++++++++++++++
>  3 files changed, 44 insertions(+), 2 deletions(-)

I stuffed them in my locking/core branch on top of Paolo's patches:

  https://lkml.kernel.org/r/1501601046-35683-1-git-send-email-pbonzini at redhat.com

This patch now looks like so.

---
Subject: jump_label: Provide hotplug context variants
From:   Marc Zyngier <marc.zyngier@arm.com>
Date: Tue, 1 Aug 2017 09:02:56 +0100

As using the normal static key API under the hotplug lock is
pretty much impossible, let's provide a variant of some of them
that require the hotplug lock to have already been taken.

These function are only meant to be used in CPU hotplug callbacks.

Cc: linux-arm-kernel at lists.infradead.org
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170801080257.5056-4-marc.zyngier at arm.com
---
 Documentation/static-keys.txt |   15 +++++++++++++++
 include/linux/jump_label.h    |   11 +++++++++--
 kernel/jump_label.c           |   22 ++++++++++++++++++----
 3 files changed, 42 insertions(+), 6 deletions(-)

--- a/Documentation/static-keys.txt
+++ b/Documentation/static-keys.txt
@@ -154,6 +154,21 @@ and 'static_key_count()'.  In general, i
 should be protected with the same mutex used around the enable/disable
 or increment/decrement function.
 
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
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -163,6 +163,8 @@ extern void jump_label_apply_nops(struct
 extern int static_key_count(struct static_key *key);
 extern void static_key_enable(struct static_key *key);
 extern void static_key_disable(struct static_key *key);
+extern void static_key_enable_cpuslocked(struct static_key *key);
+extern void static_key_disable_cpuslocked(struct static_key *key);
 
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
@@ -254,6 +256,9 @@ static inline void static_key_disable(st
 	atomic_set(&key->enabled, 0);
 }
 
+#define static_key_enable_cpuslocked(k)		static_key_enable((k))
+#define static_key_disable_cpuslocked(k)	static_key_disable((k))
+
 #define STATIC_KEY_INIT_TRUE	{ .enabled = ATOMIC_INIT(1) }
 #define STATIC_KEY_INIT_FALSE	{ .enabled = ATOMIC_INIT(0) }
 
@@ -415,8 +420,10 @@ extern bool ____wrong_branch_error(void)
  * Normal usage; boolean enable/disable.
  */
 
-#define static_branch_enable(x)		static_key_enable(&(x)->key)
-#define static_branch_disable(x)	static_key_disable(&(x)->key)
+#define static_branch_enable(x)			static_key_enable(&(x)->key)
+#define static_branch_disable(x)		static_key_disable(&(x)->key)
+#define static_branch_enable_cpuslocked(x)	static_key_enable_cpuslocked(&(x)->key)
+#define static_branch_disable_cpuslocked(x)	static_key_disable_cpuslocked(&(x)->key)
 
 #endif /* __ASSEMBLY__ */
 
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -126,15 +126,15 @@ void static_key_slow_inc(struct static_k
 }
 EXPORT_SYMBOL_GPL(static_key_slow_inc);
 
-void static_key_enable(struct static_key *key)
+void static_key_enable_cpuslocked(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE();
+
 	if (atomic_read(&key->enabled) > 0) {
 		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
 		return;
 	}
 
-	cpus_read_lock();
 	jump_label_lock();
 	if (atomic_read(&key->enabled) == 0) {
 		atomic_set(&key->enabled, -1);
@@ -145,23 +145,37 @@ void static_key_enable(struct static_key
 		atomic_set_release(&key->enabled, 1);
 	}
 	jump_label_unlock();
+}
+EXPORT_SYMBOL_GPL(static_key_enable_cpuslocked);
+
+void static_key_enable(struct static_key *key)
+{
+	cpus_read_lock();
+	static_key_enable_cpuslocked(key);
 	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(static_key_enable);
 
-void static_key_disable(struct static_key *key)
+void static_key_disable_cpuslocked(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE();
+
 	if (atomic_read(&key->enabled) != 1) {
 		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
 		return;
 	}
 
-	cpus_read_lock();
 	jump_label_lock();
 	if (atomic_cmpxchg(&key->enabled, 1, 0))
 		jump_label_update(key);
 	jump_label_unlock();
+}
+EXPORT_SYMBOL_GPL(static_key_disable_cpuslocked);
+
+void static_key_disable(struct static_key *key)
+{
+	cpus_read_lock();
+	static_key_disable_cpuslocked(key);
 	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
