From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:14 +0000
Subject: [PATCH 13/20] serial: stm32: fix error handling in probe
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-14-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/tty/serial/stm32-usart.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index c54b89d..a62fc95 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -779,8 +779,10 @@ static int stm32_init_port(struct stm32_port *stm32port,
 		return ret;
 
 	stm32port->port.uartclk = clk_get_rate(stm32port->clk);
-	if (!stm32port->port.uartclk)
+	if (!stm32port->port.uartclk) {
+		clk_disable_unprepare(stm32port->clk);
 		ret = -EINVAL;
+	}
 
 	return ret;
 }
@@ -964,7 +966,7 @@ static int stm32_serial_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&stm32_usart_driver, &stm32port->port);
 	if (ret)
-		return ret;
+		goto err_uninit;
 
 	ret = stm32_of_dma_rx_probe(stm32port, pdev);
 	if (ret)
@@ -977,6 +979,11 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, &stm32port->port);
 
 	return 0;
+
+err_uninit:
+	clk_disable_unprepare(stm32port->clk);
+
+	return ret;
 }
 
 static int stm32_serial_remove(struct platform_device *pdev)
-- 
1.9.1
