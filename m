From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Fri, 26 Oct 2018 15:48:05 +0200
Subject: [PATCH RFC 10/18] staging: vchiq_core: don't add a wmb() before
 remote_event_signal()
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
Message-ID: <20181026134813.7775-11-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's the first thing remote_event_signal() does.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 6242357735b9..e8b7ccabd9cb 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1138,9 +1138,6 @@ queue_message_sync(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			size);
 	}
 
-	/* Make sure the new header is visible to the peer. */
-	wmb();
-
 	remote_event_signal(&state->remote->sync_trigger);
 
 	if (VCHIQ_MSG_TYPE(msgid) != VCHIQ_MSG_PAUSE)
@@ -3265,7 +3262,6 @@ static void
 release_message_sync(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 {
 	header->msgid = VCHIQ_MSGID_PADDING;
-	wmb();
 	remote_event_signal(&state->remote->sync_release);
 }
 
-- 
2.19.1
