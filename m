From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:11 +0000
Subject: [PATCH 06/20] serial: stm32: fix pio transmit timeout
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-7-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

100?s was too short for low speed transmission
(9600bps)

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 3ce0f7a..79ac167 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -247,7 +247,7 @@ static void stm32_transmit_chars_pio(struct uart_port *port)
 	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
 						isr,
 						(isr & USART_SR_TXE),
-						10, 100);
+						10, 100000);
 
 	if (ret)
 		dev_err(port->dev, "tx empty not set\n");
-- 
1.9.1
