From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 11:11:47 +0000
Subject: [PATCH 3/8] ARM: sa1100/jornada720: switch PCMCIA to gpiod APIs
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <E1gRxkx-0001uV-V2@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the low level PCMCIA driver to gpiod APIs for controlling
the socket power.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/jornada720.c  | 12 ++++++
 drivers/pcmcia/sa1111_jornada720.c | 83 +++++++++++++++++++++++++-------------
 2 files changed, 67 insertions(+), 28 deletions(-)

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
index 3d4ca87ca76c..1083e1b4f25d 100644
--- a/drivers/pcmcia/sa1111_jornada720.c
+++ b/drivers/pcmcia/sa1111_jornada720.c
@@ -6,29 +6,62 @@
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
+	skt->driver_data = j;
+
+	return 0;
+}
 
 static int
 jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
 {
-	struct sa1111_pcmcia_socket *s = to_skt(skt);
-	unsigned int pa_dwr_mask, pa_dwr_set;
+	struct jornada720_data *j = skt->driver_data;
+	DECLARE_BITMAP(values, J720_GPIO_MAX) = { 0, };
 	int ret;
 
 	printk(KERN_INFO "%s(): config socket %d vcc %d vpp %d\n", __func__,
@@ -36,35 +69,34 @@ jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_s
 
 	switch (skt->nr) {
 	case 0:
-		pa_dwr_mask = SOCKET0_POWER | SOCKET0_3V;
-
 		switch (state->Vcc) {
 		default:
 		case  0:
-			pa_dwr_set = 0;
+			__assign_bit(J720_GPIO_PWR, values, 0);
+			__assign_bit(J720_GPIO_3V, values, 0);
 			break;
 		case 33:
-			pa_dwr_set = SOCKET0_POWER | SOCKET0_3V;
+			__assign_bit(J720_GPIO_PWR, values, 1);
+			__assign_bit(J720_GPIO_3V, values, 1);
 			break;
 		case 50:
-			pa_dwr_set = SOCKET0_POWER;
+			__assign_bit(J720_GPIO_PWR, values, 1);
+			__assign_bit(J720_GPIO_3V, values, 0);
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
+			__assign_bit(J720_GPIO_PWR, values, 0);
+			__assign_bit(J720_GPIO_3V, values, 0);
 			break;
 		case 33:
-			pa_dwr_set = SOCKET1_POWER;
-			break;
 		case 50:
-			pa_dwr_set = SOCKET1_POWER;
+			__assign_bit(J720_GPIO_PWR, values, 1);
+			__assign_bit(J720_GPIO_3V, values, 1);
 			break;
 		}
 		break;
@@ -81,13 +113,15 @@ jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_s
 
 	ret = sa1111_pcmcia_configure_socket(skt, state);
 	if (ret == 0)
-		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
+		ret = gpiod_set_array_value_cansleep(J720_GPIO_MAX, j->gpio,
+						     NULL, values);
 
 	return ret;
 }
 
 static struct pcmcia_low_level jornada720_pcmcia_ops = {
 	.owner			= THIS_MODULE,
+	.hw_init		= jornada720_pcmcia_hw_init,
 	.configure_socket	= jornada720_pcmcia_configure_socket,
 	.first			= 0,
 	.nr			= 2,
@@ -95,16 +129,9 @@ static struct pcmcia_low_level jornada720_pcmcia_ops = {
 
 int pcmcia_jornada720_init(struct sa1111_dev *sadev)
 {
-	unsigned int pin = GPIO_A0 | GPIO_A1 | GPIO_A2 | GPIO_A3;
-
 	/* Fixme: why messing around with SA11x0's GPIO1? */
 	GRER |= 0x00000002;
 
-	/* Set GPIO_A<3:1> to be outputs for PCMCIA/CF power controller: */
-	sa1111_set_io_dir(sadev, pin, 0, 0);
-	sa1111_set_io(sadev, pin, 0);
-	sa1111_set_sleep_io(sadev, pin, 0);
-
 	sa11xx_drv_pcmcia_ops(&jornada720_pcmcia_ops);
 	return sa1111_pcmcia_add(sadev, &jornada720_pcmcia_ops,
 				 sa11xx_drv_pcmcia_add_one);
-- 
2.7.4
