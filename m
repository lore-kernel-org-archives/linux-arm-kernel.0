From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri, 13 Oct 2017 11:01:50 +0200
Subject: [PATCH v2 06/16] serial: mvebu-uart: add soft reset at probe
In-Reply-To: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Message-ID: <20171013090200.31034-7-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Allen Yan <yanwei@marvell.com>

The existing UART driver relies on the bootloader to initialize the
port(s). However, the secondary uart port may not be initialized
properly in early boot stage. This patch adds the UART soft reset when
probing, for all ports.

Signed-off-by: Allen Yan <yanwei@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/tty/serial/mvebu-uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 900fe85796d6..e233f464d55a 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -660,6 +660,11 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	port->private_data = mvuart;
 	platform_set_drvdata(pdev, mvuart);
 
+	/* UART Soft Reset*/
+	writel(CTRL_SOFT_RST, port->membase + UART_CTRL(port));
+	udelay(1);
+	writel(0, port->membase + UART_CTRL(port));
+
 	ret = uart_add_one_port(&mvebu_uart_driver, port);
 	if (ret)
 		return ret;
-- 
2.11.0
