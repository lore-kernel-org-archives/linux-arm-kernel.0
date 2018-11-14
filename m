From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Wed, 14 Nov 2018 13:59:36 +0100
Subject: [PATCH 10/16] staging: vchiq_core: don't add a wmb() before
 remote_event_signal()
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
Message-ID: <20181114125942.25163-11-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's the first thing remote_event_signal() does.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 8b23ea5322e8..5791c2b670fa 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1137,9 +1137,6 @@ queue_message_sync(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			size);
 	}
 
-	/* Make sure the new header is visible to the peer. */
-	wmb();
-
 	remote_event_signal(&state->remote->sync_trigger);
 
 	if (VCHIQ_MSG_TYPE(msgid) != VCHIQ_MSG_PAUSE)
@@ -3269,7 +3266,6 @@ static void
 release_message_sync(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 {
 	header->msgid = VCHIQ_MSGID_PADDING;
-	wmb();
 	remote_event_signal(&state->remote->sync_release);
 }
 
-- 
2.19.1
