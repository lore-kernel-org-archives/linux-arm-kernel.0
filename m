From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:26:39 +0100
Subject: [PATCH 30/33] ARM: sa1100/jornada720: switch jornada720 PCMCIA to
 gpiod APIs
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJm3-0000od-Aq@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the low level PCMCIA driver to gpiod APIs for controlling
the socket power.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/jornada720.c  | 12 ++++++
 drivers/pcmcia/sa1111_jornada720.c | 81 +++++++++++++++++++++++++-------------
 2 files changed, 66 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 0a2ca9be00e6..6298bad09ef3 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -190,6 +190,17 @@ static struct platform_device s1d13xxxfb_device = {
 	.resource	= s1d13xxxfb_resources,
 };
 
+static struct gpiod_lookup_table jornada_pcmcia_gpiod_table = {
+	.dev_id = "1800",
+	.table = {
+		GPIO_LOOKUP("sa1111", 0, "s0-power", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 1, "s1-power", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 2, "s0-3v", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sa1111", 3, "s1-3v", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct resource sa1111_resources[] = {
 	[0] = DEFINE_RES_MEM(SA1111REGSTART, SA1111REGLEN),
 	[1] = DEFINE_RES_IRQ(IRQ_GPIO1),
@@ -265,6 +276,7 @@ static int __init jornada720_init(void)
 		udelay(20);		/* give it some time to restart */
 
 		gpiod_add_lookup_table(&jornada_ts_gpiod_table);
+		gpiod_add_lookup_table(&jornada_pcmcia_gpiod_table);
 
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	}
diff --git a/drivers/pcmcia/sa1111_jornada720.c b/drivers/pcmcia/sa1111_jornada720.c
index c2c30580c83f..bfcb9fd43352 100644
--- a/drivers/pcmcia/sa1111_jornada720.c
+++ b/drivers/pcmcia/sa1111_jornada720.c
@@ -5,29 +5,64 @@
  *
  */
 #include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/sa1111.h>
 #include <asm/mach-types.h>
 
 #include "sa1111_generic.h"
 
-/* Does SOCKET1_3V actually do anything? */
-#define SOCKET0_POWER	GPIO_GPIO0
-#define SOCKET0_3V	GPIO_GPIO2
-#define SOCKET1_POWER	(GPIO_GPIO1 | GPIO_GPIO3)
-#define SOCKET1_3V	GPIO_GPIO3
+/*
+ * Socket 0 power: GPIO A0
+ * Socket 0 3V: GPIO A2
+ * Socket 1 power: GPIO A1 & GPIO A3
+ * Socket 1 3V: GPIO A3
+ * Does Socket 1 3V actually do anything?
+ */
+enum {
+	J720_GPIO_PWR,
+	J720_GPIO_3V,
+	J720_GPIO_MAX,
+};
+struct jornada720_data {
+	struct gpio_desc *gpio[J720_GPIO_MAX];
+};
+
+static int jornada720_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+{
+	struct sa1111_pcmcia_socket *s = to_skt(skt);
+	struct device *dev = skt->socket.dev.parent;
+	struct jornada720_data *j;
+
+	j = devm_kzalloc(dev, sizeof(*j), GFP_KERNEL);
+	if (!j)
+		return -ENOMEM;
+
+	j->gpio[J720_GPIO_PWR] = devm_gpiod_get(dev, skt->nr ? "s1-power" :
+						"s0-power", GPIOD_OUT_LOW);
+	if (IS_ERR(j->gpio[J720_GPIO_PWR]))
+		return PTR_ERR(j->gpio[J720_GPIO_PWR]);
+
+	j->gpio[J720_GPIO_3V] = devm_gpiod_get(dev, skt->nr ? "s1-3v" :
+					       "s0-3v", GPIOD_OUT_LOW);
+	if (IS_ERR(j->gpio[J720_GPIO_3V]))
+		return PTR_ERR(j->gpio[J720_GPIO_3V]);
+
+	s->driver_data = j;
+
+	return 0;
+}
 
 static int
 jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
 {
 	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned int pa_dwr_mask, pa_dwr_set;
+	struct jornada720_data *j = s->driver_data;
+	int values[J720_GPIO_MAX];
 	int ret;
 
 	printk(KERN_INFO "%s(): config socket %d vcc %d vpp %d\n", __func__,
@@ -35,35 +70,32 @@ jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_s
 
 	switch (skt->nr) {
 	case 0:
-		pa_dwr_mask = SOCKET0_POWER | SOCKET0_3V;
-
 		switch (state->Vcc) {
 		default:
 		case  0:
-			pa_dwr_set = 0;
+			values[J720_GPIO_PWR] = 0;
+			values[J720_GPIO_3V] = 0;
 			break;
 		case 33:
-			pa_dwr_set = SOCKET0_POWER | SOCKET0_3V;
+			values[J720_GPIO_3V] = 1;
 			break;
 		case 50:
-			pa_dwr_set = SOCKET0_POWER;
+			values[J720_GPIO_PWR] = 1;
 			break;
 		}
 		break;
 
 	case 1:
-		pa_dwr_mask = SOCKET1_POWER;
-
 		switch (state->Vcc) {
 		default:
 		case 0:
-			pa_dwr_set = 0;
+			values[J720_GPIO_PWR] = 0;
+			values[J720_GPIO_3V] = 0;
 			break;
 		case 33:
-			pa_dwr_set = SOCKET1_POWER;
-			break;
 		case 50:
-			pa_dwr_set = SOCKET1_POWER;
+			values[J720_GPIO_PWR] = 1;
+			values[J720_GPIO_3V] = 1;
 			break;
 		}
 		break;
@@ -80,13 +112,14 @@ jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_s
 
 	ret = sa1111_pcmcia_configure_socket(skt, state);
 	if (ret == 0)
-		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
+		gpiod_set_array_value(J720_GPIO_MAX, j->gpio, values);
 
 	return ret;
 }
 
 static struct pcmcia_low_level jornada720_pcmcia_ops = {
 	.owner			= THIS_MODULE,
+	.hw_init		= jornada720_pcmcia_hw_init,
 	.configure_socket	= jornada720_pcmcia_configure_socket,
 	.first			= 0,
 	.nr			= 2,
@@ -97,15 +130,9 @@ int pcmcia_jornada720_init(struct sa1111_dev *sadev)
 	int ret = -ENODEV;
 
 	if (machine_is_jornada720()) {
-		unsigned int pin = GPIO_A0 | GPIO_A1 | GPIO_A2 | GPIO_A3;
-
+		/* Fixme: why messing around with SA11x0's GPIO1? */
 		GRER |= 0x00000002;
 
-		/* Set GPIO_A<3:1> to be outputs for PCMCIA/CF power controller: */
-		sa1111_set_io_dir(sadev, pin, 0, 0);
-		sa1111_set_io(sadev, pin, 0);
-		sa1111_set_sleep_io(sadev, pin, 0);
-
 		sa11xx_drv_pcmcia_ops(&jornada720_pcmcia_ops);
 		ret = sa1111_pcmcia_add(sadev, &jornada720_pcmcia_ops,
 				sa11xx_drv_pcmcia_add_one);
-- 
2.1.0
