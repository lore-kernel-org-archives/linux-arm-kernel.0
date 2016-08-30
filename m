From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2016 10:18:06 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <87eg57e54l.fsf@belgarion.home>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
Message-ID: <20160830091805.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 09:39:54PM +0200, Robert Jarzmik wrote:
> Maybe this one would deserve a doxygen comment ?

Does this solve it?

diff --git a/drivers/gpio/gpio-reg.c b/drivers/gpio/gpio-reg.c
index fc7e0a395f9f..b91488ec122c 100644
--- a/drivers/gpio/gpio-reg.c
+++ b/drivers/gpio/gpio-reg.c
@@ -1,3 +1,12 @@
+/*
+ * gpio-reg: single register individually fixed-direction GPIOs
+ *
+ * Copyright (C) 2016 Russell King
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ */
 #include <linux/gpio/driver.h>
 #include <linux/gpio-reg.h>
 #include <linux/io.h>
@@ -87,6 +96,22 @@ static void gpio_reg_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	spin_unlock_irqrestore(&r->lock, flags);
 }
 
+/**
+ * gpio_reg_init - add a fixed in/out register as gpio
+ * @dev: optional struct device associated with this register
+ * @base: start gpio number, or -1 to allocate
+ * @num: number of GPIOs, maximum 32
+ * @label: GPIO chip label
+ * @direction: bitmask of fixed direction, one per GPIO signal, 1 = in
+ * @def_out: initial GPIO output value
+ * @names: array of %num strings describing each GPIO signal
+ *
+ * Add a single-register GPIO device containing up to 32 GPIO signals,
+ * where each GPIO has a fixed input or output configuration.  Only
+ * input GPIOs are assumed to be readable from the register, and only
+ * then after a double-read.  Output values are assumed not to be
+ * readable.
+ */
 struct gpio_chip *gpio_reg_init(struct device *dev, void __iomem *reg,
 	int base, int num, const char *label, u32 direction, u32 def_out,
 	const char *const *names)


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
