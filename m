From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  2 Apr 2012 03:22:01 +0200
Subject: [PATCH 3/4] ARM: integrator: factor out dynamic amba device allocator
Message-ID: <1333329721-31700-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the local amba device allocator with the core code from
the bus driver.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/impd1.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 3e538da..e428f3a 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -398,24 +398,16 @@ static int impd1_probe(struct lm_device *dev)
 		struct impd1_device *idev = impd1_devs + i;
 		struct amba_device *d;
 		unsigned long pc_base;
+		char devname[32];
 
 		pc_base = dev->resource.start + idev->offset;
-
-		d = amba_device_alloc(NULL, pc_base, SZ_4K);
-		if (!d)
+		snprintf(devname, 32, "lm%x:%5.5lx", dev->id, idev->offset >> 12);
+		d = amba_ahb_device_add(&dev->dev, devname, pc_base, SZ_4K,
+					dev->irq, dev->irq,
+					idev->platform_data, idev->id);
+		if (IS_ERR(d)) {
+			dev_err(&dev->dev, "unable to register device: %ld\n", PTR_ERR(d));
 			continue;
-
-		dev_set_name(&d->dev, "lm%x:%5.5lx", dev->id, idev->offset >> 12);
-		d->dev.parent	= &dev->dev;
-		d->irq[0]	= dev->irq;
-		d->irq[1]	= dev->irq;
-		d->periphid	= idev->id;
-		d->dev.platform_data = idev->platform_data;
-
-		ret = amba_device_add(d, &dev->resource);
-		if (ret) {
-			dev_err(&d->dev, "unable to register device: %d\n", ret);
-			amba_device_put(d);
 		}
 	}
 
-- 
1.7.7.6
