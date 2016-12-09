From: mpkofron@gmail.com (Mike Kofron)
Date: Fri,  9 Dec 2016 11:21:01 -0500
Subject: [PATCH] staging: vc04_services: Fix NULL ptr sparse warnings
Message-ID: <20161209162101.10450-1-mpkofron@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In calls to queue_message() in vchiq_core.c, the "void *context"
parameter is set as 0 rather than NULL. This patch amends each call to
use the proper NULL pointer. The following sparse warnings are fixed:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:1623:23: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:1976:47: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:2075:47: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:2095:47: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:2907:39: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:2929:39: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:3059:72: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:3860:31: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:3870:31: warning: Using plain integer as NULL pointer
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:3880:31: warning: Using plain integer as NULL pointer

Signed-off-by: Mike Kofron <mpkofron@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c   | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 028e90b..32b00f8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1620,7 +1620,7 @@ parse_open(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 	/* No available service, or an invalid request - send a CLOSE */
 	if (queue_message(state, NULL,
 		VCHIQ_MAKE_MSG(VCHIQ_MSG_CLOSE, 0, VCHIQ_MSG_SRCPORT(msgid)),
-		NULL, 0, 0, 0) == VCHIQ_RETRY)
+		NULL, NULL, 0, 0) == VCHIQ_RETRY)
 		goto bail_not_ready;

 	return 1;
@@ -1973,7 +1973,7 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				/* Send a PAUSE in response */
 				if (queue_message(state, NULL,
 					VCHIQ_MAKE_MSG(VCHIQ_MSG_PAUSE, 0, 0),
-					NULL, 0, 0, QMFLAGS_NO_MUTEX_UNLOCK)
+					NULL, NULL, 0, QMFLAGS_NO_MUTEX_UNLOCK)
 				    == VCHIQ_RETRY)
 					goto bail_not_ready;
 				if (state->is_master)
@@ -2072,7 +2072,7 @@ slot_handler_func(void *v)
 					pause_bulks(state);
 				if (queue_message(state, NULL,
 					VCHIQ_MAKE_MSG(VCHIQ_MSG_PAUSE, 0, 0),
-					NULL, 0, 0,
+					NULL, NULL, 0,
 					QMFLAGS_NO_MUTEX_UNLOCK)
 				    != VCHIQ_RETRY) {
 					vchiq_set_conn_state(state,
@@ -2092,7 +2092,7 @@ slot_handler_func(void *v)
 			case VCHIQ_CONNSTATE_RESUMING:
 				if (queue_message(state, NULL,
 					VCHIQ_MAKE_MSG(VCHIQ_MSG_RESUME, 0, 0),
-					NULL, 0, 0, QMFLAGS_NO_MUTEX_LOCK)
+					NULL, NULL, 0, QMFLAGS_NO_MUTEX_LOCK)
 					!= VCHIQ_RETRY) {
 					if (state->is_master)
 						resume_bulks(state);
@@ -2904,7 +2904,7 @@ vchiq_close_service_internal(VCHIQ_SERVICE_T *service, int close_recvd)
 				(VCHIQ_MSG_CLOSE,
 				service->localport,
 				VCHIQ_MSG_DSTPORT(service->remoteport)),
-				NULL, 0, 0, 0);
+				NULL, NULL, 0, 0);
 		}
 		break;

@@ -2926,7 +2926,7 @@ vchiq_close_service_internal(VCHIQ_SERVICE_T *service, int close_recvd)
 				(VCHIQ_MSG_CLOSE,
 				service->localport,
 				VCHIQ_MSG_DSTPORT(service->remoteport)),
-				NULL, 0, 0, QMFLAGS_NO_MUTEX_UNLOCK);
+				NULL, NULL, 0, QMFLAGS_NO_MUTEX_UNLOCK);

 		if (status == VCHIQ_SUCCESS) {
 			if (!close_recvd) {
@@ -3056,7 +3056,7 @@ vchiq_connect_internal(VCHIQ_STATE_T *state, VCHIQ_INSTANCE_T instance)

 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED) {
 		if (queue_message(state, NULL,
-			VCHIQ_MAKE_MSG(VCHIQ_MSG_CONNECT, 0, 0), NULL, 0,
+			VCHIQ_MAKE_MSG(VCHIQ_MSG_CONNECT, 0, 0), NULL, NULL,
 			0, QMFLAGS_IS_BLOCKING) == VCHIQ_RETRY)
 			return VCHIQ_RETRY;

@@ -3857,7 +3857,7 @@ VCHIQ_STATUS_T vchiq_send_remote_use(VCHIQ_STATE_T *state)
 	if (state->conn_state != VCHIQ_CONNSTATE_DISCONNECTED)
 		status = queue_message(state, NULL,
 			VCHIQ_MAKE_MSG(VCHIQ_MSG_REMOTE_USE, 0, 0),
-			NULL, 0, 0, 0);
+			NULL, NULL, 0, 0);
 	return status;
 }

@@ -3867,7 +3867,7 @@ VCHIQ_STATUS_T vchiq_send_remote_release(VCHIQ_STATE_T *state)
 	if (state->conn_state != VCHIQ_CONNSTATE_DISCONNECTED)
 		status = queue_message(state, NULL,
 			VCHIQ_MAKE_MSG(VCHIQ_MSG_REMOTE_RELEASE, 0, 0),
-			NULL, 0, 0, 0);
+			NULL, NULL, 0, 0);
 	return status;
 }

@@ -3877,7 +3877,7 @@ VCHIQ_STATUS_T vchiq_send_remote_use_active(VCHIQ_STATE_T *state)
 	if (state->conn_state != VCHIQ_CONNSTATE_DISCONNECTED)
 		status = queue_message(state, NULL,
 			VCHIQ_MAKE_MSG(VCHIQ_MSG_REMOTE_USE_ACTIVE, 0, 0),
-			NULL, 0, 0, 0);
+			NULL, NULL, 0, 0);
 	return status;
 }

--
2.9.3
