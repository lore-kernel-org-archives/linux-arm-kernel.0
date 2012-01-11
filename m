From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 11 Jan 2012 14:14:28 +1100
Subject: [PATCH 03/11] ep93xx: Move peripheral defines to local SoC header
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <1326251676-7593-4-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the AHB/APB peripheral defines to local SoC header since they are
only needed by the core SoC code. The UART defines are not moved
because they are used by the mach/uncompress.h header.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/core.c                     |    1 +
 arch/arm/mach-ep93xx/dma.c                      |    2 +
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   57 +----------------------
 arch/arm/mach-ep93xx/soc.h                      |   54 +++++++++++++++++++++
 4 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 2432a6b..dcb10c2 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -46,6 +46,7 @@
 
 #include <asm/hardware/vic.h>
 
+#include "soc.h"
 
 /*************************************************************************
  * Static I/O mappings that are needed for all EP93xx platforms
diff --git a/arch/arm/mach-ep93xx/dma.c b/arch/arm/mach-ep93xx/dma.c
index 5a25708..16976d7 100644
--- a/arch/arm/mach-ep93xx/dma.c
+++ b/arch/arm/mach-ep93xx/dma.c
@@ -28,6 +28,8 @@
 #include <mach/dma.h>
 #include <mach/hardware.h>
 
+#include "soc.h"
+
 #define DMA_CHANNEL(_name, _base, _irq) \
 	{ .name = (_name), .base = (_base), .irq = (_irq) }
 
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 72b8687..387f745 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -28,50 +28,7 @@
 #define EP93XX_APB_PHYS(x)		(EP93XX_APB_PHYS_BASE + (x))
 #define EP93XX_APB_IOMEM(x)		IOMEM(EP93XX_APB_VIRT_BASE + (x))
 
-
-/* AHB peripherals */
-#define EP93XX_DMA_BASE			EP93XX_AHB_IOMEM(0x00000000)
-
-#define EP93XX_ETHERNET_PHYS_BASE	EP93XX_AHB_PHYS(0x00010000)
-#define EP93XX_ETHERNET_BASE		EP93XX_AHB_IOMEM(0x00010000)
-
-#define EP93XX_USB_PHYS_BASE		EP93XX_AHB_PHYS(0x00020000)
-#define EP93XX_USB_BASE			EP93XX_AHB_IOMEM(0x00020000)
-
-#define EP93XX_RASTER_PHYS_BASE		EP93XX_AHB_PHYS(0x00030000)
-#define EP93XX_RASTER_BASE		EP93XX_AHB_IOMEM(0x00030000)
-
-#define EP93XX_GRAPHICS_ACCEL_BASE	EP93XX_AHB_IOMEM(0x00040000)
-
-#define EP93XX_SDRAM_CONTROLLER_BASE	EP93XX_AHB_IOMEM(0x00060000)
-
-#define EP93XX_PCMCIA_CONTROLLER_BASE	EP93XX_AHB_IOMEM(0x00080000)
-
-#define EP93XX_BOOT_ROM_BASE		EP93XX_AHB_IOMEM(0x00090000)
-
-#define EP93XX_IDE_BASE			EP93XX_AHB_IOMEM(0x000a0000)
-
-#define EP93XX_VIC1_BASE		EP93XX_AHB_IOMEM(0x000b0000)
-
-#define EP93XX_VIC2_BASE		EP93XX_AHB_IOMEM(0x000c0000)
-
-
-/* APB peripherals */
-#define EP93XX_TIMER_BASE		EP93XX_APB_IOMEM(0x00010000)
-
-#define EP93XX_I2S_PHYS_BASE		EP93XX_APB_PHYS(0x00020000)
-#define EP93XX_I2S_BASE			EP93XX_APB_IOMEM(0x00020000)
-
-#define EP93XX_SECURITY_BASE		EP93XX_APB_IOMEM(0x00030000)
-
-#define EP93XX_AAC_PHYS_BASE		EP93XX_APB_PHYS(0x00080000)
-#define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
-
-#define EP93XX_SPI_PHYS_BASE		EP93XX_APB_PHYS(0x000a0000)
-#define EP93XX_SPI_BASE			EP93XX_APB_IOMEM(0x000a0000)
-
-#define EP93XX_IRDA_BASE		EP93XX_APB_IOMEM(0x000b0000)
-
+/* APB UARTs */
 #define EP93XX_UART1_PHYS_BASE		EP93XX_APB_PHYS(0x000c0000)
 #define EP93XX_UART1_BASE		EP93XX_APB_IOMEM(0x000c0000)
 
@@ -81,18 +38,6 @@
 #define EP93XX_UART3_PHYS_BASE		EP93XX_APB_PHYS(0x000e0000)
 #define EP93XX_UART3_BASE		EP93XX_APB_IOMEM(0x000e0000)
 
