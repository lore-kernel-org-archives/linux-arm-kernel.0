From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:17 +0900
Subject: [PATCH 17/17] ARM: SMDKC210: Enable I2S device
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562017-20132-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Enable I2S_0 device on the SMDK.
Also, add the dependency I2C_1 device.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv310/mach-smdkc210.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index c90d136..306b252 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 #include <linux/io.h>
+#include <linux/i2c.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -23,6 +24,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
+#include <plat/iic.h>
 
 #include <mach/map.h>
 #include <mach/regs-srom.h>
@@ -139,7 +141,12 @@ static struct platform_device smdkc210_smsc911x = {
 	},
 };
 
+static struct i2c_board_info i2c_devs1[] __initdata = {
+	{I2C_BOARD_INFO("wm8994", 0x1a),},
+};
+
 static struct platform_device *smdkc210_devices[] __initdata = {
+	&s3c_device_i2c1,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
@@ -149,6 +156,7 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&smdkc210_smsc911x,
 	&samsung_asoc_dma,
 	&s5pv310_device_ac97,
+	&s5pv310_device_i2s0,
 };
 
 static void __init smdkc210_smsc911x_init(void)
@@ -184,6 +192,9 @@ static void __init smdkc210_map_io(void)
 
 static void __init smdkc210_machine_init(void)
 {
+	s3c_i2c1_set_platdata(NULL);
+	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
+
 	smdkc210_smsc911x_init();
 
 	s3c_sdhci0_set_platdata(&smdkc210_hsmmc0_pdata);
-- 
1.6.2.5
