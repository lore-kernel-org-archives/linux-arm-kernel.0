From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Oct 2010 10:49:55 +0200
Subject: [PATCH 6/7] imx/debug-macro: rework using the new io mapping macro
In-Reply-To: <20101022175702.GI19834@pengutronix.de>
References: <20101022175702.GI19834@pengutronix.de>
Message-ID: <1288082996-21981-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of the last user of IMX_NEEDS_DEPRECATED_SYMBOLS.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |   23 +++++++----------------
 arch/arm/plat-mxc/include/mach/mx25.h        |    4 ----
 arch/arm/plat-mxc/include/mach/mx2x.h        |    5 -----
 arch/arm/plat-mxc/include/mach/mx3x.h        |    5 -----
 arch/arm/plat-mxc/include/mach/mx51.h        |    5 -----
 5 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 2560640..8170894 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -10,58 +10,49 @@
  * published by the Free Software Foundation.
  *
  */
-#define IMX_NEEDS_DEPRECATED_SYMBOLS
+#include <mach/hardware.h>
 
 #ifdef CONFIG_ARCH_MX1
-#include <mach/mx1.h>
-#define UART_PADDR	UART1_BASE_ADDR
-#define UART_VADDR	IO_ADDRESS(UART1_BASE_ADDR)
+#define UART_PADDR	MX1_UART1_BASE_ADDR
 #endif
 
 #ifdef CONFIG_ARCH_MX25
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
-#include <mach/mx25.h>
 #define UART_PADDR	MX25_UART1_BASE_ADDR
-#define UART_VADDR	MX25_AIPS1_IO_ADDRESS(MX25_UART1_BASE_ADDR)
 #endif
 
 #ifdef CONFIG_ARCH_MX2
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
-#include <mach/mx2x.h>
-#define UART_PADDR	UART1_BASE_ADDR
-#define UART_VADDR	AIPI_IO_ADDRESS(UART1_BASE_ADDR)
+#define UART_PADDR	MX2x_UART1_BASE_ADDR
 #endif
 
 #ifdef CONFIG_ARCH_MX3
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
-#include <mach/mx3x.h>
-#define UART_PADDR	UART1_BASE_ADDR
-#define UART_VADDR	AIPS1_IO_ADDRESS(UART1_BASE_ADDR)
+#define UART_PADDR	MX3x_UART1_BASE_ADDR
 #endif
 
 #ifdef CONFIG_ARCH_MX5
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
-#include <mach/mx51.h>
 #define UART_PADDR	MX51_UART1_BASE_ADDR
-#define UART_VADDR	MX51_AIPS1_IO_ADDRESS(MX51_UART1_BASE_ADDR)
 #endif
 
 #ifdef CONFIG_ARCH_MXC91231
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
-#include <mach/mxc91231.h>
 #define UART_PADDR	MXC91231_UART2_BASE_ADDR
-#define UART_VADDR	MXC91231_IO_ADDRESS(MXC91231_UART2_BASE_ADDR)
 #endif
+
+#define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
+
 		.macro	addruart, rx, tmp
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index aac6a9c..a2404b0 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -2,7 +2,6 @@
 #define __MACH_MX25_H__
 
 #define MX25_AIPS1_BASE_ADDR		0x43f00000
-#define MX25_AIPS1_BASE_ADDR_VIRT	0xf5300000
 #define MX25_AIPS1_SIZE			SZ_1M
 #define MX25_AIPS2_BASE_ADDR		0x53f00000
 #define MX25_AIPS2_SIZE			SZ_1M
@@ -25,9 +24,6 @@
 #define MX25_GPIO2_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xd0000)
 #define MX25_WDOG_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xdc000)
 
-#define MX25_AIPS1_IO_ADDRESS(x) \
-	(((x) - MX25_AIPS1_BASE_ADDR) + MX25_AIPS1_BASE_ADDR_VIRT)
-
 #define MX25_UART1_BASE_ADDR		0x43f90000
 #define MX25_UART2_BASE_ADDR		0x43f94000
 #define MX25_AUDMUX_BASE_ADDR		0x43fb0000