-#define EP93XX_KEY_MATRIX_PHYS_BASE	EP93XX_APB_PHYS(0x000f0000)
-#define EP93XX_KEY_MATRIX_BASE		EP93XX_APB_IOMEM(0x000f0000)
-
-#define EP93XX_ADC_BASE			EP93XX_APB_IOMEM(0x00100000)
-#define EP93XX_TOUCHSCREEN_BASE		EP93XX_APB_IOMEM(0x00100000)
-
-#define EP93XX_PWM_PHYS_BASE		EP93XX_APB_PHYS(0x00110000)
-#define EP93XX_PWM_BASE			EP93XX_APB_IOMEM(0x00110000)
-
-#define EP93XX_RTC_PHYS_BASE		EP93XX_APB_PHYS(0x00120000)
-#define EP93XX_RTC_BASE			EP93XX_APB_IOMEM(0x00120000)
-
 #define EP93XX_SYSCON_BASE		EP93XX_APB_IOMEM(0x00130000)
 #define EP93XX_SYSCON_REG(x)		(EP93XX_SYSCON_BASE + (x))
 #define EP93XX_SYSCON_POWER_STATE	EP93XX_SYSCON_REG(0x00)
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index 74703e7..b0ef89b 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -47,4 +47,58 @@
 #define EP93XX_SDCE3_PHYS_BASE_ASYNC	0xf0000000	/* ASDO Pin = 0 */
 #define EP93XX_CS0_PHYS_BASE_SYNC	0xf0000000	/* ASDO Pin = 1 */
 
+/* AHB peripherals */
+#define EP93XX_DMA_BASE			EP93XX_AHB_IOMEM(0x00000000)
+
+#define EP93XX_ETHERNET_PHYS_BASE	EP93XX_AHB_PHYS(0x00010000)
+#define EP93XX_ETHERNET_BASE		EP93XX_AHB_IOMEM(0x00010000)
+
+#define EP93XX_USB_PHYS_BASE		EP93XX_AHB_PHYS(0x00020000)
+#define EP93XX_USB_BASE			EP93XX_AHB_IOMEM(0x00020000)
+
+#define EP93XX_RASTER_PHYS_BASE		EP93XX_AHB_PHYS(0x00030000)
+#define EP93XX_RASTER_BASE		EP93XX_AHB_IOMEM(0x00030000)
+
+#define EP93XX_GRAPHICS_ACCEL_BASE	EP93XX_AHB_IOMEM(0x00040000)
+
+#define EP93XX_SDRAM_CONTROLLER_BASE	EP93XX_AHB_IOMEM(0x00060000)
+
+#define EP93XX_PCMCIA_CONTROLLER_BASE	EP93XX_AHB_IOMEM(0x00080000)
+
+#define EP93XX_BOOT_ROM_BASE		EP93XX_AHB_IOMEM(0x00090000)
+
+#define EP93XX_IDE_BASE			EP93XX_AHB_IOMEM(0x000a0000)
+
+#define EP93XX_VIC1_BASE		EP93XX_AHB_IOMEM(0x000b0000)
+
+#define EP93XX_VIC2_BASE		EP93XX_AHB_IOMEM(0x000c0000)
+
+/* APB peripherals */
+#define EP93XX_TIMER_BASE		EP93XX_APB_IOMEM(0x00010000)
+
+#define EP93XX_I2S_PHYS_BASE		EP93XX_APB_PHYS(0x00020000)
+#define EP93XX_I2S_BASE			EP93XX_APB_IOMEM(0x00020000)
+
+#define EP93XX_SECURITY_BASE		EP93XX_APB_IOMEM(0x00030000)
+
+#define EP93XX_AAC_PHYS_BASE		EP93XX_APB_PHYS(0x00080000)
+#define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
+
+#define EP93XX_SPI_PHYS_BASE		EP93XX_APB_PHYS(0x000a0000)
+#define EP93XX_SPI_BASE			EP93XX_APB_IOMEM(0x000a0000)
+
+#define EP93XX_IRDA_BASE		EP93XX_APB_IOMEM(0x000b0000)
+
+#define EP93XX_KEY_MATRIX_PHYS_BASE	EP93XX_APB_PHYS(0x000f0000)
+#define EP93XX_KEY_MATRIX_BASE		EP93XX_APB_IOMEM(0x000f0000)
+
+#define EP93XX_ADC_BASE			EP93XX_APB_IOMEM(0x00100000)
+#define EP93XX_TOUCHSCREEN_BASE		EP93XX_APB_IOMEM(0x00100000)
+
+#define EP93XX_PWM_PHYS_BASE		EP93XX_APB_PHYS(0x00110000)
+#define EP93XX_PWM_BASE			EP93XX_APB_IOMEM(0x00110000)
+
+#define EP93XX_RTC_PHYS_BASE		EP93XX_APB_PHYS(0x00120000)
+#define EP93XX_RTC_BASE			EP93XX_APB_IOMEM(0x00120000)
+
 #endif /* _EP93XX_PHYS_BASE_H */
-- 
1.7.0.4
