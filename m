From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 27 Aug 2012 18:56:41 +0530
Subject: [PATCH V2 3/6] ASoC/ARM: Davinci: McASP: split asp header into
 platform and audio specific
In-Reply-To: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1346074004-22172-4-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Davinci McASP header & driver are shared by few OMAP platforms (like
TI81xx, AM335x). Splitting asp header into Davinci platform specific
header and Audio specific header helps to share them across platforms.

Audio specific defines is moved to to common
<linux/platform_data/davinci_asp.h> so that the header can be
accessed by all related platforms.

While here, correct the header usage (remove multiple header
re-definitions and unused headers) and remove platform names from
structures comments and enum. Also some some coding style errors.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

---
Changes from V1:
	- Coding Style Correction

:000000 100644 0000000... d9b2acd... A	arch/arm/mach-davinci/asp.h
:100644 100644 8db0fc6... 8661b20... M	arch/arm/mach-davinci/davinci.h
:100644 100644 4735d64... bd2f72b... M	arch/arm/mach-davinci/devices-da8xx.c
:100644 100644 678cd99... e47a3f0... M	arch/arm/mach-davinci/dm355.c
:100644 100644 a50d49de.. f473745... M	arch/arm/mach-davinci/dm365.c
:100644 100644 c8b8666... 0755d46... M	arch/arm/mach-davinci/dm644x.c
:100644 100644 9eb87c1... 97c0f8e... M	arch/arm/mach-davinci/dm646x.c
:100644 100644 a2f1f27... c74a6ab... M	arch/arm/mach-davinci/include/mach/da8xx.h
:100644 100644 9aa2409... 79c26aa... R056	arch/arm/mach-davinci/include/mach/asp.h	include/linux/platform_data/davinci_asp.h
:100644 100644 4b37e2a... ab0ad45... M	sound/soc/davinci/davinci-evm.c
:100644 100644 407df72... 8218312... M	sound/soc/davinci/davinci-i2s.c
:100644 100644 51479f9... 0de9ed6... M	sound/soc/davinci/davinci-mcasp.h
:100644 100644 4b70828... 93ea3bf... M	sound/soc/davinci/davinci-pcm.c
:100644 100644 5e55164... fc4d01c... M	sound/soc/davinci/davinci-pcm.h
 arch/arm/mach-davinci/asp.h                        |   49 +++++++++++++
 arch/arm/mach-davinci/davinci.h                    |    3 +-
 arch/arm/mach-davinci/devices-da8xx.c              |    1 +
 arch/arm/mach-davinci/dm355.c                      |    2 +-
 arch/arm/mach-davinci/dm365.c                      |    2 +-
 arch/arm/mach-davinci/dm644x.c                     |    2 +-
 arch/arm/mach-davinci/dm646x.c                     |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
 .../linux/platform_data/davinci_asp.h              |   73 ++++++--------------
 sound/soc/davinci/davinci-evm.c                    |    3 -
 sound/soc/davinci/davinci-i2s.c                    |    3 +-
 sound/soc/davinci/davinci-mcasp.h                  |    3 +-
 sound/soc/davinci/davinci-pcm.c                    |    1 -
 sound/soc/davinci/davinci-pcm.h                    |    3 +-
 14 files changed, 81 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-davinci/asp.h b/arch/arm/mach-davinci/asp.h
new file mode 100644
index 0000000..d9b2acd
--- /dev/null
+++ b/arch/arm/mach-davinci/asp.h
@@ -0,0 +1,49 @@
+/*
+ * TI DaVinci Audio definitions
+ */
+#ifndef __ASM_ARCH_DAVINCI_ASP_H
+#define __ASM_ARCH_DAVINCI_ASP_H
+
+/* Bases of dm644x and dm355 register banks */
+#define DAVINCI_ASP0_BASE	0x01E02000
+#define DAVINCI_ASP1_BASE	0x01E04000
+
+/* Bases of dm365 register banks */
+#define DAVINCI_DM365_ASP0_BASE	0x01D02000
+
+/* Bases of dm646x register banks */
+#define DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
+#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
+
+/* Bases of da850/da830 McASP0  register banks */
+#define DAVINCI_DA8XX_MCASP0_REG_BASE	0x01D00000
+
+/* Bases of da830 McASP1 register banks */
+#define DAVINCI_DA830_MCASP1_REG_BASE	0x01D04000
+
+/* EDMA channels of dm644x and dm355 */
+#define DAVINCI_DMA_ASP0_TX	2
+#define DAVINCI_DMA_ASP0_RX	3
+#define DAVINCI_DMA_ASP1_TX	8
+#define DAVINCI_DMA_ASP1_RX	9
+
+/* EDMA channels of dm646x */
+#define DAVINCI_DM646X_DMA_MCASP0_AXEVT0	6
+#define DAVINCI_DM646X_DMA_MCASP0_AREVT0	9
+#define DAVINCI_DM646X_DMA_MCASP1_AXEVT1	12
+
+/* EDMA channels of da850/da830 McASP0 */
+#define DAVINCI_DA8XX_DMA_MCASP0_AREVT	0
+#define DAVINCI_DA8XX_DMA_MCASP0_AXEVT	1
+
+/* EDMA channels of da830 McASP1 */
+#define DAVINCI_DA830_DMA_MCASP1_AREVT	2
+#define DAVINCI_DA830_DMA_MCASP1_AXEVT	3
+
+/* Interrupts */
+#define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
+#define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
+#define DAVINCI_ASP1_RX_INT	IRQ_MBRINT
+#define DAVINCI_ASP1_TX_INT	IRQ_MBXINT
+
+#endif /* __ASM_ARCH_DAVINCI_ASP_H */
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 8db0fc6..8661b20 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -22,10 +22,11 @@
 #include <linux/davinci_emac.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/platform_data/davinci_asp.h>
 