diff --git a/arch/arm/plat-mxc/include/mach/mx2x.h b/arch/arm/plat-mxc/include/mach/mx2x.h
index 46eeeb2..a056948 100644
--- a/arch/arm/plat-mxc/include/mach/mx2x.h
+++ b/arch/arm/plat-mxc/include/mach/mx2x.h
@@ -27,7 +27,6 @@
 
 /* Register offsets */
 #define MX2x_AIPI_BASE_ADDR		0x10000000
-#define MX2x_AIPI_BASE_ADDR_VIRT	0xf4400000
 #define MX2x_AIPI_SIZE			SZ_1M
 #define MX2x_DMA_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x01000)
 #define MX2x_WDOG_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x02000)
@@ -68,9 +67,6 @@
 #define MX2x_SAHB1_SIZE			SZ_1M
 #define MX2x_CSI_BASE_ADDR			(MX2x_SAHB1_BASE_ADDR + 0x0000)
 
-#define AIPI_IO_ADDRESS(x)	\
-	(((x) - AIPI_BASE_ADDR) + AIPI_BASE_ADDR_VIRT)
-
 /* fixed interrupt numbers */
 #define MX2x_INT_CSPI3		6
 #define MX2x_INT_GPIO		8
@@ -148,7 +144,6 @@
 #ifdef IMX_NEEDS_DEPRECATED_SYMBOLS
 /* these should go away */
 #define AIPI_BASE_ADDR MX2x_AIPI_BASE_ADDR
-#define AIPI_BASE_ADDR_VIRT MX2x_AIPI_BASE_ADDR_VIRT
 #define AIPI_SIZE MX2x_AIPI_SIZE
 #define DMA_BASE_ADDR MX2x_DMA_BASE_ADDR
 #define WDOG_BASE_ADDR MX2x_WDOG_BASE_ADDR
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index da22cd4..3d6cc45 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -44,7 +44,6 @@
  * AIPS 1
  */
 #define MX3x_AIPS1_BASE_ADDR		0x43f00000
-#define MX3x_AIPS1_BASE_ADDR_VIRT	0xf5300000
 #define MX3x_AIPS1_SIZE			SZ_1M
 #define MX3x_MAX_BASE_ADDR			(MX3x_AIPS1_BASE_ADDR + 0x04000)
 #define MX3x_EVTMON_BASE_ADDR			(MX3x_AIPS1_BASE_ADDR + 0x08000)
@@ -141,9 +140,6 @@
 
 #define MX3x_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
-#define AIPS1_IO_ADDRESS(x)  \
-	(((x) - AIPS1_BASE_ADDR) + AIPS1_BASE_ADDR_VIRT)
-
 /*
  * Interrupt numbers
  */
@@ -230,7 +226,6 @@ static inline int mx35_revision(void)
 #define L2CC_BASE_ADDR MX3x_L2CC_BASE_ADDR
 #define L2CC_SIZE MX3x_L2CC_SIZE
 #define AIPS1_BASE_ADDR MX3x_AIPS1_BASE_ADDR
-#define AIPS1_BASE_ADDR_VIRT MX3x_AIPS1_BASE_ADDR_VIRT
 #define AIPS1_SIZE MX3x_AIPS1_SIZE
 #define MAX_BASE_ADDR MX3x_MAX_BASE_ADDR
 #define EVTMON_BASE_ADDR MX3x_EVTMON_BASE_ADDR
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 1b8715f..636347c 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -53,7 +53,6 @@
  * AIPS 1
  */
 #define MX51_AIPS1_BASE_ADDR		0x73f00000
-#define MX51_AIPS1_BASE_ADDR_VIRT	0xf5700000
 #define MX51_AIPS1_SIZE			SZ_1M
 
 #define MX51_OTG_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x80000)
@@ -137,10 +136,6 @@
 #define MX51_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX51_IO_ADDRESS(x)		IOMEM(MX51_IO_P2V(x))
 
-/* This is currently used in <mach/debug-macro.S>, but should go away */
-#define MX51_AIPS1_IO_ADDRESS(x)  \
-	(((x) - MX51_AIPS1_BASE_ADDR) + MX51_AIPS1_BASE_ADDR_VIRT)
-
 /*
  * defines for SPBA modules
  */
-- 
1.7.2.3
