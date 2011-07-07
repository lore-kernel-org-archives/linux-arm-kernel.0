From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  7 Jul 2011 14:50:16 +0200
Subject: [PATCH] plat-mxc: add missing initialisation of basic_mmio_gpio
	shadow variables
Message-ID: <1310043016-1121-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bgpio_init() function does not initialise the shadow register for
the GPIO direction register. Thus, when configuring the first GPIO with
gpio_set_direction() all other GPIOs of the same bank will be
configured as inputs. Since the bgpio layer cannot know whether the
register is readable, the initialisation should be done by the caller
of bgpio_init().

Also, the 'data' shadow variable that is used inside basic_mmio_gpio
to cache the current value of the GPIO_DR register is initialised from
the GPIO_PSR register within bgpio_init(). Thus when setting the
output value of a certain GPIO, the other GPIO outputs of the same
bank will be set or cleared depending on the pin state of the GPIO
inputs during bgpio_init().


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/gpio/gpio-mxc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index b351952..f7944ca 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -337,6 +337,8 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 		goto out_iounmap;
 
 	port->bgc.gc.base = pdev->id * 32;
+	port->bgc.dir = port->bgc.read_reg(port->bgc.reg_dir);
+	port->bgc.data = port->bgc.read_reg(port->bgc.reg_set);
 
 	err = gpiochip_add(&port->bgc.gc);
 	if (err)
-- 
1.5.6.5
