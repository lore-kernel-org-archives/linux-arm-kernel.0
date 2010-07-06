From: baruch@tkos.co.il (Baruch Siach)
Date: Tue,  6 Jul 2010 14:03:22 +0300
Subject: [PATCH v2] arm/imx/gpio: add spinlock protection
In-Reply-To: <20100706103748.GE28547@jasper.tkos.co.il>
References: <20100706103748.GE28547@jasper.tkos.co.il>
Message-ID: <a1d5b20ff1b6e39355fcad2e882489df55c7bf2a.1278413731.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO registers need protection from concurrent access for operations that
are not atomic.

Cc: stable at kernel.org
Cc: Juergen Beisert <j.beisert@pengutronix.de>
Cc: Daniel Mack <daniel@caiaq.de>
Reported-by: rpkamiak at rockwellcollins.com
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
Changes v1 -> v2

    Remove redundant protection of GPIO/IRQ registers

 arch/arm/plat-mxc/gpio.c              |    8 ++++++++
 arch/arm/plat-mxc/include/mach/gpio.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 71437c6..9ebbd31 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -214,13 +214,16 @@ static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
 	struct mxc_gpio_port *port =
 		container_of(chip, struct mxc_gpio_port, chip);
 	u32 l;
+	unsigned long flags;
 
+	spin_lock_irqsave(&port->lock, flags);
 	l = __raw_readl(port->base + GPIO_GDIR);
 	if (dir)
 		l |= 1 << offset;
 	else
 		l &= ~(1 << offset);
 	__raw_writel(l, port->base + GPIO_GDIR);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
@@ -229,9 +232,12 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		container_of(chip, struct mxc_gpio_port, chip);
 	void __iomem *reg = port->base + GPIO_DR;
 	u32 l;
+	unsigned long flags;
 
+	spin_lock_irqsave(&port->lock, flags);
 	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);
 	__raw_writel(l, reg);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -285,6 +291,8 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 		port[i].chip.base = i * 32;
 		port[i].chip.ngpio = 32;
 
+		spin_lock_init(&port[i].lock);
+
 		/* its a serious configuration bug when it fails */
 		BUG_ON( gpiochip_add(&port[i].chip) < 0 );
 
diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 894d2f8..6bd932c 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -36,6 +36,7 @@ struct mxc_gpio_port {
 	int virtual_irq_start;
 	struct gpio_chip chip;
 	u32 both_edges;
+	spinlock_t lock;
 };
 
 int mxc_gpio_init(struct mxc_gpio_port*, int);
-- 
1.7.1
