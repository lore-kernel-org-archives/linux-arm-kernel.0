From: atull@opensource.altera.com (Alan Tull)
Date: Wed, 28 Sep 2016 13:21:53 -0500
Subject: [PATCH v19 05/12] fpga-mgr: add fpga image information struct
In-Reply-To: <20160928182200.15800-1-atull@opensource.altera.com>
References: <20160928182200.15800-1-atull@opensource.altera.com>
Message-ID: <20160928182200.15800-6-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a minor change in the FPGA Mangager API
to hold information that is specific to an FPGA image
file.  This change is expected to bring little, if any,
pain.

An FPGA image file will have particulars that affect how the
image is programmed to the FPGA.  One example is that
current 'flags' currently has one bit which shows whether the
FPGA image was built for full reconfiguration or partial
reconfiguration.  Another example is timeout values for
enabling or disabling the bridges in the FPGA.  As the
complexity of the FPGA design increases, the bridges in the
FPGA may take longer times to enable or disable.

This patch adds a new 'struct fpga_image_info', moves the
current 'u32 flags' to it.  Two other image-specific u32's
are added for the bridge enable/disable timeouts.  The FPGA
Manager API functions are changed, replacing the 'u32 flag'
parameter with a pointer to struct fpga_image_info.
Subsequent patches fix the existing low level FPGA manager
drivers.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
v19: Added in v19 of this patchset
---
 drivers/fpga/fpga-mgr.c       | 17 +++++++++--------
 include/linux/fpga/fpga-mgr.h | 23 +++++++++++++++++++----
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 953dc91..c58b4c4 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -32,7 +32,7 @@ static struct class *fpga_mgr_class;
 /**
  * fpga_mgr_buf_load - load fpga from image in buffer
  * @mgr:	fpga manager
- * @flags:	flags setting fpga confuration modes
+ * @info:	fpga image specific information
  * @buf:	buffer contain fpga image
  * @count:	byte count of buf
  *
@@ -43,8 +43,8 @@ static struct class *fpga_mgr_class;
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
-		      size_t count)
+int fpga_mgr_buf_load(struct fpga_manager *mgr, struct fpga_image_info *info,
+		      const char *buf, size_t count)
 {
 	struct device *dev = &mgr->dev;
 	int ret;
@@ -55,7 +55,7 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
 	 * ready to receive an FPGA image.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
-	ret = mgr->mops->write_init(mgr, flags, buf, count);
+	ret = mgr->mops->write_init(mgr, info, buf, count);
 	if (ret) {
 		dev_err(dev, "Error preparing FPGA for writing\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
@@ -78,7 +78,7 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
 	 * steps to finish and set the FPGA into operating mode.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	ret = mgr->mops->write_complete(mgr, flags);
+	ret = mgr->mops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -93,7 +93,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_buf_load);
 /**
  * fpga_mgr_firmware_load - request firmware and load to fpga
  * @mgr:	fpga manager
- * @flags:	flags setting fpga confuration modes
+ * @info:	fpga image specific information
  * @image_name:	name of image file on the firmware search path
  *
  * Request an FPGA image using the firmware class, then write out to the FPGA.
@@ -103,7 +103,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_buf_load);
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int fpga_mgr_firmware_load(struct fpga_manager *mgr, u32 flags,
+int fpga_mgr_firmware_load(struct fpga_manager *mgr,
+			   struct fpga_image_info *info,
 			   const char *image_name)
 {
 	struct device *dev = &mgr->dev;
@@ -121,7 +122,7 @@ int fpga_mgr_firmware_load(struct fpga_manager *mgr, u32 flags,
 		return ret;
 	}
 
-	ret = fpga_mgr_buf_load(mgr, flags, fw->data, fw->size);
+	ret = fpga_mgr_buf_load(mgr, info, fw->data, fw->size);
 
 	release_firmware(fw);
 
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0940bf4..040b86d 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -69,6 +69,18 @@ enum fpga_mgr_states {
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 
 /**
+ * struct fpga_image_info - information specific to a FPGA image
+ * @flags: boolean flags as defined above
+ * @enable_timeout_us: maximum time to enable traffic through bridge (uSec)
+ * @disable_timeout_us: maximum time to disable traffic through bridge (uSec)
+ */
+struct fpga_image_info {
+	u32 flags;
+	u32 enable_timeout_us;
+	u32 disable_timeout_us;
+};
+
+/**
  * struct fpga_manager_ops - ops for low level fpga manager drivers
  * @state: returns an enum value of the FPGA's state
  * @write_init: prepare the FPGA to receive confuration data
@@ -82,10 +94,12 @@ enum fpga_mgr_states {
  */
 struct fpga_manager_ops {
 	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
-	int (*write_init)(struct fpga_manager *mgr, u32 flags,
+	int (*write_init)(struct fpga_manager *mgr,
+			  struct fpga_image_info *info,
 			  const char *buf, size_t count);
 	int (*write)(struct fpga_manager *mgr, const char *buf, size_t count);
-	int (*write_complete)(struct fpga_manager *mgr, u32 flags);
+	int (*write_complete)(struct fpga_manager *mgr,
+			      struct fpga_image_info *info);
 	void (*fpga_remove)(struct fpga_manager *mgr);
 };
 
@@ -109,10 +123,11 @@ struct fpga_manager {
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
 
-int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags,
+int fpga_mgr_buf_load(struct fpga_manager *mgr, struct fpga_image_info *info,
 		      const char *buf, size_t count);
 
-int fpga_mgr_firmware_load(struct fpga_manager *mgr, u32 flags,
+int fpga_mgr_firmware_load(struct fpga_manager *mgr,
+			   struct fpga_image_info *info,
 			   const char *image_name);
 
 struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
-- 
2.9.3
