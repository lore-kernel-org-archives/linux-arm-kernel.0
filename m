From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Oct 2010 00:39:20 +0200
Subject: [PATCH 02/13] ARM: pxa: Access SMEMC via virtual addresses
In-Reply-To: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
References: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1286663971-15634-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is important because on PXA3xx, the physical mapping of SMEMC registers
differs from the one on PXA2xx. In order to get PCMCIA working on both PXA2xx
and PXA320, the PCMCIA driver was adjusted accordingly as well.

Also, various places in the kernel had to be patched to use
__raw_read/__raw_write.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/cm-x2xx.c                  |   13 +++--
 arch/arm/mach-pxa/cpufreq-pxa2xx.c           |   10 ++--
 arch/arm/mach-pxa/csb726.c                   |    7 ++-
 arch/arm/mach-pxa/generic.c                  |    9 ++--
 arch/arm/mach-pxa/h5000.c                    |    9 ++--
 arch/arm/mach-pxa/include/mach/pxa-smemc.h   |   74 ++++++++++++++++++++++++++
 arch/arm/mach-pxa/include/mach/pxa2xx-regs.h |   55 -------------------
 arch/arm/mach-pxa/lpd270.c                   |    3 +-
 arch/arm/mach-pxa/lubbock.c                  |    3 +-
 arch/arm/mach-pxa/mainstone.c                |    5 +-
 arch/arm/mach-pxa/pxa27x.c                   |    6 ++-
 arch/arm/mach-pxa/sleep.S                    |    2 +-
 arch/arm/mach-pxa/smemc.c                    |   51 ++++++------------
 arch/arm/mach-pxa/stargate2.c                |    3 +-
 arch/arm/mach-pxa/tosa.c                     |    7 ++-
 arch/arm/mach-pxa/trizeps4.c                 |    3 +-
 arch/arm/mach-pxa/xcep.c                     |    5 +-
 arch/arm/mach-pxa/zeus.c                     |    5 +-
 drivers/pcmcia/pxa2xx_base.c                 |   65 +++++++++++++++-------
 19 files changed, 189 insertions(+), 146 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa-smemc.h

diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index c698836..2823466 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -24,6 +24,7 @@
 #include <mach/pxa2xx-regs.h>
 #include <mach/audio.h>
 #include <mach/pxafb.h>
+#include <mach/pxa-smemc.h>
 
 #include <asm/hardware/it8152.h>
 
@@ -392,9 +393,9 @@ static int cmx2xx_suspend(struct sys_device *dev, pm_message_t state)
 	cmx2xx_pci_suspend();
 
 	/* save MSC registers */
-	sleep_save_msc[0] = MSC0;
-	sleep_save_msc[1] = MSC1;
-	sleep_save_msc[2] = MSC2;
+	sleep_save_msc[0] = __raw_readl(MSC0);
+	sleep_save_msc[1] = __raw_readl(MSC1);
+	sleep_save_msc[2] = __raw_readl(MSC2);
 
 	/* setup power saving mode registers */
 	PCFR = 0x0;
@@ -416,9 +417,9 @@ static int cmx2xx_resume(struct sys_device *dev)
 	cmx2xx_pci_resume();
 
 	/* restore MSC registers */
-	MSC0 = sleep_save_msc[0];
-	MSC1 = sleep_save_msc[1];
-	MSC2 = sleep_save_msc[2];
+	__raw_writel(sleep_save_msc[0], MSC0);
+	__raw_writel(sleep_save_msc[1], MSC1);
+	__raw_writel(sleep_save_msc[2], MSC2);
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
index 58093d9..1af67ad 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
@@ -38,8 +38,10 @@
 #include <linux/cpufreq.h>
 #include <linux/err.h>
 #include <linux/regulator/consumer.h>
+#include <linux/io.h>
 
 #include <mach/pxa2xx-regs.h>
+#include <mach/pxa-smemc.h>
 
 #ifdef DEBUG
 static unsigned int freq_debug;
