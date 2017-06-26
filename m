From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:16 +0000
Subject: [PATCH 16/20] serial: stm32: fix fifo usage
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-17-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Fifo is available starting with stm32h7. Add has_fifo flag to use fifo
only when possible.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/tty/serial/stm32-usart.c | 9 ++++++++-
 drivers/tty/serial/stm32-usart.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 05d89b0..d241056 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -49,6 +49,10 @@ static void stm32_serial_debugfs(struct stm32_port *stm32port,
 {
 	struct device *dev = stm32port->port.dev;
 
+	/* For now, debugfs is only used for fifo, then skip if unsupported */
+	if (!stm32port->info->cfg.has_fifo)
+		return;
+
 	if (!stm32_debugfs_root)
 		stm32_debugfs_root = debugfs_create_dir("usart-stm32", NULL);
 
@@ -63,6 +67,9 @@ static void stm32_serial_debugfs(struct stm32_port *stm32port,
 
 static void stm32_serial_debugfs_rm(struct stm32_port *stm32port)
 {
+	if (!stm32port->info->cfg.has_fifo)
+		return;
+
 	debugfs_remove_recursive(stm32port->debugfs_dir);
 	if (atomic_dec_and_test(&stm32_debugfs_cnt)) {
 		debugfs_remove_recursive(stm32_debugfs_root);
@@ -775,6 +782,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq(pdev, 0);
 	stm32port->wakeirq = platform_get_irq(pdev, 1);
+	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
@@ -824,7 +832,6 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 	stm32_ports[id].hw_flow_control = of_property_read_bool(np,
 							"st,hw-flow-ctrl");
 	stm32_ports[id].port.line = id;
-	stm32_ports[id].fifoen = true;
 	stm32_ports[id].rx_irq = USART_CR1_RXNEIE;
 	stm32_ports[id].last_res = RX_BUF_L;
 	return &stm32_ports[id];
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 98dbf38..25ed28b 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -25,6 +25,7 @@ struct stm32_usart_config {
 	u8 uart_enable_bit; /* USART_CR1_UE */
 	bool has_7bits_data;
 	bool has_wakeup;
+	bool has_fifo;
 };
 
 struct stm32_usart_info {
@@ -93,6 +94,7 @@ struct stm32_usart_info stm32h7_info = {
 		.uart_enable_bit = 0,
 		.has_7bits_data = true,
 		.has_wakeup = true,
+		.has_fifo = true,
 	}
 };
 
-- 
1.9.1
