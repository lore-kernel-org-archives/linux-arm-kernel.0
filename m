From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 20 Mar 2010 20:20:08 +0200
Subject: [PATCH 3/4] s3c244x: configure GPG13-15 as input before suspend
In-Reply-To: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
References: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1269109209-26237-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to datasheet GPG13-15 must be configured as input in NAND
boot mode, otherwise device will not be able to wake up.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/s3c244x.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
index 5e4a97e..b100e92 100644
--- a/arch/arm/mach-s3c2440/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -21,6 +21,7 @@
 #include <linux/sysdev.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -146,6 +147,17 @@ static struct sleep_save s3c244x_sleep[] = {
 static int s3c244x_suspend(struct sys_device *dev, pm_message_t state)
 {
 	s3c_pm_do_save(s3c244x_sleep, ARRAY_SIZE(s3c244x_sleep));
+#ifdef CONFIG_S3C_DEV_NAND
+	/* According to S3C2442 user's manual, page 7-17,
+	 * when the system is operating in NAND boot mode,
+	 * the hardware pin configuration - EINT[23:21] ???
+	 * must be set as input for starting up after
+	 * wakeup from sleep mode
+	 */
+	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPIO_INPUT);
+	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPIO_INPUT);
+	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPIO_INPUT);
+#endif
 	return 0;
 }
 
-- 
1.7.0.2