@@ -242,7 +244,7 @@ static void pxa27x_guess_max_freq(void)
 
 static void init_sdram_rows(void)
 {
-	uint32_t mdcnfg = MDCNFG;
+	uint32_t mdcnfg = __raw_readl(MDCNFG);
 	unsigned int drac2 = 0, drac0 = 0;
 
 	if (mdcnfg & (MDCNFG_DE2 | MDCNFG_DE3))
@@ -331,8 +333,8 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 	 * we need to preset the smaller DRI before the change.	 If we're
 	 * speeding up we need to set the larger DRI value after the change.
 	 */
-	preset_mdrefr = postset_mdrefr = MDREFR;
-	if ((MDREFR & MDREFR_DRI_MASK) > mdrefr_dri(new_freq_mem)) {
+	preset_mdrefr = postset_mdrefr = __raw_readl(MDREFR);
+	if ((__raw_readl(MDREFR) & MDREFR_DRI_MASK) > mdrefr_dri(new_freq_mem)) {
 		preset_mdrefr = (preset_mdrefr & ~MDREFR_DRI_MASK);
 		preset_mdrefr |= mdrefr_dri(new_freq_mem);
 	}
@@ -370,7 +372,7 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 3:		nop							\n\
 	  "
 		     : "=&r" (unused)
-		     : "r" (&MDREFR), "r" (cclkcfg),
+		     : "r" (MDREFR), "r" (cclkcfg),
 		       "r" (preset_mdrefr), "r" (postset_mdrefr)
 		     : "r4", "r5");
 	local_irq_restore(flags);
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index dab9d92..317adbd 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -27,6 +27,7 @@
 #include <mach/ohci.h>
 #include <mach/pxa2xx-regs.h>
 #include <mach/audio.h>
+#include <mach/pxa-smemc.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -255,9 +256,9 @@ static struct platform_device *devices[] __initdata = {
 static void __init csb726_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(csb726_pin_config));
-/*	MSC1 = 0x7ffc3ffc; *//* LAN9215/EXP_CS */
-/*	MSC2 = 0x06697ff4; *//* none/SM501 */
-	MSC2 = (MSC2 & ~0xffff) | 0x7ff4; /* SM501 */
+/*	__raw_writel(0x7ffc3ffc, MSC1); *//* LAN9215/EXP_CS */
+/*	__raw_writel(0x06697ff4, MSC2); *//* none/SM501 */
+	__raw_writel((__raw_readl(MSC2) & ~0xffff) | 0x7ff4, MSC2); /* SM501 */
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 971f994..6d621bb 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -28,6 +28,7 @@
 
 #include <mach/reset.h>
 #include <mach/gpio.h>
+#include <mach/pxa-smemc.h>
 
 #include "generic.h"
 
