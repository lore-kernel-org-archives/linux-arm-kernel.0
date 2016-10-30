From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 30 Oct 2016 05:55:07 -0700
Subject: [PATCH] staging: vc04_services: remove vchiq_copy_from_user
Message-ID: <20161030125507.15742-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vchiq_copy_from_user function is not portable
and is consider "bad practice."  Replace this function
with a callback based mechanism that is passed downward
on the stack.  When it is actually time to copy the data,
the callback is called to copy the data into the message.

This callback is provided internally for userland calls
through ioctls on the device.

NOTE: Internal clients will need to be modified to work
with the new internal API.

Test Run:
vchiq_test -p 1
vchiq_test -f 10

Both tests pass.

Internal API Changes:

Change vchi_msg_queue to:
int32_t
vchi_msg_queue(VCHI_SERVICE_HANDLE_T handle,
	       ssize_t (*copy_callback)(void *context, void *dest,
				        size_t offset, size_t maxsize),
	       void *context,
	       uint32_t data_size );

Remove:
vchi_msg_queuev_ex
vchi_msg_queuev

These functions were not implemented anyway so no need to fix them. It's
easier to just remove them.

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 .../staging/vc04_services/interface/vchi/vchi.h    |  25 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |  11 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 103 +++++++-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 269 ++++++++++++---------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   3 -
 .../vc04_services/interface/vchiq_arm/vchiq_if.h   |   9 +-
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c |  64 +----
 7 files changed, 287 insertions(+), 197 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 1b17e98..d693728 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -226,25 +226,12 @@ extern int32_t vchi_service_set_option( const VCHI_SERVICE_HANDLE_T handle,
 					int value);
 
 // Routine to send a message across a service
-extern int32_t vchi_msg_queue( VCHI_SERVICE_HANDLE_T handle,
-                               const void *data,
-                               uint32_t data_size,
-                               VCHI_FLAGS_T flags,
-                               void *msg_handle );
-
-// scatter-gather (vector) and send message
-int32_t vchi_msg_queuev_ex( VCHI_SERVICE_HANDLE_T handle,
-                            VCHI_MSG_VECTOR_EX_T *vector,
-                            uint32_t count,
-                            VCHI_FLAGS_T flags,
-                            void *msg_handle );
-
-// legacy scatter-gather (vector) and send message, only handles pointers
-int32_t vchi_msg_queuev( VCHI_SERVICE_HANDLE_T handle,
-                         VCHI_MSG_VECTOR_T *vector,
-                         uint32_t count,
-                         VCHI_FLAGS_T flags,
-                         void *msg_handle );
+extern int32_t
+	vchi_msg_queue(VCHI_SERVICE_HANDLE_T handle,
+		       ssize_t (*copy_callback)(void *context, void *dest,
+						size_t offset, size_t maxsize),
+		       void *context,
+		       uint32_t data_size);
 
 // Routine to receive a msg from a service
 // Dequeue is equivalent to hold, copy into client buffer, release
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index a5afcc5..02db3a5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -211,17 +211,6 @@ remote_event_signal(REMOTE_EVENT_T *event)
 		writel(0, g_regs + BELL2); /* trigger vc interrupt */
 }
 
-int
-vchiq_copy_from_user(void *dst, const void *src, int size)
-{
-	if ((uint32_t)src < TASK_SIZE) {
-		return copy_from_user(dst, src, size);
-	} else {
-		memcpy(dst, src, size);
-		return 0;
-	}
-}
-
 VCHIQ_STATUS_T
 vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, VCHI_MEM_HANDLE_T memhandle,
 	void *offset, int size, int dir)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index ce3ba37..dbeeffe 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -402,6 +402,107 @@ static void close_delivered(USER_SERVICE_T *user_service)
 	}
 }
 
