From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 15 Mar 2018 08:44:46 +0000
Subject: [PATCH] serial: stm32: fix initialization of RS485 mode
Message-ID: <1521103480-6940-1-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure RS485 mode during port initialization.

Fixes: 1bcda09d291081a7732fcaa9d1745312404a4e36 ("serial: stm32: add
support for RS485 hardware control mode")

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 345fbf3..e8d7a7b 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -809,6 +809,10 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq(pdev, 0);
+	port->rs485_config = stm32_config_rs485;
+
+	stm32_init_rs485(port, pdev);
+
 	stm32port->wakeirq = platform_get_irq(pdev, 1);
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
-- 
1.9.1
