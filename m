From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 29 May 2014 11:03:34 +0100
Subject: [PATCH v6] serial: sirf: Fix compilation failure
Message-ID: <1401357814-15772-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After 07d410e0) serial: sirf: fix spinlock deadlock issue it is no longer
possiblet to compile this driver. The rename of one of the spinlocks is
faulty. After looking at the original patch I believe this is the correct
fix.

Compile tested using ARM's multi_v7_defconfig

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Barry Song <baohua@kernel.org>
Cc: Qipan Li <Qipan.Li@csr.com>
Cc: linux-serial at vger.kernel.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/sirfsoc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 236f892..1f2be48 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -704,7 +704,7 @@ static void sirfsoc_uart_rx_dma_complete_tl(unsigned long param)
 	struct sirfsoc_int_en *uint_en = &sirfport->uart_reg->uart_int_en;
 	unsigned long flags;
 	struct dma_tx_state tx_state;
-	spin_lock_irqsave(&port->rx_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	while (DMA_COMPLETE == dmaengine_tx_status(sirfport->rx_dma_chan,
 			sirfport->rx_dma_items[sirfport->rx_completed].cookie, &tx_state)) {
 		sirfsoc_uart_insert_rx_buf_to_tty(sirfport,
-- 
1.9.0
