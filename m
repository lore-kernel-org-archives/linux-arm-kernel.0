From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  1 Aug 2017 09:02:54 +0100
Subject: [PATCH v2 1/4] jump_label: Move cpu hotplug locking
In-Reply-To: <20170801080257.5056-1-marc.zyngier@arm.com>
References: <20170801080257.5056-1-marc.zyngier@arm.com>
Message-ID: <20170801080257.5056-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to rework the locking, let's move the taking and
release of the CPU hotplug lock to locations that will make its
reworking completely obvious.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/jump_label.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d11c506a6ac3..f11b10091100 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -105,6 +105,7 @@ void static_key_slow_inc(struct static_key *key)
 {
 	int v, v1;
 
+	cpus_read_lock();
 	STATIC_KEY_CHECK_USE();
 
 	/*
@@ -121,11 +122,12 @@ void static_key_slow_inc(struct static_key *key)
 	 */
 	for (v = atomic_read(&key->enabled); v > 0; v = v1) {
 		v1 = atomic_cmpxchg(&key->enabled, v, v + 1);
-		if (likely(v1 == v))
+		if (likely(v1 == v)) {
+			cpus_read_unlock();
 			return;
+		}
 	}
 
-	cpus_read_lock();
 	jump_label_lock();
 	if (atomic_read(&key->enabled) == 0) {
 		atomic_set(&key->enabled, -1);
-- 
2.11.0
