From: james.morse@arm.com (James Morse)
Date: Wed,  1 Nov 2017 15:59:41 +0000
Subject: [PATCH 15/13] firmware: arm_sdei: move the frozen flag under the
 spinlock
In-Reply-To: <20171017174432.1684-1-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
Message-ID: <20171101155941.19432-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dpm_suspend() calls the freeze/thaw callbacks for hibernate before
disable_non_bootcpus() takes down secondaries.

This leads to a fun race where the freeze/thaw callbacks reset the
SDEI interface (as we may be restoring a kernel with a different
layout due to KASLR), then the cpu-hotplug callbacks come in to
save the current state, which has already been reset.

We solve this with a 'frozen' flag that stops the hotplug callback
from overwriting the saved values.

This patch moves the flag under the 'events' spinlock we take
in the hotplug callbacks, to avoid depending on cpu-hotplug's
mechanics to ensure the callback sees the correct value.

Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 14b6d170518c..0ae497975064 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -78,7 +78,10 @@ struct sdei_event {
 static LIST_HEAD(sdei_events);
 static DEFINE_SPINLOCK(sdei_events_lock);
 
-/* When frozen, cpu-hotplug notifiers shouldn't unregister/re-register events */
+/*
+ * When frozen, cpu-hotplug notifiers shouldn't unregister/re-register events.
+ * Protected by sdei_events_lock.
+ */
 static bool frozen;
 
 /* Private events are registered/enabled via IPI passing one of these */
@@ -704,13 +707,15 @@ static int sdei_cpuhp_down(unsigned int cpu)
 	struct sdei_event *event;
 	struct sdei_crosscall_args arg;
 
+
+	spin_lock(&sdei_events_lock);
 	if (frozen) {
 		/* All events unregistered  */
+		spin_unlock(&sdei_events_lock);
 		return sdei_mask_local_cpu();
 	}
 
 	/* un-register private events */
-	spin_lock(&sdei_events_lock);
 	list_for_each_entry(event, &sdei_events, list) {
 		if (event->type == SDEI_EVENT_TYPE_SHARED)
 			continue;
@@ -732,13 +737,14 @@ static int sdei_cpuhp_up(unsigned int cpu)
 	struct sdei_event *event;
 	struct sdei_crosscall_args arg;
 
+	spin_lock(&sdei_events_lock);
 	if (frozen) {
 		/* Events will be re-registered when we thaw. */
+		spin_unlock(&sdei_events_lock);
 		return sdei_unmask_local_cpu();
 	}
 
 	/* re-register/enable private events */
-	spin_lock(&sdei_events_lock);
 	list_for_each_entry(event, &sdei_events, list) {
 		if (event->type == SDEI_EVENT_TYPE_SHARED)
 			continue;
@@ -813,7 +819,10 @@ static int sdei_device_freeze(struct device *dev)
 {
 	int err;
 
+	spin_lock(&sdei_events_lock);
 	frozen = true;
+	spin_unlock(&sdei_events_lock);
+
 	err = sdei_event_unregister_all();
 	if (err)
 		return err;
@@ -828,7 +837,11 @@ static int sdei_device_thaw(struct device *dev)
 	sdei_device_resume(dev);
 
 	err = sdei_reregister_events();
+
+	spin_lock(&sdei_events_lock);
 	frozen = false;
+	spin_unlock(&sdei_events_lock);
+
 	return err;
 }
 
@@ -865,7 +878,9 @@ static int sdei_reboot_notifier(struct notifier_block *nb, unsigned long action,
 	 * There is now no point trying to unregister private events if we go on
 	 * to take CPUs offline.
 	 */
+	spin_lock(&sdei_events_lock);
 	frozen = true;
+	spin_unlock(&sdei_events_lock);
 
 	return NOTIFY_OK;
 }
-- 
2.15.0.rc2
