From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:27 +0100
Subject: [PATCH 17/23] ASoC: samsung: move plat/ headers to local directory
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-18-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The plat/iis.h and plat/ac97.h files in the samsung platform are
only needed by the ASoC drivers, so they can be moved into the
same directory, as one more step towards a multiplatform build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/dma-s3c2410.c            |  2 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c            |  2 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c            |  2 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c            |  2 -
 arch/arm/plat-samsung/include/plat/regs-ac97.h | 67 ------------------------
 arch/arm/plat-samsung/include/plat/regs-iis.h  | 70 --------------------------
 sound/soc/samsung/ac97.c                       |  2 +-
 sound/soc/samsung/h1940_uda1380.c              |  2 +-
 sound/soc/samsung/neo1973_wm8753.c             |  2 +-
 sound/soc/samsung/regs-ac97.h                  | 67 ++++++++++++++++++++++++
 sound/soc/samsung/regs-iis.h                   | 70 ++++++++++++++++++++++++++
 sound/soc/samsung/rx1950_uda1380.c             |  2 +-
 sound/soc/samsung/s3c24xx-i2s.c                |  2 +-
 sound/soc/samsung/s3c24xx_uda134x.c            |  2 +-
 14 files changed, 143 insertions(+), 151 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-ac97.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-iis.h
 create mode 100644 sound/soc/samsung/regs-ac97.h
 create mode 100644 sound/soc/samsung/regs-iis.h

