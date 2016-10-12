From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 12 Oct 2016 09:21:03 +0300
Subject: [patch] serial: stm32: fix a type issue
Message-ID: <20161012062103.GS12841@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We store UNDEF_REG in a u8.  It causes a problem in functions like
stm32_tx_dma_complete() where we check "if (ofs->icr == UNDEF_REG)".

Fixes: 3489187204eb ('serial: stm32: adding dma support')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 41d9749..f9887cc 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -31,7 +31,7 @@ struct stm32_usart_info {
 	struct stm32_usart_config cfg;
 };
 
-#define UNDEF_REG ~0
+#define UNDEF_REG 0xFF
 
 /* Register offsets */
 struct stm32_usart_info stm32f4_info = {
