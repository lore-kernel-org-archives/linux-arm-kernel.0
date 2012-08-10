From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 15:02:05 +0200
Subject: [PATCH 08/14] tty: atmel_serial: add pinctrl support
In-Reply-To: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1344603731-32667-8-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-serial at vger.kernel.org
---
Hi Greg,

	if you don't mind I would like to apply with the rest of the pinctrl
	patch series

Best Regards,
J.
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
