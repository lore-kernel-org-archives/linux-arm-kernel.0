From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Wed, 14 Nov 2018 13:59:35 +0100
Subject: [PATCH 09/16] staging: vchiq_core: do not initialize semaphores twice
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
Message-ID: <20181114125942.25163-10-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vchiq_init_state() initialises a series of semaphores to then call
remote_event_create() on the same semaphores, which initializes them
again. We get rid of the second initialization.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c    | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index dee5ea7bfe4f..8b23ea5322e8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -418,12 +418,11 @@ vchiq_set_conn_state(VCHIQ_STATE_T *state, VCHIQ_CONNSTATE_T newstate)
 }
 
 static inline void
-remote_event_create(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
+remote_event_create(REMOTE_EVENT_T *event)
 {
 	event->armed = 0;
 	/* Don't clear the 'fired' flag because it may already have been set
 	** by the other side. */
-	sema_init((struct semaphore *)((char *)state + event->event), 0);
 }
 
 static inline int
@@ -2237,18 +2236,18 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 	state->data_quota = state->slot_queue_available - 1;
 
 	local->trigger.event = offsetof(VCHIQ_STATE_T, trigger_event);
-	remote_event_create(state, &local->trigger);
+	remote_event_create(&local->trigger);
 	local->tx_pos = 0;
 
 	local->recycle.event = offsetof(VCHIQ_STATE_T, recycle_event);
-	remote_event_create(state, &local->recycle);
+	remote_event_create(&local->recycle);
 	local->slot_queue_recycle = state->slot_queue_available;
 
 	local->sync_trigger.event = offsetof(VCHIQ_STATE_T, sync_trigger_event);
-	remote_event_create(state, &local->sync_trigger);
+	remote_event_create(&local->sync_trigger);
 
 	local->sync_release.event = offsetof(VCHIQ_STATE_T, sync_release_event);
-	remote_event_create(state, &local->sync_release);
+	remote_event_create(&local->sync_release);
 
 	/* At start-of-day, the slot is empty and available */
 	((VCHIQ_HEADER_T *)SLOT_DATA_FROM_INDEX(state, local->slot_sync))->msgid
-- 
2.19.1
