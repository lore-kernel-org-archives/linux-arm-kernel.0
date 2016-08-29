From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:25:37 +0100
Subject: [PATCH 18/33] pcmcia: sa1100: provide generic CF support
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJl3-0000nS-Nw@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide generic non-voltage sensing socket support for StrongARM
platforms using the gpiolib and regulator subsystems to obtain the
resources to control the socket.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/sa1100_generic.c | 120 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 66acdc85727c..21ccf6360b3e 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -31,7 +31,9 @@
 ======================================================================*/
 
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 
@@ -41,9 +43,78 @@
 
 #include "sa1100_generic.h"
 
+static const char *gpio_name[] = {
+	[SOC_STAT_CD] = "detect",
+	[SOC_STAT_BVD1] = "bvd1",
+	[SOC_STAT_BVD2] = "bvd2",
+	[SOC_STAT_RDY] = "ready",
+};
+
+static int sa11x0_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+{
+	struct device *dev = skt->socket.dev.parent;
+	int i;
+
+	skt->gpio_reset = gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(skt->gpio_reset))
+		return PTR_ERR(skt->gpio_reset);
+
+	skt->gpio_bus_enable = gpiod_get_optional(dev, "bus-enable",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(skt->gpio_bus_enable)) {
+		gpiod_put(skt->gpio_reset);
+		return PTR_ERR(skt->gpio_bus_enable);
+	}
+
+	skt->vcc.reg = regulator_get_optional(dev, "vcc");
+	if (IS_ERR(skt->vcc.reg)) {
+		if (skt->gpio_bus_enable)
+			gpiod_put(skt->gpio_bus_enable);
+		gpiod_put(skt->gpio_reset);
+		return PTR_ERR(skt->vcc.reg);
+	}
+
+	if (!skt->vcc.reg)
+		dev_warn(dev,
+			 "no Vcc regulator provided, ignoring Vcc controls\n");
+
+	for (i = 0; i < ARRAY_SIZE(skt->stat); i++) {
+		skt->stat[i].name = gpio_name[i];
+		skt->stat[i].desc = gpiod_get_optional(dev, gpio_name[i],
+						       GPIOD_IN);
+		if (IS_ERR(skt->stat[i].desc)) {
+			int err = PTR_ERR(skt->stat[i].desc);
+
+			while (--i >= 0) {
+				if (skt->stat[i].desc)
+					gpiod_put(skt->stat[i].desc);
+			}
+			if (skt->gpio_bus_enable)
+				gpiod_put(skt->gpio_bus_enable);
+			gpiod_put(skt->gpio_reset);
+
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int sa11x0_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
+	const socket_state_t *state)
+{
+	return soc_pcmcia_regulator_set(skt, &skt->vcc, state->Vcc);
+}
+
+static struct pcmcia_low_level sa11x0_ops = {
+	.owner = THIS_MODULE,
+	.hw_init = sa11x0_pcmcia_hw_init,
+	.socket_state = soc_common_cf_socket_state,
+	.configure_socket = sa11x0_pcmcia_configure_socket,
+};
+
 int __init pcmcia_collie_init(struct device *dev);
 
-static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) = {
+static int (*sa11x0_pcmcia_legacy_hw_init[])(struct device *dev) = {
 #ifdef CONFIG_SA1100_ASSABET
 	pcmcia_assabet_init,
 #endif
@@ -67,15 +138,15 @@ static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) = {
 #endif
 };
 
-static int sa11x0_drv_pcmcia_probe(struct platform_device *dev)
+static int sa11x0_drv_pcmcia_legacy_probe(struct platform_device *dev)
 {
 	int i, ret = -ENODEV;
 
 	/*
 	 * Initialise any "on-board" PCMCIA sockets.
 	 */
-	for (i = 0; i < ARRAY_SIZE(sa11x0_pcmcia_hw_init); i++) {
-		ret = sa11x0_pcmcia_hw_init[i](&dev->dev);
+	for (i = 0; i < ARRAY_SIZE(sa11x0_pcmcia_legacy_hw_init); i++) {
+		ret = sa11x0_pcmcia_legacy_hw_init[i](&dev->dev);
 		if (ret == 0)
 			break;
 	}
@@ -83,7 +154,7 @@ static int sa11x0_drv_pcmcia_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
+static int sa11x0_drv_pcmcia_legacy_remove(struct platform_device *dev)
 {
 	struct skt_dev_info *sinfo = platform_get_drvdata(dev);
 	int i;
@@ -96,6 +167,45 @@ static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sa11x0_drv_pcmcia_probe(struct platform_device *pdev)
+{
+	struct soc_pcmcia_socket *skt;
+	struct device *dev = &pdev->dev;
+
+	if (dev->id == -1)
+		return sa11x0_drv_pcmcia_legacy_probe(pdev);
+
+	skt = devm_kzalloc(dev, sizeof(*skt), GFP_KERNEL);
+	if (!skt)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, skt);
+
+	skt->nr = pdev->id;
+	skt->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(skt->clk))
+		return PTR_ERR(skt->clk);
+
+	sa11xx_drv_pcmcia_ops(&sa11x0_ops);
+	soc_pcmcia_init_one(skt, &sa11x0_ops, dev);
+
+	return sa11xx_drv_pcmcia_add_one(skt);
+}
+
+static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
+{
+	struct soc_pcmcia_socket *skt;
+
+	if (dev->id == -1)
+		return sa11x0_drv_pcmcia_legacy_remove(dev);
+
+	skt = platform_get_drvdata(dev);
+
+	soc_pcmcia_remove_one(skt);
+
+	return 0;
+}
+
 static struct platform_driver sa11x0_pcmcia_driver = {
 	.driver = {
 		.name		= "sa11x0-pcmcia",
-- 
2.1.0
