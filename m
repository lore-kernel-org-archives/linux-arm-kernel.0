From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Nov 2016 16:39:05 +0100
Subject: [PATCH 1/2] staging: vc04_services: remove duplicate
 mutex_lock_interruptible
Message-ID: <20161116154139.3703209-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver tries to redefine mutex_lock_interruptible as an open-coded
mutex_lock_killable, but that definition clashes with the normal
mutex_lock_interruptible definition when CONFIG_DEBUG_LOCK_ALLOC
is set:

staging/vc04_services/interface/vchiq_arm/vchiq_killable.h:67:0: error: "mutex_lock_interruptible" redefined [-Werror]
 #define mutex_lock_interruptible mutex_lock_interruptible_killable
include/linux/mutex.h:161:0: note: this is the location of the previous definition

This simply removes the private implementation and uses the
normal mutex_lock_killable directly.

We could do the same for the down_interruptible_killable here, but
it's better to just remove the semaphores entirely from the driver,
which also takes care of that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    |  2 +-
 .../interface/vchiq_arm/vchiq_connected.c            |  4 ++--
 .../vc04_services/interface/vchiq_arm/vchiq_core.c   | 20 ++++++++++----------
 .../interface/vchiq_arm/vchiq_kern_lib.c             |  4 ++--
 .../interface/vchiq_arm/vchiq_killable.h             | 14 --------------
 5 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index d0435a05ea35..0d987898b4f8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -554,7 +554,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			ret = -EINVAL;
 			break;
 		}
