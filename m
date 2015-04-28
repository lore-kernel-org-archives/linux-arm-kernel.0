From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 28 Apr 2015 21:40:33 +0800
Subject: [PATCH v3 2/3] tty: serial: 8250_mtk: Add earlycon
In-Reply-To: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1430228434-31779-3-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 8250 MTK UART driver to support earlycon device tree.
Earlycon take effect by
  add "earlycon" in kernel boot argument
  add "linux,sdtout-path" property in device tree file

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 7a11fac..8b2a666 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -289,6 +289,19 @@ static struct platform_driver mtk8250_platform_driver = {
 };
 module_platform_driver(mtk8250_platform_driver);
 
+static int __init early_mtk8250_setup(struct earlycon_device *device,
+					const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->port.iotype = UPIO_MEM32;
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
