From: james.hughes@raspberrypi.org (James Hughes)
Date: Fri, 16 Nov 2018 14:39:07 +0000
Subject: [PATCH v3] firmware: raspberrypi: Fix firmware calls with large
 buffers
Message-ID: <20181116143907.6149-1-james.hughes@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
moved away from VLA's to a fixed maximum size for mailbox data.
However, some mailbox calls use larger data buffers
than the maximum allowed in that change. This fix therefor
moves from using fixed buffers to kmalloc to ensure all sizes
are catered for.

There is some documentation, which is somewhat out of date,
on the mailbox calls here :
https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface

Fixes: a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")

Signed-off-by: James Hughes <james.hughes@raspberrypi.org>

---
 drivers/firmware/raspberrypi.c | 35 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

v2: Changes to commit message and format only. No code change.
v3: Moved declaration of header back to original position

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index a200a2174611..44eb99807e33 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
@@ -21,8 +22,6 @@
 #define MBOX_DATA28(msg)		((msg) & ~0xf)
 #define MBOX_CHAN_PROPERTY		8
 
-#define MAX_RPI_FW_PROP_BUF_SIZE	32
-
 static struct platform_device *rpi_hwmon;
 
 struct rpi_firmware {
@@ -144,28 +143,30 @@ EXPORT_SYMBOL_GPL(rpi_firmware_property_list);
 int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *tag_data, size_t buf_size)
 {
-	/* Single tags are very small (generally 8 bytes), so the
-	 * stack should be safe.
-	 */
-	u8 data[sizeof(struct rpi_firmware_property_tag_header) +
-		MAX_RPI_FW_PROP_BUF_SIZE];
-	struct rpi_firmware_property_tag_header *header =
-		(struct rpi_firmware_property_tag_header *)data;
+	struct rpi_firmware_property_tag_header *header;
 	int ret;
 
-	if (WARN_ON(buf_size > sizeof(data) - sizeof(*header)))
-		return -EINVAL;
+	/* Some mailboxes can use over 1k bytes. Rather than checking
+	 * size and using stack or kmalloc depending on requirements,
+	 * just use kmalloc. Mailboxes don't get called enough to worry
+	 * too much about the time taken in the allocation.
+	 */
+	void *data = kmalloc(sizeof(*header) + buf_size, GFP_KERNEL);
 
+	if (!data)
+		return -ENOMEM;
+
+	header = data;
 	header->tag = tag;
 	header->buf_size = buf_size;
 	header->req_resp_size = 0;
-	memcpy(data + sizeof(struct rpi_firmware_property_tag_header),
-	       tag_data, buf_size);
+	memcpy(data + sizeof(*header), tag_data, buf_size);
+
+	ret = rpi_firmware_property_list(fw, data, buf_size + sizeof(*header));
+
+	memcpy(tag_data, data + sizeof(*header), buf_size);
 
-	ret = rpi_firmware_property_list(fw, &data, buf_size + sizeof(*header));
-	memcpy(tag_data,
-	       data + sizeof(struct rpi_firmware_property_tag_header),
-	       buf_size);
+	kfree(data);
 
 	return ret;
 }
-- 
2.17.1
