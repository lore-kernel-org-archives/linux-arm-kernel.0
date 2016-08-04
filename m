From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 04 Aug 2016 15:38:42 +0200
Subject: [PATCH 2/8] ARM: S3C24XX: Specify audio codec platform_data for
 mini2440 board
In-Reply-To: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
References: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1470317928-25365-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L3 bus GPIOs are specified in the board file rather than through
the sound card's device platform_data. This allows to ensure the codec
driver doesn't get probed with uninitialized platform_data field of
its corresponding platform device.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index a852168..13999c1 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -497,9 +497,28 @@ static struct i2c_board_info mini2440_i2c_devs[] __initdata = {
 	},
 };
 
+static struct uda134x_platform_data s3c24xx_uda134x = {
+	.l3 = {
+		.gpio_clk = S3C2410_GPB(4),
+		.gpio_data = S3C2410_GPB(3),
+		.gpio_mode = S3C2410_GPB(2),
+		.use_gpios = 1,
+		.data_hold = 1,
+		.data_setup = 1,
+		.clock_high = 1,
+		.mode_hold = 1,
+		.mode = 1,
+		.mode_setup = 1,
+	},
+	.model = UDA134X_UDA1341,
+};
+
 static struct platform_device uda1340_codec = {
 		.name = "uda134x-codec",
 		.id = -1,
+		.dev = {
+			.platform_data	= &s3c24xx_uda134x,
+		},
 };
 
 static struct platform_device *mini2440_devices[] __initdata = {
-- 
1.9.1
