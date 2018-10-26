From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Fri, 26 Oct 2018 15:47:58 +0200
Subject: [PATCH RFC 03/18] staging: vchiq_shim: delete vchi_service_create
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
Message-ID: <20181026134813.7775-4-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No one is using the API neither in the actual staging tree nor in the
downstream tree (https://github.com/raspberrypi/linux).

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       |  5 ---
 .../interface/vchiq_arm/vchiq_shim.c          | 32 -------------------
 2 files changed, 37 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 01381904775d..379a16ebfd5b 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -113,11 +113,6 @@ extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
 /******************************************************************************
  Global service API
  *****************************************************************************/
-// Routine to create a named service
-extern int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
-				   SERVICE_CREATION_T *setup,
-				   VCHI_SERVICE_HANDLE_T *handle);
-
 // Routine to destroy a service
 extern int32_t vchi_service_destroy(const VCHI_SERVICE_HANDLE_T handle);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index c3223fcdaf87..81cac68f4b78 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -660,38 +660,6 @@ int32_t vchi_service_open(VCHI_INSTANCE_T instance_handle,
 }
 EXPORT_SYMBOL(vchi_service_open);
 
-int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
-	SERVICE_CREATION_T *setup,
-	VCHI_SERVICE_HANDLE_T *handle)
-{
-	VCHIQ_INSTANCE_T instance = (VCHIQ_INSTANCE_T)instance_handle;
-	struct shim_service *service = service_alloc(instance, setup);
-
-	*handle = (VCHI_SERVICE_HANDLE_T)service;
-
-	if (service) {
-		VCHIQ_SERVICE_PARAMS_T params;
-		VCHIQ_STATUS_T status;
-
-		memset(&params, 0, sizeof(params));
-		params.fourcc = setup->service_id;
-		params.callback = shim_callback;
-		params.userdata = service;
-		params.version = setup->version.version;
-		params.version_min = setup->version.version_min;
-		status = vchiq_add_service(instance, &params, &service->handle);
-
-		if (status != VCHIQ_SUCCESS) {
-			service_free(service);
-			service = NULL;
-			*handle = NULL;
-		}
-	}
-
-	return (service != NULL) ? 0 : -1;
-}
-EXPORT_SYMBOL(vchi_service_create);
-
 int32_t vchi_service_close(const VCHI_SERVICE_HANDLE_T handle)
 {
 	int32_t ret = -1;
-- 
2.19.1
