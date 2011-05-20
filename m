From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Fri, 20 May 2011 19:44:01 +0530
Subject: [PATCH 4/4] davinci: create new common platform header for davinci
Message-ID: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove the code from individual platform header files for
dm365, dm355, dm644x and dm646x and consolidate it into a
single and common header file dmx.h.
Include the new header file in individual platform header
files as a pre-cursor for deleting these headers in follow
up patches.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |    6 ++-
 arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |    5 ++-
 arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |    2 +-
 arch/arm/mach-davinci/dm355.c               |    2 +-
 arch/arm/mach-davinci/dm365.c               |    2 +-
 arch/arm/mach-davinci/dm644x.c              |    2 +-
 arch/arm/mach-davinci/dm646x.c              |    2 +-
 arch/arm/mach-davinci/include/mach/dm355.h  |   32 -----------
 arch/arm/mach-davinci/include/mach/dm365.h  |   40 --------------
 arch/arm/mach-davinci/include/mach/dm644x.h |   40 --------------
 arch/arm/mach-davinci/include/mach/dmx.h    |   77 +++++++++++++++++++++++++++
 drivers/media/video/davinci/vpif.h          |    2 +-
 drivers/media/video/davinci/vpif_capture.h  |    1 +
 drivers/media/video/davinci/vpif_display.c  |    2 +-
 18 files changed, 98 insertions(+), 125 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm355.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm644x.h
 create mode 100644 arch/arm/mach-davinci/include/mach/dmx.h

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 6e7cad1..bcb2974 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -26,7 +26,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm355.h>
+#include <mach/dmx.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
 #include <mach/nand.h>
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 543f991..3694b32 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -23,7 +23,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm355.h>
+#include <mach/dmx.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
 #include <mach/nand.h>
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index c67f684..7be75b2 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -32,7 +32,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/mux.h>
-#include <mach/dm365.h>
+#include <mach/dmx.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
@@ -143,6 +143,10 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.ecc_bits		= 4,
 };
 
