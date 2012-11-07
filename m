From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 07 Nov 2012 14:00:13 +0100
Subject: [PATCH] ARM: EXYNOS: Make s3c_device_i2c0 always use id 0
Message-ID: <4039915.8GOx0SKq2B@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes compatibility definitions added long time ago when
clock ids were used instead of devnames that were needed for platforms
with only one i2c controller with id -1 (some s3c24xx's).

Because currently devname field is used for matching device instances to
clocks and if no devname is provided (as in clock-s3c2412.c and
common-s3c2443.c for i2c clock, both in arch/arm/mach-s3c24xx) the clock
is being matched only by name, so s3c_device_i2c0 can always have id 0.

This patch solves the issue with i2c0 broken on boards where its the
only i2c controller used, tested on Origen.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c | 4 ----
 arch/arm/plat-samsung/devs.c  | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 28041e8..0fd7417 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -138,11 +138,7 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= S3C_CLKCON_PCLK_TSADC,
 	}, {
 		.name		= "i2c",
-#ifdef CONFIG_S3C_DEV_I2C1
 		.devname        = "s3c2440-i2c.0",
-#else
-		.devname	= "s3c2440-i2c",
-#endif
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIC,
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 52dfa8f..bc50b20 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -486,11 +486,7 @@ static struct resource s3c_i2c0_resource[] = {
 
 struct platform_device s3c_device_i2c0 = {
 	.name		= "s3c2410-i2c",
-#ifdef CONFIG_S3C_DEV_I2C1
 	.id		= 0,
-#else
-	.id		= -1,
-#endif
 	.num_resources	= ARRAY_SIZE(s3c_i2c0_resource),
 	.resource	= s3c_i2c0_resource,
 };
-- 
1.8.0