+struct vchiq_io_copy_callback_context {
+	VCHIQ_ELEMENT_T *current_element;
+	size_t current_element_offset;
+	unsigned long elements_to_go;
+	size_t current_offset;
+};
+
+static ssize_t
+vchiq_ioc_copy_element_data(
+	void *context,
+	void *dest,
+	size_t offset,
+	size_t maxsize)
+{
+	long res;
+	size_t bytes_this_round;
+	struct vchiq_io_copy_callback_context *copy_context =
+		(struct vchiq_io_copy_callback_context *)context;
+
+	if (offset != copy_context->current_offset)
+		return 0;
+
+	if (!copy_context->elements_to_go)
+		return 0;
+
+	/*
+	 * Complex logic here to handle the case of 0 size elements
+	 * in the middle of the array of elements.
+	 *
+	 * Need to skip over these 0 size elements.
+	 */
+	while (1) {
+		bytes_this_round = min(copy_context->current_element->size -
+				       copy_context->current_element_offset,
+				       maxsize);
+
+		if (bytes_this_round)
+			break;
+
+		copy_context->elements_to_go--;
+		copy_context->current_element++;
+		copy_context->current_element_offset = 0;
+
+		if (!copy_context->elements_to_go)
+			return 0;
+	}
+
+	res = copy_from_user(dest,
+			     copy_context->current_element->data +
+			     copy_context->current_element_offset,
+			     bytes_this_round);
+
+	if (res != 0)
+		return -EFAULT;
+
+	copy_context->current_element_offset += bytes_this_round;
+	copy_context->current_offset += bytes_this_round;
+
+	/*
+	 * Check if done with current element, and if so advance to the next.
+	 */
+	if (copy_context->current_element_offset ==
+	    copy_context->current_element->size) {
+		copy_context->elements_to_go--;
+		copy_context->current_element++;
+		copy_context->current_element_offset = 0;
+	}
+
+	return bytes_this_round;
+}
+
+/**************************************************************************
+ *
+ *   vchiq_ioc_queue_message
+ *
+ **************************************************************************/
+static VCHIQ_STATUS_T
+vchiq_ioc_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
+			VCHIQ_ELEMENT_T *elements,
+			unsigned long count)
+{
+	struct vchiq_io_copy_callback_context context;
+	unsigned long i;
+	size_t total_size = 0;
+
+	context.current_element = elements;
+	context.current_element_offset = 0;
+	context.elements_to_go = count;
+	context.current_offset = 0;
+
+	for (i = 0; i < count; i++) {
+		if (!elements[i].data && elements[i].size != 0)
+			return -EFAULT;
+
+		total_size += elements[i].size;
+	}
+
+	return vchiq_queue_message(handle, vchiq_ioc_copy_element_data,
+				   &context, total_size);
+}
+
 /****************************************************************************
 *
 *   vchiq_ioctl
@@ -651,7 +752,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			VCHIQ_ELEMENT_T elements[MAX_ELEMENTS];
 			if (copy_from_user(elements, args.elements,
 				args.count * sizeof(VCHIQ_ELEMENT_T)) == 0)
-				status = vchiq_queue_message
+				status = vchiq_ioc_queue_message
 					(args.handle,
 					elements, args.count);
 			else
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index f3e1000..a771062 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -463,8 +463,8 @@ remote_event_pollall(VCHIQ_STATE_T *state)
 ** enough for a header. This relies on header size being a power of two, which
 ** has been verified earlier by a static assertion. */
 
-static inline unsigned int
-calc_stride(unsigned int size)
+static inline size_t
+calc_stride(size_t size)
 {
 	/* Allow room for the header */
 	size += sizeof(VCHIQ_HEADER_T);
@@ -543,7 +543,7 @@ request_poll(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service, int poll_type)
 /* Called from queue_message, by the slot handler and application threads,
 ** with slot_mutex held */
 static VCHIQ_HEADER_T *
-reserve_space(VCHIQ_STATE_T *state, int space, int is_blocking)
+reserve_space(VCHIQ_STATE_T *state, size_t space, int is_blocking)
 {
 	VCHIQ_SHARED_STATE_T *local = state->local;
 	int tx_pos = state->local_tx_pos;
@@ -725,18 +725,66 @@ process_free_queue(VCHIQ_STATE_T *state)
 	}
 }
 