+#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01D10000
+#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
+#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000
+
 static struct resource davinci_nand_resources[] = {
 	{
 		.start		= DM365_ASYNC_EMIF_DATA_CE0_BASE,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 0ca90b8..c365458 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -29,7 +29,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm644x.h>
+#include <mach/dmx.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index f6ac9ba..73497a6 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -35,7 +35,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm646x.h>
+#include <mach/dmx.h>
 #include <mach/common.h>
 #include <mach/serial.h>
 #include <mach/i2c.h>
@@ -91,6 +91,9 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.options		= 0,
 };
 
+#define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
+#define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
+
 static struct resource davinci_nand_resources[] = {
 	{
 		.start		= DM646X_ASYNC_EMIF_CS2_SPACE_BASE,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 6c389ff..52b30c8 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -30,7 +30,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm644x.h>
+#include <mach/dmx.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 61ac96d..16c96a5 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -35,7 +35,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
-#include <mach/dm644x.h>
+#include <mach/dmx.h>
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a5f8a80..36cf3bb 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -19,7 +19,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/dm355.h>
+#include <mach/dmx.h>
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/psc.h>
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 7e2464e..54f6aaf 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -22,7 +22,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/dm365.h>
+#include <mach/dmx.h>
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/psc.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 4fbb250..3efcdef 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -16,7 +16,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/dm644x.h>
+#include <mach/dmx.h>
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 9efa380..015c59f 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -16,7 +16,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/dm646x.h>
+#include <mach/dmx.h>
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/include/mach/dm355.h b/arch/arm/mach-davinci/include/mach/dm355.h
deleted file mode 100644
index 36dff4a..0000000
--- a/arch/arm/mach-davinci/include/mach/dm355.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Chip specific defines for DM355 SoC
- *
- * Author: Kevin Hilman, Deep Root Systems, LLC
- *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_ARCH_DM355_H
-#define __ASM_ARCH_DM355_H
-
-#include <mach/hardware.h>
-#include <mach/asp.h>
-#include <media/davinci/vpfe_capture.h>
-
-#define DM355_ASYNC_EMIF_CONTROL_BASE	0x01E10000
-#define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-
-#define ASP1_TX_EVT_EN	1
-#define ASP1_RX_EVT_EN	2
-
-struct spi_board_info;
-
-void __init dm355_init(void);
-void dm355_init_spi0(unsigned chipselect_mask,
-		struct spi_board_info *info, unsigned len);
-void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata);
-void dm355_set_vpfe_config(struct vpfe_config *cfg);
-
-#endif /* __ASM_ARCH_DM355_H */
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
deleted file mode 100644
index c3c69a6..0000000
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments Incorporated
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __ASM_ARCH_DM365_H
-#define __ASM_ARCH_DM665_H
-
-#include <linux/platform_device.h>
-#include <linux/davinci_emac.h>
-#include <mach/hardware.h>
-#include <mach/asp.h>
-#include <mach/keyscan.h>
-#include <media/davinci/vpfe_capture.h>
-
-#define DAVINCI_DM365_VC_BASE		(0x01D0C000)
-#define DAVINCI_DMA_VC_TX		2
-#define DAVINCI_DMA_VC_RX		3
-
-#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01D10000
-#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000
-
-void __init dm365_init(void);
-void __init dm365_init_asp(struct snd_platform_data *pdata);
-void __init dm365_init_vc(struct snd_platform_data *pdata);
-void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
-void __init dm365_init_rtc(void);
-void dm365_init_spi0(unsigned chipselect_mask,
-			struct spi_board_info *info, unsigned len);
-
-void dm365_set_vpfe_config(struct vpfe_config *cfg);
-#endif /* __ASM_ARCH_DM365_H */
diff --git a/arch/arm/mach-davinci/include/mach/dm644x.h b/arch/arm/mach-davinci/include/mach/dm644x.h
deleted file mode 100644
index 724377f..0000000
--- a/arch/arm/mach-davinci/include/mach/dm644x.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * This file contains the processor specific definitions
- * of the TI DM644x.
- *
- * Copyright (C) 2008 Texas Instruments.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
-#ifndef __ASM_ARCH_DM644X_H
-#define __ASM_ARCH_DM644X_H
-
-#include <linux/davinci_emac.h>
-#include <mach/hardware.h>
-#include <mach/asp.h>
-#include <media/davinci/vpfe_capture.h>
-
-#define DM644X_ASYNC_EMIF_CONTROL_BASE	0x01E00000
-#define DM644X_ASYNC_EMIF_DATA_CE0_BASE 0x02000000
-#define DM644X_ASYNC_EMIF_DATA_CE1_BASE 0x04000000
-#define DM644X_ASYNC_EMIF_DATA_CE2_BASE 0x06000000
-#define DM644X_ASYNC_EMIF_DATA_CE3_BASE 0x08000000
-
-void __init dm644x_init(void);
-void __init dm644x_init_asp(struct snd_platform_data *pdata);
-void dm644x_set_vpfe_config(struct vpfe_config *cfg);
-
-#endif /* __ASM_ARCH_DM644X_H */
diff --git a/arch/arm/mach-davinci/include/mach/dmx.h b/arch/arm/mach-davinci/include/mach/dmx.h
new file mode 100644
index 0000000..67b1671
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/dmx.h
@@ -0,0 +1,77 @@
+/*
+ * This file contains the processor specific definitions
+ * of the TI DM644x, DM355, DM365, and DM646x.
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __DMX_H
+#define __DMX_H
+
+#include <mach/asp.h>
+#include <linux/clk.h>
+#include <mach/keyscan.h>
+#include <linux/davinci_emac.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_device.h>
+#include <media/davinci/vpfe_capture.h>
+#include <media/davinci/vpif_types.h>
+
+/* DM355 base addresses */
+#define DM355_ASYNC_EMIF_CONTROL_BASE	0x01E10000
+#define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
+
+#define ASP1_TX_EVT_EN	1
+#define ASP1_RX_EVT_EN	2
+
+/* DM644x base addresses */
+#define DM644X_ASYNC_EMIF_CONTROL_BASE	0x01E00000
+#define DM644X_ASYNC_EMIF_DATA_CE0_BASE 0x02000000
+#define DM644X_ASYNC_EMIF_DATA_CE1_BASE 0x04000000
+#define DM644X_ASYNC_EMIF_DATA_CE2_BASE 0x06000000
+#define DM644X_ASYNC_EMIF_DATA_CE3_BASE 0x08000000
+
+/* DM355 function declarations */
+struct spi_board_info;
+
+void dm355_init(void);
+void dm355_init_spi0(unsigned chipselect_mask,
+		struct spi_board_info *info, unsigned len);
+void dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata);
+void dm355_set_vpfe_config(struct vpfe_config *cfg);
+
+/* DM365 function declarations */
+void dm365_init(void);
+void dm365_init_asp(struct snd_platform_data *pdata);
+void dm365_init_vc(struct snd_platform_data *pdata);
+void dm365_init_ks(struct davinci_ks_platform_data *pdata);
+void dm365_init_rtc(void);
+void dm365_init_spi0(unsigned chipselect_mask,
+			struct spi_board_info *info, unsigned len);
+void dm365_set_vpfe_config(struct vpfe_config *cfg);
+
+/* DM644X function declarations */
+void dm644x_init(void);
+void dm644x_init_asp(struct snd_platform_data *pdata);
+void dm644x_set_vpfe_config(struct vpfe_config *cfg);
+
+/* DM646X function declarations */
+void dm646x_init(void);
+void dm646x_init_mcasp0(struct snd_platform_data *pdata);
+void dm646x_init_mcasp1(struct snd_platform_data *pdata);
+void dm646x_board_setup_refclk(struct clk *clk);
+int dm646x_init_edma(struct edma_rsv_info *rsv);
+
+void dm646x_video_init(void);
+
+void dm646x_setup_vpif(struct vpif_display_config *,
+		       struct vpif_capture_config *);
+#endif /*__DMX_H */
diff --git a/drivers/media/video/davinci/vpif.h b/drivers/media/video/davinci/vpif.h
index e76dded..5949e64 100644
--- a/drivers/media/video/davinci/vpif.h
+++ b/drivers/media/video/davinci/vpif.h
@@ -19,7 +19,7 @@
 #include <linux/io.h>
 #include <linux/videodev2.h>
 #include <mach/hardware.h>
-#include <mach/dm646x.h>
+#include <mach/dmx.h>
 #include <media/davinci/vpif.h>
 
 /* Maximum channel allowed */
diff --git a/drivers/media/video/davinci/vpif_capture.h b/drivers/media/video/davinci/vpif_capture.h
index fa50b6b..cafa762 100644
--- a/drivers/media/video/davinci/vpif_capture.h
+++ b/drivers/media/video/davinci/vpif_capture.h
@@ -28,6 +28,7 @@
 #include <media/v4l2-device.h>
 #include <media/videobuf-core.h>
 #include <media/videobuf-dma-contig.h>
+#include <mach/dmx.h>
 #include <media/davinci/vpif.h>
 
 #include "vpif.h"
diff --git a/drivers/media/video/davinci/vpif_display.c b/drivers/media/video/davinci/vpif_display.c
index cdf659a..a7d8bc8 100644
--- a/drivers/media/video/davinci/vpif_display.c
+++ b/drivers/media/video/davinci/vpif_display.c
@@ -40,7 +40,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-chip-ident.h>
 
-#include <mach/dm646x.h>
+#include <mach/dmx.h>
 
 #include "vpif_display.h"
 #include "vpif.h"
-- 
1.6.2.4
