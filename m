From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:10:54 +0200
Subject: [PATCH 01/13] scpi: Add vendor_send_message to enable access to
 vendor commands
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds an optional vendor_send_message to the scpi to enable sending
vendor platform specific commands to the SCP firmware.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c   | 26 +++++++++++++++++++++++---
 include/linux/scpi_protocol.h |  4 ++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 4388937..403783a 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -46,6 +46,8 @@
 
 #define CMD_ID_SHIFT		0
 #define CMD_ID_MASK		0x7f
+#define CMD_SET_SHIFT		7
+#define CMD_SET_MASK		0x1
 #define CMD_TOKEN_ID_SHIFT	8
 #define CMD_TOKEN_ID_MASK	0xff
 #define CMD_DATA_SIZE_SHIFT	16
@@ -53,6 +55,10 @@
 #define PACK_SCPI_CMD(cmd_id, tx_sz)			\
 	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |	\
 	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
+#define PACK_EXT_SCPI_CMD(cmd_id, tx_sz)		\
+	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |	\
+	(CMD_SET_MASK << CMD_SET_SHIFT) |		\
+	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
 #define ADD_SCPI_TOKEN(cmd, token)			\
 	((cmd) |= (((token) & CMD_TOKEN_ID_MASK) << CMD_TOKEN_ID_SHIFT))
 
@@ -344,8 +350,8 @@ static void put_scpi_xfer(struct scpi_xfer *t, struct scpi_chan *ch)
 	mutex_unlock(&ch->xfers_lock);
 }
 
-static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
-			     void *rx_buf, unsigned int rx_len)
+static int __scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+			       void *rx_buf, unsigned int rx_len, bool extn)
 {
 	int ret;
 	u8 chan;
@@ -360,7 +366,8 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 		return -ENOMEM;
 
 	msg->slot = BIT(SCPI_SLOT);
-	msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
+	msg->cmd = extn ? PACK_EXT_SCPI_CMD(cmd, tx_len) :
+			  PACK_SCPI_CMD(cmd, tx_len);
 	msg->tx_buf = tx_buf;
 	msg->tx_len = tx_len;
 	msg->rx_buf = rx_buf;
@@ -385,6 +392,18 @@ out:
 	return ret > 0 ? scpi_to_linux_errno(ret) : ret;
 }
 
+static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+			     void *rx_buf, unsigned int rx_len)
+{
+	return __scpi_send_message(cmd, tx_buf, tx_len, rx_buf, rx_len, false);
+}
+
+static int scpi_ext_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+				 void *rx_buf, unsigned int rx_len)
+{
+	return __scpi_send_message(cmd, tx_buf, tx_len, rx_buf, rx_len, true);
+}
+
 static u32 scpi_get_version(void)
 {
 	return scpi_info->protocol_version;
@@ -578,6 +597,7 @@ static struct scpi_ops scpi_ops = {
 	.sensor_get_value = scpi_sensor_get_value,
 	.device_get_power_state = scpi_device_get_power_state,
 	.device_set_power_state = scpi_device_set_power_state,
+	.vendor_send_message = scpi_ext_send_message,
 };
 
 struct scpi_ops *get_scpi_ops(void)
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index dc5f989..2b68581 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -58,6 +58,8 @@ struct scpi_sensor_info {
  *	OPP is an index to the list return by @dvfs_get_info
  * @dvfs_get_info: returns the DVFS capabilities of the given power
  *	domain. It includes the OPP list and the latency information
+ * @vendor_send_message: vendor specific message sending, arg can specify
+ *	a scpi implementation specific argument
  */
 struct scpi_ops {
 	u32 (*get_version)(void);
@@ -72,6 +74,8 @@ struct scpi_ops {
 	int (*sensor_get_value)(u16, u64 *);
 	int (*device_get_power_state)(u16);
 	int (*device_set_power_state)(u16, u8);
+	int (*vendor_send_message)(u8 cmd, void *tx_buf, unsigned int tx_len,
+				   void *rx_buf, unsigned int rx_len);
 };
 
 #if IS_REACHABLE(CONFIG_ARM_SCPI_PROTOCOL)
-- 
1.9.1
