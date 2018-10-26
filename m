From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Fri, 26 Oct 2018 15:48:04 +0200
Subject: [PATCH RFC 09/18] staging: vchiq_core: do not initialize semaphores
 twice
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
Message-ID: <20181026134813.7775-10-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vchiq_init_state() initialises a series of semaphores to then call
remote_event_create() on the same semaphores, which initializes them
again.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index dee5ea7bfe4f..6242357735b9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2200,11 +2200,6 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 
 	sema_init(&state->connect, 0);
 	mutex_init(&state->mutex);
-	sema_init(&state->trigger_event, 0);
-	sema_init(&state->recycle_event, 0);
-	sema_init(&state->sync_trigger_event, 0);
-	sema_init(&state->sync_release_event, 0);
-
 	mutex_init(&state->slot_mutex);
 	mutex_init(&state->recycle_mutex);
 	mutex_init(&state->sync_mutex);
-- 
2.19.1
