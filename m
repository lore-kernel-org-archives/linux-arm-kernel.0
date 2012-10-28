From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 28 Oct 2012 12:23:24 +0000
Subject: [PATCH] mvebu-gpio: Disable blinking when enabling a GPIO for output
Message-ID: <1351427004-32110-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The plat-orion GPIO driver would disable any pin blinking whenever
using a pin for output. Do the same here, as a blinking LED will
continue to blink regardless of what the GPIO pin level is.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
The power LED on the DNS-320/DNS-325 is left blinking by the bootloader,
the LED turning steady indicates it's booted. The blinking needs to be
disabled before setting the GPIO pin level has any effect.

Apart from the custom init code running too soon, I think everything is
working now.

I haven't tested this on any other boards, so not sure if it's sensible
beyond the kirkwood/orion world.

 drivers/gpio/gpio-mvebu.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index cf7afb9..be65c04 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -92,6 +92,11 @@ static inline void __iomem *mvebu_gpioreg_out(struct mvebu_gpio_chip *mvchip)
 	return mvchip->membase + GPIO_OUT_OFF;
 }
 
+static inline void __iomem *mvebu_gpioreg_blink(struct mvebu_gpio_chip *mvchip)
+{
+	return mvchip->membase + GPIO_BLINK_EN_OFF;
+}
+
 static inline void __iomem *mvebu_gpioreg_io_conf(struct mvebu_gpio_chip *mvchip)
 {
 	return mvchip->membase + GPIO_IO_CONF_OFF;
@@ -206,6 +211,23 @@ static int mvebu_gpio_get(struct gpio_chip *chip, unsigned pin)
 	return (u >> pin) & 1;
 }
 
+static void mvebu_gpio_blink(struct gpio_chip *chip, unsigned pin, int value)
+{
+	struct mvebu_gpio_chip *mvchip =
+		container_of(chip, struct mvebu_gpio_chip, chip);
+	unsigned long flags;
+	u32 u;
+
+	spin_lock_irqsave(&mvchip->lock, flags);
+	u = readl_relaxed(mvebu_gpioreg_blink(mvchip));
+	if (value)
+		u |= 1 << pin;
+	else
+		u &= ~(1 << pin);
+	writel_relaxed(u, mvebu_gpioreg_blink(mvchip));
+	spin_unlock_irqrestore(&mvchip->lock, flags);
+}
+
 static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned pin)
 {
 	struct mvebu_gpio_chip *mvchip =
@@ -244,6 +266,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned pin,
 	if (ret)
 		return ret;
 
+	mvebu_gpio_blink(chip, pin, 0);
 	mvebu_gpio_set(chip, pin, value);
 
 	spin_lock_irqsave(&mvchip->lock, flags);
-- 
1.7.10.4
