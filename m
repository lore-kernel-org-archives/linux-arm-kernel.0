From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:27:07 +0200
Subject: [PATCH 10/16] tty: atmel_serial: add pinctrl support
In-Reply-To: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120917140423.GA17667@game.jcrosoft.org>
 <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1347895633-1763-10-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/tty/serial/atmel_serial.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3d7e1ee..65f891b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -39,6 +39,7 @@
 #include <linux/atmel_pdc.h>
 #include <linux/atmel_serial.h>
 #include <linux/uaccess.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
@@ -1773,6 +1774,7 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
 	struct atmel_uart_data *pdata = pdev->dev.platform_data;
 	void *data;
 	int ret = -ENODEV;
+	struct pinctrl *pinctrl;
 
 	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
 
@@ -1805,6 +1807,12 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
 
 	atmel_init_port(port, pdev);
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto err;
+	}
+
 	if (!atmel_use_dma_rx(&port->uart)) {
 		ret = -ENOMEM;
 		data = kmalloc(sizeof(struct atmel_uart_char)
-- 
1.7.10.4
