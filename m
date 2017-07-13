From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 13 Jul 2017 15:08:30 +0000
Subject: [PATCH 9/9] serial: stm32: add fifo support
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Message-ID: <1499958494-19354-10-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gerald Baeza <gerald.baeza@st.com>

This patch adds fifo mode support for rx and tx.

A fifo configuration is set in each port structure.
Add has_fifo flag to usart configuration to use fifo only when possible.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 7 +++++++
 drivers/tty/serial/stm32-usart.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 684cbe3..b16e7e7 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -468,6 +468,8 @@ static int stm32_startup(struct uart_port *port)
 	}
 
 	val = USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
+	if (stm32_port->fifoen)
+		val |= USART_CR1_FIFOEN;
 	stm32_set_bits(port, ofs->cr1, val);
 
 	return 0;
@@ -482,6 +484,8 @@ static void stm32_shutdown(struct uart_port *port)
 
 	val = USART_CR1_TXEIE | USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
 	val |= BIT(cfg->uart_enable_bit);
+	if (stm32_port->fifoen)
+		val |= USART_CR1_FIFOEN;
 	stm32_clr_bits(port, ofs->cr1, val);
 
 	dev_pm_clear_wake_irq(port->dev);
@@ -512,6 +516,8 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_RXNEIE;
 	cr1 |= BIT(cfg->uart_enable_bit);
+	if (stm32_port->fifoen)
+		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
 	cr3 = 0;
 
@@ -676,6 +682,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq(pdev, 0);
 	stm32port->wakeirq = platform_get_irq(pdev, 1);
+	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 5984a66..ffc0c52 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -26,6 +26,7 @@ struct stm32_usart_config {
 	u8 uart_enable_bit; /* USART_CR1_UE */
 	bool has_7bits_data;
 	bool has_wakeup;
+	bool has_fifo;
 };
 
 struct stm32_usart_info {
@@ -94,6 +95,7 @@ struct stm32_usart_info stm32h7_info = {
 		.uart_enable_bit = 0,
 		.has_7bits_data = true,
 		.has_wakeup = true,
+		.has_fifo = true,
 	}
 };
 
@@ -159,6 +161,7 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR1_EOBIE		BIT(27)		/* F7 */
 #define USART_CR1_M1		BIT(28)		/* F7 */
 #define USART_CR1_IE_MASK	(GENMASK(8, 4) | BIT(14) | BIT(26) | BIT(27))
+#define USART_CR1_FIFOEN	BIT(29)		/* H7 */
 
 /* USART_CR2 */
 #define USART_CR2_ADD_MASK	GENMASK(3, 0)	/* F4 */
@@ -253,6 +256,7 @@ struct stm32_port {
 	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
+	bool fifoen;
 	int wakeirq;
 };
 
-- 
1.9.1