@@ -117,8 +118,8 @@ static struct map_desc common_io_desc[] __initdata = {
 
 static struct map_desc pxa2xx_io_desc[] __initdata = {
 	{	/* Mem Ctl */
-		.virtual	=  0xf6000000,
-		.pfn		= __phys_to_pfn(0x48000000),
+		.virtual	=  PXA_SMEMC_VIRT,
+		.pfn		= __phys_to_pfn(PXA2XX_SMEMC_BASE),
 		.length		= 0x00200000,
 		.type		= MT_DEVICE
 	}
@@ -126,8 +127,8 @@ static struct map_desc pxa2xx_io_desc[] __initdata = {
 
 static struct map_desc pxa3xx_io_desc[] __initdata = {
 	{	/* Mem Ctl */
-		.virtual	=  0xf6000000,
-		.pfn		= __phys_to_pfn(0x4a000000),
+		.virtual	=  PXA_SMEMC_VIRT,
+		.pfn		= __phys_to_pfn(PXA3XX_SMEMC_BASE),
 		.length		= 0x00200000,
 		.type		= MT_DEVICE
 	}
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index 9048066..3f69fce 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -32,6 +32,7 @@
 #include <mach/pxa25x.h>
 #include <mach/h5000.h>
 #include <mach/udc.h>
+#include <mach/pxa-smemc.h>
 
 #include "generic.h"
 
@@ -172,11 +173,11 @@ static unsigned long h5000_pin_config[] __initdata = {
 
 static void fix_msc(void)
 {
-	MSC0 = 0x129c24f2;
-	MSC1 = 0x7ff424fa;
-	MSC2 = 0x7ff47ff4;
+	__raw_writel(0x129c24f2, MSC0);
+	__raw_writel(0x7ff424fa, MSC1);
+	__raw_writel(0x7ff47ff4, MSC2);
 
-	MDREFR |= 0x02080000;
+	__raw_writel(__raw_readl(MDREFR) | 0x02080000, MDREFR);
 }
 
 /*
diff --git a/arch/arm/mach-pxa/include/mach/pxa-smemc.h b/arch/arm/mach-pxa/include/mach/pxa-smemc.h
new file mode 100644
index 0000000..e3b270b
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/pxa-smemc.h
@@ -0,0 +1,74 @@
+/*
+ * Static memory controller register definitions for PXA CPUs
+ *
+ * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PXA_SMEMC_REGS_H
+#define __PXA_SMEMC_REGS_H
+
+#define	PXA2XX_SMEMC_BASE	0x48000000
+#define	PXA3XX_SMEMC_BASE	0x4a000000
+#define	PXA_SMEMC_VIRT		0xf6000000
+
+#define MDCNFG		(PXA_SMEMC_VIRT + 0x00)  /* SDRAM Configuration Register 0 */
+#define MDREFR		(PXA_SMEMC_VIRT + 0x04)  /* SDRAM Refresh Control Register */
+#define MSC0		(PXA_SMEMC_VIRT + 0x08)  /* Static Memory Control Register 0 */
+#define MSC1		(PXA_SMEMC_VIRT + 0x0C)  /* Static Memory Control Register 1 */
+#define MSC2		(PXA_SMEMC_VIRT + 0x10)  /* Static Memory Control Register 2 */
+#define MECR		(PXA_SMEMC_VIRT + 0x14)  /* Expansion Memory (PCMCIA/Compact Flash) Bus Configuration */
+#define SXLCR		(PXA_SMEMC_VIRT + 0x18)  /* LCR value to be written to SDRAM-Timing Synchronous Flash */
+#define SXCNFG		(PXA_SMEMC_VIRT + 0x1C)  /* Synchronous Static Memory Control Register */
+#define SXMRS		(PXA_SMEMC_VIRT + 0x24)  /* MRS value to be written to Synchronous Flash or SMROM */
+#define MCMEM0		(PXA_SMEMC_VIRT + 0x28)  /* Card interface Common Memory Space Socket 0 Timing */
+#define MCMEM1		(PXA_SMEMC_VIRT + 0x2C)  /* Card interface Common Memory Space Socket 1 Timing */
+#define MCATT0		(PXA_SMEMC_VIRT + 0x30)  /* Card interface Attribute Space Socket 0 Timing Configuration */
+#define MCATT1		(PXA_SMEMC_VIRT + 0x34)  /* Card interface Attribute Space Socket 1 Timing Configuration */
+#define MCIO0		(PXA_SMEMC_VIRT + 0x38)  /* Card interface I/O Space Socket 0 Timing Configuration */
+#define MCIO1		(PXA_SMEMC_VIRT + 0x3C)  /* Card interface I/O Space Socket 1 Timing Configuration */
+#define MDMRS		(PXA_SMEMC_VIRT + 0x40)  /* MRS value to be written to SDRAM */
+#define BOOT_DEF	(PXA_SMEMC_VIRT + 0x44)  /* Read-Only Boot-Time Register. Contains BOOT_SEL and PKG_SEL */
+#define MEMCLKCFG	(PXA_SMEMC_VIRT + 0x68)	/* Clock Configuration */
+#define CSADRCFG0	(PXA_SMEMC_VIRT + 0x80)	/* Address Configuration Register for CS0 */
+#define CSADRCFG1	(PXA_SMEMC_VIRT + 0x84)	/* Address Configuration Register for CS1 */
+#define CSADRCFG2	(PXA_SMEMC_VIRT + 0x88)	/* Address Configuration Register for CS2 */
+#define CSADRCFG3	(PXA_SMEMC_VIRT + 0x8C)	/* Address Configuration Register for CS3 */
+
+/*
+ * More handy macros for PCMCIA
+ *
+ * Arg is socket number
+ */
+#define MCMEM(s)	(PXA_SMEMC_VIRT + 0x28 + ((s)<<2))  /* Card interface Common Memory Space Socket s Timing */
+#define MCATT(s)	(PXA_SMEMC_VIRT + 0x30 + ((s)<<2))  /* Card interface Attribute Space Socket s Timing Configuration */
+#define MCIO(s)		(PXA_SMEMC_VIRT + 0x38 + ((s)<<2))  /* Card interface I/O Space Socket s Timing Configuration */
+
+/* MECR register defines */
+#define MECR_NOS	(1 << 0)	/* Number Of Sockets: 0 -> 1 sock, 1 -> 2 sock */
+#define MECR_CIT	(1 << 1)	/* Card Is There: 0 -> no card, 1 -> card inserted */
+
+#define MDCNFG_DE0	(1 << 0)	/* SDRAM Bank 0 Enable */
+#define MDCNFG_DE1	(1 << 1)	/* SDRAM Bank 1 Enable */
+#define MDCNFG_DE2	(1 << 16)	/* SDRAM Bank 2 Enable */
+#define MDCNFG_DE3	(1 << 17)	/* SDRAM Bank 3 Enable */
+
+#define MDREFR_K0DB4	(1 << 29)	/* SDCLK0 Divide by 4 Control/Status */
+#define MDREFR_K2FREE	(1 << 25)	/* SDRAM Free-Running Control */
+#define MDREFR_K1FREE	(1 << 24)	/* SDRAM Free-Running Control */
+#define MDREFR_K0FREE	(1 << 23)	/* SDRAM Free-Running Control */
+#define MDREFR_SLFRSH	(1 << 22)	/* SDRAM Self-Refresh Control/Status */
+#define MDREFR_APD	(1 << 20)	/* SDRAM/SSRAM Auto-Power-Down Enable */
+#define MDREFR_K2DB2	(1 << 19)	/* SDCLK2 Divide by 2 Control/Status */
+#define MDREFR_K2RUN	(1 << 18)	/* SDCLK2 Run Control/Status */
+#define MDREFR_K1DB2	(1 << 17)	/* SDCLK1 Divide by 2 Control/Status */
+#define MDREFR_K1RUN	(1 << 16)	/* SDCLK1 Run Control/Status */
+#define MDREFR_E1PIN	(1 << 15)	/* SDCKE1 Level Control/Status */
+#define MDREFR_K0DB2	(1 << 14)	/* SDCLK0 Divide by 2 Control/Status */
+#define MDREFR_K0RUN	(1 << 13)	/* SDCLK0 Run Control/Status */
+#define MDREFR_E0PIN	(1 << 12)	/* SDCKE0 Level Control/Status */
+
+#endif
diff --git a/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h b/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
index 4fcddd9..b98f236 100644
--- a/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
@@ -28,61 +28,6 @@
 #define PXA_CS5_PHYS	0x14000000
 
 /*
- * Memory controller
- */
-
-#define MDCNFG		__REG(0x48000000)  /* SDRAM Configuration Register 0 */
-#define MDREFR		__REG(0x48000004)  /* SDRAM Refresh Control Register */
-#define MSC0		__REG(0x48000008)  /* Static Memory Control Register 0 */
-#define MSC1		__REG(0x4800000C)  /* Static Memory Control Register 1 */
-#define MSC2		__REG(0x48000010)  /* Static Memory Control Register 2 */
-#define MECR		__REG(0x48000014)  /* Expansion Memory (PCMCIA/Compact Flash) Bus Configuration */
-#define SXLCR		__REG(0x48000018)  /* LCR value to be written to SDRAM-Timing Synchronous Flash */
-#define SXCNFG		__REG(0x4800001C)  /* Synchronous Static Memory Control Register */
-#define SXMRS		__REG(0x48000024)  /* MRS value to be written to Synchronous Flash or SMROM */
-#define MCMEM0		__REG(0x48000028)  /* Card interface Common Memory Space Socket 0 Timing */
-#define MCMEM1		__REG(0x4800002C)  /* Card interface Common Memory Space Socket 1 Timing */
-#define MCATT0		__REG(0x48000030)  /* Card interface Attribute Space Socket 0 Timing Configuration */
-#define MCATT1		__REG(0x48000034)  /* Card interface Attribute Space Socket 1 Timing Configuration */
-#define MCIO0		__REG(0x48000038)  /* Card interface I/O Space Socket 0 Timing Configuration */
-#define MCIO1		__REG(0x4800003C)  /* Card interface I/O Space Socket 1 Timing Configuration */
-#define MDMRS		__REG(0x48000040)  /* MRS value to be written to SDRAM */
-#define BOOT_DEF	__REG(0x48000044)  /* Read-Only Boot-Time Register. Contains BOOT_SEL and PKG_SEL */
-
-/*
- * More handy macros for PCMCIA
- *
- * Arg is socket number
- */
-#define MCMEM(s)	__REG2(0x48000028, (s)<<2 )  /* Card interface Common Memory Space Socket s Timing */
-#define MCATT(s)	__REG2(0x48000030, (s)<<2 )  /* Card interface Attribute Space Socket s Timing Configuration */
-#define MCIO(s)		__REG2(0x48000038, (s)<<2 )  /* Card interface I/O Space Socket s Timing Configuration */
-
-/* MECR register defines */
-#define MECR_NOS	(1 << 0)	/* Number Of Sockets: 0 -> 1 sock, 1 -> 2 sock */
-#define MECR_CIT	(1 << 1)	/* Card Is There: 0 -> no card, 1 -> card inserted */
-
-#define MDCNFG_DE0	(1 << 0)	/* SDRAM Bank 0 Enable */
-#define MDCNFG_DE1	(1 << 1)	/* SDRAM Bank 1 Enable */
-#define MDCNFG_DE2	(1 << 16)	/* SDRAM Bank 2 Enable */
-#define MDCNFG_DE3	(1 << 17)	/* SDRAM Bank 3 Enable */
-
-#define MDREFR_K0DB4	(1 << 29)	/* SDCLK0 Divide by 4 Control/Status */
-#define MDREFR_K2FREE	(1 << 25)	/* SDRAM Free-Running Control */
-#define MDREFR_K1FREE	(1 << 24)	/* SDRAM Free-Running Control */
-#define MDREFR_K0FREE	(1 << 23)	/* SDRAM Free-Running Control */
-#define MDREFR_SLFRSH	(1 << 22)	/* SDRAM Self-Refresh Control/Status */
-#define MDREFR_APD	(1 << 20)	/* SDRAM/SSRAM Auto-Power-Down Enable */
-#define MDREFR_K2DB2	(1 << 19)	/* SDCLK2 Divide by 2 Control/Status */
-#define MDREFR_K2RUN	(1 << 18)	/* SDCLK2 Run Control/Status */
-#define MDREFR_K1DB2	(1 << 17)	/* SDCLK1 Divide by 2 Control/Status */
-#define MDREFR_K1RUN	(1 << 16)	/* SDCLK1 Run Control/Status */
-#define MDREFR_E1PIN	(1 << 15)	/* SDCKE1 Level Control/Status */
-#define MDREFR_K0DB2	(1 << 14)	/* SDCLK0 Divide by 2 Control/Status */
-#define MDREFR_K0RUN	(1 << 13)	/* SDCLK0 Run Control/Status */
-#define MDREFR_E0PIN	(1 << 12)	/* SDCKE0 Level Control/Status */
-
-/*
  * Power Manager
  */
 
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index f1685cc..40a219a 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -46,6 +46,7 @@
 #include <mach/mmc.h>
 #include <mach/irda.h>
 #include <mach/ohci.h>
+#include <mach/pxa-smemc.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -463,7 +464,7 @@ static void __init lpd270_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	lpd270_flash_data[0].width = (BOOT_DEF & 1) ? 2 : 4;
+	lpd270_flash_data[0].width = (__raw_readl(BOOT_DEF) & 1) ? 2 : 4;
 	lpd270_flash_data[1].width = 4;
 
 	/*
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index e73fc1d..e16450e 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -50,6 +50,7 @@
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
 #include <mach/pm.h>
+#include <mach/pxa-smemc.h>
 
 #include "generic.h"
 #include "clock.h"
@@ -525,7 +526,7 @@ static void __init lubbock_init(void)
 	pxa_set_ac97_info(NULL);
 
 	lubbock_flash_data[0].width = lubbock_flash_data[1].width =
-		(BOOT_DEF & 1) ? 2 : 4;
+		(__raw_readl(BOOT_DEF) & 1) ? 2 : 4;
 	/* Compensate for the nROMBT switch which swaps the flash banks */
 	printk(KERN_NOTICE "Lubbock configured to boot from %s (bank %d)\n",
 	       flashboot?"Flash":"ROM", flashboot);
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 12f5e9e..f3ea1d7 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -41,7 +41,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 
-#include <plat/pxa27x.h>
+#include <mach/pxa27x.h>
 #include <mach/gpio.h>
 #include <mach/mainstone.h>
 #include <mach/audio.h>
@@ -51,6 +51,7 @@
 #include <mach/irda.h>
 #include <mach/ohci.h>
 #include <plat/pxa27x_keypad.h>
+#include <mach/pxa-smemc.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -565,7 +566,7 @@ static void __init mainstone_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	mst_flash_data[0].width = (BOOT_DEF & 1) ? 2 : 4;
+	mst_flash_data[0].width = (__raw_readl(BOOT_DEF) & 1) ? 2 : 4;
 	mst_flash_data[1].width = 4;
 
 	/* Compensate for SW7 which swaps the flash banks */
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 12e5b9f..b1b01e6 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/platform_device.h>
 #include <linux/sysdev.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -27,6 +28,7 @@
 #include <mach/ohci.h>
 #include <mach/pm.h>
 #include <mach/dma.h>
+#include <mach/pxa-smemc.h>
 #include <plat/i2c.h>
 
 #include "generic.h"
@@ -254,7 +256,7 @@ enum {
 
 void pxa27x_cpu_pm_save(unsigned long *sleep_save)
 {
-	SAVE(MDREFR);
+	sleep_save[SLEEP_SAVE_MDREFR] = __raw_readl(MDREFR);
 	SAVE(PCFR);
 
 	SAVE(CKEN);
@@ -263,7 +265,7 @@ void pxa27x_cpu_pm_save(unsigned long *sleep_save)
 
 void pxa27x_cpu_pm_restore(unsigned long *sleep_save)
 {
-	RESTORE(MDREFR);
+	__raw_writel(sleep_save[SLEEP_SAVE_MDREFR], MDREFR);
 	RESTORE(PCFR);
 
 	PSSR = PSSR_RDH | PSSR_PH;
diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index 52c30b0..227df3a 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -14,7 +14,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <mach/hardware.h>
-
+#include <mach/pxa-smemc.h>
 #include <mach/pxa2xx-regs.h>
 
 #define MDREFR_KDIV	0x200a4000	// all banks
diff --git a/arch/arm/mach-pxa/smemc.c b/arch/arm/mach-pxa/smemc.c
index d6f6904..91edda8 100644
--- a/arch/arm/mach-pxa/smemc.c
+++ b/arch/arm/mach-pxa/smemc.c
@@ -9,50 +9,37 @@
 #include <linux/sysdev.h>
 
 #include <mach/hardware.h>
-
-#define SMEMC_PHYS_BASE	(0x4A000000)
-#define SMEMC_PHYS_SIZE	(0x90)
-
-#define MSC0		(0x08)	/* Static Memory Controller Register 0 */
-#define MSC1		(0x0C)	/* Static Memory Controller Register 1 */
-#define SXCNFG		(0x1C)	/* Synchronous Static Memory Control Register */
-#define MEMCLKCFG	(0x68)	/* Clock Configuration */
-#define CSADRCFG0	(0x80)	/* Address Configuration Register for CS0 */
-#define CSADRCFG1	(0x84)	/* Address Configuration Register for CS1 */
-#define CSADRCFG2	(0x88)	/* Address Configuration Register for CS2 */
-#define CSADRCFG3	(0x8C)	/* Address Configuration Register for CS3 */
+#include <mach/pxa-smemc.h>
 
 #ifdef CONFIG_PM
-static void __iomem *smemc_mmio_base;
-
 static unsigned long msc[2];
 static unsigned long sxcnfg, memclkcfg;
 static unsigned long csadrcfg[4];
 
 static int pxa3xx_smemc_suspend(struct sys_device *dev, pm_message_t state)
 {
-	msc[0] = __raw_readl(smemc_mmio_base + MSC0);
-	msc[1] = __raw_readl(smemc_mmio_base + MSC1);
-	sxcnfg = __raw_readl(smemc_mmio_base + SXCNFG);
-	memclkcfg = __raw_readl(smemc_mmio_base + MEMCLKCFG);
-	csadrcfg[0] = __raw_readl(smemc_mmio_base + CSADRCFG0);
-	csadrcfg[1] = __raw_readl(smemc_mmio_base + CSADRCFG1);
-	csadrcfg[2] = __raw_readl(smemc_mmio_base + CSADRCFG2);
-	csadrcfg[3] = __raw_readl(smemc_mmio_base + CSADRCFG3);
+	msc[0] = __raw_readl(MSC0);
+	msc[1] = __raw_readl(MSC1);
+	sxcnfg = __raw_readl(SXCNFG);
+	memclkcfg = __raw_readl(MEMCLKCFG);
+	csadrcfg[0] = __raw_readl(CSADRCFG0);
+	csadrcfg[1] = __raw_readl(CSADRCFG1);
+	csadrcfg[2] = __raw_readl(CSADRCFG2);
+	csadrcfg[3] = __raw_readl(CSADRCFG3);
 
 	return 0;
 }
 
 static int pxa3xx_smemc_resume(struct sys_device *dev)
 {
-	__raw_writel(msc[0], smemc_mmio_base + MSC0);
-	__raw_writel(msc[1], smemc_mmio_base + MSC1);
-	__raw_writel(sxcnfg, smemc_mmio_base + SXCNFG);
-	__raw_writel(memclkcfg, smemc_mmio_base + MEMCLKCFG);
-	__raw_writel(csadrcfg[0], smemc_mmio_base + CSADRCFG0);
-	__raw_writel(csadrcfg[1], smemc_mmio_base + CSADRCFG1);
-	__raw_writel(csadrcfg[2], smemc_mmio_base + CSADRCFG2);
-	__raw_writel(csadrcfg[3], smemc_mmio_base + CSADRCFG3);
+	__raw_writel(msc[0], MSC0);
+	__raw_writel(msc[1], MSC1);
+	__raw_writel(sxcnfg, SXCNFG);
+	__raw_writel(memclkcfg, MEMCLKCFG);
+	__raw_writel(csadrcfg[0], CSADRCFG0);
+	__raw_writel(csadrcfg[1], CSADRCFG1);
+	__raw_writel(csadrcfg[2], CSADRCFG2);
+	__raw_writel(csadrcfg[3], CSADRCFG3);
 
 	return 0;
 }
@@ -73,10 +60,6 @@ static int __init smemc_init(void)
 	int ret = 0;
 
 	if (cpu_is_pxa3xx()) {
-		smemc_mmio_base = ioremap(SMEMC_PHYS_BASE, SMEMC_PHYS_SIZE);
-		if (smemc_mmio_base == NULL)
-			return -ENODEV;
-
 		ret = sysdev_class_register(&smemc_sysclass);
 		if (ret)
 			return ret;
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 2f45af4..61af9a0 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -48,6 +48,7 @@
 #include <mach/udc.h>
 #include <mach/pxa2xx_spi.h>
 #include <mach/pxa27x-udc.h>
+#include <mach/pxa-smemc.h>
 
 #include <linux/spi/spi.h>
 #include <linux/mfd/da903x.h>
@@ -976,7 +977,7 @@ static void __init stargate2_init(void)
 {
 	/* This is probably a board specific hack as this must be set
 	   prior to connecting the MFP stuff up. */
-	MECR &= ~MECR_NOS;
+	__raw_writel(__raw_readl(MECR) & ~MECR_NOS, MECR);
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(stargate2_pin_config));
 
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 86b6c7a..1fe9e98 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -46,6 +46,7 @@
 #include <mach/tosa_bt.h>
 #include <mach/pxa2xx_spi.h>
 #include <mach/audio.h>
+#include <mach/pxa-smemc.h>
 
 #include <asm/mach/arch.h>
 #include <mach/tosa.h>
@@ -893,9 +894,11 @@ static void tosa_poweroff(void)
 
 static void tosa_restart(char mode, const char *cmd)
 {
+	uint32_t msc0 = __raw_readl(MSC0);
+
 	/* Bootloader magic for a reboot */
-	if((MSC0 & 0xffff0000) == 0x7ff00000)
-		MSC0 = (MSC0 & 0xffff) | 0x7ee00000;
+	if((msc0 & 0xffff0000) == 0x7ff00000)
+		__raw_writel((msc0 & 0xffff) | 0x7ee00000, MSC0);
 
 	tosa_poweroff();
 }
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index d4ecc25..881f77d 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -47,6 +47,7 @@
 #include <mach/mmc.h>
 #include <mach/irda.h>
 #include <mach/ohci.h>
+#include <mach/pxa-smemc.h>
 #include <plat/i2c.h>
 
 #include "generic.h"
@@ -542,7 +543,7 @@ static void __init trizeps4_map_io(void)
 	pxa2xx_map_io();
 	iotable_init(trizeps4_io_desc, ARRAY_SIZE(trizeps4_io_desc));
 
-	if ((MSC0 & 0x8) && (BOOT_DEF & 0x1)) {
+	if ((__raw_readl(MSC0) & 0x8) && (__raw_readl(BOOT_DEF) & 0x1)) {
 		/* if flash is 16 bit wide its a Trizeps4 WL */
 		__machine_arch_type = MACH_TYPE_TRIZEPS4WL;
 		trizeps4_flash_data[0].width = 2;
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 649e74b..bd8a38f 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -31,6 +31,7 @@
 #include <mach/hardware.h>
 #include <mach/pxa2xx-regs.h>
 #include <mach/mfp-pxa25x.h>
+#include <mach/pxa-smemc.h>
 
 #include "generic.h"
 
@@ -172,9 +173,9 @@ static void __init xcep_init(void)
 
 	/* See Intel XScale Developer's Guide for details */
 	/* Set RDF and RDN to appropriate values (chip select 3 (smc91x)) */
-	MSC1 = (MSC1 & 0xffff) | 0xD5540000;
+	__raw_writel((__raw_readl(MSC1) & 0xffff) | 0xD5540000, MSC1);
 	/* Set RDF and RDN to appropriate values (chip select 5 (fpga)) */
-	MSC2 = (MSC2 & 0xffff) | 0x72A00000;
+	__raw_writel((__raw_readl(MSC2) & 0xffff) | 0x72A00000, MSC2);
 
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 	pxa_set_i2c_info(&xcep_i2c_platform_data);
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 96a064f..cf410ba 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -47,6 +47,7 @@
 #include <mach/audio.h>
 #include <mach/arcom-pcmcia.h>
 #include <mach/zeus.h>
+#include <mach/pxa-smemc.h>
 
 #include "generic.h"
 
@@ -828,8 +829,8 @@ static void __init zeus_init(void)
 	pr_info("Zeus CPLD V%dI%d\n", (system_rev & 0xf0) >> 4, (system_rev & 0x0f));
 
 	/* Fix timings for dm9000s (CS1/CS2)*/
-	MSC0 = (MSC0 & 0xffff) | (dm9000_msc << 16);
-	MSC1 = (MSC1 & 0xffff0000) | dm9000_msc;
+	__raw_writel((MSC0 & 0xffff) | (dm9000_msc << 16), MSC0);
+	__raw_writel((MSC1 & 0xffff0000) | dm9000_msc, MSC1);
 
 	pm_power_off = zeus_power_off;
 	zeus_setup_apm();
diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index ae07b4d..65a8b6f 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
+#include <mach/pxa-smemc.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/system.h>
@@ -116,37 +117,49 @@ static inline u_int pxa2xx_pcmcia_cmd_time(u_int mem_clk_10khz,
 
 static int pxa2xx_pcmcia_set_mcmem( int sock, int speed, int clock )
 {
-	MCMEM(sock) = ((pxa2xx_mcxx_setup(speed, clock)
+	uint32_t val;
+
+	val = ((pxa2xx_mcxx_setup(speed, clock)
 		& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
 		| ((pxa2xx_mcxx_asst(speed, clock)
 		& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
+	__raw_writel(val, MCMEM(sock));
+
 	return 0;
 }
 
 static int pxa2xx_pcmcia_set_mcio( int sock, int speed, int clock )
 {
-	MCIO(sock) = ((pxa2xx_mcxx_setup(speed, clock)
+	uint32_t val;
+
+	val = ((pxa2xx_mcxx_setup(speed, clock)
 		& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
 		| ((pxa2xx_mcxx_asst(speed, clock)
 		& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
+	__raw_writel(val, MCIO(sock));
+
 	return 0;
 }
 
 static int pxa2xx_pcmcia_set_mcatt( int sock, int speed, int clock )
 {
-	MCATT(sock) = ((pxa2xx_mcxx_setup(speed, clock)
+	uint32_t val;
+
+	val = ((pxa2xx_mcxx_setup(speed, clock)
 		& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
 		| ((pxa2xx_mcxx_asst(speed, clock)
 		& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
 		| ((pxa2xx_mcxx_hold(speed, clock)
 		& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
 
+	__raw_writel(val, MCATT(sock));
+
 	return 0;
 }
 
@@ -205,19 +218,18 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
 static void pxa2xx_configure_sockets(struct device *dev)
 {
 	struct pcmcia_low_level *ops = dev->platform_data;
-
 	/*
 	 * We have at least one socket, so set MECR:CIT
 	 * (Card Is There)
 	 */
-	MECR |= MECR_CIT;
+	uint32_t mecr = MECR_CIT;
 
 	/* Set MECR:NOS (Number Of Sockets) */
 	if ((ops->first + ops->nr) > 1 ||
 	    machine_is_viper() || machine_is_arcom_zeus())
-		MECR |= MECR_NOS;
-	else
-		MECR &= ~MECR_NOS;
+		mecr |= MECR_NOS;
+
+	__raw_writel(mecr, MECR);
 }
 
 static const char *skt_names[] = {
@@ -272,14 +284,24 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 	struct soc_pcmcia_socket *skt;
 
 	ops = (struct pcmcia_low_level *)dev->dev.platform_data;
-	if (!ops)
-		return -ENODEV;
+	if (!ops) {
+		ret = -ENODEV;
+		goto err0;
+	}
+
+	if (cpu_is_pxa320() && ops->nr > 1) {
+		dev_err(&dev->dev, "pxa320 supports only one pcmcia slot");
+		ret = -EINVAL;
+		goto err0;
+	}
 
 	pxa2xx_drv_pcmcia_ops(ops);
 
 	sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
-	if (!sinfo)
-		return -ENOMEM;
+	if (!sinfo) {
+		ret = -ENOMEM;
+		goto err0;
+	}
 
 	sinfo->nskt = ops->nr;
 
@@ -295,18 +317,19 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 
 		ret = pxa2xx_drv_pcmcia_add_one(skt);
 		if (ret)
-			break;
+			goto err1;
 	}
 
-	if (ret) {
-		while (--i >= 0)
-			soc_pcmcia_remove_one(&sinfo->skt[i]);
-		kfree(sinfo);
-	} else {
-		pxa2xx_configure_sockets(&dev->dev);
-		dev_set_drvdata(&dev->dev, sinfo);
-	}
+	pxa2xx_configure_sockets(&dev->dev);
+	dev_set_drvdata(&dev->dev, sinfo);
 
+	return 0;
+
+err1:
+	while (--i >= 0)
+		soc_pcmcia_remove_one(&sinfo->skt[i]);
+	kfree(sinfo);
+err0:
 	return ret;
 }
 
-- 
1.7.1
