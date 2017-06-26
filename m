From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:13 +0000
Subject: [PATCH 12/20] serial: stm32: fix last_res value
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-13-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Set last_res value in each port

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 6 +++---
 drivers/tty/serial/stm32-usart.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index a7401b0..c54b89d 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -155,14 +155,13 @@ static void stm32_receive_chars(struct uart_port *port, bool threaded)
 	unsigned long c;
 	u32 sr;
 	char flag;
-	static int last_res = RX_BUF_L;
 
 	if (port->irq_wake)
 		pm_wakeup_event(tport->tty->dev, 0);
 
-	while (stm32_pending_rx(port, &sr, &last_res, threaded)) {
+	while (stm32_pending_rx(port, &sr, &stm32_port->last_res, threaded)) {
 		sr |= USART_SR_DUMMY_RX;
-		c = stm32_get_char(port, &sr, &last_res);
+		c = stm32_get_char(port, &sr, &stm32_port->last_res);
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
@@ -808,6 +807,7 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 	stm32_ports[id].port.line = id;
 	stm32_ports[id].fifoen = true;
 	stm32_ports[id].rx_irq = USART_CR1_RXNEIE;
+	stm32_ports[id].last_res = RX_BUF_L;
 	return &stm32_ports[id];
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index f9fe15b..056a837 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -226,6 +226,7 @@ struct stm32_port {
 	dma_addr_t tx_dma_buf;   /* dma tx buffer bus address */
 	unsigned char *tx_buf;   /* dma tx buffer cpu address */
 	u32 rx_irq;		 /* USART_CR1_RXNEIE or RTOIE */
+	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
 	bool fifoen;
-- 
1.9.1
