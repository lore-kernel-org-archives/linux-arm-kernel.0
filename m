From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 31 Dec 2016 23:00:09 +0100
Subject: [PATCH 2/6] staging: vchiq_arm: Adjust 13 checks for null pointers
In-Reply-To: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
References: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
Message-ID: <2b11ef55-9123-3d0e-fb04-dca8cc3b5081@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 31 Dec 2016 21:23:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" pointed information out like the following.

Comparison to NULL could be written ?

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 34 ++++++++++------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 4af77d790ae0..2a260034189d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -533,7 +533,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		/* Remove all services */
 		i = 0;
 		while ((service = next_service_by_instance(instance->state,
-			instance, &i)) != NULL) {
+							   instance, &i))) {
 			status = vchiq_remove_service(service->handle);
 			unlock_service(service);
 			if (status != VCHIQ_SUCCESS)
@@ -614,7 +614,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				&args.params, srvstate,
 				instance, user_service_free);
 
-		if (service != NULL) {
+		if (service) {
 			user_service->service = service;
 			user_service->userdata = userdata;
 			user_service->instance = instance;
@@ -661,7 +661,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
 
 		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
+		if (service) {
 			USER_SERVICE_T *user_service =
 				(USER_SERVICE_T *)service->base.userdata;
 			/* close_pending is false on first entry, and when the
@@ -687,7 +687,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
 
 		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
+		if (service) {
 			USER_SERVICE_T *user_service =
 				(USER_SERVICE_T *)service->base.userdata;
 			/* close_pending is false on first entry, and when the
@@ -714,7 +714,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
 
 		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
+		if (service) {
 			status = (cmd == VCHIQ_IOC_USE_SERVICE)	?
 				vchiq_use_service_internal(service) :
 				vchiq_release_service_internal(service);
@@ -747,7 +747,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 		service = find_service_for_instance(instance, args.handle);
 
-		if ((service != NULL) && (args.count <= MAX_ELEMENTS)) {
+		if (service && (args.count <= MAX_ELEMENTS)) {
 			/* Copy elements into kernel space */
 			VCHIQ_ELEMENT_T elements[MAX_ELEMENTS];
 			if (copy_from_user(elements, args.elements,
@@ -1063,11 +1063,11 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		spin_unlock(&msg_queue_spinlock);
 
 		up(&user_service->remove_event);
-		if (header == NULL)
+		if (!header)
 			ret = -ENOTCONN;
 		else if (header->size <= args.bufsize) {
 			/* Copy to user space if msgbuf is not NULL */
-			if ((args.buf == NULL) ||
+			if (!args.buf ||
 				(copy_to_user((void __user *)args.buf,
 				header->data,
 				header->size) == 0)) {
@@ -1161,7 +1161,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
 
 		service = find_closed_service_for_instance(instance, handle);
-		if (service != NULL) {
+		if (service) {
 			USER_SERVICE_T *user_service =
 				(USER_SERVICE_T *)service->base.userdata;
 			close_delivered(user_service);
@@ -1559,7 +1559,7 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 
 	num_pages = (offset + num_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
 	pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL);
-	if (pages == NULL) {
+	if (!pages) {
 		vchiq_log_error(vchiq_arm_log_level,
 			"Unable to allocation memory for %d pages\n",
 			num_pages);
@@ -1590,8 +1590,7 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 		page_idx = offset / PAGE_SIZE;
 
 		if (page_idx != prev_idx) {
-
-			if (page != NULL)
+			if (page)
 				kunmap(page);
 			page = pages[page_idx];
 			kmapped_virt_ptr = kmap(page);
@@ -1609,7 +1608,7 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 	}
 
 out:
-	if (page != NULL)
+	if (page)
 		kunmap(page);
 
 	for (page_idx = 0; page_idx < num_pages; page_idx++)
@@ -1644,14 +1643,13 @@ vchiq_read(struct file *file, char __user *buf,
 VCHIQ_STATE_T *
 vchiq_get_state(void)
 {
-
-	if (g_state.remote == NULL)
+	if (!g_state.remote)
 		printk(KERN_ERR "%s: g_state.remote == NULL\n", __func__);
 	else if (g_state.remote->initialised != 1)
 		printk(KERN_NOTICE "%s: g_state.remote->initialised != 1 (%d)\n",
 			__func__, g_state.remote->initialised);
 
-	return ((g_state.remote != NULL) &&
+	return (g_state.remote &&
 		(g_state.remote->initialised == 1)) ? &g_state : NULL;
 }
 
@@ -2655,7 +2653,7 @@ vchiq_instance_get_use_count(VCHIQ_INSTANCE_T instance)
 	int use_count = 0, i;
 	i = 0;
 	while ((service = next_service_by_instance(instance->state,
-		instance, &i)) != NULL) {
+						   instance, &i))) {
 		use_count += service->service_use_count;
 		unlock_service(service);
 	}
@@ -2681,7 +2679,7 @@ vchiq_instance_set_trace(VCHIQ_INSTANCE_T instance, int trace)
 	int i;
 	i = 0;
 	while ((service = next_service_by_instance(instance->state,
-		instance, &i)) != NULL) {
+						   instance, &i))) {
 		service->trace = trace;
 		unlock_service(service);
 	}
-- 
2.11.0
