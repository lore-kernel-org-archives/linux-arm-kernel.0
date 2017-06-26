From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:12 +0000
Subject: [PATCH 10/20] serial: stm32: fix dma receive
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-11-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Two improvements for dma receive in this patch:
- usart dma receiver (DMAR) is disabled during receive
- dma receive buffer is sync-ed for cpu before reading
and given back to the dma just after

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 266dc4f..13fc520 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -393,11 +393,21 @@ static irqreturn_t stm32_threaded_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	spin_lock(&port->lock);
 
-	if (stm32_port->rx_ch)
+	if (stm32_port->rx_ch) {
+		stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+		dma_sync_single_for_cpu(port->dev,
+					stm32_port->rx_dma_buf,
+					RX_BUF_L, DMA_FROM_DEVICE);
 		stm32_receive_chars(port, true);
+		dma_sync_single_for_device(port->dev,
+					   stm32_port->rx_dma_buf,
+					   RX_BUF_L, DMA_FROM_DEVICE);
+		stm32_set_bits(port, ofs->cr3, USART_CR3_DMAR);
+	}
 
 	spin_unlock(&port->lock);
 
-- 
1.9.1
