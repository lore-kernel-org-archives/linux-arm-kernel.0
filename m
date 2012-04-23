From: shubhrajyoti@ti.com (Datta, Shubhrajyoti)
Date: Mon, 23 Apr 2012 21:27:00 +0530
Subject: [PATCHv8 02/10] I2C: OMAP: Fix the mismatch of pm_runtime enable
 and disable
In-Reply-To: <20120423154345.GA27321@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-3-git-send-email-shubhrajyoti@ti.com>
 <20120423154345.GA27321@pengutronix.de>
Message-ID: <CANQgH-YfhZWEi0nMVAJmgwGzYsNWmQr4HOwn7g4cZ1Ca405-1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review,

On Mon, Apr 23, 2012 at 9:13 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Apr 19, 2012 at 06:58:13PM +0530, Shubhrajyoti D wrote:
>> Currently the i2c driver calls the pm_runtime_enable and never
>> the disable. This may cause a warning when pm_runtime_enable
>> checks for the count match.Attempting to fix the same by calling
>> pm_runtime_disable in the error and the remove path.
>
> Why "attempting"?
yes will correct it. The updated patch below.

>From 1f6d8671d15b16de8840f0ff23d77d613a03e876 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Fri, 16 Dec 2011 19:43:16 +0530
Subject: [PATCHv8 02/10] I2C: OMAP: Fix the mismatch of pm_runtime enable and
 disable

Currently the i2c driver calls the pm_runtime_enable and never
the disable. This may cause a warning when pm_runtime_enable
checks for the count match. Fix the same by calling  pm_runtime_disable
in the error and the remove path.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4f4188d..c851672 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1090,6 +1090,7 @@ err_unuse_clocks:
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	pm_runtime_put(dev->dev);
 	iounmap(dev->base);
+	pm_runtime_disable(&pdev->dev);
 err_free_mem:
 	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
@@ -1110,6 +1111,7 @@ omap_i2c_remove(struct platform_device *pdev)
 	free_irq(dev->irq, dev);
 	i2c_del_adapter(&dev->adapter);
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	pm_runtime_disable(&pdev->dev);
 	iounmap(dev->base);
 	kfree(dev);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.5.4
