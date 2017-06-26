From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:10 +0000
Subject: [PATCH 03/20] serial: stm32: fix multi ports management
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-4-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

alias definition in the device tree is mandatory
for each port.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 6 ++++--
 drivers/tty/serial/stm32-usart.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 50948f6..c6ae4fd 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -696,8 +696,10 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 		return NULL;
 
 	id = of_alias_get_id(np, "serial");
-	if (id < 0)
-		id = 0;
+	if (id < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", id);
+		return NULL;
+	}
 
 	if (WARN_ON(id >= STM32_MAX_PORTS))
 		return NULL;
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 9f0d0e8..33f1320 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -206,7 +206,7 @@ struct stm32_usart_info stm32f7_info = {
 #define USART_ICR_CMCF		BIT(17)		/* F7 */
 
 #define STM32_SERIAL_NAME "ttyS"
-#define STM32_MAX_PORTS 6
+#define STM32_MAX_PORTS 8
 
 #define RX_BUF_L 200		 /* dma rx buffer length     */
 #define RX_BUF_P RX_BUF_L	 /* dma rx buffer period     */
-- 
1.9.1
