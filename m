From: b32955@freescale.com (Huang Shijie)
Date: Wed, 6 Nov 2013 16:53:27 +0800
Subject: [PATCH bugfix] mtd: gpmi: serialize all the dma operations
Message-ID: <1383728007-15564-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[1] The gpmi uses the nand_command_lp to issue the commands to NAND chips.
    It will issue a DMA operation when it handles a NAND_CMD_NONE control
    command. So when we read a page(NAND_CMD_READ0) from the NAND, we may send
    two DMA operations back-to-back.

    If we do not serialize the two DMA operations, we will meet a bug when

    1.1) we enable CONFIG_DMA_API_DEBUG, CONFIG_DMADEVICES_DEBUG,
         and CONFIG_DEBUG_SG.

    1.2) Use the following commands in an UART console and a SSH console:
         cmd 1: while true;do dd if=/dev/mtd0 of=/dev/null;done
         cmd 1: while true;do dd if=/dev/mmcblk0 of=/dev/null;done

    The kernel log shows below:
    -----------------------------------------------------------------
    kernel BUG at lib/scatterlist.c:28!
    Unable to handle kernel NULL pointer dereference at virtual address 00000000
      .........................
    [<80044a0c>] (__bug+0x18/0x24) from [<80249b74>] (sg_next+0x48/0x4c)
    [<80249b74>] (sg_next+0x48/0x4c) from [<80255398>] (debug_dma_unmap_sg+0x170/0x1a4)
    [<80255398>] (debug_dma_unmap_sg+0x170/0x1a4) from [<8004af58>] (dma_unmap_sg+0x14/0x6c)
    [<8004af58>] (dma_unmap_sg+0x14/0x6c) from [<8027e594>] (mxs_dma_tasklet+0x18/0x1c)
    [<8027e594>] (mxs_dma_tasklet+0x18/0x1c) from [<8007d444>] (tasklet_action+0x114/0x164)
    -----------------------------------------------------------------

    1.3) Assume the two DMA operations is X (first) and Y (second).
         The root cause of the bug:
         X's tasklet mxs_dma_tasklet trid to unmap the scatterlist, while Y is
         trying to set up a new DMA operation with the _SAME_ scatterlist in
         another ARM core.

[2] This patch adds a wait queue and two helpers gpmi_enter_dma/gpmi_exit_dma to
    serialize all the DMA operations.

Signed-off-by: Huang Shijie <b32955@freescale.com>
Cc: stable at vger.kernel.org
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   24 ++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 71df69e..b849b92 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -392,6 +392,20 @@ void prepare_data_dma(struct gpmi_nand_data *this, enum dma_data_direction dr)
 	}
 }
 
+static void gpmi_enter_dma(struct gpmi_nand_data *this)
+{
+	/* Wait until the previous DMA is finished. */
+	wait_event(this->dma_wait, !this->dma_is_working);
+
+	this->dma_is_working = true;
+}
+
+static void gpmi_exit_dma(struct gpmi_nand_data *this)
+{
+	this->dma_is_working = false;
+	wake_up(&this->dma_wait);
+}
+
 /* This will be called after the DMA operation is finished. */
 static void dma_irq_callback(void *param)
 {
@@ -424,6 +438,7 @@ static void dma_irq_callback(void *param)
 	default:
 		pr_err("in wrong DMA operation.\n");
 	}
+	gpmi_exit_dma(this);
 }
 
 int start_dma_without_bch_irq(struct gpmi_nand_data *this,
@@ -906,6 +921,8 @@ static void gpmi_cmd_ctrl(struct mtd_info *mtd, int data, unsigned int ctrl)
 	if (!this->command_length)
 		return;
 
+	gpmi_enter_dma(this);
+
 	ret = gpmi_send_command(this);
 	if (ret)
 		pr_err("Chip: %u, Error %d\n", this->current_chip, ret);
@@ -943,6 +960,8 @@ static void gpmi_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 	this->upper_buf	= buf;
 	this->upper_len	= len;
 
+	gpmi_enter_dma(this);
+
 	gpmi_read_data(this);
 }
 
@@ -955,6 +974,8 @@ static void gpmi_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 	this->upper_buf	= (uint8_t *)buf;
 	this->upper_len	= len;
 
+	gpmi_enter_dma(this);
+
 	gpmi_send_data(this);
 }
 
@@ -1031,6 +1052,7 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	int           ret;
 
 	pr_debug("page number is : %d\n", page);
+	gpmi_enter_dma(this);
 	ret = read_page_prepare(this, buf, mtd->writesize,
 					this->payload_virt, this->payload_phys,
 					nfc_geo->payload_size,
@@ -1107,6 +1129,7 @@ static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	int        ret;
 
 	pr_debug("ecc write page.\n");
+	gpmi_enter_dma(this);
 	if (this->swap_block_mark) {
 		/*
 		 * If control arrives here, we're doing block mark swapping.
@@ -1745,6 +1768,7 @@ static int gpmi_nand_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, this);
 	this->pdev  = pdev;
 	this->dev   = &pdev->dev;
+	init_waitqueue_head(&this->dma_wait);
 
 	ret = acquire_resources(this);
 	if (ret)
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index a7685e3..9597615 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -160,6 +160,8 @@ struct gpmi_nand_data {
 
 	/* for DMA operations */
 	bool			direct_dma_map_ok;
+	bool			dma_is_working;
+	wait_queue_head_t	dma_wait;
 
 	struct scatterlist	cmd_sgl;
 	char			*cmd_buffer;
-- 
1.7.2.rc3
