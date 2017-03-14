From: pushkar.iit@gmail.com (Pushkar Jambhlekar)
Date: Tue, 14 Mar 2017 18:39:04 +0530
Subject: [PATCH] vc04_services: Fixing coding and logical guidelines
Message-ID: <1489496944-44038-1-git-send-email-pushkar.iit@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Description:
    in file 'vc04_services/interface/vchiq_arm/vchiq_shim.c', making changes to make code according to 'checkpath.pl'.
Also, fixing logical issue, i.e. removing break after goto statement.

Signed-off-by: Pushkar Jambhlekar <pushkar.iit@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c | 33 ++++++++++++++++------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 48984ab..6d8a1d8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -52,7 +52,8 @@ typedef struct {
 
 /* ----------------------------------------------------------------------
  * return pointer to the mphi message driver function table
- * -------------------------------------------------------------------- */
+ * ----------------------------------------------------------------------
+ */
 const VCHI_MESSAGE_DRIVER_T *
 vchi_mphi_message_driver_func_table(void)
 {
@@ -61,7 +62,8 @@ vchi_mphi_message_driver_func_table(void)
 
 /* ----------------------------------------------------------------------
  * return a pointer to the 'single' connection driver fops
- * -------------------------------------------------------------------- */
+ * ----------------------------------------------------------------------
+ */
 const VCHI_CONNECTION_API_T *
 single_get_func_table(void)
 {
@@ -556,6 +558,7 @@ EXPORT_SYMBOL(vchi_connect);
 int32_t vchi_disconnect(VCHI_INSTANCE_T instance_handle)
 {
 	VCHIQ_INSTANCE_T instance = (VCHIQ_INSTANCE_T)instance_handle;
+
 	return vchiq_status_to_vchi(vchiq_shutdown(instance));
 }
 EXPORT_SYMBOL(vchi_disconnect);
@@ -592,7 +595,6 @@ static VCHIQ_STATUS_T shim_callback(VCHIQ_REASON_T reason,
 				  VCHI_CALLBACK_MSG_AVAILABLE, NULL);
 
 		goto done;
-		break;
 
 	case VCHIQ_BULK_TRANSMIT_DONE:
 		service->callback(service->callback_param,
@@ -733,8 +735,10 @@ int32_t vchi_service_close(const VCHI_SERVICE_HANDLE_T handle)
 {
 	int32_t ret = -1;
 	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
+
 	if (service) {
 		VCHIQ_STATUS_T status = vchiq_close_service(service->handle);
+
 		if (status == VCHIQ_SUCCESS) {
 			service_free(service);
 			service = NULL;
@@ -750,8 +754,10 @@ int32_t vchi_service_destroy(const VCHI_SERVICE_HANDLE_T handle)
 {
 	int32_t ret = -1;
 	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
+
 	if (service) {
 		VCHIQ_STATUS_T status = vchiq_remove_service(service->handle);
+
 		if (status == VCHIQ_SUCCESS) {
 			service_free(service);
 			service = NULL;
@@ -770,6 +776,7 @@ int32_t vchi_service_set_option(const VCHI_SERVICE_HANDLE_T handle,
 	int32_t ret = -1;
 	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
 	VCHIQ_SERVICE_OPTION_T vchiq_option;
+
 	switch (option) {
 	case VCHI_SERVICE_OPTION_TRACE:
 		vchiq_option = VCHIQ_SERVICE_OPTION_TRACE;
@@ -797,8 +804,8 @@ int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle, short *peer_ve
 {
 	int32_t ret = -1;
 	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
-	if (service)
-	{
+
+	if (service) {
 		VCHIQ_STATUS_T status;
 
 		status = vchiq_get_peer_version(service->handle, peer_version);
@@ -811,7 +818,8 @@ EXPORT_SYMBOL(vchi_get_peer_version);
 /* ----------------------------------------------------------------------
  * read a uint32_t from buffer.
  * network format is defined to be little endian
- * -------------------------------------------------------------------- */
+ * ----------------------------------------------------------------------
+ */
 uint32_t
 vchi_readbuf_uint32(const void *_ptr)
 {
@@ -822,11 +830,13 @@ vchi_readbuf_uint32(const void *_ptr)
 /* ----------------------------------------------------------------------
  * write a uint32_t to buffer.
  * network format is defined to be little endian
- * -------------------------------------------------------------------- */
+ * ----------------------------------------------------------------------
+ */
 void
 vchi_writebuf_uint32(void *_ptr, uint32_t value)
 {
 	unsigned char *ptr = _ptr;
+
 	ptr[0] = (unsigned char)((value >> 0)  & 0xFF);
 	ptr[1] = (unsigned char)((value >> 8)  & 0xFF);
 	ptr[2] = (unsigned char)((value >> 16) & 0xFF);
@@ -836,7 +846,8 @@ vchi_writebuf_uint32(void *_ptr, uint32_t value)
 /* ----------------------------------------------------------------------
  * read a uint16_t from buffer.
  * network format is defined to be little endian
- * -------------------------------------------------------------------- */
+ * ----------------------------------------------------------------------
+ */
 uint16_t
 vchi_readbuf_uint16(const void *_ptr)
 {
@@ -847,11 +858,13 @@ vchi_readbuf_uint16(const void *_ptr)
 /* ----------------------------------------------------------------------
  * write a uint16_t into the buffer.
  * network format is defined to be little endian
- * -------------------------------------------------------------------- */
+ * ----------------------------------------------------------------------
+ */
 void
 vchi_writebuf_uint16(void *_ptr, uint16_t value)
 {
 	unsigned char *ptr = _ptr;
+
 	ptr[0] = (value >> 0)  & 0xFF;
 	ptr[1] = (value >> 8)  & 0xFF;
 }
@@ -870,6 +883,7 @@ int32_t vchi_service_use(const VCHI_SERVICE_HANDLE_T handle)
 {
 	int32_t ret = -1;
 	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
+
 	if (service)
 		ret = vchiq_status_to_vchi(vchiq_use_service(service->handle));
 	return ret;
@@ -890,6 +904,7 @@ int32_t vchi_service_release(const VCHI_SERVICE_HANDLE_T handle)
 {
 	int32_t ret = -1;
 	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
+
 	if (service)
 		ret = vchiq_status_to_vchi(
 			vchiq_release_service(service->handle));
-- 
2.7.4
