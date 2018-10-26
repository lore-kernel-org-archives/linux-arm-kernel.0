From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Fri, 26 Oct 2018 15:47:57 +0200
Subject: [PATCH RFC 02/18] staging: vchiq_arm: rework close/remove_service
 IOCTLS
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
Message-ID: <20181026134813.7775-3-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implementation of both IOCTLS was the same except for one function
call. This joins both implementations and updates the code to avoid
unneeded indentations.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 66 +++++++------------
 1 file changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6d503392341e..d88dd7415e1e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1019,55 +1019,37 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 	} break;
 
-	case VCHIQ_IOC_CLOSE_SERVICE: {
+	case VCHIQ_IOC_CLOSE_SERVICE:
+	case VCHIQ_IOC_REMOVE_SERVICE: {
 		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+		USER_SERVICE_T *user_service;
 
 		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
-			USER_SERVICE_T *user_service =
-				(USER_SERVICE_T *)service->base.userdata;
-			/* close_pending is false on first entry, and when the
-			   wait in vchiq_close_service has been interrupted. */
-			if (!user_service->close_pending) {
-				status = vchiq_close_service(service->handle);
-				if (status != VCHIQ_SUCCESS)
-					break;
-			}
-
-			/* close_pending is true once the underlying service
-			   has been closed until the client library calls the
-			   CLOSE_DELIVERED ioctl, signalling close_event. */
-			if (user_service->close_pending &&
-				down_interruptible(&user_service->close_event))
-				status = VCHIQ_RETRY;
-		} else
+		if (!service) {
 			ret = -EINVAL;
-	} break;
+			break;
+		}
 
-	case VCHIQ_IOC_REMOVE_SERVICE: {
-		VCHIQ_SERVICE_HANDLE_T handle = (VCHIQ_SERVICE_HANDLE_T)arg;
+		user_service = service->base.userdata;
 
-		service = find_service_for_instance(instance, handle);
-		if (service != NULL) {
-			USER_SERVICE_T *user_service =
-				(USER_SERVICE_T *)service->base.userdata;
-			/* close_pending is false on first entry, and when the
-			   wait in vchiq_close_service has been interrupted. */
-			if (!user_service->close_pending) {
-				status = vchiq_remove_service(service->handle);
-				if (status != VCHIQ_SUCCESS)
-					break;
-			}
+		/* close_pending is false on first entry, and when the
+		   wait in vchiq_close_service has been interrupted. */
+		if (!user_service->close_pending) {
+			status = (cmd == VCHIQ_IOC_CLOSE_SERVICE) ?
+				 vchiq_close_service(service->handle) :
+				 vchiq_remove_service(service->handle);
+			if (status != VCHIQ_SUCCESS)
+				break;
+		}
 
-			/* close_pending is true once the underlying service
-			   has been closed until the client library calls the
-			   CLOSE_DELIVERED ioctl, signalling close_event. */
-			if (user_service->close_pending &&
-				down_interruptible(&user_service->close_event))
-				status = VCHIQ_RETRY;
-		} else
-			ret = -EINVAL;
-	} break;
+		/* close_pending is true once the underlying service
+		   has been closed until the client library calls the
+		   CLOSE_DELIVERED ioctl, signalling close_event. */
+		if (user_service->close_pending &&
+			down_interruptible(&user_service->close_event))
+			status = VCHIQ_RETRY;
+		break;
+	}
 
 	case VCHIQ_IOC_USE_SERVICE:
 	case VCHIQ_IOC_RELEASE_SERVICE:	{
-- 
2.19.1
