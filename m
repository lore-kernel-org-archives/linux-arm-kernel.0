From: maninder.s2@samsung.com (Maninder Singh)
Date: Fri, 11 Nov 2016 17:46:45 +0530
Subject: [PATCH] staging: vc04_services: Remove explicit NULL pointer
Message-ID: <1478866605-1561-1-git-send-email-maninder.s2@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace direct comparisons to NULL i.e.
'x == NULL' with '!x'
'x != NULL' with 'x'

Signed-off-by: Maninder Singh <maninder.s2@samsung.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   32 ++++++++++----------
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |    4 +--
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c |    4 +--
 .../vc04_services/interface/vchiq_arm/vchiq_util.c |    4 +--
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 8fcd940..0068a1c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -533,7 +533,7 @@ struct vchiq_io_copy_callback_context {
 		/* Remove all services */
 		i = 0;
 		while ((service = next_service_by_instance(instance->state,
-			instance, &i)) != NULL) {
+			instance, &i))) {
 			status = vchiq_remove_service(service->handle);
 			unlock_service(service);
 			if (status != VCHIQ_SUCCESS)
@@ -614,7 +614,7 @@ struct vchiq_io_copy_callback_context {
 				&args.params, srvstate,
 				instance, user_service_free);
 
-		if (service != NULL) {
+		if (service) {
 			user_service->service = service;
 			user_service->userdata = userdata;
 			user_service->instance = instance;
@@ -661,7 +661,7 @@ struct vchiq_io_copy_callback_context {
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
 
 		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
+		if (service) {
 			USER_SERVICE_T *user_service =
 				(USER_SERVICE_T *)service->base.userdata;
 			/* close_pending is false on first entry, and when the
@@ -687,7 +687,7 @@ struct vchiq_io_copy_callback_context {
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
 
 		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
+		if (service) {
 			USER_SERVICE_T *user_service =
 				(USER_SERVICE_T *)service->base.userdata;
 			/* close_pending is false on first entry, and when the
@@ -714,7 +714,7 @@ struct vchiq_io_copy_callback_context {
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
 
 		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
+		if (service) {
 			status = (cmd == VCHIQ_IOC_USE_SERVICE)	?
 				vchiq_use_service_internal(service) :
 				vchiq_release_service_internal(service);
@@ -747,7 +747,7 @@ struct vchiq_io_copy_callback_context {
 
 		service = find_service_for_instance(instance, args.handle);
 
-		if ((service != NULL) && (args.count <= MAX_ELEMENTS)) {
+		if (service && (args.count <= MAX_ELEMENTS)) {
 			/* Copy elements into kernel space */
 			VCHIQ_ELEMENT_T elements[MAX_ELEMENTS];
 			if (copy_from_user(elements, args.elements,
@@ -1063,7 +1063,7 @@ struct vchiq_io_copy_callback_context {
 		spin_unlock(&msg_queue_spinlock);
 
 		up(&user_service->remove_event);
-		if (header == NULL)
+		if (!header)
 			ret = -ENOTCONN;
 		else if (header->size <= args.bufsize) {
 			/* Copy to user space if msgbuf is not NULL */
@@ -1161,7 +1161,7 @@ struct vchiq_io_copy_callback_context {
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
 
 		service = find_closed_service_for_instance(instance, handle);
-		if (service != NULL) {
+		if (service) {
 			USER_SERVICE_T *user_service =
 				(USER_SERVICE_T *)service->base.userdata;
 			close_delivered(user_service);
@@ -1305,7 +1305,7 @@ struct vchiq_io_copy_callback_context {
 		/* Mark all services for termination... */
 		i = 0;
 		while ((service = next_service_by_instance(state, instance,
-			&i)) !=	NULL) {
+			&i))) {
 			USER_SERVICE_T *user_service = service->base.userdata;
 
 			/* Wake the slot handler if the msg queue is full. */
@@ -1317,8 +1317,8 @@ struct vchiq_io_copy_callback_context {
 
 		/* ...and wait for them to die */
 		i = 0;
-		while ((service = next_service_by_instance(state, instance, &i))
-			!= NULL) {
+		while ((service = next_service_by_instance(state,
+							   instance, &i))) {
 			USER_SERVICE_T *user_service = service->base.userdata;
 
 			down(&service->remove_event);
@@ -1560,7 +1560,7 @@ struct vchiq_io_copy_callback_context {
 	num_pages = (offset + num_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
 
 	pages = kmalloc(sizeof(struct page *) * num_pages, GFP_KERNEL);
-	if (pages == NULL) {
+	if (!pages) {
 		vchiq_log_error(vchiq_arm_log_level,
 			"Unable to allocation memory for %d pages\n",
 			num_pages);
@@ -1592,7 +1592,7 @@ struct vchiq_io_copy_callback_context {
 
 		if (page_idx != prev_idx) {
 
-			if (page != NULL)
+			if (page)
 				kunmap(page);
 			page = pages[page_idx];
 			kmapped_virt_ptr = kmap(page);
@@ -1610,7 +1610,7 @@ struct vchiq_io_copy_callback_context {
 	}
 
 out:
-	if (page != NULL)
+	if (page)
 		kunmap(page);
 
 	for (page_idx = 0; page_idx < num_pages; page_idx++)
@@ -2659,7 +2659,7 @@ struct vchiq_io_copy_callback_context {
 	int use_count = 0, i;
 	i = 0;
 	while ((service = next_service_by_instance(instance->state,
-		instance, &i)) != NULL) {
+		instance, &i))) {
 		use_count += service->service_use_count;
 		unlock_service(service);
 	}
@@ -2685,7 +2685,7 @@ struct vchiq_io_copy_callback_context {
 	int i;
 	i = 0;
 	while ((service = next_service_by_instance(instance->state,
-		instance, &i)) != NULL) {
+		instance, &i))) {
 		service->trace = trace;
 		unlock_service(service);
 	}
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 7440db2..82f6496 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3273,7 +3273,7 @@ static const char *msg_type_str(unsigned int msg_type)
 
 	if (!service ||
 		 (service->srvstate != VCHIQ_SRVSTATE_OPEN) ||
-		 ((memhandle == VCHI_MEM_HANDLE_INVALID) && (offset == NULL)) ||
+		 ((memhandle == VCHI_MEM_HANDLE_INVALID) && (!offset)) ||
 		 (vchiq_check_service(service) != VCHIQ_SUCCESS))
 		goto error_exit;
 
@@ -3910,7 +3910,7 @@ void vchiq_log_dump_mem(const char *label, uint32_t addr, const void *void_mem,
 		}
 		*s++ = '\0';
 
-		if ((label != NULL) && (*label != '\0'))
+		if (label && (*label != '\0'))
 			vchiq_log_trace(VCHIQ_LOG_TRACE,
 				"%s: %08x: %s", label, addr, line_buf);
 		else
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index d977139..b6d0a75 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -639,7 +639,7 @@ int32_t vchi_service_open(VCHI_INSTANCE_T instance_handle,
 		}
 	}
 
-	return (service != NULL) ? 0 : -1;
+	return (service) ? 0 : -1;
 }
 EXPORT_SYMBOL(vchi_service_open);
 
@@ -671,7 +671,7 @@ int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
 		}
 	}
 
-	return (service != NULL) ? 0 : -1;
+	return (service) ? 0 : -1;
 }
 EXPORT_SYMBOL(vchi_service_create);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 384acb8..ac6a386 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -52,7 +52,7 @@ int vchiu_queue_init(VCHIU_QUEUE_T *queue, int size)
 	sema_init(&queue->push, 0);
 
 	queue->storage = kzalloc(size * sizeof(VCHIQ_HEADER_T *), GFP_KERNEL);
-	if (queue->storage == NULL) {
+	if (!queue->storage) {
 		vchiu_queue_delete(queue);
 		return 0;
 	}
@@ -61,7 +61,7 @@ int vchiu_queue_init(VCHIU_QUEUE_T *queue, int size)
 
 void vchiu_queue_delete(VCHIU_QUEUE_T *queue)
 {
-	if (queue->storage != NULL)
+	if (queue->storage)
 		kfree(queue->storage);
 }
 
-- 
1.7.9.5
