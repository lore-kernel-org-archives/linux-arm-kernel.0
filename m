From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 15 Sep 2016 18:42:41 +0200
Subject: [PATCH 09/11] serial: stm32: fix spin_lock management
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473957763-30629-10-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 24c4d82..3b99d79 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -321,6 +321,8 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 
+	spin_lock(&port->lock);
+
 	sr = readl_relaxed(port->membase + ofs->isr);
 
 	if ((sr & USART_SR_RXNE) && !(stm32_port->rx_ch))
@@ -329,6 +331,8 @@ static irqreturn_t stm32_interrupt(int irq, void *ptr)
 	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch))
 		stm32_transmit_chars(port);
 
+	spin_unlock(&port->lock);
+
 	if (stm32_port->rx_ch)
 		return IRQ_WAKE_THREAD;
 	else
-- 
1.9.1
