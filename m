From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:04 +0900
Subject: [PATCH 02/17] ARM: SMDK6442: Enable I2C0 device on board
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562004-19652-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/mach-smdk6442.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
index 819fd80..e69f137 100644
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ b/arch/arm/mach-s5p6442/mach-smdk6442.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/serial_core.h>
+#include <linux/i2c.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -25,6 +26,7 @@
 #include <plat/s5p6442.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/iic.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDK6442_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -65,10 +67,15 @@ static struct s3c2410_uartcfg smdk6442_uartcfgs[] __initdata = {
 };
 
 static struct platform_device *smdk6442_devices[] __initdata = {
+	&s3c_device_i2c0,
 	&s5p6442_device_iis0,
 	&s3c_device_wdt,
 };
 
+static struct i2c_board_info smdk6442_i2c_devs0[] __initdata = {
+	{ I2C_BOARD_INFO("wm8580", 0x1b), },
+};
+
 static void __init smdk6442_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -78,6 +85,9 @@ static void __init smdk6442_map_io(void)
 
 static void __init smdk6442_machine_init(void)
 {
+	s3c_i2c0_set_platdata(NULL);
+	i2c_register_board_info(0, smdk6442_i2c_devs0,
+			ARRAY_SIZE(smdk6442_i2c_devs0));
 	platform_add_devices(smdk6442_devices, ARRAY_SIZE(smdk6442_devices));
 }
 
-- 
1.6.2.5