+static ssize_t
+memcpy_copy_callback(
+	void *context, void *dest,
+	size_t offset, size_t maxsize)
+{
+	void *src = context;
+
+	memcpy(dest + offset, src + offset, maxsize);
+	return maxsize;
+}
+
+static ssize_t
+copy_message_data(
+	ssize_t (*copy_callback)(void *context, void *dest,
+				 size_t offset, size_t maxsize),
+	void *context,
+	void *dest,
+	size_t size)
+{
+	size_t pos = 0;
+
+	while (pos < size) {
+		ssize_t callback_result;
+		size_t max_bytes = size - pos;
+
+		callback_result =
+			copy_callback(context, dest + pos,
+				      pos, max_bytes);
+
+		if (callback_result < 0)
+			return callback_result;
+
+		if (!callback_result)
+			return -EIO;
+
+		if (callback_result > max_bytes)
+			return -EIO;
+
+		pos += callback_result;
+	}
+
+	return size;
+}
+
 /* Called by the slot handler and application threads */
 static VCHIQ_STATUS_T
 queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
-	int msgid, const VCHIQ_ELEMENT_T *elements,
-	int count, int size, int flags)
+	int msgid,
+	ssize_t (*copy_callback)(void *context, void *dest,
+				 size_t offset, size_t maxsize),
+	void *context,
+	size_t size,
+	int flags)
 {
 	VCHIQ_SHARED_STATE_T *local;
 	VCHIQ_SERVICE_QUOTA_T *service_quota = NULL;
 	VCHIQ_HEADER_T *header;
 	int type = VCHIQ_MSG_TYPE(msgid);
 
-	unsigned int stride;
+	size_t stride;
 
 	local = state->local;
 
@@ -842,7 +890,7 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 	}
 
 	if (type == VCHIQ_MSG_DATA) {
-		int i, pos;
+		ssize_t callback_result;
 		int tx_end_index;
 		int slot_use_count;
 
@@ -856,27 +904,23 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 		BUG_ON((flags & (QMFLAGS_NO_MUTEX_LOCK |
 				 QMFLAGS_NO_MUTEX_UNLOCK)) != 0);
 
-		for (i = 0, pos = 0; i < (unsigned int)count;
-			pos += elements[i++].size)
-			if (elements[i].size) {
-				if (vchiq_copy_from_user
-					(header->data + pos, elements[i].data,
-					(size_t) elements[i].size) !=
-					VCHIQ_SUCCESS) {
-					mutex_unlock(&state->slot_mutex);
-					VCHIQ_SERVICE_STATS_INC(service,
+		callback_result =
+			copy_message_data(copy_callback, context,
+					  header->data, size);
+
+		if (callback_result < 0) {
+			mutex_unlock(&state->slot_mutex);
+			VCHIQ_SERVICE_STATS_INC(service,
 						error_count);
-					return VCHIQ_ERROR;
-				}
-				if (i == 0) {
-					if (SRVTRACE_ENABLED(service,
-							VCHIQ_LOG_INFO))
-						vchiq_log_dump_mem("Sent", 0,
-							header->data + pos,
-							min(64u,
-							elements[0].size));
-				}
-			}
+			return VCHIQ_ERROR;
+		}
+
+		if (SRVTRACE_ENABLED(service,
+				     VCHIQ_LOG_INFO))
+			vchiq_log_dump_mem("Sent", 0,
+					   header->data,
+					   min((size_t)64,
+					       (size_t)callback_result));
 
 		spin_lock(&quota_spinlock);
 		service_quota->message_use_count++;
@@ -918,9 +962,17 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			header, size, VCHIQ_MSG_SRCPORT(msgid),
 			VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
-			WARN_ON(!((count == 1) && (size == elements[0].size)));
-			memcpy(header->data, elements[0].data,
-				elements[0].size);
+			/* It is assumed for now that this code path
+			 * only happens from calls inside this file.
+			 *
+			 * External callers are through the vchiq_queue_message
+			 * path which always sets the type to be VCHIQ_MSG_DATA
+			 *
+			 * At first glance this appears to be correct but
+			 * more review is needed.
+			 */
+			copy_message_data(copy_callback, context,
+					  header->data, size);
 		}
 		VCHIQ_STATS_INC(state, ctrl_tx_count);
 	}
