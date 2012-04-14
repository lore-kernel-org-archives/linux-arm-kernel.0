From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Apr 2012 09:57:09 +0100
Subject: [PATCH] Fix asic3 build error
Message-ID: <20120414085709.GQ24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP randconfig builds occasionally fail with:

drivers/mfd/asic3.c: In function 'asic3_gpio_to_irq':
drivers/mfd/asic3.c:530: error: 'IRQ_BOARD_START' undeclared (first use in this function)
drivers/mfd/asic3.c:530: error: (Each undeclared identifier is reported only once
drivers/mfd/asic3.c:530: error: for each function it appears in.)

Fix it by using asic->irq_base rather than assuming this value is
IRQ_BOARD_START.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
I don't have the ability to do anything but compile test this.  Please
check that it's correct.  Also, I believe that the check for ASIC3_NUM_GPIOS
is unnecessary - gpiolib won't call your driver if you don't own the GPIO.

 drivers/mfd/asic3.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 1895cf9..1582c3d 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -527,7 +527,9 @@ static void asic3_gpio_set(struct gpio_chip *chip,
 
 static int asic3_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return (offset < ASIC3_NUM_GPIOS) ? IRQ_BOARD_START + offset : -ENXIO;
+	struct asic3 *asic = container_of(chip, struct asic3, gpio);
+
+	return (offset < ASIC3_NUM_GPIOS) ? asic->irq_base + offset : -ENXIO;
 }
 
 static __init int asic3_gpio_probe(struct platform_device *pdev,
