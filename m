From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 12 Jan 2015 21:08:22 +0800
Subject: [PATCH v2 2/4] tty: serial: 8250_mtk: Add earlycon
In-Reply-To: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1421068104-30463-3-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 8250 MTK UART driver to support earlycon device tree.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 7a11fac..86964df 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -23,6 +23,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/console.h>
 
 #include "8250.h"
 
@@ -289,6 +290,20 @@ static struct platform_driver mtk8250_platform_driver = {
 };
 module_platform_driver(mtk8250_platform_driver);
 
+static int __init early_mtk8250_setup(struct earlycon_device *device,
+					const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->port.iotype = UPIO_MEM32;
+	device->noinit = 1;
+
+	return early_serial8250_setup(device, NULL);
+}
+
+OF_EARLYCON_DECLARE(mtk8250, "mediatek,mt6577-uart", early_mtk8250_setup);
+
 MODULE_AUTHOR("Matthias Brugger");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Mediatek 8250 serial port driver");
-- 
1.8.1.1.dirty
