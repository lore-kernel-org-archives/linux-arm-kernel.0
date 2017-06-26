From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:11 +0000
Subject: [PATCH 07/20] serial: stm32: less messages on dma alloc error
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-8-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Just display one info (instead of two) in the
log buffer when there is no dma.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 79ac167..dcc6d1e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -786,10 +786,8 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 
 	/* Request DMA RX channel */
 	stm32port->rx_ch = dma_request_slave_channel(dev, "rx");
-	if (!stm32port->rx_ch) {
-		dev_info(dev, "rx dma alloc failed\n");
+	if (!stm32port->rx_ch)
 		return -ENODEV;
-	}
 	stm32port->rx_buf = dma_alloc_coherent(&pdev->dev, RX_BUF_L,
 						 &stm32port->rx_dma_buf,
 						 GFP_KERNEL);
@@ -858,10 +856,8 @@ static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
 
 	/* Request DMA TX channel */
 	stm32port->tx_ch = dma_request_slave_channel(dev, "tx");
-	if (!stm32port->tx_ch) {
-		dev_info(dev, "tx dma alloc failed\n");
+	if (!stm32port->tx_ch)
 		return -ENODEV;
-	}
 	stm32port->tx_buf = dma_alloc_coherent(&pdev->dev, TX_BUF_L,
 						 &stm32port->tx_dma_buf,
 						 GFP_KERNEL);
-- 
1.9.1
