From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 31 Jul 2017 09:31:52 +0000
Subject: [PATCH] serial: stm32: fix pio transmit timeout
Message-ID: <1501493505-27933-1-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gerald Baeza <gerald.baeza@st.com>

100?s was too short for low speed transmission
(9600bps)

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 72c0ec1..b16e7e7 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -203,7 +203,7 @@ static void stm32_transmit_chars_pio(struct uart_port *port)
 	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
 						isr,
 						(isr & USART_SR_TXE),
-						10, 100);
+						10, 100000);
 
 	if (ret)
 		dev_err(port->dev, "tx empty not set\n");
-- 
1.9.1
