From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 12:48:22 +0100
Subject: [RFC PATCH 5/5] mxc: convert to basic-mmio-gpio
In-Reply-To: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1302522502-24381-6-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The basic-mmio-gpio driver is capable of supporting this controller so
convert the platform to use it for basic GPIO support.

Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/plat-mxc/gpio.c              |   96 +++++++++-----------------------
 arch/arm/plat-mxc/include/mach/gpio.h |    3 +-
 2 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 7a10724..9c494b4 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -19,11 +19,14 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <linux/basic_mmio_gpio.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 #include <mach/hardware.h>
 #include <asm-generic/bug.h>
 
@@ -40,6 +43,14 @@ static int gpio_table_size;
 #define GPIO_IMR	(cpu_is_mx1_mx2() ? 0x30 : 0x14)
 #define GPIO_ISR	(cpu_is_mx1_mx2() ? 0x34 : 0x18)
 
+#define GPIO_RES(__name, __addr) \
+	{ \
+		.start = (__addr), \
+		.end = (__addr) + 0x3, \
+		.flags = IORESOURCE_MEM, \
+		.name = #__name, \
+	}
+
 #define GPIO_INT_LOW_LEV	(cpu_is_mx1_mx2() ? 0x3 : 0x0)
 #define GPIO_INT_HIGH_LEV	(cpu_is_mx1_mx2() ? 0x2 : 0x1)
 #define GPIO_INT_RISE_EDGE	(cpu_is_mx1_mx2() ? 0x0 : 0x2)
@@ -81,8 +92,6 @@ static void gpio_unmask_irq(struct irq_data *d)
 	_set_gpio_irqenable(&mxc_gpio_ports[gpio / 32], gpio & 0x1f, 1);
 }
 
-static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset);
-
 static int gpio_set_irq_type(struct irq_data *d, u32 type)
 {
 	u32 gpio = irq_to_gpio(d->irq);
@@ -100,7 +109,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 		edge = GPIO_INT_FALL_EDGE;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		val = mxc_gpio_get(&port->chip, gpio & 31);
+		val = gpio_get_value(gpio);
 		if (val) {
 			edge = GPIO_INT_LOW_LEV;
 			pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
@@ -241,60 +250,6 @@ static struct irq_chip gpio_irq_chip = {
 	.irq_set_wake = gpio_set_wake_irq,
 };
 
-static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
-				int dir)
-{
-	struct mxc_gpio_port *port =
-		container_of(chip, struct mxc_gpio_port, chip);
-	u32 l;
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->lock, flags);
-	l = __raw_readl(port->base + GPIO_GDIR);
-	if (dir)
-		l |= 1 << offset;
-	else
-		l &= ~(1 << offset);
-	__raw_writel(l, port->base + GPIO_GDIR);
-	spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-{
-	struct mxc_gpio_port *port =
-		container_of(chip, struct mxc_gpio_port, chip);
-	void __iomem *reg = port->base + GPIO_DR;
-	u32 l;
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->lock, flags);
-	l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);
-	__raw_writel(l, reg);
-	spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	struct mxc_gpio_port *port =
-		container_of(chip, struct mxc_gpio_port, chip);
-
-	return (__raw_readl(port->base + GPIO_PSR) >> offset) & 1;
-}
-
-static int mxc_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	_set_gpio_direction(chip, offset, 0);
-	return 0;
-}
-
-static int mxc_gpio_direction_output(struct gpio_chip *chip,
-				     unsigned offset, int value)
-{
-	mxc_gpio_set(chip, offset, value);
-	_set_gpio_direction(chip, offset, 1);
-	return 0;
-}
-
 int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 {
 	int i, j;
@@ -306,6 +261,17 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 	printk(KERN_INFO "MXC GPIO hardware\n");
 
 	for (i = 0; i < cnt; i++) {
+		struct resource res[] = {
+			GPIO_RES(set, port[i].base_phys + GPIO_DR),
+			GPIO_RES(dat, port[i].base_phys + GPIO_PSR),
+			GPIO_RES(dirout, port[i].base_phys + GPIO_GDIR),
+		};
+		struct bgpio_pdata pdata = {
+			.base	= i * 32,
+			.ngpio	= 32,
+		};
+		struct platform_device *pdev;
+
 		/* disable the interrupt and clear the status */
 		__raw_writel(0, port[i].base + GPIO_IMR);
 		__raw_writel(~0, port[i].base + GPIO_ISR);
@@ -316,18 +282,10 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 			set_irq_flags(j, IRQF_VALID);
 		}
 
-		/* register gpio chip */
-		port[i].chip.direction_input = mxc_gpio_direction_input;
-		port[i].chip.direction_output = mxc_gpio_direction_output;
-		port[i].chip.get = mxc_gpio_get;
-		port[i].chip.set = mxc_gpio_set;
-		port[i].chip.base = i * 32;
-		port[i].chip.ngpio = 32;
-
-		spin_lock_init(&port[i].lock);
-
-		/* its a serious configuration bug when it fails */
-		BUG_ON( gpiochip_add(&port[i].chip) < 0 );
+		pdev = platform_device_register_resndata(NULL,
+			"basic-mmio-gpio", i, res, ARRAY_SIZE(res), &pdata,
+			sizeof(pdata));
+		BUG_ON(IS_ERR(pdev));
 
 		if (cpu_is_mx1() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
 			/* setup one handler for each entry */
diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index a2747f1..ba46be9 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -38,12 +38,12 @@
 
 struct mxc_gpio_port {
 	void __iomem *base;
+	unsigned long base_phys;
 	int irq;
 	int irq_high;
 	int virtual_irq_start;
 	struct gpio_chip chip;
 	u32 both_edges;
-	spinlock_t lock;
 };
 
 #define DEFINE_IMX_GPIO_PORT_IRQ_HIGH(soc, _id, _hwid, _irq, _irq_high)	\
@@ -53,6 +53,7 @@ struct mxc_gpio_port {
 		.irq_high = _irq_high,					\
 		.base = soc ## _IO_ADDRESS(				\
 				soc ## _GPIO ## _hwid ## _BASE_ADDR),	\
+		.base_phys = soc ## _GPIO ## _hwid ## _BASE_ADDR,	\
 		.virtual_irq_start = MXC_GPIO_IRQ_START + (_id) * 32,	\
 	}
 
-- 
1.7.4.2
