From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 13 Jul 2017 15:08:29 +0000
Subject: [PATCH 6/9] serial: stm32: fix error handling in probe
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Message-ID: <1499958494-19354-7-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Disable clock properly in case of error.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 9158d31..413ff49 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -678,8 +678,10 @@ static int stm32_init_port(struct stm32_port *stm32port,
 		return ret;
 
 	stm32port->port.uartclk = clk_get_rate(stm32port->clk);
-	if (!stm32port->port.uartclk)
+	if (!stm32port->port.uartclk) {
+		clk_disable_unprepare(stm32port->clk);
 		ret = -EINVAL;
+	}
 
 	return ret;
 }
@@ -865,7 +867,7 @@ static int stm32_serial_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&stm32_usart_driver, &stm32port->port);
 	if (ret)
-		return ret;
+		goto err_uninit;
 
 	ret = stm32_of_dma_rx_probe(stm32port, pdev);
 	if (ret)
@@ -878,6 +880,11 @@ static int stm32_serial_probe(struct platform_device *pdev)
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
