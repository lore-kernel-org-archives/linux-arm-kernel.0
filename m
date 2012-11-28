From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Nov 2012 23:16:57 +0100
Subject: [PATCH 2/2] ARM: integrator: pass the lm resource to amba
Message-ID: <1354141017-22987-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This passes the lm resource to register the AMBA devices on the
LM as contained within the LM resource.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/impd1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index b3d86d7..9f82f9d 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -342,9 +342,10 @@ static int impd1_probe(struct lm_device *dev)
 
 		pc_base = dev->resource.start + idev->offset;
 		snprintf(devname, 32, "lm%x:%5.5lx", dev->id, idev->offset >> 12);
-		d = amba_ahb_device_add(&dev->dev, devname, pc_base, SZ_4K,
-					dev->irq, dev->irq,
-					idev->platform_data, idev->id);
+		d = amba_ahb_device_add_res(&dev->dev, devname, pc_base, SZ_4K,
+					    dev->irq, dev->irq,
+					    idev->platform_data, idev->id,
+					    &dev->resource);
 		if (IS_ERR(d)) {
 			dev_err(&dev->dev, "unable to register device: %ld\n", PTR_ERR(d));
 			continue;
-- 
1.7.11.7
