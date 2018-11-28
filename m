From: szekelyszilv@gmail.com (=?UTF-8?q?Szilveszter=20Sz=C3=A9kely?=)
Date: Wed, 28 Nov 2018 23:40:32 +0000
Subject: [PATCH] staging: vchiq_arm: add __user pointer annotations
Message-ID: <20181128234032.7170-1-szekelyszilv@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add __user to pointers based on context and suggestions by sparse.

Other sparse warnings still remain, in cases where more change would be
required apart from adding __user.

Signed-off-by: Szilveszter Sz?kely <szekelyszilv@gmail.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 28 +++++++++----------
 .../interface/vchiq_arm/vchiq_if.h            |  2 +-
 .../interface/vchiq_arm/vchiq_ioctl.h         |  4 +--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 0caee2d69..f28f68119 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1593,7 +1593,7 @@ vchiq_compat_ioctl_queue_message(struct file *file,
 				 unsigned long arg)
 {
 	VCHIQ_QUEUE_MESSAGE_T *args;
-	struct vchiq_element *elements;
+	struct vchiq_element __user *elements;
 	struct vchiq_queue_message32 args32;
 	unsigned int count;
 
@@ -1659,7 +1659,7 @@ vchiq_compat_ioctl_queue_bulk(struct file *file,
 			      unsigned int cmd,
 			      unsigned long arg)
 {
-	VCHIQ_QUEUE_BULK_TRANSFER_T *args;
+	VCHIQ_QUEUE_BULK_TRANSFER_T __user *args;
 	struct vchiq_queue_bulk_transfer32 args32;
 	struct vchiq_queue_bulk_transfer32 *ptrargs32 =
 		(struct vchiq_queue_bulk_transfer32 *)arg;
@@ -1725,16 +1725,16 @@ vchiq_compat_ioctl_await_completion(struct file *file,
 				    unsigned int cmd,
 				    unsigned long arg)
 {
-	VCHIQ_AWAIT_COMPLETION_T *args;
-	VCHIQ_COMPLETION_DATA_T *completion;
+	VCHIQ_AWAIT_COMPLETION_T __user *args;
+	VCHIQ_COMPLETION_DATA_T __user *completion;
 	VCHIQ_COMPLETION_DATA_T completiontemp;
 	struct vchiq_await_completion32 args32;
 	struct vchiq_completion_data32 completion32;
-	unsigned int *msgbufcount32;
+	unsigned int __user *msgbufcount32;
 	unsigned int msgbufcount_native;
 	compat_uptr_t msgbuf32;
-	void *msgbuf;
-	void **msgbufptr;
+	void __user *msgbuf;
+	void * __user *msgbufptr;
 	long ret;
 
 	args = compat_alloc_user_space(sizeof(*args) +
@@ -1743,11 +1743,11 @@ vchiq_compat_ioctl_await_completion(struct file *file,
 	if (!args)
 		return -EFAULT;
 
-	completion = (VCHIQ_COMPLETION_DATA_T *)(args + 1);
-	msgbufptr = (void __user **)(completion + 1);
+	completion = (VCHIQ_COMPLETION_DATA_T __user *)(args + 1);
+	msgbufptr = (void * __user *)(completion + 1);
 
 	if (copy_from_user(&args32,
-			   (struct vchiq_completion_data32 *)arg,
+			   (struct vchiq_completion_data32 __user *)arg,
 			   sizeof(args32)))
 		return -EFAULT;
 
@@ -1875,7 +1875,7 @@ vchiq_compat_ioctl_dequeue_message(struct file *file,
 				   unsigned int cmd,
 				   unsigned long arg)
 {
-	VCHIQ_DEQUEUE_MESSAGE_T *args;
+	VCHIQ_DEQUEUE_MESSAGE_T __user *args;
 	struct vchiq_dequeue_message32 args32;
 
 	args = compat_alloc_user_space(sizeof(*args));
@@ -1883,7 +1883,7 @@ vchiq_compat_ioctl_dequeue_message(struct file *file,
 		return -EFAULT;
 
 	if (copy_from_user(&args32,
-			   (struct vchiq_dequeue_message32 *)arg,
+			   (struct vchiq_dequeue_message32 __user *)arg,
 			   sizeof(args32)))
 		return -EFAULT;
 
@@ -1910,7 +1910,7 @@ vchiq_compat_ioctl_get_config(struct file *file,
 			      unsigned int cmd,
 			      unsigned long arg)
 {
-	VCHIQ_GET_CONFIG_T *args;
+	VCHIQ_GET_CONFIG_T __user *args;
 	struct vchiq_get_config32 args32;
 
 	args = compat_alloc_user_space(sizeof(*args));
@@ -1918,7 +1918,7 @@ vchiq_compat_ioctl_get_config(struct file *file,
 		return -EFAULT;
 
 	if (copy_from_user(&args32,
-			   (struct vchiq_get_config32 *)arg,
+			   (struct vchiq_get_config32 __user *)arg,
 			   sizeof(args32)))
 		return -EFAULT;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 7b948a173..0cdaebee9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -87,7 +87,7 @@ typedef struct vchiq_header_struct {
 } VCHIQ_HEADER_T;
 
 struct vchiq_element {
-	const void *data;
+	const void __user *data;
 	unsigned int size;
 };
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 9f859953f..858f46bd2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -50,7 +50,7 @@ typedef struct {
 typedef struct {
 	unsigned int handle;
 	unsigned int count;
-	const struct vchiq_element *elements;
+	const struct vchiq_element __user *elements;
 } VCHIQ_QUEUE_MESSAGE_T;
 
 typedef struct {
@@ -85,7 +85,7 @@ typedef struct {
 
 typedef struct {
 	unsigned int config_size;
-	VCHIQ_CONFIG_T *pconfig;
+	VCHIQ_CONFIG_T __user *pconfig;
 } VCHIQ_GET_CONFIG_T;
 
 typedef struct {
-- 
2.19.2
