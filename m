From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:02 +0100
Subject: [RFC PATCH 08/18] ARM: msm: fix gpiomux config for multiplatform
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm gpiomux code uses a global symbol for configuration
that has multiple definitions, and a size that depends on
the SoC that is configured. Both of these are broken
when dealing with a kernel that enables more than one soc,
so we have to pass the data at boot time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/board-msm7x30.c |  4 +++-
 arch/arm/mach-msm/board-qsd8x50.c |  3 +++
 arch/arm/mach-msm/gpiomux-8x50.c  |  2 +-
 arch/arm/mach-msm/gpiomux-v1.h    |  9 ++-------
 arch/arm/mach-msm/gpiomux.c       | 18 +++++++++---------
 arch/arm/mach-msm/gpiomux.h       |  8 +++++++-
 drivers/gpio/gpio-msm-v1.c        | 16 +++++++++++-----
 7 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index e19109f69096..a964e3e3724d 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -99,7 +99,7 @@ static struct msm_otg_platform_data msm_otg_pdata = {
 	.phy_clk_reset		= hsusb_phy_clk_reset,
 };
 
-struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
+static struct msm_gpiomux_config msm7x30_gpiomux_configs[MSM7X30_GPIOMUX_NGPIOS] = {
 #ifdef CONFIG_SERIAL_MSM_CONSOLE
 	[49] = { /* UART2 RFR */
 		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
@@ -139,6 +139,8 @@ static void __init msm7x30_init_irq(void)
 
 static void __init msm7x30_init(void)
 {
+	gpiomux_init(msm7x30_gpiomux_configs,
+		     ARRAY_SIZE(msm7x30_gpiomux_configs));
 	msm_device_otg.dev.platform_data = &msm_otg_pdata;
 	msm_device_hsusb.dev.parent = &msm_device_otg.dev;
 	msm_device_hsusb_host.dev.parent = &msm_device_otg.dev;
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 24f4ae061f79..259ea05c41b9 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -36,6 +36,7 @@
 
 #include "devices.h"
 #include "common.h"
+#include "gpiomux.h"
 
 static const resource_size_t qsd8x50_surf_smc91x_base __initconst = 0x70000300;
 static const unsigned        qsd8x50_surf_smc91x_gpio __initconst = 156;
@@ -228,6 +229,8 @@ static void __init qsd8x50_init_irq(void)
 
 static void __init qsd8x50_init(void)
 {
+	gpiomux_init(qsd8x50_gpiomux_configs,
+		     ARRAY_SIZE(qsd8x50_gpiomux_configs));
 	msm_device_otg.dev.platform_data = &msm_otg_pdata;
 	msm_device_hsusb.dev.parent = &msm_device_otg.dev;
 	msm_device_hsusb_host.dev.parent = &msm_device_otg.dev;
diff --git a/arch/arm/mach-msm/gpiomux-8x50.c b/arch/arm/mach-msm/gpiomux-8x50.c
index f7a4ea593c95..6851342ec049 100644
--- a/arch/arm/mach-msm/gpiomux-8x50.c
+++ b/arch/arm/mach-msm/gpiomux-8x50.c
@@ -29,7 +29,7 @@
 #define SDC1_SUSPEND_CONFIG (GPIOMUX_VALID | GPIOMUX_PULL_DOWN\
 				| GPIOMUX_FUNC_GPIO | GPIOMUX_DRV_2MA)
 
-struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
+struct msm_gpiomux_config qsd8x50_gpiomux_configs[QSD8X50_GPIOMUX_NGPIOS] = {
 	[86] = { /* UART3 RX */
 		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
 			     GPIOMUX_FUNC_1 | GPIOMUX_VALID,
diff --git a/arch/arm/mach-msm/gpiomux-v1.h b/arch/arm/mach-msm/gpiomux-v1.h
index 71d86feba450..733c11aa7707 100644
--- a/arch/arm/mach-msm/gpiomux-v1.h
+++ b/arch/arm/mach-msm/gpiomux-v1.h
@@ -17,13 +17,8 @@
 #ifndef __ARCH_ARM_MACH_MSM_GPIOMUX_V1_H
 #define __ARCH_ARM_MACH_MSM_GPIOMUX_V1_H
 
-#if defined(CONFIG_ARCH_MSM7X30)
-#define GPIOMUX_NGPIOS 182
-#elif defined(CONFIG_ARCH_QSD8X50)
-#define GPIOMUX_NGPIOS 165
-#else
-#define GPIOMUX_NGPIOS 133
-#endif
+#define MSM7X30_GPIOMUX_NGPIOS 182
+#define QSD8X50_GPIOMUX_NGPIOS 165
 
 typedef u32 gpiomux_config_t;
 
diff --git a/arch/arm/mach-msm/gpiomux.c b/arch/arm/mach-msm/gpiomux.c
index 2b8e2d217082..768de1a05a56 100644
--- a/arch/arm/mach-msm/gpiomux.c
+++ b/arch/arm/mach-msm/gpiomux.c
@@ -20,6 +20,8 @@
 #include "proc_comm.h"
 
 static DEFINE_SPINLOCK(gpiomux_lock);
+static int gpiomux_ngpios;
+static struct msm_gpiomux_config *msm_gpiomux_configs;
 
 static void __msm_gpiomux_write(unsigned gpio, gpiomux_config_t val)
 {
@@ -43,7 +45,7 @@ int msm_gpiomux_write(unsigned gpio,
 	unsigned long irq_flags;
 	gpiomux_config_t setting;
 
-	if (gpio >= GPIOMUX_NGPIOS)
+	if (gpio >= gpiomux_ngpios)
 		return -EINVAL;
 
 	spin_lock_irqsave(&gpiomux_lock, irq_flags);
@@ -61,14 +63,13 @@ int msm_gpiomux_write(unsigned gpio,
 	spin_unlock_irqrestore(&gpiomux_lock, irq_flags);
 	return 0;
 }
-EXPORT_SYMBOL(msm_gpiomux_write);
 
 int msm_gpiomux_get(unsigned gpio)
 {
 	struct msm_gpiomux_config *cfg = msm_gpiomux_configs + gpio;
 	unsigned long irq_flags;
 
-	if (gpio >= GPIOMUX_NGPIOS)
+	if (gpio >= gpiomux_ngpios)
 		return -EINVAL;
 
 	spin_lock_irqsave(&gpiomux_lock, irq_flags);
@@ -77,14 +78,13 @@ int msm_gpiomux_get(unsigned gpio)
 	spin_unlock_irqrestore(&gpiomux_lock, irq_flags);
 	return 0;
 }
-EXPORT_SYMBOL(msm_gpiomux_get);
 
 int msm_gpiomux_put(unsigned gpio)
 {
 	struct msm_gpiomux_config *cfg = msm_gpiomux_configs + gpio;
 	unsigned long irq_flags;
 
-	if (gpio >= GPIOMUX_NGPIOS)
+	if (gpio >= gpiomux_ngpios)
 		return -EINVAL;
 
 	spin_lock_irqsave(&gpiomux_lock, irq_flags);
@@ -94,13 +94,14 @@ int msm_gpiomux_put(unsigned gpio)
 	spin_unlock_irqrestore(&gpiomux_lock, irq_flags);
 	return 0;
 }
-EXPORT_SYMBOL(msm_gpiomux_put);
 
-static int __init gpiomux_init(void)
+int __init gpiomux_init(struct msm_gpiomux_config *config, unsigned int ngpios)
 {
 	unsigned n;
+	msm_gpiomux_configs = config;
+	gpiomux_ngpios = ngpios;
 
-	for (n = 0; n < GPIOMUX_NGPIOS; ++n) {
+	for (n = 0; n < gpiomux_ngpios; ++n) {
 		msm_gpiomux_configs[n].ref = 0;
 		if (!(msm_gpiomux_configs[n].suspended & GPIOMUX_VALID))
 			continue;
@@ -108,4 +109,3 @@ static int __init gpiomux_init(void)
 	}
 	return 0;
 }
-postcore_initcall(gpiomux_init);
diff --git a/arch/arm/mach-msm/gpiomux.h b/arch/arm/mach-msm/gpiomux.h
index 4410d7766f93..cdc1578d1e73 100644
--- a/arch/arm/mach-msm/gpiomux.h
+++ b/arch/arm/mach-msm/gpiomux.h
@@ -65,7 +65,7 @@ enum {
  * of that flag will prevent the configuration from being applied
  * during state transitions.
  */
-extern struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS];
+extern struct msm_gpiomux_config qsd8x50_gpiomux_configs[QSD8X50_GPIOMUX_NGPIOS];
 
 /* Install a new configuration to the gpio line.  To avoid overwriting
  * a configuration, leave the VALID bit out.
@@ -73,6 +73,8 @@ extern struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS];
 int msm_gpiomux_write(unsigned gpio,
 		      gpiomux_config_t active,
 		      gpiomux_config_t suspended);
+
+int gpiomux_init(struct msm_gpiomux_config *config, unsigned int ngpios);
 #else
 static inline int msm_gpiomux_write(unsigned gpio,
 				    gpiomux_config_t active,
@@ -80,5 +82,9 @@ static inline int msm_gpiomux_write(unsigned gpio,
 {
 	return -ENOSYS;
 }
+int gpiomux_init(struct msm_gpiomux_config *config, unsigned int ngpios)
+{
+	return 0;
+}
 #endif
 #endif
diff --git a/drivers/gpio/gpio-msm-v1.c b/drivers/gpio/gpio-msm-v1.c
index edf285e26667..589115c1faa2 100644
--- a/drivers/gpio/gpio-msm-v1.c
+++ b/drivers/gpio/gpio-msm-v1.c
@@ -328,8 +328,11 @@ struct msm_gpio_chip {
 struct msm_gpio_initdata {
 	struct msm_gpio_chip *chips;
 	int count;
+	bool mux;
 };
 
+static bool msm_gpio_mux;
+
 static void msm_gpio_writel(struct msm_gpio_chip *chip, u32 val,
 			    enum msm_gpio_reg reg)
 {
@@ -446,20 +449,19 @@ static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return MSM_GPIO_TO_INT(chip->base + offset);
 }
 
-#ifdef CONFIG_MSM_GPIOMUX
 static int msm_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
+	if (!IS_ENABLED(CONFIG_MSM_GPIOMUX) || !msm_gpio_mux)
+		return 0;
 	return msm_gpiomux_get(chip->base + offset);
 }
 
 static void msm_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
+	if (!IS_ENABLED(CONFIG_MSM_GPIOMUX) || !msm_gpio_mux)
+		return;
 	msm_gpiomux_put(chip->base + offset);
 }
-#else
-#define msm_gpio_request NULL
-#define msm_gpio_free NULL
-#endif
 
 static struct msm_gpio_chip *msm_gpio_chips;
 static int msm_gpio_count;
@@ -476,6 +478,7 @@ static struct msm_gpio_chip msm_gpio_chips_msm7x01[] = {
 static struct msm_gpio_initdata msm_gpio_7x01_init = {
 	.chips = msm_gpio_chips_msm7x01,
 	.count = ARRAY_SIZE(msm_gpio_chips_msm7x01),
+	.mux = false,
 };
 
 static struct msm_gpio_chip msm_gpio_chips_msm7x30[] = {
@@ -492,6 +495,7 @@ static struct msm_gpio_chip msm_gpio_chips_msm7x30[] = {
 static struct msm_gpio_initdata msm_gpio_7x30_init = {
 	.chips = msm_gpio_chips_msm7x30,
 	.count = ARRAY_SIZE(msm_gpio_chips_msm7x30),
+	.mux = true,
 };
 
 static struct msm_gpio_chip msm_gpio_chips_qsd8x50[] = {
@@ -508,6 +512,7 @@ static struct msm_gpio_chip msm_gpio_chips_qsd8x50[] = {
 static struct msm_gpio_initdata msm_gpio_8x50_init = {
 	.chips = msm_gpio_chips_qsd8x50,
 	.count = ARRAY_SIZE(msm_gpio_chips_qsd8x50),
+	.mux = true,
 };
 
 static void msm_gpio_irq_ack(struct irq_data *d)
@@ -643,6 +648,7 @@ static int gpio_msm_v1_probe(struct platform_device *pdev)
 	data = (struct msm_gpio_initdata *)dev_id->driver_data;
 	msm_gpio_chips = data->chips;
 	msm_gpio_count = data->count;
+	msm_gpio_mux = data->mux;
 
 	irq1 = platform_get_irq(pdev, 0);
 	if (irq1 < 0)
-- 
2.1.0.rc2
