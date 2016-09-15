From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 15 Sep 2016 18:42:38 +0200
Subject: [PATCH 06/11] serial: stm32: clock disabling management
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473957763-30629-7-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep the clock enabled at the end of stm32_init_port
but disable it in stm32_serial_remove.
Note that stm32_pm function is there to manage the
clock at runtime.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ab294b9..520e7de 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -487,8 +487,6 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	if (!stm32port->port.uartclk)
 		ret = -EINVAL;
 
-	clk_disable_unprepare(stm32port->clk);
-
 	return ret;
 }
 
@@ -557,6 +555,9 @@ static int stm32_serial_probe(struct platform_device *pdev)
 static int stm32_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
+	struct stm32_port *stm32_port = to_stm32_port(port);
+
+	clk_disable_unprepare(stm32_port->clk);
 
 	return uart_remove_one_port(&stm32_usart_driver, port);
 }
-- 
1.9.1