@@ -966,11 +1018,16 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 /* Called by the slot handler and application threads */
 static VCHIQ_STATUS_T
 queue_message_sync(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
-	int msgid, const VCHIQ_ELEMENT_T *elements,
-	int count, int size, int is_blocking)
+	int msgid,
+	ssize_t (*copy_callback)(void *context, void *dest,
+				 size_t offset, size_t maxsize),
+	void *context,
+	int size,
+	int is_blocking)
 {
 	VCHIQ_SHARED_STATE_T *local;
 	VCHIQ_HEADER_T *header;
+	ssize_t callback_result;
 
 	local = state->local;
 
@@ -993,50 +1050,34 @@ queue_message_sync(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 				state->id, oldmsgid);
 	}
 
-	if (service) {
-		int i, pos;
+	vchiq_log_info(vchiq_sync_log_level,
+		       "%d: qms %s@%pK,%x (%d->%d)", state->id,
+		       msg_type_str(VCHIQ_MSG_TYPE(msgid)),
+		       header, size, VCHIQ_MSG_SRCPORT(msgid),
+		       VCHIQ_MSG_DSTPORT(msgid));
 
-		vchiq_log_info(vchiq_sync_log_level,
-			"%d: qms %s@%pK,%x (%d->%d)", state->id,
-			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			header, size, VCHIQ_MSG_SRCPORT(msgid),
-			VCHIQ_MSG_DSTPORT(msgid));
+	callback_result =
+		copy_message_data(copy_callback, context,
+				  header->data, size);
 
-		for (i = 0, pos = 0; i < (unsigned int)count;
-			pos += elements[i++].size)
-			if (elements[i].size) {
-				if (vchiq_copy_from_user
-					(header->data + pos, elements[i].data,
-					(size_t) elements[i].size) !=
-					VCHIQ_SUCCESS) {
-					mutex_unlock(&state->sync_mutex);
-					VCHIQ_SERVICE_STATS_INC(service,
-						error_count);
-					return VCHIQ_ERROR;
-				}
-				if (i == 0) {
-					if (vchiq_sync_log_level >=
-						VCHIQ_LOG_TRACE)
-						vchiq_log_dump_mem("Sent Sync",
-							0, header->data + pos,
-							min(64u,
-							elements[0].size));
-				}
-			}
+	if (callback_result < 0) {
+		mutex_unlock(&state->slot_mutex);
+		VCHIQ_SERVICE_STATS_INC(service,
+					error_count);
+		return VCHIQ_ERROR;
+	}
+
+	if (service) {
+		if (SRVTRACE_ENABLED(service,
+				     VCHIQ_LOG_INFO))
+			vchiq_log_dump_mem("Sent", 0,
+					   header->data,
+					   min((size_t)64,
+					       (size_t)callback_result));
 
 		VCHIQ_SERVICE_STATS_INC(service, ctrl_tx_count);
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
-		vchiq_log_info(vchiq_sync_log_level,
-			"%d: qms %s@%pK,%x (%d->%d)", state->id,
-			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			header, size, VCHIQ_MSG_SRCPORT(msgid),
-			VCHIQ_MSG_DSTPORT(msgid));
-		if (size != 0) {
-			WARN_ON(!((count == 1) && (size == elements[0].size)));
-			memcpy(header->data, elements[0].data,
-				elements[0].size);
-		}
 		VCHIQ_STATS_INC(state, ctrl_tx_count);
 	}
 
@@ -1149,11 +1190,16 @@ notify_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue,
 				VCHIQ_MSG_BULK_RX_DONE : VCHIQ_MSG_BULK_TX_DONE;
 			int msgid = VCHIQ_MAKE_MSG(msgtype, service->localport,
 				service->remoteport);
-			VCHIQ_ELEMENT_T element = { &bulk->actual, 4 };
 			/* Only reply to non-dummy bulk requests */
 			if (bulk->remote_data) {
-				status = queue_message(service->state, NULL,
-					msgid, &element, 1, 4, 0);
+				status = queue_message(
+						service->state,
+						NULL,
+						msgid,
+						memcpy_copy_callback,
+						&bulk->actual,
+						4,
+						0);
 				if (status != VCHIQ_SUCCESS)
 					break;
 			}
@@ -1513,10 +1559,6 @@ parse_open(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 				struct vchiq_openack_payload ack_payload = {
 					service->version
 				};
-				VCHIQ_ELEMENT_T body = {
-					&ack_payload,
-					sizeof(ack_payload)
-				};
 
 				if (state->version_common <
 				    VCHIQ_VERSION_SYNCHRONOUS_MODE)
@@ -1526,21 +1568,28 @@ parse_open(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 				if (service->sync &&
 				    (state->version_common >=
 				     VCHIQ_VERSION_SYNCHRONOUS_MODE)) {
-					if (queue_message_sync(state, NULL,
+					if (queue_message_sync(
+						state,
+						NULL,
 						VCHIQ_MAKE_MSG(
 							VCHIQ_MSG_OPENACK,
 							service->localport,
 							remoteport),
-						&body, 1, sizeof(ack_payload),
+						memcpy_copy_callback,
+						&ack_payload,
+						sizeof(ack_payload),
 						0) == VCHIQ_RETRY)
 						goto bail_not_ready;
 				} else {
-					if (queue_message(state, NULL,
-						VCHIQ_MAKE_MSG(
+					if (queue_message(state,
+							NULL,
+							VCHIQ_MAKE_MSG(
 							VCHIQ_MSG_OPENACK,
 							service->localport,
 							remoteport),
-						&body, 1, sizeof(ack_payload),
+						memcpy_copy_callback,
+						&ack_payload,
+						sizeof(ack_payload),
 						0) == VCHIQ_RETRY)
 						goto bail_not_ready;
 				}
@@ -2630,14 +2679,19 @@ vchiq_open_service_internal(VCHIQ_SERVICE_T *service, int client_id)
 		service->version,
 		service->version_min
 	};
-	VCHIQ_ELEMENT_T body = { &payload, sizeof(payload) };
 	VCHIQ_STATUS_T status = VCHIQ_SUCCESS;
 
 	service->client_id = client_id;
 	vchiq_use_service_internal(service);
-	status = queue_message(service->state, NULL,
-		VCHIQ_MAKE_MSG(VCHIQ_MSG_OPEN, service->localport, 0),
-		&body, 1, sizeof(payload), QMFLAGS_IS_BLOCKING);
+	status = queue_message(service->state,
+			       NULL,
+			       VCHIQ_MAKE_MSG(VCHIQ_MSG_OPEN,
+					      service->localport,
+					      0),
+			       memcpy_copy_callback,
+			       &payload,
+			       sizeof(payload),
+			       QMFLAGS_IS_BLOCKING);
 	if (status == VCHIQ_SUCCESS) {
 		/* Wait for the ACK/NAK */
 		if (down_interruptible(&service->remove_event) != 0) {
@@ -3305,15 +3359,18 @@ vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 				VCHIQ_POLL_TXNOTIFY : VCHIQ_POLL_RXNOTIFY);
 	} else {
 		int payload[2] = { (int)(long)bulk->data, bulk->size };
-		VCHIQ_ELEMENT_T element = { payload, sizeof(payload) };
 
-		status = queue_message(state, NULL,
-			VCHIQ_MAKE_MSG(dir_msgtype,
-				service->localport, service->remoteport),
-			&element, 1, sizeof(payload),
-			QMFLAGS_IS_BLOCKING |
-			QMFLAGS_NO_MUTEX_LOCK |
-			QMFLAGS_NO_MUTEX_UNLOCK);
+		status = queue_message(state,
+				       NULL,
+				       VCHIQ_MAKE_MSG(dir_msgtype,
+						      service->localport,
+						      service->remoteport),
+				       memcpy_copy_callback,
+				       &payload,
+				       sizeof(payload),
+				       QMFLAGS_IS_BLOCKING |
+				       QMFLAGS_NO_MUTEX_LOCK |
+				       QMFLAGS_NO_MUTEX_UNLOCK);
 		if (status != VCHIQ_SUCCESS) {
 			goto unlock_both_error_exit;
 		}
@@ -3359,26 +3416,22 @@ vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 
 VCHIQ_STATUS_T
 vchiq_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
-	const VCHIQ_ELEMENT_T *elements, unsigned int count)
+		    ssize_t (*copy_callback)(void *context, void *dest,
+					     size_t offset, size_t maxsize),
+		    void *context,
+		    size_t size)
 {
 	VCHIQ_SERVICE_T *service = find_service_by_handle(handle);
 	VCHIQ_STATUS_T status = VCHIQ_ERROR;
 
-	unsigned int size = 0;
-	unsigned int i;
-
 	if (!service ||
 		(vchiq_check_service(service) != VCHIQ_SUCCESS))
 		goto error_exit;
 
-	for (i = 0; i < (unsigned int)count; i++) {
-		if (elements[i].size) {
-			if (elements[i].data == NULL) {
-				VCHIQ_SERVICE_STATS_INC(service, error_count);
-				goto error_exit;
-			}
-			size += elements[i].size;
-		}
+	if (!size) {
+		VCHIQ_SERVICE_STATS_INC(service, error_count);
+		goto error_exit;
+
 	}
 
 	if (size > VCHIQ_MAX_MSG_SIZE) {
@@ -3392,14 +3445,14 @@ vchiq_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
 				VCHIQ_MAKE_MSG(VCHIQ_MSG_DATA,
 					service->localport,
 					service->remoteport),
-				elements, count, size, 1);
+				copy_callback, context, size, 1);
 		break;
 	case VCHIQ_SRVSTATE_OPENSYNC:
 		status = queue_message_sync(service->state, service,
 				VCHIQ_MAKE_MSG(VCHIQ_MSG_DATA,
 					service->localport,
 					service->remoteport),
-				elements, count, size, 1);
+				copy_callback, context, size, 1);
 		break;
 	default:
 		status = VCHIQ_ERROR;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 1c2b1b5..9e16465 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -634,9 +634,6 @@ vchiq_transfer_bulk(VCHIQ_BULK_T *bulk);
 extern void
 vchiq_complete_bulk(VCHIQ_BULK_T *bulk);
 
-extern VCHIQ_STATUS_T
-vchiq_copy_from_user(void *dst, const void *src, int size);
-
 extern void
 remote_event_signal(REMOTE_EVENT_T *event);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 8067bbe..377e8e4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -141,9 +141,12 @@ extern VCHIQ_STATUS_T vchiq_use_service(VCHIQ_SERVICE_HANDLE_T service);
 extern VCHIQ_STATUS_T vchiq_use_service_no_resume(
 	VCHIQ_SERVICE_HANDLE_T service);
 extern VCHIQ_STATUS_T vchiq_release_service(VCHIQ_SERVICE_HANDLE_T service);
-
-extern VCHIQ_STATUS_T vchiq_queue_message(VCHIQ_SERVICE_HANDLE_T service,
-	const VCHIQ_ELEMENT_T *elements, unsigned int count);
+extern VCHIQ_STATUS_T
+vchiq_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
+		    ssize_t (*copy_callback)(void *context, void *dest,
+					     size_t offset, size_t maxsize),
+		    void *context,
+		    size_t size);
 extern void           vchiq_release_message(VCHIQ_SERVICE_HANDLE_T service,
 	VCHIQ_HEADER_T *header);
 extern VCHIQ_STATUS_T vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T service,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 7694627..d977139 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -148,10 +148,10 @@ EXPORT_SYMBOL(vchi_msg_remove);
  * Name: vchi_msg_queue
  *
  * Arguments:  VCHI_SERVICE_HANDLE_T handle,
- *             const void *data,
- *             uint32_t data_size,
- *             VCHI_FLAGS_T flags,
- *             void *msg_handle,
+ *             ssize_t (*copy_callback)(void *context, void *dest,
+ *				        size_t offset, size_t maxsize),
+ *	       void *context,
+ *             uint32_t data_size
  *
  * Description: Thin wrapper to queue a message onto a connection
  *
@@ -159,21 +159,19 @@ EXPORT_SYMBOL(vchi_msg_remove);
  *
  ***********************************************************/
 int32_t vchi_msg_queue(VCHI_SERVICE_HANDLE_T handle,
-	const void *data,
-	uint32_t data_size,
-	VCHI_FLAGS_T flags,
-	void *msg_handle)
+	ssize_t (*copy_callback)(void *context, void *dest,
+				 size_t offset, size_t maxsize),
+	void *context,
+	uint32_t data_size)
 {
 	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
-	VCHIQ_ELEMENT_T element = {data, data_size};
 	VCHIQ_STATUS_T status;
 
-	(void)msg_handle;
-
-	WARN_ON(flags != VCHI_FLAGS_BLOCK_UNTIL_QUEUED);
-
 	while (1) {
-		status = vchiq_queue_message(service->handle, &element, 1);
+		status = vchiq_queue_message(service->handle,
+					     copy_callback,
+					     context,
+					     data_size);
 
 		/*
 		 * vchiq_queue_message() may return VCHIQ_RETRY, so we need to
@@ -356,44 +354,6 @@ int32_t vchi_msg_dequeue(VCHI_SERVICE_HANDLE_T handle,
 EXPORT_SYMBOL(vchi_msg_dequeue);
 
 /***********************************************************
- * Name: vchi_msg_queuev
- *
- * Arguments:  VCHI_SERVICE_HANDLE_T handle,
- *             VCHI_MSG_VECTOR_T *vector,
- *             uint32_t count,
- *             VCHI_FLAGS_T flags,
- *             void *msg_handle
- *
- * Description: Thin wrapper to queue a message onto a connection
- *
- * Returns: int32_t - success == 0
- *
- ***********************************************************/
-
-vchiq_static_assert(sizeof(VCHI_MSG_VECTOR_T) == sizeof(VCHIQ_ELEMENT_T));
-vchiq_static_assert(offsetof(VCHI_MSG_VECTOR_T, vec_base) ==
-	offsetof(VCHIQ_ELEMENT_T, data));
-vchiq_static_assert(offsetof(VCHI_MSG_VECTOR_T, vec_len) ==
-	offsetof(VCHIQ_ELEMENT_T, size));
-
-int32_t vchi_msg_queuev(VCHI_SERVICE_HANDLE_T handle,
-	VCHI_MSG_VECTOR_T *vector,
-	uint32_t count,
-	VCHI_FLAGS_T flags,
-	void *msg_handle)
-{
-	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
-
-	(void)msg_handle;
-
-	WARN_ON(flags != VCHI_FLAGS_BLOCK_UNTIL_QUEUED);
-
-	return vchiq_status_to_vchi(vchiq_queue_message(service->handle,
-		(const VCHIQ_ELEMENT_T *)vector, count));
-}
-EXPORT_SYMBOL(vchi_msg_queuev);
-
-/***********************************************************
  * Name: vchi_held_msg_release
  *
  * Arguments:  VCHI_HELD_MSG_T *message
-- 
2.10.1
