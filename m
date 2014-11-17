From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 17 Nov 2014 11:45:22 +0900
Subject: [PATCH] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2
In-Reply-To: <cover.1416192055.git.horms+renesas@verge.net.au>
References: <cover.1416192055.git.horms+renesas@verge.net.au>
Message-ID: <b207422bb92f17f4f892a9b8737d44b37fece25b.1416192055.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On sh73a0/kzm9g-legacy, probing of the i2c masters fails with:

    i2c-sh_mobile i2c-sh_mobile.0: timing values out of range: L/H=0x208/0x1bf
    sh_mobile: probe of i2c-sh_mobile.0 failed with error -22

According to the datasheet, the transfer rate is derived from the HP
clock (which runs at 104 MHz) divided by two. Hence
i2c_sh_mobile_platform_data.clks_per_count should be set to two.

Now probing succeeds, and i2c works:

    i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz (L/H=0x104/0xe0)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index b7bd8e5..328657d 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -26,6 +26,7 @@
 #include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/i2c/i2c-sh_mobile.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
@@ -192,11 +193,18 @@ static struct resource i2c4_resources[] = {
 	},
 };
 
+static struct i2c_sh_mobile_platform_data i2c_platform_data = {
+	.clks_per_count	= 2,
+};
+
 static struct platform_device i2c0_device = {
 	.name		= "i2c-sh_mobile",
 	.id		= 0,
 	.resource	= i2c0_resources,
 	.num_resources	= ARRAY_SIZE(i2c0_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static struct platform_device i2c1_device = {
@@ -204,6 +212,9 @@ static struct platform_device i2c1_device = {
 	.id		= 1,
 	.resource	= i2c1_resources,
 	.num_resources	= ARRAY_SIZE(i2c1_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static struct platform_device i2c2_device = {
@@ -211,6 +222,9 @@ static struct platform_device i2c2_device = {
 	.id		= 2,
 	.resource	= i2c2_resources,
 	.num_resources	= ARRAY_SIZE(i2c2_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static struct platform_device i2c3_device = {
@@ -218,6 +232,9 @@ static struct platform_device i2c3_device = {
 	.id		= 3,
 	.resource	= i2c3_resources,
 	.num_resources	= ARRAY_SIZE(i2c3_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static struct platform_device i2c4_device = {
@@ -225,6 +242,9 @@ static struct platform_device i2c4_device = {
 	.id		= 4,
 	.resource	= i2c4_resources,
 	.num_resources	= ARRAY_SIZE(i2c4_resources),
+	.dev		= {
+		.platform_data	= &i2c_platform_data,
+	},
 };
 
 static const struct sh_dmae_slave_config sh73a0_dmae_slaves[] = {
-- 
2.1.1