-#include <mach/asp.h>
 #include <mach/keyscan.h>
 #include <mach/hardware.h>
+#include <mach/edma.h>
 
 #include <media/davinci/vpfe_capture.h>
 #include <media/davinci/vpif_types.h>
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 4735d64..bd2f72b 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -24,6 +24,7 @@
 #include <mach/cpuidle.h>
 
 #include "clock.h"
+#include "asp.h"
 
 #define DA8XX_TPCC_BASE			0x01c00000
 #define DA8XX_TPTC0_BASE		0x01c08000
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 678cd99..e47a3f0 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -26,13 +26,13 @@
 #include <mach/time.h>
 #include <mach/serial.h>
 #include <mach/common.h>
-#include <mach/asp.h>
 #include <mach/spi.h>
 #include <mach/gpio-davinci.h>
 
 #include "davinci.h"
 #include "clock.h"
 #include "mux.h"
+#include "asp.h"
 
 #define DM355_UART2_BASE	(IO_PHYS + 0x206000)
 
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index a50d49d..f473745 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -29,7 +29,6 @@
 #include <mach/time.h>
 #include <mach/serial.h>
 #include <mach/common.h>
-#include <mach/asp.h>
 #include <mach/keyscan.h>
 #include <mach/spi.h>
 #include <mach/gpio-davinci.h>
@@ -37,6 +36,7 @@
 #include "davinci.h"
 #include "clock.h"
 #include "mux.h"
+#include "asp.h"
 
 #define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
 
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index c8b8666..0755d46 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -23,12 +23,12 @@
 #include <mach/time.h>
 #include <mach/serial.h>
 #include <mach/common.h>
-#include <mach/asp.h>
 #include <mach/gpio-davinci.h>
 
 #include "davinci.h"
 #include "clock.h"
 #include "mux.h"
+#include "asp.h"
 
 /*
  * Device specific clocks
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 9eb87c1..97c0f8e 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -24,12 +24,12 @@
 #include <mach/time.h>
 #include <mach/serial.h>
 #include <mach/common.h>
-#include <mach/asp.h>
 #include <mach/gpio-davinci.h>
 
 #include "davinci.h"
 #include "clock.h"
 #include "mux.h"
+#include "asp.h"
 
 #define DAVINCI_VPIF_BASE       (0x01C12000)
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index a2f1f27..c74a6ab 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -16,11 +16,11 @@
 #include <linux/platform_device.h>
 #include <linux/davinci_emac.h>
 #include <linux/spi/spi.h>
+#include <linux/platform_data/davinci_asp.h>
 
 #include <mach/serial.h>
 #include <mach/edma.h>
 #include <mach/i2c.h>
-#include <mach/asp.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
 #include <mach/pm.h>
diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/include/linux/platform_data/davinci_asp.h
similarity index 56%
rename from arch/arm/mach-davinci/include/mach/asp.h
rename to include/linux/platform_data/davinci_asp.h
index 9aa2409..79c26aa 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -1,59 +1,26 @@
 /*
- * <mach/asp.h> - DaVinci Audio Serial Port support
+ * TI DaVinci Audio Serial Port support
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
  */
-#ifndef __ASM_ARCH_DAVINCI_ASP_H
-#define __ASM_ARCH_DAVINCI_ASP_H
 
