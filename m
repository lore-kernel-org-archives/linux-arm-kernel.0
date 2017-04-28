From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Apr 2017 12:01:05 +0100
Subject: [PATCHv3 1/2] jump_label: Provide
 static_key_[enable|/slow_inc]_cpuslocked()
In-Reply-To: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
References: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1493377266-2205-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Provide static_key_[enable|slow_inc]_cpuslocked() variant that
don't take cpu_hotplug_lock().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: jbaron at akamai.com
---
 include/linux/jump_label.h |  7 +++++++
 kernel/jump_label.c        | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index d7b17d1..c80d8b1 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -164,6 +164,7 @@ extern void arch_jump_label_transform_static(struct jump_entry *entry,
 extern void jump_label_apply_nops(struct module *mod);
 extern int static_key_count(struct static_key *key);
 extern void static_key_enable(struct static_key *key);
+extern void static_key_enable_cpuslocked(struct static_key *key);
 extern void static_key_disable(struct static_key *key);
 extern void static_key_disable_cpuslocked(struct static_key *key);
 
@@ -252,6 +253,11 @@ static inline void static_key_enable(struct static_key *key)
 		static_key_slow_inc(key);
 }
 
+static inline void static_key_enable_cpuslocked(struct static_key *key)
+{
+	static_key_enable(key);
+}
+
 static inline void static_key_disable(struct static_key *key)
 {
 	int count = static_key_count(key);
@@ -429,6 +435,7 @@ struct static_key_false {
  */
 
 #define static_branch_enable(x)			static_key_enable(&(x)->key)
+#define static_branch_enable_cpuslocked(x)	static_key_enable_cpuslocked(&(x)->key)
 #define static_branch_disable(x)		static_key_disable(&(x)->key)
 #define static_branch_disable_cpuslocked(x)	static_key_disable_cpuslocked(&(x)->key)
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d71124e..6343f4c 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -90,6 +90,16 @@ void static_key_enable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_enable);
 
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
 void static_key_disable(struct static_key *key)
 {
 	int count = static_key_count(key);
-- 
1.9.1
