From: bigeasy@linutronix.de (Sebastian Siewior)
Date: Tue, 25 Apr 2017 19:28:38 +0200
Subject: [patch V2 00/24] cpu/hotplug: Convert get_online_cpus() to a
 percpu_rwsem
In-Reply-To: <20170425161037.GA27156@leverpostej>
References: <20170418170442.665445272@linutronix.de>
 <20170425161037.GA27156@leverpostej>
Message-ID: <20170425172838.mr3kyccsdteyjso5@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-04-25 17:10:37 [+0100], Mark Rutland wrote:
> Hi,
Hi,

> When we bring the secondary CPU online, we detect an erratum that wasn't
> present on the boot CPU, and try to enable a static branch we use to
> track the erratum. The call to static_branch_enable() blows up as above.

this (cpus_set_cap()) seems only to be used used in CPU up part.

> I see that we now have static_branch_disable_cpuslocked(), but we don't
> have an equivalent for enable. I'm not sure what we should be doing
> here.

We should introduce static_branch_enable_cpuslocked(). Does this work
for you (after s/static_branch_enable/static_branch_enable_cpuslocked/
in cpus_set_cap()) ?:

>From fe004351e4649da037d5165247e89ab976fe4a26 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 25 Apr 2017 18:43:00 +0200
Subject: [PATCH] jump_label: Provide
 static_key_[enable|/slow_inc]_cpuslocked()

Provide static_key_[enable|slow_inc]_cpuslocked() variant that
don't take cpu_hotplug_lock().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/jump_label.h |  7 +++++++
 kernel/jump_label.c        | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index d7b17d1ab875..c80d8b1279b5 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -164,6 +164,7 @@ extern void static_key_slow_dec_cpuslocked(struct static_key *key);
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
@@ -429,6 +435,7 @@ extern bool ____wrong_branch_error(void);
  */
 
 #define static_branch_enable(x)			static_key_enable(&(x)->key)
+#define static_branch_enable_cpuslocked(x)	static_key_enable_cpuslocked(&(x)->key)
 #define static_branch_disable(x)		static_key_disable(&(x)->key)
 #define static_branch_disable_cpuslocked(x)	static_key_disable_cpuslocked(&(x)->key)
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d71124ee3b14..6343f4c7e27f 100644
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
2.11.0

> Thanks,
> Mark.

Sebastian
