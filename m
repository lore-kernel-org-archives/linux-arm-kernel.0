From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 08 Jun 2010 18:55:29 +0800
Subject: [PATCH 2/2] pxa: modify the pxa2xx-ac97 file for pxa168
Message-ID: <4C0E21A1.4000909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow the sharing of the pxa2xx-ac97 driver file with pxa168,
we have to do a little change to pxa2xx-ac97 file.

All private register addresses were located in mach/include/ac97.h.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-pxa/include/mach/ac97.h      |   27 ++++++++++++++++++
 arch/arm/plat-pxa/include/plat/regs-ac97.h |   42 ++++++++++++++--------------
 sound/arm/pxa2xx-ac97.c                    |    4 +-
 sound/soc/pxa/pxa2xx-ac97.c                |   10 +++---
 4 files changed, 55 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/ac97.h

diff --git a/arch/arm/mach-pxa/include/mach/ac97.h b/arch/arm/mach-pxa/include/mach/ac97.h
new file mode 100644
index 0000000..c8db278
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/ac97.h
@@ -0,0 +1,27 @@
+/*
+ * arch/arm/mach-pxa/include/mach/ac97.h
+ *
+ * PXA AC97 header file
+ *
+ * Written by Wan ZongShun <mcuos.com@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+
+#ifndef __ASM_ARCH_PXA_AC97_H
+#define __ASM_ARCH_PXA_AC97_H
+
+#include <mach/hardware.h>
+
+# define AC97_REG(x)		__REG((x) + 0x40500000)
+
+#define AC97_AUDIO_TX		12
+#define AC97_AUDIO_RX		11
+#define AC97_MODEM_TX		10
+#define AC97_MODEM_RX		9
+#define AC97_MIC		8
+
+#endif /* __ASM_ARCH_PXA_AC97_H */
diff --git a/arch/arm/plat-pxa/include/plat/regs-ac97.h b/arch/arm/plat-pxa/include/plat/regs-ac97.h
index b8d14bd..95d6cc5 100644
--- a/arch/arm/plat-pxa/include/plat/regs-ac97.h
+++ b/arch/arm/plat-pxa/include/plat/regs-ac97.h
@@ -1,25 +1,25 @@
 #ifndef __ASM_ARCH_REGS_AC97_H
 #define __ASM_ARCH_REGS_AC97_H

-#include <mach/hardware.h>
+#include <mach/ac97.h>

 /*
  * AC97 Controller registers
  */

-#define POCR		__REG(0x40500000)  /* PCM Out Control Register */
+#define POCR		AC97_REG(0x0000)  /* PCM Out Control Register */
 #define POCR_FEIE	(1 << 3)	/* FIFO Error Interrupt Enable */
 #define POCR_FSRIE	(1 << 1)	/* FIFO Service Request Interrupt Enable */

-#define PICR		__REG(0x40500004)  /* PCM In Control Register */
+#define PICR		AC97_REG(0x0004)  /* PCM In Control Register */
 #define PICR_FEIE	(1 << 3)	/* FIFO Error Interrupt Enable */
 #define PICR_FSRIE	(1 << 1)	/* FIFO Service Request Interrupt Enable */

-#define MCCR		__REG(0x40500008)  /* Mic In Control Register */
+#define MCCR		AC97_REG(0x0008)  /* Mic In Control Register */
 #define MCCR_FEIE	(1 << 3)	/* FIFO Error Interrupt Enable */
 #define MCCR_FSRIE	(1 << 1)	/* FIFO Service Request Interrupt Enable */

-#define GCR		__REG(0x4050000C)  /* Global Control Register */
+#define GCR		AC97_REG(0x000C)  /* Global Control Register */
 #ifdef CONFIG_PXA3xx
 #define GCR_CLKBPB	(1 << 31)	/* Internal clock enable */
 #endif
@@ -35,21 +35,21 @@
 #define GCR_COLD_RST	(1 << 1)	/* AC'97 Cold Reset (0 = active) */
 #define GCR_GIE		(1 << 0)	/* Codec GPI Interrupt Enable */

-#define POSR		__REG(0x40500010)  /* PCM Out Status Register */
+#define POSR		AC97_REG(0x0010)  /* PCM Out Status Register */
 #define POSR_FIFOE	(1 << 4)	/* FIFO error */
 #define POSR_FSR	(1 << 2)	/* FIFO Service Request */

-#define PISR		__REG(0x40500014)  /* PCM In Status Register */
+#define PISR		AC97_REG(0x0014)  /* PCM In Status Register */
 #define PISR_FIFOE	(1 << 4)	/* FIFO error */
 #define PISR_EOC	(1 << 3)	/* DMA End-of-Chain (exclusive clear) */
 #define PISR_FSR	(1 << 2)	/* FIFO Service Request */

-#define MCSR		__REG(0x40500018)  /* Mic In Status Register */
+#define MCSR		AC97_REG(0x0018)  /* Mic In Status Register */
 #define MCSR_FIFOE	(1 << 4)	/* FIFO error */
 #define MCSR_EOC	(1 << 3)	/* DMA End-of-Chain (exclusive clear) */
 #define MCSR_FSR	(1 << 2)	/* FIFO Service Request */

-#define GSR		__REG(0x4050001C)  /* Global Status Register */
+#define GSR		AC97_REG(0x001C)  /* Global Status Register */
 #define GSR_CDONE	(1 << 19)	/* Command Done */
 #define GSR_SDONE	(1 << 18)	/* Status Done */
 #define GSR_RDCS	(1 << 15)	/* Read Completion Status */
@@ -68,34 +68,34 @@
 #define GSR_MIINT	(1 << 1)	/* Modem In Interrupt */
 #define GSR_GSCI	(1 << 0)	/* Codec GPI Status Change Interrupt */

