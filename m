From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 14 May 2015 06:45:25 +0000
Subject: [PATCH 5/6] serial: sirf: add serial loopback function support
In-Reply-To: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
References: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1431585926-10746-5-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 20 ++++++++++++++++++++
 drivers/tty/serial/sirfsoc_uart.h |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index a500721..0e43799 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -108,6 +108,26 @@ static void sirfsoc_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	unsigned int val = assert ? SIRFUART_AFC_CTRL_RX_THD : 0x0;
 	unsigned int current_val;
 
+	if (mctrl & TIOCM_LOOP) {
+		if (sirfport->uart_reg->uart_type == SIRF_REAL_UART)
+			wr_regl(port, ureg->sirfsoc_line_ctrl,
+				rd_regl(port, ureg->sirfsoc_line_ctrl) |
+				SIRFUART_LOOP_BACK);
+		else
+			wr_regl(port, ureg->sirfsoc_mode1,
+				rd_regl(port, ureg->sirfsoc_mode1) |
+				SIRFSOC_USP_LOOP_BACK_CTRL);
+	} else {
+		if (sirfport->uart_reg->uart_type == SIRF_REAL_UART)
+			wr_regl(port, ureg->sirfsoc_line_ctrl,
+				rd_regl(port, ureg->sirfsoc_line_ctrl) &
+				~SIRFUART_LOOP_BACK);
+		else
+			wr_regl(port, ureg->sirfsoc_mode1,
+				rd_regl(port, ureg->sirfsoc_mode1) &
+				~SIRFSOC_USP_LOOP_BACK_CTRL);
+	}
+
 	if (!sirfport->hw_flow_ctrl || !sirfport->ms_enabled)
 		return;
 	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index b49c23a..3ab3141 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -322,7 +322,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRFSOC_USP_RX_CLK_DIVISOR_OFFSET	24
 #define SIRFSOC_USP_ASYNC_DIV2_MASK		0x3f
 #define SIRFSOC_USP_ASYNC_DIV2_OFFSET		16
-
+#define SIRFSOC_USP_LOOP_BACK_CTRL		BIT(2)
 /* USP-UART Common */
 #define SIRFSOC_UART_RX_TIMEOUT(br, to)	(((br) * (((to) + 999) / 1000)) / 1000)
 #define SIRFUART_RECV_TIMEOUT_VALUE(x)	\
-- 
2.3.5