diff --git a/arch/arm/mach-s3c24xx/dma-s3c2410.c b/arch/arm/mach-s3c24xx/dma-s3c2410.c
index 25d085a..a4a13c9 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2410.c
@@ -25,11 +25,9 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <plat/regs-ac97.h>
 #include <plat/regs-dma.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
 static struct s3c24xx_dma_map __initdata s3c2410_dma_mappings[] = {
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2412.c b/arch/arm/mach-s3c24xx/dma-s3c2412.c
index d2408ba..6eaa7a4 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2412.c
@@ -25,11 +25,9 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <plat/regs-ac97.h>
 #include <plat/regs-dma.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
 #define MAP(x) { (x)| DMA_CH_VALID, (x)| DMA_CH_VALID, (x)| DMA_CH_VALID, (x)| DMA_CH_VALID }
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2440.c b/arch/arm/mach-s3c24xx/dma-s3c2440.c
index 0b86e74..477d450 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2440.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2440.c
@@ -25,11 +25,9 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <plat/regs-ac97.h>
 #include <plat/regs-dma.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
 static struct s3c24xx_dma_map __initdata s3c2440_dma_mappings[] = {
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2443.c b/arch/arm/mach-s3c24xx/dma-s3c2443.c
index 0553625..80a8d56 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2443.c
@@ -25,11 +25,9 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <plat/regs-ac97.h>
 #include <plat/regs-dma.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
 #define MAP(x) { \
diff --git a/arch/arm/plat-samsung/include/plat/regs-ac97.h b/arch/arm/plat-samsung/include/plat/regs-ac97.h
deleted file mode 100644
index c3878f7..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-ac97.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-ac97.h
- *
- * Copyright (c) 2006 Simtec Electronics <linux@simtec.co.uk>
- *		http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2440 AC97 Controller
-*/
-
-#ifndef __ASM_ARCH_REGS_AC97_H
-#define __ASM_ARCH_REGS_AC97_H __FILE__
-
-#define S3C_AC97_GLBCTRL				(0x00)
-
-#define S3C_AC97_GLBCTRL_CODECREADYIE			(1<<22)
-#define S3C_AC97_GLBCTRL_PCMOUTURIE			(1<<21)
-#define S3C_AC97_GLBCTRL_PCMINORIE			(1<<20)
-#define S3C_AC97_GLBCTRL_MICINORIE			(1<<19)
-#define S3C_AC97_GLBCTRL_PCMOUTTIE			(1<<18)
-#define S3C_AC97_GLBCTRL_PCMINTIE			(1<<17)
-#define S3C_AC97_GLBCTRL_MICINTIE			(1<<16)
-#define S3C_AC97_GLBCTRL_PCMOUTTM_OFF			(0<<12)
-#define S3C_AC97_GLBCTRL_PCMOUTTM_PIO			(1<<12)
-#define S3C_AC97_GLBCTRL_PCMOUTTM_DMA			(2<<12)
-#define S3C_AC97_GLBCTRL_PCMOUTTM_MASK			(3<<12)
-#define S3C_AC97_GLBCTRL_PCMINTM_OFF			(0<<10)
-#define S3C_AC97_GLBCTRL_PCMINTM_PIO			(1<<10)
-#define S3C_AC97_GLBCTRL_PCMINTM_DMA			(2<<10)
-#define S3C_AC97_GLBCTRL_PCMINTM_MASK			(3<<10)
-#define S3C_AC97_GLBCTRL_MICINTM_OFF			(0<<8)
-#define S3C_AC97_GLBCTRL_MICINTM_PIO			(1<<8)
-#define S3C_AC97_GLBCTRL_MICINTM_DMA			(2<<8)
-#define S3C_AC97_GLBCTRL_MICINTM_MASK			(3<<8)
-#define S3C_AC97_GLBCTRL_TRANSFERDATAENABLE		(1<<3)
-#define S3C_AC97_GLBCTRL_ACLINKON			(1<<2)
-#define S3C_AC97_GLBCTRL_WARMRESET			(1<<1)
-#define S3C_AC97_GLBCTRL_COLDRESET			(1<<0)
-
-#define S3C_AC97_GLBSTAT				(0x04)
-
-#define S3C_AC97_GLBSTAT_CODECREADY			(1<<22)
-#define S3C_AC97_GLBSTAT_PCMOUTUR			(1<<21)
-#define S3C_AC97_GLBSTAT_PCMINORI			(1<<20)
-#define S3C_AC97_GLBSTAT_MICINORI			(1<<19)
-#define S3C_AC97_GLBSTAT_PCMOUTTI			(1<<18)
-#define S3C_AC97_GLBSTAT_PCMINTI			(1<<17)
-#define S3C_AC97_GLBSTAT_MICINTI			(1<<16)
-#define S3C_AC97_GLBSTAT_MAINSTATE_IDLE			(0<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_INIT			(1<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_READY		(2<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE		(3<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_LP			(4<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_WARM			(5<<0)
-
-#define S3C_AC97_CODEC_CMD				(0x08)
-
-#define S3C_AC97_CODEC_CMD_READ				(1<<23)
-
-#define S3C_AC97_STAT					(0x0c)
-#define S3C_AC97_PCM_ADDR				(0x10)
-#define S3C_AC97_PCM_DATA				(0x18)
-#define S3C_AC97_MIC_DATA				(0x1C)
-
-#endif /* __ASM_ARCH_REGS_AC97_H */
diff --git a/arch/arm/plat-samsung/include/plat/regs-iis.h b/arch/arm/plat-samsung/include/plat/regs-iis.h
deleted file mode 100644
index a18d35e..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-iis.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* arch/arm/plat-samsung/include/plat/regs-iis.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 IIS register definition
-*/
-
-#ifndef __ASM_ARCH_REGS_IIS_H
-#define __ASM_ARCH_REGS_IIS_H
-
-#define S3C2410_IISCON			(0x00)
-
-#define S3C2410_IISCON_LRINDEX		(1 << 8)
-#define S3C2410_IISCON_TXFIFORDY	(1 << 7)
-#define S3C2410_IISCON_RXFIFORDY	(1 << 6)
-#define S3C2410_IISCON_TXDMAEN		(1 << 5)
-#define S3C2410_IISCON_RXDMAEN		(1 << 4)
-#define S3C2410_IISCON_TXIDLE		(1 << 3)
-#define S3C2410_IISCON_RXIDLE		(1 << 2)
-#define S3C2410_IISCON_PSCEN		(1 << 1)
-#define S3C2410_IISCON_IISEN		(1 << 0)
-
-#define S3C2410_IISMOD			(0x04)
-
-#define S3C2440_IISMOD_MPLL		(1 << 9)
-#define S3C2410_IISMOD_SLAVE		(1 << 8)
-#define S3C2410_IISMOD_NOXFER		(0 << 6)
-#define S3C2410_IISMOD_RXMODE		(1 << 6)
-#define S3C2410_IISMOD_TXMODE		(2 << 6)
-#define S3C2410_IISMOD_TXRXMODE		(3 << 6)
-#define S3C2410_IISMOD_LR_LLOW		(0 << 5)
-#define S3C2410_IISMOD_LR_RLOW		(1 << 5)
-#define S3C2410_IISMOD_IIS		(0 << 4)
-#define S3C2410_IISMOD_MSB		(1 << 4)
-#define S3C2410_IISMOD_8BIT		(0 << 3)
-#define S3C2410_IISMOD_16BIT		(1 << 3)
-#define S3C2410_IISMOD_BITMASK		(1 << 3)
-#define S3C2410_IISMOD_256FS		(0 << 2)
-#define S3C2410_IISMOD_384FS		(1 << 2)
-#define S3C2410_IISMOD_16FS		(0 << 0)
-#define S3C2410_IISMOD_32FS		(1 << 0)
-#define S3C2410_IISMOD_48FS		(2 << 0)
-#define S3C2410_IISMOD_FS_MASK		(3 << 0)
-
-#define S3C2410_IISPSR			(0x08)
-
-#define S3C2410_IISPSR_INTMASK		(31 << 5)
-#define S3C2410_IISPSR_INTSHIFT		(5)
-#define S3C2410_IISPSR_EXTMASK		(31 << 0)
-#define S3C2410_IISPSR_EXTSHFIT		(0)
-
-#define S3C2410_IISFCON			(0x0c)
-
-#define S3C2410_IISFCON_TXDMA		(1 << 15)
-#define S3C2410_IISFCON_RXDMA		(1 << 14)
-#define S3C2410_IISFCON_TXENABLE	(1 << 13)
-#define S3C2410_IISFCON_RXENABLE	(1 << 12)
-#define S3C2410_IISFCON_TXMASK		(0x3f << 6)
-#define S3C2410_IISFCON_TXSHIFT		(6)
-#define S3C2410_IISFCON_RXMASK		(0x3f)
-#define S3C2410_IISFCON_RXSHIFT		(0)
-
-#define S3C2410_IISFIFO			(0x10)
-
-#endif /* __ASM_ARCH_REGS_IIS_H */
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 0df3c56..c76abdf 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -20,7 +20,7 @@
 #include <sound/soc.h>
 
 #include <mach/dma.h>
-#include <plat/regs-ac97.h>
+#include "regs-ac97.h"
 #include <linux/platform_data/asoc-s3c.h>
 
 #include "dma.h"
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 15a3817..fa91376 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -20,7 +20,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include <plat/regs-iis.h>
+#include "regs-iis.h"
 #include <asm/mach-types.h>
 
 #include "s3c24xx-i2s.h"
diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index a301d8c..ccc601d 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -21,7 +21,7 @@
 #include <sound/soc.h>
 
 #include <asm/mach-types.h>
-#include <plat/regs-iis.h>
+#include "regs-iis.h"
 #include <mach/gta02.h>
 
 #include "../codecs/wm8753.h"
diff --git a/sound/soc/samsung/regs-ac97.h b/sound/soc/samsung/regs-ac97.h
new file mode 100644
index 0000000..c3878f7
--- /dev/null
+++ b/sound/soc/samsung/regs-ac97.h
@@ -0,0 +1,67 @@
+/* arch/arm/mach-s3c2410/include/mach/regs-ac97.h
+ *
+ * Copyright (c) 2006 Simtec Electronics <linux@simtec.co.uk>
+ *		http://www.simtec.co.uk/products/SWLINUX/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2440 AC97 Controller
+*/
+
+#ifndef __ASM_ARCH_REGS_AC97_H
+#define __ASM_ARCH_REGS_AC97_H __FILE__
+
+#define S3C_AC97_GLBCTRL				(0x00)
+
+#define S3C_AC97_GLBCTRL_CODECREADYIE			(1<<22)
+#define S3C_AC97_GLBCTRL_PCMOUTURIE			(1<<21)
+#define S3C_AC97_GLBCTRL_PCMINORIE			(1<<20)
+#define S3C_AC97_GLBCTRL_MICINORIE			(1<<19)
+#define S3C_AC97_GLBCTRL_PCMOUTTIE			(1<<18)
+#define S3C_AC97_GLBCTRL_PCMINTIE			(1<<17)
+#define S3C_AC97_GLBCTRL_MICINTIE			(1<<16)
+#define S3C_AC97_GLBCTRL_PCMOUTTM_OFF			(0<<12)
+#define S3C_AC97_GLBCTRL_PCMOUTTM_PIO			(1<<12)
+#define S3C_AC97_GLBCTRL_PCMOUTTM_DMA			(2<<12)
+#define S3C_AC97_GLBCTRL_PCMOUTTM_MASK			(3<<12)
+#define S3C_AC97_GLBCTRL_PCMINTM_OFF			(0<<10)
+#define S3C_AC97_GLBCTRL_PCMINTM_PIO			(1<<10)
+#define S3C_AC97_GLBCTRL_PCMINTM_DMA			(2<<10)
+#define S3C_AC97_GLBCTRL_PCMINTM_MASK			(3<<10)
+#define S3C_AC97_GLBCTRL_MICINTM_OFF			(0<<8)
+#define S3C_AC97_GLBCTRL_MICINTM_PIO			(1<<8)
+#define S3C_AC97_GLBCTRL_MICINTM_DMA			(2<<8)
+#define S3C_AC97_GLBCTRL_MICINTM_MASK			(3<<8)
+#define S3C_AC97_GLBCTRL_TRANSFERDATAENABLE		(1<<3)
+#define S3C_AC97_GLBCTRL_ACLINKON			(1<<2)
+#define S3C_AC97_GLBCTRL_WARMRESET			(1<<1)
+#define S3C_AC97_GLBCTRL_COLDRESET			(1<<0)
+
+#define S3C_AC97_GLBSTAT				(0x04)
+
+#define S3C_AC97_GLBSTAT_CODECREADY			(1<<22)
+#define S3C_AC97_GLBSTAT_PCMOUTUR			(1<<21)
+#define S3C_AC97_GLBSTAT_PCMINORI			(1<<20)
+#define S3C_AC97_GLBSTAT_MICINORI			(1<<19)
+#define S3C_AC97_GLBSTAT_PCMOUTTI			(1<<18)
+#define S3C_AC97_GLBSTAT_PCMINTI			(1<<17)
+#define S3C_AC97_GLBSTAT_MICINTI			(1<<16)
+#define S3C_AC97_GLBSTAT_MAINSTATE_IDLE			(0<<0)
+#define S3C_AC97_GLBSTAT_MAINSTATE_INIT			(1<<0)
+#define S3C_AC97_GLBSTAT_MAINSTATE_READY		(2<<0)
+#define S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE		(3<<0)
+#define S3C_AC97_GLBSTAT_MAINSTATE_LP			(4<<0)
+#define S3C_AC97_GLBSTAT_MAINSTATE_WARM			(5<<0)
+
+#define S3C_AC97_CODEC_CMD				(0x08)
+
+#define S3C_AC97_CODEC_CMD_READ				(1<<23)
+
+#define S3C_AC97_STAT					(0x0c)
+#define S3C_AC97_PCM_ADDR				(0x10)
+#define S3C_AC97_PCM_DATA				(0x18)
+#define S3C_AC97_MIC_DATA				(0x1C)
+
+#endif /* __ASM_ARCH_REGS_AC97_H */
diff --git a/sound/soc/samsung/regs-iis.h b/sound/soc/samsung/regs-iis.h
new file mode 100644
index 0000000..a18d35e
--- /dev/null
+++ b/sound/soc/samsung/regs-iis.h
@@ -0,0 +1,70 @@
+/* arch/arm/plat-samsung/include/plat/regs-iis.h
+ *
+ * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
+ *		      http://www.simtec.co.uk/products/SWLINUX/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2410 IIS register definition
+*/
+
+#ifndef __ASM_ARCH_REGS_IIS_H
+#define __ASM_ARCH_REGS_IIS_H
+
+#define S3C2410_IISCON			(0x00)
+
+#define S3C2410_IISCON_LRINDEX		(1 << 8)
+#define S3C2410_IISCON_TXFIFORDY	(1 << 7)
+#define S3C2410_IISCON_RXFIFORDY	(1 << 6)
+#define S3C2410_IISCON_TXDMAEN		(1 << 5)
+#define S3C2410_IISCON_RXDMAEN		(1 << 4)
+#define S3C2410_IISCON_TXIDLE		(1 << 3)
+#define S3C2410_IISCON_RXIDLE		(1 << 2)
+#define S3C2410_IISCON_PSCEN		(1 << 1)
+#define S3C2410_IISCON_IISEN		(1 << 0)
+
+#define S3C2410_IISMOD			(0x04)
+
+#define S3C2440_IISMOD_MPLL		(1 << 9)
+#define S3C2410_IISMOD_SLAVE		(1 << 8)
+#define S3C2410_IISMOD_NOXFER		(0 << 6)
+#define S3C2410_IISMOD_RXMODE		(1 << 6)
+#define S3C2410_IISMOD_TXMODE		(2 << 6)
+#define S3C2410_IISMOD_TXRXMODE		(3 << 6)
+#define S3C2410_IISMOD_LR_LLOW		(0 << 5)
+#define S3C2410_IISMOD_LR_RLOW		(1 << 5)
+#define S3C2410_IISMOD_IIS		(0 << 4)
+#define S3C2410_IISMOD_MSB		(1 << 4)
+#define S3C2410_IISMOD_8BIT		(0 << 3)
+#define S3C2410_IISMOD_16BIT		(1 << 3)
+#define S3C2410_IISMOD_BITMASK		(1 << 3)
+#define S3C2410_IISMOD_256FS		(0 << 2)
+#define S3C2410_IISMOD_384FS		(1 << 2)
+#define S3C2410_IISMOD_16FS		(0 << 0)
+#define S3C2410_IISMOD_32FS		(1 << 0)
+#define S3C2410_IISMOD_48FS		(2 << 0)
+#define S3C2410_IISMOD_FS_MASK		(3 << 0)
+
+#define S3C2410_IISPSR			(0x08)
+
+#define S3C2410_IISPSR_INTMASK		(31 << 5)
+#define S3C2410_IISPSR_INTSHIFT		(5)
+#define S3C2410_IISPSR_EXTMASK		(31 << 0)
+#define S3C2410_IISPSR_EXTSHFIT		(0)
+
+#define S3C2410_IISFCON			(0x0c)
+
+#define S3C2410_IISFCON_TXDMA		(1 << 15)
+#define S3C2410_IISFCON_RXDMA		(1 << 14)
+#define S3C2410_IISFCON_TXENABLE	(1 << 13)
+#define S3C2410_IISFCON_RXENABLE	(1 << 12)
+#define S3C2410_IISFCON_TXMASK		(0x3f << 6)
+#define S3C2410_IISFCON_TXSHIFT		(6)
+#define S3C2410_IISFCON_RXMASK		(0x3f)
+#define S3C2410_IISFCON_RXSHIFT		(0)
+
+#define S3C2410_IISFIFO			(0x10)
+
+#endif /* __ASM_ARCH_REGS_IIS_H */
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index a5826ea..704460a 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -24,7 +24,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include <plat/regs-iis.h>
+#include "regs-iis.h"
 #include <asm/mach-types.h>
 
 #include "s3c24xx-i2s.h"
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 13f6dd1..a7b17c1 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -24,7 +24,7 @@
 #include <sound/pcm_params.h>
 
 #include <mach/dma.h>
-#include <plat/regs-iis.h>
+#include "regs-iis.h"
 
 #include "dma.h"
 #include "s3c24xx-i2s.h"
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 333e1b7..1b7b52b 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -18,7 +18,7 @@
 #include <sound/soc.h>
 #include <sound/s3c24xx_uda134x.h>
 
-#include <plat/regs-iis.h>
+#include "regs-iis.h"
 
 #include "s3c24xx-i2s.h"
 
-- 
1.8.1.2
