From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 12:44:03 -0700
Subject: [PATCH 2/5] staging/vchi: Fix build warnings when formatting pointers
 on aarch64.
In-Reply-To: <20161017194406.1080-1-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
Message-ID: <20161017194406.1080-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code was generally using "%x" to print and "(unsigned int)" to
cast the pointers, but we have %p for printing pointers in the same
format without any broken casts.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../interface/vchiq_arm/vchiq_2835_arm.c           |   9 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  32 ++--
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 178 ++++++++++-----------
 3 files changed, 109 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 4cb5bff23728..c5255bc6c589 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -174,8 +174,8 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	}
 
 	vchiq_log_info(vchiq_arm_log_level,
-		"vchiq_init - done (slots %x, phys %pad)",
-		(unsigned int)vchiq_slot_zero, &slot_phys);
+		"vchiq_init - done (slots %p, phys %pad)",
+		vchiq_slot_zero, &slot_phys);
 
 	vchiq_call_connected_callbacks();
 
@@ -389,8 +389,7 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
                            (num_pages * sizeof(pages[0])),
                            GFP_KERNEL);
 
-	vchiq_log_trace(vchiq_arm_log_level,
-		"create_pagelist - %x", (unsigned int)pagelist);
+	vchiq_log_trace(vchiq_arm_log_level, "create_pagelist - %p", pagelist);
 	if (!pagelist)
 		return -ENOMEM;
 
@@ -515,7 +514,7 @@ free_pagelist(PAGELIST_T *pagelist, int actual)
 	unsigned int num_pages, i;
 
 	vchiq_log_trace(vchiq_arm_log_level,
-		"free_pagelist - %x, %d", (unsigned int)pagelist, actual);
+		"free_pagelist - %p, %d", pagelist, actual);
 
 	num_pages =
 		(pagelist->length + pagelist->offset + PAGE_SIZE - 1) /
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 47df1af2219d..68ee5216f5bc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -418,8 +418,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	DEBUG_INITIALISE(g_state.local)
 
 	vchiq_log_trace(vchiq_arm_log_level,
-		 "vchiq_ioctl - instance %x, cmd %s, arg %lx",
-		(unsigned int)instance,
+		 "vchiq_ioctl - instance %p, cmd %s, arg %lx",
+		instance,
 		((_IOC_TYPE(cmd) == VCHIQ_IOC_MAGIC) &&
 		(_IOC_NR(cmd) <= VCHIQ_IOC_MAX)) ?
 		ioctl_names[_IOC_NR(cmd)] : "<invalid>", arg);
@@ -713,8 +713,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				break;
 			}
 			vchiq_log_info(vchiq_arm_log_level,
-				"found bulk_waiter %x for pid %d",
-				(unsigned int)waiter, current->pid);
+				"found bulk_waiter %p for pid %d",
+				waiter, current->pid);
 			args.userdata = &waiter->bulk_waiter;
 		}
 		status = vchiq_bulk_transfer
