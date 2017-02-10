From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Fri, 10 Feb 2017 22:06:40 +0100
Subject: [PATCH] serial: efm32: Fix parity management in
 'efm32_uart_console_get_options()'
Message-ID: <20170210210640.17749-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UARTn_FRAME_PARITY_ODD is 0x0300
UARTn_FRAME_PARITY_EVEN is 0x0200
So if the UART is configured for EVEN parity, it would be reported as ODD.
Fix it by testing if the 2 bits are set in the ODD case.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested
---
 drivers/tty/serial/efm32-uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index ebd8569f9ad5..84034ef20c88 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -572,9 +572,9 @@ static void efm32_uart_console_get_options(struct efm32_uart_port *efm_port,
 			16 * (4 + (clkdiv >> 6)));
 
 	frame = efm32_uart_read32(efm_port, UARTn_FRAME);
-	if (frame & UARTn_FRAME_PARITY_ODD)
+	if ((frame & UARTn_FRAME_PARITY_ODD) == UARTn_FRAME_PARITY_ODD)
 		*parity = 'o';
-	else if (frame & UARTn_FRAME_PARITY_EVEN)
+	else if ((frame & UARTn_FRAME_PARITY_EVEN) == UARTn_FRAME_PARITY_EVEN)
 		*parity = 'e';
 	else
 		*parity = 'n';
-- 
2.9.3
