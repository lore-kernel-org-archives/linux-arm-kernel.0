From: lakshmi.sai.krishna.potthuri@xilinx.com (P L Sai Krishna)
Date: Thu, 7 Apr 2016 20:09:27 +0530
Subject: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the spi_transfer
 structure.
Message-ID: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dummy_cycles entry in the spi_transfer structure.
len field in the transfer structure contains dummy bytes along with
actual data bytes, controllers which requires dummy bytes use len
field and simply Ignore the dummy_cycles field. Controllers which
expects dummy cycles won't work directly by using len field because
host driver doesn't know that len field of a particular transfer
includes dummy bytes or not (and also number of dummy bytes included
in len field). In such cases host driver use this dummy_cycles field
to identify the number of dummy cycles and based on that it will send
the required number of dummy cycles.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
v2: 
 - Changed the structure member name from dummy to dummy_cycles.
 - Updated the documentation of dummy_cycles.
 - m25p80 changes split into another patch.

 include/linux/spi/spi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 857a9a1..63135b3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -664,6 +664,9 @@ extern void spi_res_release(struct spi_master *master,
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
+ * @dummy_cycles: number of dummy cycles. If host controller requires
+ * 	dummy cycles rather than dummy bytes which send along with Cmd
+ *	and address then this dummy_cycles is used.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
  * @cs_change: affects chipselect after this transfer completes
@@ -752,6 +755,7 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u16		delay_usecs;
 	u32		speed_hz;
+	u32		dummy_cycles;
 
 	struct list_head transfer_list;
 };
-- 
2.1.2