-#include <mach/irqs.h>
-#include <mach/edma.h>
-
-/* Bases of dm644x and dm355 register banks */
-#define DAVINCI_ASP0_BASE	0x01E02000
-#define DAVINCI_ASP1_BASE	0x01E04000
-
-/* Bases of dm365 register banks */
-#define DAVINCI_DM365_ASP0_BASE	0x01D02000
-
-/* Bases of dm646x register banks */
-#define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
-#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
-
-/* Bases of da850/da830 McASP0  register banks */
-#define DAVINCI_DA8XX_MCASP0_REG_BASE	0x01D00000
-
-/* Bases of da830 McASP1 register banks */
-#define DAVINCI_DA830_MCASP1_REG_BASE	0x01D04000
-
-/* EDMA channels of dm644x and dm355 */
-#define DAVINCI_DMA_ASP0_TX	2
-#define DAVINCI_DMA_ASP0_RX	3
-#define DAVINCI_DMA_ASP1_TX	8
-#define DAVINCI_DMA_ASP1_RX	9
-
-/* EDMA channels of dm646x */
-#define	DAVINCI_DM646X_DMA_MCASP0_AXEVT0	6
-#define	DAVINCI_DM646X_DMA_MCASP0_AREVT0	9
-#define	DAVINCI_DM646X_DMA_MCASP1_AXEVT1	12
-
-/* EDMA channels of da850/da830 McASP0 */
-#define	DAVINCI_DA8XX_DMA_MCASP0_AREVT	0
-#define	DAVINCI_DA8XX_DMA_MCASP0_AXEVT	1
-
-/* EDMA channels of da830 McASP1 */
-#define	DAVINCI_DA830_DMA_MCASP1_AREVT	2
-#define	DAVINCI_DA830_DMA_MCASP1_AXEVT	3
-
-/* Interrupts */
-#define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
-#define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
-#define DAVINCI_ASP1_RX_INT	IRQ_MBRINT
-#define DAVINCI_ASP1_TX_INT	IRQ_MBXINT
+#ifndef __DAVINCI_ASP_H
+#define __DAVINCI_ASP_H
 
 struct snd_platform_data {
 	u32 tx_dma_offset;
 	u32 rx_dma_offset;
-	enum dma_event_q asp_chan_q;	/* event queue number for ASP channel */
-	enum dma_event_q ram_chan_q;	/* event queue number for RAM channel */
+	int asp_chan_q;	/* event queue number for ASP channel */
+	int ram_chan_q;	/* event queue number for RAM channel */
 	unsigned int codec_fmt;
 	/*
 	 * Allowing this is more efficient and eliminates left and right swaps
@@ -70,7 +37,7 @@ struct snd_platform_data {
 	 * and MCBSP_CLKS.
 	 * Depending on different hardware connections it is possible
 	 * to use this setting to change the behaviour of McBSP
-	 * driver. The dm365_clk_input_pin enum is available for dm365
+	 * driver.
 	 */
 	int clk_input_pin;
 
@@ -122,8 +89,8 @@ enum {
 	MCASP_VERSION_2,	/* DA8xx/OMAPL1x */
 };
 
-enum dm365_clk_input_pin {
-	MCBSP_CLKR = 0,		/* DM365 */
+enum mcbsp_clk_input_pin {
+	MCBSP_CLKR = 0,		/* as in DM365 */
 	MCBSP_CLKS,
 };
 
@@ -134,4 +101,4 @@ enum dm365_clk_input_pin {
 #define DAVINCI_MCASP_IIS_MODE	0
 #define DAVINCI_MCASP_DIT_MODE	1
 
-#endif /* __ASM_ARCH_DAVINCI_ASP_H */
+#endif
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 4b37e2a..ab0ad45 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -22,9 +22,6 @@
 #include <asm/dma.h>
 #include <asm/mach-types.h>
 
-#include <mach/asp.h>
-#include <mach/edma.h>
-
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
 #include "davinci-mcasp.h"
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 407df72..8218312 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/platform_data/davinci_asp.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -23,8 +24,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <mach/asp.h>
-
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
 
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 51479f9..0de9ed6 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -19,7 +19,8 @@
 #define DAVINCI_MCASP_H
 
 #include <linux/io.h>
-#include <mach/asp.h>
+#include <linux/platform_data/davinci_asp.h>
+
 #include "davinci-pcm.h"
 
 #define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_96000
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 4b70828..93ea3bf 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -23,7 +23,6 @@
 #include <sound/soc.h>
 
 #include <asm/dma.h>
-#include <mach/edma.h>
 #include <mach/sram.h>
 
 #include "davinci-pcm.h"
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 5e55164..fc4d01c 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -12,9 +12,8 @@
 #ifndef _DAVINCI_PCM_H
 #define _DAVINCI_PCM_H
 
+#include <linux/platform_data/davinci_asp.h>
 #include <mach/edma.h>
-#include <mach/asp.h>
-
 
 struct davinci_pcm_dma_params {
 	int channel;			/* sync dma channel ID */
-- 
1.7.1
