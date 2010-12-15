From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:45 +0100
Subject: [PATCH 11/16] ARM: mxc: Switch over to gpiolib ->to_irq() and
	__gpio_to_irq().
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020345.GD15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/plat-mxc/gpio.c              |    9 +++++++++
 arch/arm/plat-mxc/include/mach/gpio.h |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 9c3e362..8e97976 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -272,6 +272,14 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static int mxc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct mxc_gpio_port *port =
+		container_of(chip, struct mxc_gpio_port, chip);
+
+	return port->virtual_irq_start + offset;
+}
+
 static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct mxc_gpio_port *port =
@@ -320,6 +328,7 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 		port[i].chip.direction_output = mxc_gpio_direction_output;
 		port[i].chip.get = mxc_gpio_get;
 		port[i].chip.set = mxc_gpio_set;
+		port[i].chip.to_irq = mxc_gpio_to_irq;
 		port[i].chip.base = i * 32;
 		port[i].chip.ngpio = 32;
 
diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index af33b74..9062fe3 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -27,8 +27,8 @@
 #define gpio_get_value		__gpio_get_value
 #define gpio_set_value		__gpio_set_value
 #define gpio_cansleep		__gpio_cansleep
+#define gpio_to_irq		__gpio_to_irq
 
-#define gpio_to_irq(gpio)	(MXC_GPIO_IRQ_START + (gpio))
 #define irq_to_gpio(irq)	((irq) - MXC_GPIO_IRQ_START)
 
 struct mxc_gpio_port {
-- 
1.7.1
