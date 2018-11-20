From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Tue, 20 Nov 2018 15:53:39 +0100
Subject: [PATCH 04/16] staging: vchiq_arm: use list_for_each_entry when
 accessing bulk_waiter_list
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
Message-ID: <20181120145351.30390-5-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The resulting code is way more readeable and intuitive compared to plain
list_for_each.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 52 ++++++-------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 835152799433..76de36e9e3b6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -280,16 +280,11 @@ VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 		"%s(%p): returning %d", __func__, instance, status);
 
 	if (status == VCHIQ_SUCCESS) {
-		struct list_head *pos, *next;
+		struct bulk_waiter_node *waiter, *next;
 
-		list_for_each_safe(pos, next,
-				&instance->bulk_waiter_list) {
-			struct bulk_waiter_node *waiter;
-
-			waiter = list_entry(pos,
-					struct bulk_waiter_node,
-					list);
-			list_del(pos);
+		list_for_each_entry_safe(waiter, next,
+					 &instance->bulk_waiter_list, list) {
+			list_del(&waiter->list);
 			vchiq_log_info(vchiq_arm_log_level,
 					"bulk_waiter - cleaned up %pK for pid %d",
 					waiter, waiter->pid);
@@ -473,7 +468,6 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 	VCHIQ_SERVICE_T *service;
 	VCHIQ_STATUS_T status;
 	struct bulk_waiter_node *waiter = NULL;
-	struct list_head *pos;
 
 	service = find_service_by_handle(handle);
 	if (!service)
@@ -484,13 +478,9 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 	unlock_service(service);
 
 	mutex_lock(&instance->bulk_waiter_list_mutex);
-	list_for_each(pos, &instance->bulk_waiter_list) {
-		if (list_entry(pos, struct bulk_waiter_node,
-				list)->pid == current->pid) {
-			waiter = list_entry(pos,
-				struct bulk_waiter_node,
-				list);
-			list_del(pos);
+	list_for_each_entry(waiter, &instance->bulk_waiter_list, list) {
+		if (waiter->pid == current->pid) {
+			list_del(&waiter->list);
 			break;
 		}
 	}
@@ -1135,21 +1125,16 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				ret = -ENOMEM;
 				break;
 			}
+
 			args.userdata = &waiter->bulk_waiter;
 		} else if (args.mode == VCHIQ_BULK_MODE_WAITING) {
-			struct list_head *pos;
-
 			mutex_lock(&instance->bulk_waiter_list_mutex);
-			list_for_each(pos, &instance->bulk_waiter_list) {
-				if (list_entry(pos, struct bulk_waiter_node,
-					list)->pid == current->pid) {
-					waiter = list_entry(pos,
-						struct bulk_waiter_node,
-						list);
-					list_del(pos);
+			list_for_each_entry(waiter, &instance->bulk_waiter_list,
+					    list) {
+				if (waiter->pid == current->pid) {
+					list_del(&waiter->list);
 					break;
 				}
-
 			}
 			mutex_unlock(&instance->bulk_waiter_list_mutex);
 			if (!waiter) {
@@ -2163,16 +2148,11 @@ vchiq_release(struct inode *inode, struct file *file)
 		vchiq_release_internal(instance->state, NULL);
 
 		{
-			struct list_head *pos, *next;
-
-			list_for_each_safe(pos, next,
-				&instance->bulk_waiter_list) {
-				struct bulk_waiter_node *waiter;
+			struct bulk_waiter_node *waiter, *next;
 
-				waiter = list_entry(pos,
-					struct bulk_waiter_node,
-					list);
-				list_del(pos);
+			list_for_each_entry_safe(waiter, next,
+					&instance->bulk_waiter_list, list) {
+				list_del(&waiter->list);
 				vchiq_log_info(vchiq_arm_log_level,
 					"bulk_waiter - cleaned up %pK for pid %d",
 					waiter, waiter->pid);
-- 
2.19.1
