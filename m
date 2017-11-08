From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed,  8 Nov 2017 22:29:54 +0100
Subject: [PATCH] Kernel debugging: omap: print warning if CONFIG_DEBUG_LL is
 enabled
Message-ID: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d2b310b0234c ("ARM: debug: Use generic 8250 debug_ll for omap2 and omap3/4/5 common uarts")
commit fc23beb8a577 ("ARM: debug: Use generic 8250 debug_ll for omap3/4/5")

switched to generic 8250 debug_ll code which seems to be incompatible
with at least OMAP5 boards (OMAP5EVM, Pyra) if CONFIG_DEBUG_LL is
still enabled in some legacy defconfig. Since this is very hard to
relate to these patches and difficult to identify, let's have the
compiler emit a warning.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/include/debug/omap2plus.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
index 192a7583999c..3e7ea21cde2a 100644
--- a/arch/arm/include/debug/omap2plus.S
+++ b/arch/arm/include/debug/omap2plus.S
@@ -12,6 +12,10 @@
 
 #include <linux/serial_reg.h>
 
+#if defined(CONFIG_DEBUG_LL)
+#warning Please disable CONFIG_DEBUG_LL and enable CONFIG_SERIAL_EARLYCON or OMAP5 devices will not boot
+#endif
+
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
 #define ZOOM_UART_VIRT		0xfa400000
-- 
2.12.2
