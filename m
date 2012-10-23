From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 Oct 2012 10:17:05 +0200
Subject: [PATCH] gpio: mvebu: correctly set the value in direction_output()
Message-ID: <1350980225-6546-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->direction_output() operation of gpio_chip is supposed to set the
direction to output but also to set the GPIO to an initial
value. Unfortunately, this last part was not done until now, causing
for example the LEDs to not be properly set to their default initial
value. This patch fixes this by calling the mvebu_gpio_set() function
from mvebu_gpio_direction_output() before configuring the GPIO as an
output GPIO.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

---
As this is a fix, it should most likely go into 3.7.
---
 drivers/gpio/gpio-mvebu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 7a87412..eb42ab1 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -244,6 +244,8 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned pin,
 	if (ret)
 		return ret;
 
+	mvebu_gpio_set(chip, pin, value);
+
 	spin_lock_irqsave(&mvchip->lock, flags);
 	u = readl_relaxed(mvebu_gpioreg_io_conf(mvchip));
 	u &= ~(1 << pin);
-- 
1.7.9.5
