From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jan 2012 21:31:45 +0000
Subject: [PATCH 3/4] ARM: S3C6410: Use device names for both I2C clocks
In-Reply-To: <1327440706-31915-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120124213127.GH1135@opensource.wolfsonmicro.com>
 <1327440706-31915-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1327440706-31915-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the S3C64xx CPUs were converted to clkdev mappings were added for the
I2C controllers on them. On S3C6410 a device name is specified for I2C
controller 1 but not for controller 0 which makes the code less robust as
we'll falsely return the clock for controller 0 if there's an error in the
request for controller 1.

Improve things by registering a device name for controller 0 as well. Due
to the fact that we change the numbering for controller 0 depending on if
we've registered controller 1 this requires an ifdef to choose the name.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/clock.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 63f2c8a..52f079a 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -138,6 +138,11 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= S3C_CLKCON_PCLK_TSADC,
 	}, {
 		.name		= "i2c",
+#ifdef CONFIG_S3C_DEV_I2C1
+		.devname        = "s3c2440-i2c.0",
+#else
+		.devname	= "s3c2440-i2c",
+#endif
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIC,
-- 
1.7.9.rc1
