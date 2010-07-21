From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 21 Jul 2010 14:46:11 +0200
Subject: [PATCH v2 1/3] i.MX51: handle IRQ for gpio 16..31
In-Reply-To: <1279703092.5412.47.camel@ra7055-laptop>
References: <1279703092.5412.47.camel@ra7055-laptop>
Message-ID: <1279716371-9852-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX51 generates 2 IRQ for each GPIO bank : one for gpio 0 to 15
and one for gpio 16 to 31.
Actually only the lower IRQ is registered so register the second one.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 :
	add irq_high to struct mxc_gpio_port as per Rob Herring's
	suggestion

 arch/arm/mach-mx5/devices.c           |    4 ++++
 arch/arm/plat-mxc/gpio.c              |    6 ++++++
 arch/arm/plat-mxc/include/mach/gpio.h |    1 +
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index aafa61c..1920ff4 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -250,24 +250,28 @@ static struct mxc_gpio_port mxc_gpio_ports[] = {
 		.chip.label = "gpio-0",
 		.base = MX51_IO_ADDRESS(MX51_GPIO1_BASE_ADDR),
 		.irq = MX51_MXC_INT_GPIO1_LOW,
+		.irq_high = MX51_MXC_INT_GPIO1_HIGH,
 		.virtual_irq_start = MXC_GPIO_IRQ_START
 	},
 	{
 		.chip.label = "gpio-1",
 		.base = MX51_IO_ADDRESS(MX51_GPIO2_BASE_ADDR),
 		.irq = MX51_MXC_INT_GPIO2_LOW,
+		.irq_high = MX51_MXC_INT_GPIO2_HIGH,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 1
 	},
 	{
 		.chip.label = "gpio-2",
 		.base = MX51_IO_ADDRESS(MX51_GPIO3_BASE_ADDR),
 		.irq = MX51_MXC_INT_GPIO3_LOW,
+		.irq_high = MX51_MXC_INT_GPIO3_HIGH,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 2
 	},
 	{
 		.chip.label = "gpio-3",
 		.base = MX51_IO_ADDRESS(MX51_GPIO4_BASE_ADDR),
 		.irq = MX51_MXC_INT_GPIO4_LOW,
+		.irq_high = MX51_MXC_INT_GPIO4_HIGH,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 3
 	},
 };
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 71437c6..11dc061 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -292,6 +292,12 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 			/* setup one handler for each entry */
 			set_irq_chained_handler(port[i].irq, mx3_gpio_irq_handler);
 			set_irq_data(port[i].irq, &port[i]);
+			if (port[i].irq_high) {
+				/* setup handler for GPIO 16 to 31 */
+				set_irq_chained_handler(port[i].irq_high,
+						mx3_gpio_irq_handler);
+				set_irq_data(port[i].irq_high, &port[i]);
+			}
 		}
 	}
 
diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 894d2f8..9541ecb 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -33,6 +33,7 @@
 struct mxc_gpio_port {
 	void __iomem *base;
 	int irq;
+	int irq_high;
 	int virtual_irq_start;
 	struct gpio_chip chip;
 	u32 both_edges;
-- 
1.6.3.3
