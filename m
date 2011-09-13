From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Sep 2011 11:17:15 +0100
Subject: Fwd: [PATCH] Fix build errors with gpio-generic.c
Message-ID: <20110913101715.GA8141@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.  Any chance of getting this in before 3.1 ?

----- Forwarded message from Russell King - ARM Linux <linux@arm.linux.org.uk> -----
Date: Mon, 15 Aug 2011 20:25:31 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel at lists.infradead.org, linux-kernel at vger.kernel.org
Subject: [PATCH] Fix build errors with gpio-generic.c

From: Russell King <rmk+kernel@arm.linux.org.uk>
GPIO: Fix build errors with gpio-generic.c

Building a kernel with hotplug disabled results in a link failure:

`bgpio_remove' referenced in section `___ksymtab_gpl+bgpio_remove' of drivers/built-in.o: defined in discarded section `.devexit.text' of drivers/built-in.o

This is caused because of the bgpio_remove is exported.  It is illegal
to export symbols which are discarded either at link time or as part of
an init/exit section.

Fix this by dropping the __devexit attributation from bgpio_remove().
Also drop the __devinit attributation from bgpio_init().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpio/gpio-generic.c     |   15 +++++----------
 include/linux/basic_mmio_gpio.h |   15 +++++----------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
index 231714d..4e24436 100644
--- a/drivers/gpio/gpio-generic.c
+++ b/drivers/gpio/gpio-generic.c
@@ -351,7 +351,7 @@ static int bgpio_setup_direction(struct bgpio_chip *bgc,
 	return 0;
 }
 
-int __devexit bgpio_remove(struct bgpio_chip *bgc)
+int bgpio_remove(struct bgpio_chip *bgc)
 {
 	int err = gpiochip_remove(&bgc->gc);
 
@@ -361,15 +361,10 @@ int __devexit bgpio_remove(struct bgpio_chip *bgc)
 }
 EXPORT_SYMBOL_GPL(bgpio_remove);
 
-int __devinit bgpio_init(struct bgpio_chip *bgc,
-			 struct device *dev,
-			 unsigned long sz,
-			 void __iomem *dat,
-			 void __iomem *set,
-			 void __iomem *clr,
-			 void __iomem *dirout,
-			 void __iomem *dirin,
-			 bool big_endian)
+int bgpio_init(struct bgpio_chip *bgc, struct device *dev,
+	       unsigned long sz, void __iomem *dat, void __iomem *set,
+	       void __iomem *clr, void __iomem *dirout, void __iomem *dirin,
+	       bool big_endian)
 {
 	int ret;
 
diff --git a/include/linux/basic_mmio_gpio.h b/include/linux/basic_mmio_gpio.h
index 98999cf..feb91219 100644
--- a/include/linux/basic_mmio_gpio.h
+++ b/include/linux/basic_mmio_gpio.h
@@ -63,15 +63,10 @@ static inline struct bgpio_chip *to_bgpio_chip(struct gpio_chip *gc)
 	return container_of(gc, struct bgpio_chip, gc);
 }
 
-int __devexit bgpio_remove(struct bgpio_chip *bgc);
-int __devinit bgpio_init(struct bgpio_chip *bgc,
-			 struct device *dev,
-			 unsigned long sz,
-			 void __iomem *dat,
-			 void __iomem *set,
-			 void __iomem *clr,
-			 void __iomem *dirout,
-			 void __iomem *dirin,
-			 bool big_endian);
+int bgpio_remove(struct bgpio_chip *bgc);
+int bgpio_init(struct bgpio_chip *bgc, struct device *dev,
+	       unsigned long sz, void __iomem *dat, void __iomem *set,
+	       void __iomem *clr, void __iomem *dirout, void __iomem *dirin,
+	       bool big_endian);
 
 #endif /* __BASIC_MMIO_GPIO_H */


----- End forwarded message -----
