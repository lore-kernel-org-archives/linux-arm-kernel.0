From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 12:29:18 +0200
Subject: [RFC PATCH v3 4/8] firmware: arm_scpi: Enable vendor_send_message as
 ext commands
In-Reply-To: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
References: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1470738562-20026-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement official SCPI external commands with the newly introduced
vendor_send_message in ops.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index c6d6528..7290182 100644
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
 
@@ -343,8 +349,8 @@ static void put_scpi_xfer(struct scpi_xfer *t, struct scpi_chan *ch)
 	mutex_unlock(&ch->xfers_lock);
 }
 
-static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
-			     void *rx_buf, unsigned int rx_len)
+static int __scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+			       void *rx_buf, unsigned int rx_len, bool extn)
 {
 	int ret;
 	u8 chan;
@@ -359,7 +365,8 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
 		return -ENOMEM;
 
 	msg->slot = BIT(SCPI_SLOT);
-	msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
+	msg->cmd = extn ? PACK_EXT_SCPI_CMD(cmd, tx_len) :
+			  PACK_SCPI_CMD(cmd, tx_len);
 	msg->tx_buf = tx_buf;
 	msg->tx_len = tx_len;
 	msg->rx_buf = rx_buf;
@@ -384,6 +391,20 @@ out:
 	return ret > 0 ? scpi_to_linux_errno(ret) : ret;
 }
 
+static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
+			     void *rx_buf, unsigned int rx_len)
+{
+	return __scpi_send_message(cmd, tx_buf, tx_len, rx_buf, rx_len, false);
+}
+
+static int scpi_ext_send_message(u8 cmd, unsigned long arg,
+				 void *tx_buf, unsigned int tx_len,
+				 void *rx_buf, unsigned int rx_len)
+{
+	return __scpi_send_message(cmd, tx_buf, tx_len, rx_buf, rx_len, true);
+}
+
+
 static u32 scpi_get_version(void)
 {
 	return scpi_info->protocol_version;
@@ -577,6 +598,7 @@ static struct scpi_ops scpi_ops = {
 	.sensor_get_value = scpi_sensor_get_value,
 	.device_get_power_state = scpi_device_get_power_state,
 	.device_set_power_state = scpi_device_set_power_state,
+	.vendor_send_message = scpi_ext_send_message,
 };
 
 static int scpi_init_versions(struct scpi_drvinfo *info)
-- 
2.7.0
