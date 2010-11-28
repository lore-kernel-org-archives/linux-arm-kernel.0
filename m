From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Sun, 28 Nov 2010 20:30:25 +0200
Subject: [PATCH 07/10] ARM S3C2443: Implement GPIO pull-up/down configuration
	methods
In-Reply-To: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
Message-ID: <1290969027-10178-7-git-send-email-jekhor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>

S3C2443 has two-bits pull-up/pull-down configuration fields in GPIO
registers, but values are differ from other SoCs with two-bits
configuration. gpio-cfg-helpers.h already has prototypes for
s3c2443-style pull-up/down methods, so implement them.

Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
---
 arch/arm/mach-s3c2443/Kconfig                      |    1 +
 arch/arm/mach-s3c2443/s3c2443.c                    |    7 +++
 arch/arm/plat-samsung/Kconfig                      |    6 +++
 arch/arm/plat-samsung/gpio-config.c                |   42 ++++++++++++++++++++
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |    2 +-
 5 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
index 8814031..d8eb868 100644
--- a/arch/arm/mach-s3c2443/Kconfig
+++ b/arch/arm/mach-s3c2443/Kconfig
@@ -10,6 +10,7 @@ config CPU_S3C2443
 	select CPU_LLSERIAL_S3C2440
 	select SAMSUNG_CLKSRC
 	select S3C2443_CLOCK
+	select S3C_GPIO_PULL_S3C2443
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-s3c2443/s3c2443.c
index 33d18dd..e6a28ba 100644
--- a/arch/arm/mach-s3c2443/s3c2443.c
+++ b/arch/arm/mach-s3c2443/s3c2443.c
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/timer.h>
 #include <linux/init.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/sysdev.h>
@@ -32,6 +33,9 @@
 #include <mach/regs-s3c2443-clock.h>
 #include <mach/reset.h>
 
+#include <plat/gpio-core.h>
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-helpers.h>
 #include <plat/s3c2443.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -86,6 +90,9 @@ void __init s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 
 void __init s3c2443_map_io(void)
 {
+	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_s3c2443;
+	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_s3c2443;
+
 	iotable_init(s3c2443_iodesc, ARRAY_SIZE(s3c2443_iodesc));
 }
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index dcd6eff..4ecb155 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -95,6 +95,12 @@ config S3C_GPIO_PULL_UPDOWN
 	help
 	  Internal configuration to enable the correct GPIO pull helper
 
+config S3C_GPIO_PULL_S3C2443
+	bool
+	select S3C_GPIO_PULL_UPDOWN
+	help
+	  Internal configuration to enable the correct GPIO pull helper for S3C2443-style GPIO
+
 config S3C_GPIO_PULL_DOWN
 	bool
 	help
diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index b732b77..6eeb20b 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -278,6 +278,48 @@ s3c_gpio_pull_t s3c_gpio_getpull_updown(struct s3c_gpio_chip *chip,
 	pup &= 0x3;
 	return (__force s3c_gpio_pull_t)pup;
 }
+
+#ifdef CONFIG_S3C_GPIO_PULL_S3C2443
+int s3c_gpio_setpull_s3c2443(struct s3c_gpio_chip *chip,
+				unsigned int off, s3c_gpio_pull_t pull)
+{
+	switch (pull) {
+	case S3C_GPIO_PULL_NONE:
+		pull = 0x01;
+		break;
+	case S3C_GPIO_PULL_UP:
+		pull = 0x00;
+		break;
+	case S3C_GPIO_PULL_DOWN:
+		pull = 0x02;
+		break;
+	}
+	return s3c_gpio_setpull_updown(chip, off, pull);
+}
+
+s3c_gpio_pull_t s3c_gpio_getpull_s3c2443(struct s3c_gpio_chip *chip,
+					unsigned int off)
+{
+	s3c_gpio_pull_t pull;
+
+	pull = s3c_gpio_getpull_updown(chip, off);
+
+	switch (pull) {
+	case 0x00:
+		pull = S3C_GPIO_PULL_UP;
+		break;
+	case 0x01:
+	case 0x03:
+		pull = S3C_GPIO_PULL_NONE;
+		break;
+	case 0x02:
+		pull = S3C_GPIO_PULL_DOWN;
+		break;
+	}
+
+	return pull;
+}
+#endif
 #endif
 
 #ifdef CONFIG_S3C_GPIO_PULL_UP
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
index 8fd65d8..b3bd3e8 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
@@ -233,7 +233,7 @@ extern int s3c_gpio_setpull_s3c2443(struct s3c_gpio_chip *chip,
  * This helper function reads the state of the pull-{up,down} resistor for the
  * given GPIO in the same case as s3c_gpio_setpull_upown.
 */
-extern s3c_gpio_pull_t s3c_gpio_getpull_s3c24xx(struct s3c_gpio_chip *chip,
+extern s3c_gpio_pull_t s3c_gpio_getpull_s3c2443(struct s3c_gpio_chip *chip,
 						unsigned int off);
 
 #endif /* __PLAT_GPIO_CFG_HELPERS_H */
-- 
1.7.2.3
