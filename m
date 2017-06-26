From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:10 +0000
Subject: [PATCH 05/20] serial: stm32: add debugfs
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-6-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Adding debugfs infrastructure and one virtual
file allowing to change fifoen value.
This value change is taken into account on next
port setup or enabling.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 49 ++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/stm32-usart.h |  3 +++
 2 files changed, 52 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 34e31d1..3ce0f7a 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -34,6 +34,51 @@
 
 #include "stm32-usart.h"
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+static struct dentry *stm32_debugfs_root;
+static atomic_t stm32_debugfs_cnt = ATOMIC_INIT(0);
+
+static void stm32_serial_debugfs(struct stm32_port *stm32port,
+				 phys_addr_t phys_addr)
+{
+	struct device *dev = stm32port->port.dev;
+
+	if (!stm32_debugfs_root)
+		stm32_debugfs_root = debugfs_create_dir("usart-stm32", NULL);
+
+	stm32port->debugfs_dir = debugfs_create_dir(dev_name(dev),
+						    stm32_debugfs_root);
+
+	debugfs_create_bool("fifoen", 0644,
+			    stm32port->debugfs_dir, &stm32port->fifoen);
+
+	atomic_inc(&stm32_debugfs_cnt);
+}
+
+static void stm32_serial_debugfs_rm(struct stm32_port *stm32port)
+{
+	debugfs_remove_recursive(stm32port->debugfs_dir);
+	if (atomic_dec_and_test(&stm32_debugfs_cnt)) {
+		debugfs_remove_recursive(stm32_debugfs_root);
+		stm32_debugfs_root = NULL;
+	}
+}
+#else
+static void stm32_serial_debugfs(struct stm32_port *stm32port,
+				 phys_addr_t phys_addr)
+{
+}
+
+static void stm32_serial_debugfs_rm(struct stm32_port *stm32port)
+{
+}
+#endif
+
 static void stm32_stop_tx(struct uart_port *port);
 static void stm32_transmit_chars(struct uart_port *port);
 
@@ -672,6 +717,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
 		return PTR_ERR(port->membase);
 	port->mapbase = res->start;
 
+	stm32_serial_debugfs(stm32port, res->start);
+
 	spin_lock_init(&port->lock);
 
 	stm32port->clk = devm_clk_get(&pdev->dev, NULL);
@@ -914,6 +961,8 @@ static int stm32_serial_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(stm32_port->clk);
 
+	stm32_serial_debugfs_rm(stm32_port);
+
 	return uart_remove_one_port(&stm32_usart_driver, port);
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 9429baf..a8999a1 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -216,6 +216,9 @@ struct stm32_port {
 	struct uart_port port;
 	struct clk *clk;
 	struct stm32_usart_info *info;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_dir;
+#endif
 	struct dma_chan *rx_ch;  /* dma rx channel            */
 	dma_addr_t rx_dma_buf;   /* dma rx buffer bus address */
 	unsigned char *rx_buf;   /* dma rx buffer cpu address */
-- 
1.9.1
