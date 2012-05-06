From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  6 May 2012 23:34:58 +0800
Subject: [PATCH 2/9] serial: amba-pl011: adopt pinctrl support
In-Reply-To: <1336318505-27043-1-git-send-email-shawn.guo@linaro.org>
References: <1336318505-27043-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336318505-27043-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3d569cd..062ef8c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -52,6 +52,7 @@
 #include <linux/scatterlist.h>
 #include <linux/delay.h>
 #include <linux/types.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
@@ -1916,6 +1917,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
+	struct pinctrl *pinctrl;
 	void __iomem *base;
 	int i, ret;
 
@@ -1940,6 +1942,12 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto free;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&dev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto unmap;
+	}
+
 	uap->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(uap->clk)) {
 		ret = PTR_ERR(uap->clk);
-- 
1.7.5.4
