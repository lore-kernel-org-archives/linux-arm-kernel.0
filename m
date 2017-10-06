From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 6 Oct 2017 20:59:05 +0200
Subject: [PATCH] firmware: arm_scpi: silence sparse warnings
Message-ID: <05d15d9d-4664-8bbe-ea4b-90e538d2c1b3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At several positions in the code sparse complains about incorrect access
to __iomem annotated memory. Fix this and make sparse happy.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index f0c37a4e..dfb373c8 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -405,19 +405,20 @@ static void scpi_process_cmd(struct scpi_chan *ch, u32 cmd)
 		unsigned int len;
 
 		if (scpi_info->is_legacy) {
-			struct legacy_scpi_shared_mem *mem = ch->rx_payload;
+			struct legacy_scpi_shared_mem __iomem *mem =
+							ch->rx_payload;
 
 			/* RX Length is not replied by the legacy Firmware */
 			len = match->rx_len;
 
-			match->status = le32_to_cpu(mem->status);
+			match->status = ioread32(&mem->status);
 			memcpy_fromio(match->rx_buf, mem->payload, len);
 		} else {
-			struct scpi_shared_mem *mem = ch->rx_payload;
+			struct scpi_shared_mem __iomem *mem = ch->rx_payload;
 
 			len = min(match->rx_len, CMD_SIZE(cmd));
 
-			match->status = le32_to_cpu(mem->status);
+			match->status = ioread32(&mem->status);
 			memcpy_fromio(match->rx_buf, mem->payload, len);
 		}
 
@@ -431,11 +432,11 @@ static void scpi_process_cmd(struct scpi_chan *ch, u32 cmd)
 static void scpi_handle_remote_msg(struct mbox_client *c, void *msg)
 {
 	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
-	struct scpi_shared_mem *mem = ch->rx_payload;
+	struct scpi_shared_mem __iomem *mem = ch->rx_payload;
 	u32 cmd = 0;
 
 	if (!scpi_info->is_legacy)
-		cmd = le32_to_cpu(mem->command);
+		cmd = ioread32(&mem->command);
 
 	scpi_process_cmd(ch, cmd);
 }
@@ -445,7 +446,7 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	unsigned long flags;
 	struct scpi_xfer *t = msg;
 	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
-	struct scpi_shared_mem *mem = ch->tx_payload;
+	struct scpi_shared_mem __iomem *mem = ch->tx_payload;
 
 	if (t->tx_buf) {
 		if (scpi_info->is_legacy)
@@ -464,7 +465,7 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	}
 
 	if (!scpi_info->is_legacy)
-		mem->command = cpu_to_le32(t->cmd);
+		iowrite32(t->cmd, &mem->command);
 }
 
 static struct scpi_xfer *get_scpi_xfer(struct scpi_chan *ch)
-- 
2.14.2
