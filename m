From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 14 May 2015 06:45:22 +0000
Subject: [PATCH 2/6] serial: sirf: fix the issue that HW flow control doesn't
 work for BT
In-Reply-To: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
References: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1431585926-10746-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

>From HW spec, when rxfifo's data is less than AFC_RX_THD(RX threshhold), RTS
signal is active. otherwise, RTS signal is inactive.

Crrently the RX threshhold is set as zero, so RTS has no chance to be
active. This patch replaces the default 0 by a positive number.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 1d0d47f..48cceaf 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -344,7 +344,8 @@ static void sirfsoc_uart_enable_ms(struct uart_port *port)
 	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
 		wr_regl(port, ureg->sirfsoc_afc_ctrl,
 				rd_regl(port, ureg->sirfsoc_afc_ctrl) |
-				SIRFUART_AFC_TX_EN | SIRFUART_AFC_RX_EN);
+				SIRFUART_AFC_TX_EN | SIRFUART_AFC_RX_EN |
+				SIRFUART_AFC_CTRL_RX_THD);
 		if (!sirfport->is_atlas7)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
 					rd_regl(port, ureg->sirfsoc_int_en_reg)
-- 
2.3.5
