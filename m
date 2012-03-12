From: b32955@freescale.com (Huang Shijie)
Date: Mon, 12 Mar 2012 10:22:18 +0800
Subject: [PATCH] mtd/gpmi : fix the wrong DMA command.
Message-ID: <1331518938-24047-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last DMA command of ECC read page is used to disable the BCH module.
But the original code missed to set the pio[2] which is used to set the
GPMI_HW_GPMI_ECCCTRL register. fix it now.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 5e3c505..c34dab1 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -1061,8 +1061,9 @@ int gpmi_read_page(struct gpmi_nand_data *this,
 		| BF_GPMI_CTRL0_ADDRESS(address)
 		| BF_GPMI_CTRL0_XFER_COUNT(geo->page_size);
 	pio[1] = 0;
+	pio[2] = 0; /* clear GPMI_HW_GPMI_ECCCTRL, disable the BCH. */
 	desc = channel->device->device_prep_slave_sg(channel,
-				(struct scatterlist *)pio, 2,
+				(struct scatterlist *)pio, 3,
 				DMA_TRANS_NONE,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-- 
1.7.3.2
