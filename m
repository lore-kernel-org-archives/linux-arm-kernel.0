From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 27 Apr 2012 10:15:45 +0200
Subject: [PATCH] arm/imx6: Add debug UART2
Message-ID: <1335514545-13481-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to enable early debugging on boards using the UART2 for the
console, add the option for early debugging on UART2.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug                       |    8 ++++++++
 arch/arm/mach-imx/lluart.c                   |    6 ++++++
 arch/arm/plat-mxc/include/mach/debug-macro.S |    2 ++
 arch/arm/plat-mxc/include/mach/mx6q.h        |    2 ++
 4 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 85348a0..0f876c2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -180,6 +180,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX50 or i.MX53.
 
+	config DEBUG_IMX6Q_UART2
+		bool "i.MX6Q Debug UART2"
+		depends on SOC_IMX6Q
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX6Q UART2. This is correct for e.g. the SabreLite
+                  board.
+
 	config DEBUG_IMX6Q_UART4
 		bool "i.MX6Q Debug UART4"
 		depends on SOC_IMX6Q
diff --git a/arch/arm/mach-imx/lluart.c b/arch/arm/mach-imx/lluart.c
index 0213f8d..c40a34c 100644
--- a/arch/arm/mach-imx/lluart.c
+++ b/arch/arm/mach-imx/lluart.c
@@ -17,6 +17,12 @@
 #include <mach/hardware.h>
 
 static struct map_desc imx_lluart_desc = {
+#ifdef CONFIG_DEBUG_IMX6Q_UART2
+	.virtual	= MX6Q_IO_P2V(MX6Q_UART2_BASE_ADDR),
+	.pfn		= __phys_to_pfn(MX6Q_UART2_BASE_ADDR),
+	.length		= MX6Q_UART2_SIZE,
+	.type		= MT_DEVICE,
+#endif
 #ifdef CONFIG_DEBUG_IMX6Q_UART4
 	.virtual	= MX6Q_IO_P2V(MX6Q_UART4_BASE_ADDR),
 	.pfn		= __phys_to_pfn(MX6Q_UART4_BASE_ADDR),
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 8ddda36..761e45f 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -24,6 +24,8 @@
 #define UART_PADDR	MX51_UART1_BASE_ADDR
 #elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
 #define UART_PADDR	MX53_UART1_BASE_ADDR
+#elif defined (CONFIG_DEBUG_IMX6Q_UART2)
+#define UART_PADDR	MX6Q_UART2_BASE_ADDR
 #elif defined (CONFIG_DEBUG_IMX6Q_UART4)
 #define UART_PADDR	MX6Q_UART4_BASE_ADDR
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/mx6q.h b/arch/arm/plat-mxc/include/mach/mx6q.h
index 254a561..f7e7dba 100644
--- a/arch/arm/plat-mxc/include/mach/mx6q.h
+++ b/arch/arm/plat-mxc/include/mach/mx6q.h
@@ -27,6 +27,8 @@
 #define MX6Q_CCM_SIZE			0x4000
 #define MX6Q_ANATOP_BASE_ADDR		0x020c8000
 #define MX6Q_ANATOP_SIZE		0x1000
+#define MX6Q_UART2_BASE_ADDR		0x021e8000
+#define MX6Q_UART2_SIZE			0x4000
 #define MX6Q_UART4_BASE_ADDR		0x021f0000
 #define MX6Q_UART4_SIZE			0x4000
 
-- 
1.7.0.4
