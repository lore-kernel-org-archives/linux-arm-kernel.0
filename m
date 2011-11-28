From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 29 Nov 2011 02:28:54 +0530
Subject: [PATCH v2] ARM: restart: davinci: use new restart hook
Message-ID: <1322513934-23069-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than using DaVinci specific davinci_soc_info based
restart hook, use the restart hook available in the machine
descriptor instead.

Tested on DM365 and AM18x EVMs.

v2:
Changed to use restart hook in machine descriptor
per Russell's comment.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-da830-evm.c        |    1 +
 arch/arm/mach-davinci/board-da850-evm.c        |    1 +
 arch/arm/mach-davinci/board-dm355-evm.c        |    1 +
 arch/arm/mach-davinci/board-dm355-leopard.c    |    1 +
 arch/arm/mach-davinci/board-dm365-evm.c        |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c       |    1 +
 arch/arm/mach-davinci/board-dm646x-evm.c       |    2 ++
 arch/arm/mach-davinci/board-mityomapl138.c     |    1 +
 arch/arm/mach-davinci/board-neuros-osd2.c      |    1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c    |    1 +
 arch/arm/mach-davinci/board-sffsdr.c           |    1 +
 arch/arm/mach-davinci/board-tnetv107x-evm.c    |    1 +
 arch/arm/mach-davinci/common.c                 |    3 ---
 arch/arm/mach-davinci/da830.c                  |    1 -
 arch/arm/mach-davinci/da850.c                  |    1 -
 arch/arm/mach-davinci/devices-da8xx.c          |    5 +++++
 arch/arm/mach-davinci/devices.c                |    5 +++++
 arch/arm/mach-davinci/dm355.c                  |    1 -
 arch/arm/mach-davinci/dm365.c                  |    1 -
 arch/arm/mach-davinci/dm644x.c                 |    1 -
 arch/arm/mach-davinci/dm646x.c                 |    1 -
 arch/arm/mach-davinci/include/mach/common.h    |    3 +--
 arch/arm/mach-davinci/include/mach/da8xx.h     |    1 +
 arch/arm/mach-davinci/include/mach/system.h    |    2 --
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    1 +
 arch/arm/mach-davinci/tnetv107x.c              |    7 +++++--
 26 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 11c3db9..dc1afe5 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -682,4 +682,5 @@ MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.timer		= &davinci_timer,
 	.init_machine	= da830_evm_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 1d7d249..7f09460 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1411,4 +1411,5 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.timer		= &davinci_timer,
 	.init_machine	= da850_evm_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 4e0e707..275341f 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -357,4 +357,5 @@ MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.timer	      = &davinci_timer,
 	.init_machine = dm355_evm_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index ff2d241..e99db28 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -276,4 +276,5 @@ MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.timer	      = &davinci_timer,
 	.init_machine = dm355_leopard_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 1918ae7..4eff499 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -618,5 +618,6 @@ MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.timer		= &davinci_timer,
 	.init_machine	= dm365_evm_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= davinci_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 0cf8abf..a64b49c 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -719,4 +719,5 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	.timer	      = &davinci_timer,
 	.init_machine = davinci_evm_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index e574d7f..9d66fd3 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -799,6 +799,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.timer        = &davinci_timer,
 	.init_machine = evm_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= davinci_restart,
 MACHINE_END
 
 MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
@@ -808,5 +809,6 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.timer        = &davinci_timer,
 	.init_machine = evm_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= davinci_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 3cfff55..672d820 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -573,4 +573,5 @@ MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.timer		= &davinci_timer,
 	.init_machine	= mityomapl138_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index e5f231a..6c4a164 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -278,4 +278,5 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	.timer		= &davinci_timer,
 	.init_machine = davinci_ntosd2_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index c6701e4..e7c0c7c 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -344,4 +344,5 @@ MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.timer		= &davinci_timer,
 	.init_machine	= omapl138_hawk_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= da8xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 5dd4da9..0b136a8 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -157,4 +157,5 @@ MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.timer	      = &davinci_timer,
 	.init_machine = davinci_sffsdr_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= davinci_restart,
 MACHINE_END
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index f69e40a..5f14e30 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -283,4 +283,5 @@ MACHINE_START(TNETV107X, "TNETV107X EVM")
 	.timer		= &davinci_timer,
 	.init_machine	= tnetv107x_evm_board_init,
 	.dma_zone_size	= SZ_128M,
+	.restart	= tnetv107x_restart,
 MACHINE_END
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
index 68def71..42dbf3d 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -363,6 +363,11 @@ struct platform_device da8xx_wdt_device = {
 	.resource	= da8xx_watchdog_resources,
 };
 
+void da8xx_restart(char mode, const char *cmd)
+{
+	davinci_watchdog_reset(&da8xx_wdt_device);
+}
+
 int __init da8xx_register_watchdog(void)
 {
 	return platform_device_register(&da8xx_wdt_device);
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 806a2f0..50c0156 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -291,6 +291,11 @@ struct platform_device davinci_wdt_device = {
 	.resource	= wdt_resources,
 };
 
+void davinci_restart(char mode, const char *cmd)
+{
+	davinci_watchdog_reset(&davinci_wdt_device);
+}
+
 static void davinci_init_wdt(void)
 {
 	platform_device_register(&davinci_wdt_device);
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
index a57cba2..5cd39a4 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -77,14 +77,13 @@ struct davinci_soc_info {
 	struct emac_platform_data	*emac_pdata;
 	dma_addr_t			sram_dma;
 	unsigned			sram_len;
-	struct platform_device		*reset_device;
-	void				(*reset)(struct platform_device *);
 };
 
 extern struct davinci_soc_info davinci_soc_info;
 
 extern void davinci_common_init(struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
+void davinci_restart(char mode, const char *cmd);
 
 /* standard place to map on-chip SRAMs; they *may* support DMA */
 #define SRAM_VIRT	0xfffe0000
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index eaca7d8..ee3461d 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -91,6 +91,7 @@ int da8xx_register_cpuidle(void);
 void __iomem * __init da8xx_get_mem_ctlr(void);
 int da850_register_pm(struct platform_device *pdev);
 int __init da850_register_sata(unsigned long refclkpn);
+void da8xx_restart(char mode, const char *cmd);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
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
diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
index 89c1fdc..83e5926 100644
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@ -54,6 +54,7 @@ extern struct platform_device tnetv107x_serial_device;
 extern void __init tnetv107x_init(void);
 extern void __init tnetv107x_devices_init(struct tnetv107x_device_info *);
 extern void __init tnetv107x_irq_init(void);
+void tnetv107x_restart(char mode, const char *cmd);
 
 #endif
 
diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index 409bb86..dc1a209 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -730,6 +730,11 @@ static void tnetv107x_watchdog_reset(struct platform_device *pdev)
 	__raw_writel(1, &regs->kick);
 }
 
+void tnetv107x_restart(char mode, const char *cmd)
+{
+	tnetv107x_watchdog_reset(&tnetv107x_wdt_device);
+}
+
 static struct davinci_soc_info tnetv107x_soc_info = {
 	.io_desc		= io_desc,
 	.io_desc_num		= ARRAY_SIZE(io_desc),
@@ -752,8 +757,6 @@ static struct davinci_soc_info tnetv107x_soc_info = {
 	.gpio_num		= TNETV107X_N_GPIO,
 	.timer_info		= &timer_info,
 	.serial_dev		= &tnetv107x_serial_device,
-	.reset			= tnetv107x_watchdog_reset,
-	.reset_device		= &tnetv107x_wdt_device,
 };
 
 void __init tnetv107x_init(void)
-- 
1.6.2.4