@@ -743,8 +743,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			list_add(&waiter->list, &instance->bulk_waiter_list);
 			mutex_unlock(&instance->bulk_waiter_list_mutex);
 			vchiq_log_info(vchiq_arm_log_level,
-				"saved bulk_waiter %x for pid %d",
-				(unsigned int)waiter, current->pid);
+				"saved bulk_waiter %p for pid %d",
+				waiter, current->pid);
 
 			if (copy_to_user((void __user *)
 				&(((VCHIQ_QUEUE_BULK_TRANSFER_T __user *)
@@ -826,9 +826,9 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 					if (args.msgbufsize < msglen) {
 						vchiq_log_error(
 							vchiq_arm_log_level,
-							"header %x: msgbufsize"
+							"header %p: msgbufsize"
 							" %x < msglen %x",
-							(unsigned int)header,
+							header,
 							args.msgbufsize,
 							msglen);
 						WARN(1, "invalid message "
@@ -980,8 +980,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				ret = -EFAULT;
 		} else {
 			vchiq_log_error(vchiq_arm_log_level,
-				"header %x: bufsize %x < size %x",
-				(unsigned int)header, args.bufsize,
+				"header %p: bufsize %x < size %x",
+				header, args.bufsize,
 				header->size);
 			WARN(1, "invalid size\n");
 			ret = -EMSGSIZE;
@@ -1284,9 +1284,9 @@ vchiq_release(struct inode *inode, struct file *file)
 					list);
 				list_del(pos);
 				vchiq_log_info(vchiq_arm_log_level,
-					"bulk_waiter - cleaned up %x "
+					"bulk_waiter - cleaned up %p "
 					"for pid %d",
-					(unsigned int)waiter, waiter->pid);
+					waiter, waiter->pid);
 				kfree(waiter);
 			}
 		}
@@ -1385,9 +1385,9 @@ vchiq_dump_platform_instances(void *dump_context)
 			instance = service->instance;
 			if (instance && !instance->mark) {
 				len = snprintf(buf, sizeof(buf),
-					"Instance %x: pid %d,%s completions "
+					"Instance %p: pid %d,%s completions "
 						"%d/%d",
-					(unsigned int)instance, instance->pid,
+					instance, instance->pid,
 					instance->connected ? " connected, " :
 						"",
 					instance->completion_insert -
@@ -1415,8 +1415,8 @@ vchiq_dump_platform_service_state(void *dump_context, VCHIQ_SERVICE_T *service)
 	char buf[80];
 	int len;
 
-	len = snprintf(buf, sizeof(buf), "  instance %x",
-		(unsigned int)service->instance);
+	len = snprintf(buf, sizeof(buf), "  instance %p",
+		       service->instance);
 
 	if ((service->base.callback == service_callback) &&
 		user_service->is_vchi) {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 2c98da4307df..93a6ac75791f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -380,9 +380,9 @@ make_service_callback(VCHIQ_SERVICE_T *service, VCHIQ_REASON_T reason,
 	VCHIQ_HEADER_T *header, void *bulk_userdata)
 {
 	VCHIQ_STATUS_T status;
-	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %x, %x)",
+	vchiq_log_trace(vchiq_core_log_level, "%d: callback:%d (%s, %p, %p)",
 		service->state->id, service->localport, reason_names[reason],
-		(unsigned int)header, (unsigned int)bulk_userdata);
+		header, bulk_userdata);
 	status = service->base.callback(reason, header, service->handle,
 		bulk_userdata);
 	if (status == VCHIQ_ERROR) {
@@ -626,8 +626,8 @@ process_free_queue(VCHIQ_STATE_T *state)
 		char *data = (char *)SLOT_DATA_FROM_INDEX(state, slot_index);
 		int data_found = 0;
 
-		vchiq_log_trace(vchiq_core_log_level, "%d: pfq %d=%x %x %x",
-			state->id, slot_index, (unsigned int)data,
+		vchiq_log_trace(vchiq_core_log_level, "%d: pfq %d=%p %x %x",
+			state->id, slot_index, data,
 			local->slot_queue_recycle, slot_queue_available);
 
 		/* Initialise the bitmask for services which have used this
@@ -661,13 +661,13 @@ process_free_queue(VCHIQ_STATE_T *state)
 					vchiq_log_error(vchiq_core_log_level,
 						"service %d "
 						"message_use_count=%d "
-						"(header %x, msgid %x, "
+						"(header %p, msgid %x, "
 						"header->msgid %x, "
 						"header->size %x)",
 						port,
 						service_quota->
 							message_use_count,
-						(unsigned int)header, msgid,
+						header, msgid,
 						header->msgid,
 						header->size);
 					WARN(1, "invalid message use count\n");
@@ -690,24 +690,24 @@ process_free_queue(VCHIQ_STATE_T *state)
 						up(&service_quota->quota_event);
 						vchiq_log_trace(
 							vchiq_core_log_level,
-							"%d: pfq:%d %x@%x - "
+							"%d: pfq:%d %x@%p - "
 							"slot_use->%d",
 							state->id, port,
 							header->size,
-							(unsigned int)header,
+							header,
 							count - 1);
 					} else {
 						vchiq_log_error(
 							vchiq_core_log_level,
 								"service %d "
 								"slot_use_count"
-								"=%d (header %x"
+								"=%d (header %p"
 								", msgid %x, "
 								"header->msgid"
 								" %x, header->"
 								"size %x)",
 							port, count,
-							(unsigned int)header,
+							header,
 							msgid,
 							header->msgid,
 							header->size);
@@ -721,9 +721,9 @@ process_free_queue(VCHIQ_STATE_T *state)
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
 				vchiq_log_error(vchiq_core_log_level,
-					"pfq - pos %x: header %x, msgid %x, "
+					"pfq - pos %x: header %p, msgid %x, "
 					"header->msgid %x, header->size %x",
-					pos, (unsigned int)header, msgid,
+					pos, header, msgid,
 					header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
 			}
@@ -868,10 +868,10 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 		int slot_use_count;
 
 		vchiq_log_info(vchiq_core_log_level,
-			"%d: qm %s@%x,%x (%d->%d)",
+			"%d: qm %s@%p,%x (%d->%d)",
 			state->id,
 			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			(unsigned int)header, size,
+			header, size,
 			VCHIQ_MSG_SRCPORT(msgid),
 			VCHIQ_MSG_DSTPORT(msgid));
 
@@ -936,9 +936,9 @@ queue_message(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
 		vchiq_log_info(vchiq_core_log_level,
-			"%d: qm %s@%x,%x (%d->%d)", state->id,
+			"%d: qm %s@%p,%x (%d->%d)", state->id,
 			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			(unsigned int)header, size,
+			header, size,
 			VCHIQ_MSG_SRCPORT(msgid),
 			VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
@@ -1021,9 +1021,9 @@ queue_message_sync(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 		int i, pos;
 
 		vchiq_log_info(vchiq_sync_log_level,
-			"%d: qms %s@%x,%x (%d->%d)", state->id,
+			"%d: qms %s@%p,%x (%d->%d)", state->id,
 			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			(unsigned int)header, size,
+			header, size,
 			VCHIQ_MSG_SRCPORT(msgid),
 			VCHIQ_MSG_DSTPORT(msgid));
 
@@ -1053,9 +1053,9 @@ queue_message_sync(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
 		vchiq_log_info(vchiq_sync_log_level,
-			"%d: qms %s@%x,%x (%d->%d)", state->id,
+			"%d: qms %s@%p,%x (%d->%d)", state->id,
 			msg_type_str(VCHIQ_MSG_TYPE(msgid)),
-			(unsigned int)header, size,
+			header, size,
 			VCHIQ_MSG_SRCPORT(msgid),
 			VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
@@ -1356,26 +1356,26 @@ resolve_bulks(VCHIQ_SERVICE_T *service, VCHIQ_BULK_QUEUE_T *queue)
 				"Send Bulk to" : "Recv Bulk from";
 			if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED)
 				vchiq_log_info(SRVTRACE_LEVEL(service),
-					"%s %c%c%c%c d:%d len:%d %x<->%x",
+					"%s %c%c%c%c d:%d len:%d %p<->%p",
 					header,
 					VCHIQ_FOURCC_AS_4CHARS(
 						service->base.fourcc),
 					service->remoteport,
 					bulk->size,
-					(unsigned int)bulk->data,
-					(unsigned int)bulk->remote_data);
+					bulk->data,
+					bulk->remote_data);
 			else
 				vchiq_log_info(SRVTRACE_LEVEL(service),
 					"%s %c%c%c%c d:%d ABORTED - tx len:%d,"
-					" rx len:%d %x<->%x",
+					" rx len:%d %p<->%p",
 					header,
 					VCHIQ_FOURCC_AS_4CHARS(
 						service->base.fourcc),
 					service->remoteport,
 					bulk->size,
 					bulk->remote_size,
-					(unsigned int)bulk->data,
-					(unsigned int)bulk->remote_data);
+					bulk->data,
+					bulk->remote_data);
 		}
 
 		vchiq_complete_bulk(bulk);
@@ -1511,8 +1511,8 @@ parse_open(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 
 		fourcc = payload->fourcc;
 		vchiq_log_info(vchiq_core_log_level,
-			"%d: prs OPEN@%x (%d->'%c%c%c%c')",
-			state->id, (unsigned int)header,
+			"%d: prs OPEN@%p (%d->'%c%c%c%c')",
+			state->id, header,
 			localport,
 			VCHIQ_FOURCC_AS_4CHARS(fourcc));
 
@@ -1684,20 +1684,20 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 					remoteport);
 				if (service)
 					vchiq_log_warning(vchiq_core_log_level,
-						"%d: prs %s@%x (%d->%d) - "
+						"%d: prs %s@%p (%d->%d) - "
 						"found connected service %d",
 						state->id, msg_type_str(type),
-						(unsigned int)header,
+						header,
 						remoteport, localport,
 						service->localport);
 			}
 
 			if (!service) {
 				vchiq_log_error(vchiq_core_log_level,
-					"%d: prs %s@%x (%d->%d) - "
+					"%d: prs %s@%p (%d->%d) - "
 					"invalid/closed service %d",
 					state->id, msg_type_str(type),
-					(unsigned int)header,
+					header,
 					remoteport, localport, localport);
 				goto skip_message;
 			}
@@ -1726,9 +1726,9 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 		if (((unsigned int)header & VCHIQ_SLOT_MASK) + calc_stride(size)
 			> VCHIQ_SLOT_SIZE) {
 			vchiq_log_error(vchiq_core_log_level,
-				"header %x (msgid %x) - size %x too big for "
+				"header %p (msgid %x) - size %x too big for "
 				"slot",
-				(unsigned int)header, (unsigned int)msgid,
+				header, (unsigned int)msgid,
 				(unsigned int)size);
 			WARN(1, "oversized for slot\n");
 		}
@@ -1747,8 +1747,8 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				service->peer_version = payload->version;
 			}
 			vchiq_log_info(vchiq_core_log_level,
-				"%d: prs OPENACK@%x,%x (%d->%d) v:%d",
-				state->id, (unsigned int)header, size,
+				"%d: prs OPENACK@%p,%x (%d->%d) v:%d",
+				state->id, header, size,
 				remoteport, localport, service->peer_version);
 			if (service->srvstate ==
 				VCHIQ_SRVSTATE_OPENING) {
@@ -1765,8 +1765,8 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 			WARN_ON(size != 0); /* There should be no data */
 
 			vchiq_log_info(vchiq_core_log_level,
-				"%d: prs CLOSE@%x (%d->%d)",
-				state->id, (unsigned int)header,
+				"%d: prs CLOSE@%p (%d->%d)",
+				state->id, header,
 				remoteport, localport);
 
 			mark_service_closing_internal(service, 1);
@@ -1783,8 +1783,8 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 			break;
 		case VCHIQ_MSG_DATA:
 			vchiq_log_info(vchiq_core_log_level,
-				"%d: prs DATA@%x,%x (%d->%d)",
-				state->id, (unsigned int)header, size,
+				"%d: prs DATA@%p,%x (%d->%d)",
+				state->id, header, size,
 				remoteport, localport);
 
 			if ((service->remoteport == remoteport)
@@ -1808,8 +1808,8 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 			break;
 		case VCHIQ_MSG_CONNECT:
 			vchiq_log_info(vchiq_core_log_level,
-				"%d: prs CONNECT@%x",
-				state->id, (unsigned int)header);
+				"%d: prs CONNECT@%p",
+				state->id, header);
 			state->version_common = ((VCHIQ_SLOT_ZERO_T *)
 						 state->slot_data)->version;
 			up(&state->connect);
@@ -1843,12 +1843,12 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				wmb();
 
 				vchiq_log_info(vchiq_core_log_level,
-					"%d: prs %s@%x (%d->%d) %x@%x",
+					"%d: prs %s@%p (%d->%d) %x@%p",
 					state->id, msg_type_str(type),
-					(unsigned int)header,
+					header,
 					remoteport, localport,
 					bulk->remote_size,
-					(unsigned int)bulk->remote_data);
+					bulk->remote_data);
 
 				queue->remote_insert++;
 
@@ -1901,10 +1901,10 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				if ((int)(queue->remote_insert -
 					queue->local_insert) >= 0) {
 					vchiq_log_error(vchiq_core_log_level,
-						"%d: prs %s@%x (%d->%d) "
+						"%d: prs %s@%p (%d->%d) "
 						"unexpected (ri=%d,li=%d)",
 						state->id, msg_type_str(type),
-						(unsigned int)header,
+						header,
 						remoteport, localport,
 						queue->remote_insert,
 						queue->local_insert);
@@ -1921,11 +1921,11 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 				queue->remote_insert++;
 
 				vchiq_log_info(vchiq_core_log_level,
-					"%d: prs %s@%x (%d->%d) %x@%x",
+					"%d: prs %s@%p (%d->%d) %x@%p",
 					state->id, msg_type_str(type),
-					(unsigned int)header,
+					header,
 					remoteport, localport,
-					bulk->actual, (unsigned int)bulk->data);
+					bulk->actual, bulk->data);
 
 				vchiq_log_trace(vchiq_core_log_level,
 					"%d: prs:%d %cx li=%x ri=%x p=%x",
@@ -1947,14 +1947,14 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 			break;
 		case VCHIQ_MSG_PADDING:
 			vchiq_log_trace(vchiq_core_log_level,
-				"%d: prs PADDING@%x,%x",
-				state->id, (unsigned int)header, size);
+				"%d: prs PADDING@%p,%x",
+				state->id, header, size);
 			break;
 		case VCHIQ_MSG_PAUSE:
 			/* If initiated, signal the application thread */
 			vchiq_log_trace(vchiq_core_log_level,
-				"%d: prs PAUSE@%x,%x",
-				state->id, (unsigned int)header, size);
+				"%d: prs PAUSE@%p,%x",
+				state->id, header, size);
 			if (state->conn_state == VCHIQ_CONNSTATE_PAUSED) {
 				vchiq_log_error(vchiq_core_log_level,
 					"%d: PAUSE received in state PAUSED",
@@ -1977,8 +1977,8 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 			break;
 		case VCHIQ_MSG_RESUME:
 			vchiq_log_trace(vchiq_core_log_level,
-				"%d: prs RESUME@%x,%x",
-				state->id, (unsigned int)header, size);
+				"%d: prs RESUME@%p,%x",
+				state->id, header, size);
 			/* Release the slot mutex */
 			mutex_unlock(&state->slot_mutex);
 			if (state->is_master)
@@ -1999,8 +1999,8 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 
 		default:
 			vchiq_log_error(vchiq_core_log_level,
-				"%d: prs invalid msgid %x@%x,%x",
-				state->id, msgid, (unsigned int)header, size);
+				"%d: prs invalid msgid %x@%p,%x",
+				state->id, msgid, header, size);
 			WARN(1, "invalid message\n");
 			break;
 		}
@@ -2165,10 +2165,10 @@ sync_func(void *v)
 
 		if (!service) {
 			vchiq_log_error(vchiq_sync_log_level,
-				"%d: sf %s@%x (%d->%d) - "
+				"%d: sf %s@%p (%d->%d) - "
 				"invalid/closed service %d",
 				state->id, msg_type_str(type),
-				(unsigned int)header,
+				header,
 				remoteport, localport, localport);
 			release_message_sync(state, header);
 			continue;
@@ -2199,8 +2199,8 @@ sync_func(void *v)
 				service->peer_version = payload->version;
 			}
 			vchiq_log_info(vchiq_sync_log_level,
-				"%d: sf OPENACK@%x,%x (%d->%d) v:%d",
-				state->id, (unsigned int)header, size,
+				"%d: sf OPENACK@%p,%x (%d->%d) v:%d",
+				state->id, header, size,
 				remoteport, localport, service->peer_version);
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
 				service->remoteport = remoteport;
@@ -2214,8 +2214,8 @@ sync_func(void *v)
 
 		case VCHIQ_MSG_DATA:
 			vchiq_log_trace(vchiq_sync_log_level,
-				"%d: sf DATA@%x,%x (%d->%d)",
-				state->id, (unsigned int)header, size,
+				"%d: sf DATA@%p,%x (%d->%d)",
+				state->id, header, size,
 				remoteport, localport);
 
 			if ((service->remoteport == remoteport) &&
@@ -2234,8 +2234,8 @@ sync_func(void *v)
 
 		default:
 			vchiq_log_error(vchiq_sync_log_level,
-				"%d: sf unexpected msgid %x@%x,%x",
-				state->id, msgid, (unsigned int)header, size);
+				"%d: sf unexpected msgid %x@%p,%x",
+				state->id, msgid, header, size);
 			release_message_sync(state, header);
 			break;
 		}
@@ -2324,8 +2324,8 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
 	if (slot_zero->magic != VCHIQ_MAGIC) {
 		vchiq_loud_error_header();
 		vchiq_loud_error("Invalid VCHIQ magic value found.");
-		vchiq_loud_error("slot_zero=%x: magic=%x (expected %x)",
-			(unsigned int)slot_zero, slot_zero->magic, VCHIQ_MAGIC);
+		vchiq_loud_error("slot_zero=%p: magic=%x (expected %x)",
+				 slot_zero, slot_zero->magic, VCHIQ_MAGIC);
 		vchiq_loud_error_footer();
 		return VCHIQ_ERROR;
 	}
@@ -2333,9 +2333,9 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
 	if (slot_zero->version < VCHIQ_VERSION_MIN) {
 		vchiq_loud_error_header();
 		vchiq_loud_error("Incompatible VCHIQ versions found.");
-		vchiq_loud_error("slot_zero=%x: VideoCore version=%d "
+		vchiq_loud_error("slot_zero=%p: VideoCore version=%d "
 			"(minimum %d)",
-			(unsigned int)slot_zero, slot_zero->version,
+			slot_zero, slot_zero->version,
 			VCHIQ_VERSION_MIN);
 		vchiq_loud_error("Restart with a newer VideoCore image.");
 		vchiq_loud_error_footer();
@@ -2345,9 +2345,9 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
 	if (VCHIQ_VERSION < slot_zero->version_min) {
 		vchiq_loud_error_header();
 		vchiq_loud_error("Incompatible VCHIQ versions found.");
-		vchiq_loud_error("slot_zero=%x: version=%d (VideoCore "
+		vchiq_loud_error("slot_zero=%p: version=%d (VideoCore "
 			"minimum %d)",
-			(unsigned int)slot_zero, VCHIQ_VERSION,
+			slot_zero, VCHIQ_VERSION,
 			slot_zero->version_min);
 		vchiq_loud_error("Restart with a newer kernel.");
 		vchiq_loud_error_footer();
@@ -2360,25 +2360,25 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero,
 		 (slot_zero->max_slots_per_side != VCHIQ_MAX_SLOTS_PER_SIDE)) {
 		vchiq_loud_error_header();
 		if (slot_zero->slot_zero_size != sizeof(VCHIQ_SLOT_ZERO_T))
-			vchiq_loud_error("slot_zero=%x: slot_zero_size=%x "
+			vchiq_loud_error("slot_zero=%p: slot_zero_size=%x "
 				"(expected %x)",
-				(unsigned int)slot_zero,
+				slot_zero,
 				slot_zero->slot_zero_size,
 				sizeof(VCHIQ_SLOT_ZERO_T));
 		if (slot_zero->slot_size != VCHIQ_SLOT_SIZE)
-			vchiq_loud_error("slot_zero=%x: slot_size=%d "
+			vchiq_loud_error("slot_zero=%p: slot_size=%d "
 				"(expected %d",
-				(unsigned int)slot_zero, slot_zero->slot_size,
+				slot_zero, slot_zero->slot_size,
 				VCHIQ_SLOT_SIZE);
 		if (slot_zero->max_slots != VCHIQ_MAX_SLOTS)
-			vchiq_loud_error("slot_zero=%x: max_slots=%d "
+			vchiq_loud_error("slot_zero=%p: max_slots=%d "
 				"(expected %d)",
-				(unsigned int)slot_zero, slot_zero->max_slots,
+				slot_zero, slot_zero->max_slots,
 				VCHIQ_MAX_SLOTS);
 		if (slot_zero->max_slots_per_side != VCHIQ_MAX_SLOTS_PER_SIDE)
-			vchiq_loud_error("slot_zero=%x: max_slots_per_side=%d "
+			vchiq_loud_error("slot_zero=%p: max_slots_per_side=%d "
 				"(expected %d)",
-				(unsigned int)slot_zero,
+				slot_zero,
 				slot_zero->max_slots_per_side,
 				VCHIQ_MAX_SLOTS_PER_SIDE);
 		vchiq_loud_error_footer();
@@ -2756,18 +2756,18 @@ release_service_messages(VCHIQ_SERVICE_T *service)
 				if ((port == service->localport) &&
 					(msgid & VCHIQ_MSGID_CLAIMED)) {
 					vchiq_log_info(vchiq_core_log_level,
-						"  fsi - hdr %x",
-						(unsigned int)header);
+						"  fsi - hdr %p",
+						header);
 					release_slot(state, slot_info, header,
 						NULL);
 				}
 				pos += calc_stride(header->size);
 				if (pos > VCHIQ_SLOT_SIZE) {
 					vchiq_log_error(vchiq_core_log_level,
-						"fsi - pos %x: header %x, "
+						"fsi - pos %x: header %p, "
 						"msgid %x, header->msgid %x, "
 						"header->size %x",
-						pos, (unsigned int)header,
+						pos, header,
 						msgid, header->msgid,
 						header->size);
 					WARN(1, "invalid slot position\n");
@@ -3341,10 +3341,10 @@ vchiq_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle,
 	wmb();
 
 	vchiq_log_info(vchiq_core_log_level,
-		"%d: bt (%d->%d) %cx %x@%x %x",
+		"%d: bt (%d->%d) %cx %x@%p %p",
 		state->id,
 		service->localport, service->remoteport, dir_char,
-		size, (unsigned int)bulk->data, (unsigned int)userdata);
+		size, bulk->data, userdata);
 
 	/* The slot mutex must be held when the service is being closed, so
 	   claim it here to ensure that isn't happening */
@@ -3691,12 +3691,12 @@ vchiq_dump_state(void *dump_context, VCHIQ_STATE_T *state)
 	vchiq_dump(dump_context, buf, len + 1);
 
 	len = snprintf(buf, sizeof(buf),
-		"  tx_pos=%x(@%x), rx_pos=%x(@%x)",
+		"  tx_pos=%x(@%p), rx_pos=%x(@%p)",
 		state->local->tx_pos,
-		(uint32_t)state->tx_data +
+		state->tx_data +
 			(state->local_tx_pos & VCHIQ_SLOT_MASK),
 		state->rx_pos,
-		(uint32_t)state->rx_data +
+		state->rx_data +
 			(state->rx_pos & VCHIQ_SLOT_MASK));
 	vchiq_dump(dump_context, buf, len + 1);
 
-- 
2.9.3
