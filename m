From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 15 Sep 2016 18:42:42 +0200
Subject: [PATCH 10/11] serial: stm32: fix uart enable management
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473957763-30629-11-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 3b99d79..4d3001b 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -461,9 +461,11 @@ static void stm32_shutdown(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 val;
 
 	val = USART_CR1_TXEIE | USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
+	val |= BIT(cfg->uart_enable_bit);
 	stm32_clr_bits(port, ofs->cr1, val);
 
 	free_irq(port->irq, port);
@@ -923,6 +925,7 @@ static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
 	struct uart_port *port = &stm32_ports[co->index].port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	unsigned long flags;
 	u32 old_cr1, new_cr1;
 	int locked = 1;
@@ -935,9 +938,10 @@ static void stm32_console_write(struct console *co, const char *s, unsigned cnt)
 	else
 		spin_lock(&port->lock);
 
-	/* Save and disable interrupts */
+	/* Save and disable interrupts, enable the transmitter */
 	old_cr1 = readl_relaxed(port->membase + ofs->cr1);
 	new_cr1 = old_cr1 & ~USART_CR1_IE_MASK;
+	new_cr1 |=  USART_CR1_TE | BIT(cfg->uart_enable_bit);
 	writel_relaxed(new_cr1, port->membase + ofs->cr1);
 
 	uart_console_write(port, s, cnt, stm32_console_putchar);
-- 
1.9.1
