From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Mon, 9 Oct 2017 20:57:12 +0200
Subject: [PATCH 3/3] firmware: arm_scpi: use FIELD_GET/_PREP to simplify macro
 definitions
In-Reply-To: <8afb173f-1480-baf8-e15b-5c01ed033671@gmail.com>
References: <8afb173f-1480-baf8-e15b-5c01ed033671@gmail.com>
Message-ID: <f9b589a4-5fe9-5584-486b-d2bcba8f46bd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Macro definitions can be simplified by making use of the FIELD_GET/_PREP
bitfield macros.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 579941d5..fc868d66 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -46,27 +46,19 @@
 #include <linux/sort.h>
 #include <linux/spinlock.h>
 
-#define CMD_ID_SHIFT		0
-#define CMD_ID_MASK		0x7f
-#define CMD_TOKEN_ID_SHIFT	8
-#define CMD_TOKEN_ID_MASK	0xff
-#define CMD_DATA_SIZE_SHIFT	16
-#define CMD_DATA_SIZE_MASK	0x1ff
-#define CMD_LEGACY_DATA_SIZE_SHIFT	20
-#define CMD_LEGACY_DATA_SIZE_MASK	0x1ff
-#define PACK_SCPI_CMD(cmd_id, tx_sz)			\
-	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |	\
-	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
-#define ADD_SCPI_TOKEN(cmd, token)			\
-	((cmd) |= (((token) & CMD_TOKEN_ID_MASK) << CMD_TOKEN_ID_SHIFT))
-#define PACK_LEGACY_SCPI_CMD(cmd_id, tx_sz)				\
-	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |			       \
-	(((tx_sz) & CMD_LEGACY_DATA_SIZE_MASK) << CMD_LEGACY_DATA_SIZE_SHIFT))
-
-#define CMD_SIZE(cmd)	(((cmd) >> CMD_DATA_SIZE_SHIFT) & CMD_DATA_SIZE_MASK)
-#define CMD_LEGACY_SIZE(cmd)	(((cmd) >> CMD_LEGACY_DATA_SIZE_SHIFT) & \
-					CMD_LEGACY_DATA_SIZE_MASK)
-#define CMD_UNIQ_MASK	(CMD_TOKEN_ID_MASK << CMD_TOKEN_ID_SHIFT | CMD_ID_MASK)
+#define CMD_ID_MASK		GENMASK(6, 0)
+#define CMD_TOKEN_ID_MASK	GENMASK(15, 8)
+#define CMD_DATA_SIZE_MASK	GENMASK(24, 16)
+#define CMD_LEGACY_DATA_SIZE_MASK	GENMASK(28, 20)
+#define PACK_SCPI_CMD(cmd_id, tx_sz)		\
+	(FIELD_PREP(CMD_ID_MASK, cmd_id) |	\
+	FIELD_PREP(CMD_DATA_SIZE_MASK, tx_sz))
+#define PACK_LEGACY_SCPI_CMD(cmd_id, tx_sz)	\
+	(FIELD_PREP(CMD_ID_MASK, cmd_id) |	\
+	FIELD_PREP(CMD_LEGACY_DATA_SIZE_MASK, tx_sz))
+
+#define CMD_SIZE(cmd)	FIELD_GET(CMD_DATA_SIZE_MASK, cmd)
+#define CMD_UNIQ_MASK	(CMD_TOKEN_ID_MASK | CMD_ID_MASK)
 #define CMD_XTRACT_UNIQ(cmd)	((cmd) & CMD_UNIQ_MASK)
 
 #define SCPI_SLOT		0
@@ -412,7 +404,7 @@ static void scpi_process_cmd(struct scpi_chan *ch, u32 cmd)
 		} else {
 			struct scpi_shared_mem __iomem *mem = ch->rx_payload;
 
-			len = min(match->rx_len, CMD_SIZE(cmd));
+			len = min_t(unsigned int, match->rx_len, CMD_SIZE(cmd));
 
 			match->status = ioread32(&mem->status);
 			memcpy_fromio(match->rx_buf, mem->payload, len);
@@ -454,7 +446,7 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	if (t->rx_buf) {
 		if (!(++ch->token))
 			++ch->token;
-		ADD_SCPI_TOKEN(t->cmd, ch->token);
+		t->cmd |= FIELD_PREP(CMD_TOKEN_ID_MASK, ch->token);
 		spin_lock_irqsave(&ch->rx_lock, flags);
 		list_add_tail(&t->node, &ch->rx_pending);
 		spin_unlock_irqrestore(&ch->rx_lock, flags);
-- 
2.14.2
