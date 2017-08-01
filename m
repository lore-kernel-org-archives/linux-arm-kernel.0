From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  1 Aug 2017 09:02:55 +0100
Subject: [PATCH v2 2/4] jump_label: Split out code under the hotplug lock
In-Reply-To: <20170801080257.5056-1-marc.zyngier@arm.com>
References: <20170801080257.5056-1-marc.zyngier@arm.com>
Message-ID: <20170801080257.5056-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to later introduce an "already locked" version of some
of the static key funcions, let's split the code into the core stuff
(the *_cpuslocked functions) and the usual helpers, which now
take/release the hotplug lock and call into the _cpuslocked
versions.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/jump_label.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index f11b10091100..0ab8b35daa54 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -101,11 +101,10 @@ void static_key_disable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-void static_key_slow_inc(struct static_key *key)
+static void static_key_slow_inc_cpuslocked(struct static_key *key)
 {
 	int v, v1;
 
-	cpus_read_lock();
 	STATIC_KEY_CHECK_USE();
 
 	/*
@@ -122,10 +121,8 @@ void static_key_slow_inc(struct static_key *key)
 	 */
 	for (v = atomic_read(&key->enabled); v > 0; v = v1) {
 		v1 = atomic_cmpxchg(&key->enabled, v, v + 1);
-		if (likely(v1 == v)) {
-			cpus_read_unlock();
+		if (likely(v1 == v))
 			return;
-		}
 	}
 
 	jump_label_lock();
@@ -137,14 +134,20 @@ void static_key_slow_inc(struct static_key *key)
 		atomic_inc(&key->enabled);
 	}
 	jump_label_unlock();
+}
+
+void static_key_slow_inc(struct static_key *key)
+{
+	cpus_read_lock();
+	static_key_slow_inc_cpuslocked(key);
 	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(static_key_slow_inc);
 
-static void __static_key_slow_dec(struct static_key *key,
-		unsigned long rate_limit, struct delayed_work *work)
+static void static_key_slow_dec_cpuslocked(struct static_key *key,
+					   unsigned long rate_limit,
+					   struct delayed_work *work)
 {
-	cpus_read_lock();
 	/*
 	 * The negative count check is valid even when a negative
 	 * key->enabled is in use by static_key_slow_inc(); a
@@ -155,7 +158,6 @@ static void __static_key_slow_dec(struct static_key *key,
 	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
 		WARN(atomic_read(&key->enabled) < 0,
 		     "jump label: negative count!\n");
-		cpus_read_unlock();
 		return;
 	}
 
@@ -166,6 +168,14 @@ static void __static_key_slow_dec(struct static_key *key,
 		jump_label_update(key);
 	}
 	jump_label_unlock();
+}
+
+static void __static_key_slow_dec(struct static_key *key,
+				  unsigned long rate_limit,
+				  struct delayed_work *work)
+{
+	cpus_read_lock();
+	static_key_slow_dec_cpuslocked(key, rate_limit, work);
 	cpus_read_unlock();
 }
 
-- 
2.11.0
