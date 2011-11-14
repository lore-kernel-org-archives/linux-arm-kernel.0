From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2011 00:22:55 +0530
Subject: [PATCH] ARM: restart: davinci: use new restart hook
Message-ID: <1321296775-5110-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than using davinci specifci davinci_soc_info based
restart hook, use the existing arm_pm_restart pointer
instead.

This should finally graduate to using the restart
hook provided in machine descriptor, but that needs
more local header files in davinci.

Tested on DM365 and AM18x EVMs.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Applies to reset branch of rmk's tree.

 arch/arm/mach-davinci/common.c              |    3 ---
 arch/arm/mach-davinci/da830.c               |    1 -
 arch/arm/mach-davinci/da850.c               |    1 -
 arch/arm/mach-davinci/devices-da8xx.c       |    6 ++++++
 arch/arm/mach-davinci/devices.c             |    6 ++++++
 arch/arm/mach-davinci/dm355.c               |    1 -
 arch/arm/mach-davinci/dm365.c               |    1 -
 arch/arm/mach-davinci/dm644x.c              |    1 -
 arch/arm/mach-davinci/dm646x.c              |    1 -
 arch/arm/mach-davinci/include/mach/common.h |    2 --
 arch/arm/mach-davinci/include/mach/system.h |    2 --
 arch/arm/mach-davinci/tnetv107x.c           |    9 +++++++--
 12 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 865ffe5..cb9b2e4 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -97,9 +97,6 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 	local_flush_tlb_all();
 	flush_cache_all();
 
-	if (!davinci_soc_info.reset)
-		davinci_soc_info.reset = davinci_watchdog_reset;
-
 	/*
 	 * We want to check CPU revision early for cpu_is_xxxx() macros.
 	 * IO space mapping must be initialized before we can do that.
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index a6bf5dc..deee5c2 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1201,7 +1201,6 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
 	.serial_dev		= &da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
-	.reset_device		= &da8xx_wdt_device,
 };
 
 void __init da830_init(void)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index b047f87..0ed7fdb 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1121,7 +1121,6 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_ARM_RAM_BASE,
 	.sram_len		= SZ_8K,
-	.reset_device		= &da8xx_wdt_device,
 };
 
 void __init da850_init(void)
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 68def71..96b8bce 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -363,8 +363,14 @@ struct platform_device da8xx_wdt_device = {
 	.resource	= da8xx_watchdog_resources,
 };
 
+static void da8xx_restart(char mode, const char *cmd)
+{
+	davinci_watchdog_reset(&da8xx_wdt_device);
+}
+
 int __init da8xx_register_watchdog(void)
 {
+	arm_pm_restart = da8xx_restart;
 	return platform_device_register(&da8xx_wdt_device);
 }
 
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 806a2f0..433416a 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -291,8 +291,14 @@ struct platform_device davinci_wdt_device = {
 	.resource	= wdt_resources,
 };
 
+static void davinci_restart(char mode, const char *cmd)
+{
+	davinci_watchdog_reset(&davinci_wdt_device);
+}
+
 static void davinci_init_wdt(void)
 {
+	arm_pm_restart = davinci_restart;
 	platform_device_register(&davinci_wdt_device);
 }
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index fe520d4..19667cf 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -853,7 +853,6 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.serial_dev		= &dm355_serial_device,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
-	.reset_device		= &davinci_wdt_device,
 };
 
 void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 679e168..f15b435 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1083,7 +1083,6 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
-	.reset_device		= &davinci_wdt_device,
 };
 
 void __init dm365_init_asp(struct snd_platform_data *pdata)
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 3470983..0800f9c 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -767,7 +767,6 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
-	.reset_device		= &davinci_wdt_device,
 };
 
 void __init dm644x_init_asp(struct snd_platform_data *pdata)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 0b68ed5..f8e07dc 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -855,7 +855,6 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
-	.reset_device		= &davinci_wdt_device,
 };
 
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index a57cba2..2f9d06d 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -77,8 +77,6 @@ struct davinci_soc_info {
 	struct emac_platform_data	*emac_pdata;
 	dma_addr_t			sram_dma;
 	unsigned			sram_len;
-	struct platform_device		*reset_device;
-	void				(*reset)(struct platform_device *);
 };
 
 extern struct davinci_soc_info davinci_soc_info;
diff --git a/arch/arm/mach-davinci/include/mach/system.h b/arch/arm/mach-davinci/include/mach/system.h
index e65629c..6bd1dc0 100644
--- a/arch/arm/mach-davinci/include/mach/system.h
+++ b/arch/arm/mach-davinci/include/mach/system.h
@@ -20,8 +20,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (davinci_soc_info.reset)
-		davinci_soc_info.reset(davinci_soc_info.reset_device);
 }
 
 #endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index 409bb86..cffa147 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -730,6 +730,11 @@ static void tnetv107x_watchdog_reset(struct platform_device *pdev)
 	__raw_writel(1, &regs->kick);
 }
 
+static void tnetv107x_restart(char mode, const char *cmd)
+{
+	tnetv107x_watchdog_reset(&tnetv107x_wdt_device);
+}
+
 static struct davinci_soc_info tnetv107x_soc_info = {
 	.io_desc		= io_desc,
 	.io_desc_num		= ARRAY_SIZE(io_desc),
@@ -752,11 +757,11 @@ static struct davinci_soc_info tnetv107x_soc_info = {
 	.gpio_num		= TNETV107X_N_GPIO,
 	.timer_info		= &timer_info,
 	.serial_dev		= &tnetv107x_serial_device,
-	.reset			= tnetv107x_watchdog_reset,
-	.reset_device		= &tnetv107x_wdt_device,
 };
 
 void __init tnetv107x_init(void)
 {
 	davinci_common_init(&tnetv107x_soc_info);
+
+	arm_pm_restart = tnetv107x_restart;
 }
-- 
1.6.2.4