-#define CAR		__REG(0x40500020)  /* CODEC Access Register */
+#define CAR		AC97_REG(0x0020)  /* CODEC Access Register */
 #define CAR_CAIP	(1 << 0)	/* Codec Access In Progress */

-#define PCDR		__REG(0x40500040)  /* PCM FIFO Data Register */
-#define MCDR		__REG(0x40500060)  /* Mic-in FIFO Data Register */
+#define PCDR		AC97_REG(0x0040)  /* PCM FIFO Data Register */
+#define MCDR		AC97_REG(0x0060)  /* Mic-in FIFO Data Register */

-#define MOCR		__REG(0x40500100)  /* Modem Out Control Register */
+#define MOCR		AC97_REG(0x0100)  /* Modem Out Control Register */
 #define MOCR_FEIE	(1 << 3)	/* FIFO Error */
 #define MOCR_FSRIE	(1 << 1)	/* FIFO Service Request Interrupt Enable */

-#define MICR		__REG(0x40500108)  /* Modem In Control Register */
+#define MICR		AC97_REG(0x0108)  /* Modem In Control Register */
 #define MICR_FEIE	(1 << 3)	/* FIFO Error */
 #define MICR_FSRIE	(1 << 1)	/* FIFO Service Request Interrupt Enable */

-#define MOSR		__REG(0x40500110)  /* Modem Out Status Register */
+#define MOSR		AC97_REG(0x0110)  /* Modem Out Status Register */
 #define MOSR_FIFOE	(1 << 4)	/* FIFO error */
 #define MOSR_FSR	(1 << 2)	/* FIFO Service Request */

-#define MISR		__REG(0x40500118)  /* Modem In Status Register */
+#define MISR		AC97_REG(0x0118)  /* Modem In Status Register */
 #define MISR_FIFOE	(1 << 4)	/* FIFO error */
 #define MISR_EOC	(1 << 3)	/* DMA End-of-Chain (exclusive clear) */
 #define MISR_FSR	(1 << 2)	/* FIFO Service Request */

-#define MODR		__REG(0x40500140)  /* Modem FIFO Data Register */
+#define MODR		AC97_REG(0x0140)  /* Modem FIFO Data Register */

-#define PAC_REG_BASE	__REG(0x40500200)  /* Primary Audio Codec */
-#define SAC_REG_BASE	__REG(0x40500300)  /* Secondary Audio Codec */
-#define PMC_REG_BASE	__REG(0x40500400)  /* Primary Modem Codec */
-#define SMC_REG_BASE	__REG(0x40500500)  /* Secondary Modem Codec */
+#define PAC_REG_BASE	AC97_REG(0x0200)  /* Primary Audio Codec */
+#define SAC_REG_BASE	AC97_REG(0x0300)  /* Secondary Audio Codec */
+#define PMC_REG_BASE	AC97_REG(0x0400)  /* Primary Modem Codec */
+#define SMC_REG_BASE	AC97_REG(0x0500)  /* Secondary Modem Codec */

 #endif /* __ASM_ARCH_REGS_AC97_H */
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 246d0a1..4b66545 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -43,7 +43,7 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_out = {
 	.name			= "AC97 PCM out",
 	.dev_addr		= __PREG(PCDR),
-	.drcmr			= &DRCMR(12),
+	.drcmr			= &DRCMR(AC97_AUDIO_TX),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST32 | DCMD_WIDTH4,
 };
@@ -51,7 +51,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_out = {
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_in = {
 	.name			= "AC97 PCM in",
 	.dev_addr		= __PREG(PCDR),
-	.drcmr			= &DRCMR(11),
+	.drcmr			= &DRCMR(AC97_AUDIO_RX),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST32 | DCMD_WIDTH4,
 };
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 173c476..abb735c 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -51,7 +51,7 @@ struct snd_ac97_bus_ops soc_ac97_ops = {
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_stereo_out = {
 	.name			= "AC97 PCM Stereo out",
 	.dev_addr		= __PREG(PCDR),
-	.drcmr			= &DRCMR(12),
+	.drcmr			= &DRCMR(AC97_AUDIO_TX),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST32 | DCMD_WIDTH4,
 };
@@ -59,7 +59,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_stereo_out = {
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_stereo_in = {
 	.name			= "AC97 PCM Stereo in",
 	.dev_addr		= __PREG(PCDR),
-	.drcmr			= &DRCMR(11),
+	.drcmr			= &DRCMR(AC97_AUDIO_RX),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST32 | DCMD_WIDTH4,
 };
@@ -67,7 +67,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_stereo_in = {
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_aux_mono_out = {
 	.name			= "AC97 Aux PCM (Slot 5) Mono out",
 	.dev_addr		= __PREG(MODR),
-	.drcmr			= &DRCMR(10),
+	.drcmr			= &DRCMR(AC97_MODEM_TX),
 	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -75,7 +75,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_aux_mono_out = {
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_aux_mono_in = {
 	.name			= "AC97 Aux PCM (Slot 5) Mono in",
 	.dev_addr		= __PREG(MODR),
-	.drcmr			= &DRCMR(9),
+	.drcmr			= &DRCMR(AC97_MODEM_RX),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
@@ -83,7 +83,7 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_aux_mono_in = {
 static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_mic_mono_in = {
 	.name			= "AC97 Mic PCM (Slot 6) Mono in",
 	.dev_addr		= __PREG(MCDR),
-	.drcmr			= &DRCMR(8),
+	.drcmr			= &DRCMR(AC97_MIC),
 	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
 				  DCMD_BURST16 | DCMD_WIDTH2,
 };
-- 
1.6.3.3
