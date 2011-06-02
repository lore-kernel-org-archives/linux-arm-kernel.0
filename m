From: khilman@ti.com (Kevin Hilman)
Date: Wed,  1 Jun 2011 17:19:35 -0700
Subject: [PATCH v4 09/18] I2C: OMAP2+: Solve array bounds overflow error on
	i2c idle
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Message-ID: <1306973984-15165-10-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Green <andy@warmcat.com>

This solves the main problem the patch series is about.  Prior
to this patch on OMAP3530 the driver wrongly interprets the I2C
peripheral unit's own reported revision as meaning it is running
on an IP V2 device and must use the extended registers.

In fact OMAP3530 is IP V1 with the smaller register set, the
reason for the confusion is that the hardware does in fact report
having the same IP revision index as is found on an OMAP4430,
which really is IP V2 and has the extended registers.

This corrects the test for which registers to use so that it
decides using hwmod knowledge found in the platform_data.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fbd4ec4..f7196f3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -309,7 +309,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	pdata = pdev->dev.platform_data;
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	if (dev->rev >= OMAP_I2C_REV_ON_4430)
+	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
 		omap_i2c_write_reg(dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
-- 
1.7.4
