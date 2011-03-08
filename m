From: andy@warmcat.com (Andy Green)
Date: Tue, 08 Mar 2011 11:08:20 +0000
Subject: [PATCH 2 08/18] I2C: OMAP2+: use platform_data ip revision to select
	register map
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Message-ID: <20110308110819.23531.59280.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the register map names to reflect the IP revision they
are representing, and use the platform_data IP revision index
to select between them at init time.

Eliminates 1 of 17 cpu_...() calls in the driver.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2826c13..eee0bb8 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -205,7 +205,7 @@ struct omap_i2c_dev {
 	u16			errata;
 };
 
-const static u8 reg_map[] = {
+const static u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_REV_REG] = 0x00,
 	[OMAP_I2C_IE_REG] = 0x01,
 	[OMAP_I2C_STAT_REG] = 0x02,
@@ -226,7 +226,7 @@ const static u8 reg_map[] = {
 	[OMAP_I2C_BUFSTAT_REG] = 0x10,
 };
 
-const static u8 omap4_reg_map[] = {
+const static u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_REV_REG] = 0x04,
 	[OMAP_I2C_IE_REG] = 0x2c,
 	[OMAP_I2C_STAT_REG] = 0x28,
@@ -1037,10 +1037,10 @@ omap_i2c_probe(struct platform_device *pdev)
 	else
 		dev->reg_shift = 2;
 
-	if (cpu_is_omap44xx())
-		dev->regs = (u8 *) omap4_reg_map;
+	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
+		dev->regs = (u8 *)reg_map_ip_v2;
 	else
-		dev->regs = (u8 *) reg_map;
+		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(&pdev->dev);
 	omap_i2c_unidle(dev);