-		rc = mutex_lock_interruptible(&instance->state->mutex);
+		rc = mutex_lock_killable(&instance->state->mutex);
 		if (rc != 0) {
 			vchiq_log_error(vchiq_arm_log_level,
 				"vchiq: connect: could not lock mutex for "
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 5efc62ffb2f5..7ea29665bd0c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -72,7 +72,7 @@ void vchiq_add_connected_callback(VCHIQ_CONNECTED_CALLBACK_T callback)
 {
 	connected_init();
 
-	if (mutex_lock_interruptible(&g_connected_mutex) != 0)
+	if (mutex_lock_killable(&g_connected_mutex) != 0)
 		return;
 
 	if (g_connected)
@@ -107,7 +107,7 @@ void vchiq_call_connected_callbacks(void)
 
 	connected_init();
 
-	if (mutex_lock_interruptible(&g_connected_mutex) != 0)
+	if (mutex_lock_killable(&g_connected_mutex) != 0)
 		return;
 
 	for (i = 0; i <  g_num_deferred_callbacks; i++)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 7440db2ce40b..028e90bc1cdc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -794,7 +794,7 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 	WARN_ON(!(stride <= VCHIQ_SLOT_SIZE));
 
 	if (!(flags & QMFLAGS_NO_MUTEX_LOCK) &&
-		(mutex_lock_interruptible(&state->slot_mutex) != 0))
+		(mutex_lock_killable(&state->slot_mutex) != 0))
 		return VCHIQ_RETRY;
 
 	if (type == VCHIQ_MSG_DATA) {
@@ -863,7 +863,7 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 				return VCHIQ_RETRY;
 			if (service->closing)
 				return VCHIQ_ERROR;
-			if (mutex_lock_interruptible(&state->slot_mutex) != 0)
+			if (mutex_lock_killable(&state->slot_mutex) != 0)
 				return VCHIQ_RETRY;
 			if (service->srvstate != VCHIQ_SRVSTATE_OPEN) {
 				/* The service has been closed */
@@ -1033,7 +1033,7 @@ queue_message_sync(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 	local = state->local;
 
 	if ((VCHIQ_MSG_TYPE(msgid) != VCHIQ_MSG_RESUME) &&
-		(mutex_lock_interruptible(&state->sync_mutex) != 0))
+		(mutex_lock_killable(&state->sync_mutex) != 0))
 		return VCHIQ_RETRY;
 
 	remote_event_wait(state, &local->sync_release);
@@ -1365,7 +1365,7 @@ resolve_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue)
 		WARN_ON(!((int)(queue->local_insert - queue->process) > 0));
 		WARN_ON(!((int)(queue->remote_insert - queue->process) > 0));
 
-		rc = mutex_lock_interruptible(&state->bulk_transfer_mutex);
+		rc = mutex_lock_killable(&state->bulk_transfer_mutex);
 		if (rc != 0)
 			break;
 
@@ -1839,7 +1839,7 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				int resolved = 0;
 
 				DEBUG_TRACE(PARSE_LINE);
-				if (mutex_lock_interruptible(
+				if (mutex_lock_killable(
 					&service->bulk_mutex) != 0) {
 					DEBUG_TRACE(PARSE_LINE);
 					goto bail_not_ready;
@@ -1903,7 +1903,7 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 					&service->bulk_rx : &service->bulk_tx;
 
 				DEBUG_TRACE(PARSE_LINE);
-				if (mutex_lock_interruptible(
+				if (mutex_lock_killable(
 					&service->bulk_mutex) != 0) {
 					DEBUG_TRACE(PARSE_LINE);
 					goto bail_not_ready;
@@ -2780,7 +2780,7 @@ do_abort_bulks(VCHIQ_SERVICE_T *service)
 	VCHIQ_STATUS_T status;
 
 	/* Abort any outstanding bulk transfers */
-	if (mutex_lock_interruptible(&service->bulk_mutex) != 0)
+	if (mutex_lock_killable(&service->bulk_mutex) != 0)
 		return 0;
 	abort_outstanding_bulks(service, &service->bulk_tx);
 	abort_outstanding_bulks(service, &service->bulk_rx);
@@ -3300,7 +3300,7 @@ vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 	queue = (dir == VCHIQ_BULK_TRANSMIT) ?
 		&service->bulk_tx : &service->bulk_rx;
 
-	if (mutex_lock_interruptible(&service->bulk_mutex) != 0) {
+	if (mutex_lock_killable(&service->bulk_mutex) != 0) {
 		status = VCHIQ_RETRY;
 		goto error_exit;
 	}
@@ -3314,7 +3314,7 @@ vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 				status = VCHIQ_RETRY;
 				goto error_exit;
 			}
-			if (mutex_lock_interruptible(&service->bulk_mutex)
+			if (mutex_lock_killable(&service->bulk_mutex)
 				!= 0) {
 				status = VCHIQ_RETRY;
 				goto error_exit;
@@ -3344,7 +3344,7 @@ vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 
 	/* The slot mutex must be held when the service is being closed, so
 	   claim it here to ensure that isn't happening */
-	if (mutex_lock_interruptible(&state->slot_mutex) != 0) {
+	if (mutex_lock_killable(&state->slot_mutex) != 0) {
 		status = VCHIQ_RETRY;
 		goto cancel_bulk_error_exit;
 	}
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
index 14bd2857e462..e93922a87263 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
@@ -134,7 +134,7 @@ VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 	vchiq_log_trace(vchiq_core_log_level,
 		"%s(%p) called", __func__, instance);
 
-	if (mutex_lock_interruptible(&state->mutex) != 0)
+	if (mutex_lock_killable(&state->mutex) != 0)
 		return VCHIQ_RETRY;
 
 	/* Remove all services */
@@ -191,7 +191,7 @@ VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
 	vchiq_log_trace(vchiq_core_log_level,
 		"%s(%p) called", __func__, instance);
 
-	if (mutex_lock_interruptible(&state->mutex) != 0) {
+	if (mutex_lock_killable(&state->mutex) != 0) {
 		vchiq_log_trace(vchiq_core_log_level,
 			"%s: call to mutex_lock failed", __func__);
 		status = VCHIQ_RETRY;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h
index 335446e05476..778063ba312a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h
@@ -52,18 +52,4 @@ static inline int __must_check down_interruptible_killable(struct semaphore *sem
 }
 #define down_interruptible down_interruptible_killable
 
-
-static inline int __must_check mutex_lock_interruptible_killable(struct mutex *lock)
-{
-	/* Allow interception of killable signals only. We don't want to be interrupted by harmless signals like SIGALRM */
-	int ret;
-	sigset_t blocked, oldset;
-	siginitsetinv(&blocked, SHUTDOWN_SIGS);
-	sigprocmask(SIG_SETMASK, &blocked, &oldset);
-	ret = mutex_lock_interruptible(lock);
-	sigprocmask(SIG_SETMASK, &oldset, NULL);
-	return ret;
-}
-#define mutex_lock_interruptible mutex_lock_interruptible_killable
-
 #endif
-- 
2.9.0
