From: andy@warmcat.com (Andy Green)
Date: Tue, 08 Mar 2011 11:08:27 +0000
Subject: [PATCH 2 09/18] I2C: OMAP2+: Solve array bounds overflow error on i2c
	idle
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Message-ID: <20110308110827.23531.55834.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---

 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index eee0bb8..14f5b50 100644
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
