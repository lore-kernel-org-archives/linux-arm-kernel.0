From: vikram.pandita@ti.com (Vikram Pandita)
Date: Fri, 18 Sep 2009 19:39:40 -0500
Subject: [PATCH 2/2] OMAP: Zoom2: Add DEBUG_LL interface using Quart
In-Reply-To: <1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
References: <1253320780-19396-1-git-send-email-vikram.pandita@ti.com>
	<1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
Message-ID: <1253320780-19396-3-git-send-email-vikram.pandita@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DEBUG_LL interface for Zoom2 board.
The low level debug uart now points corrctly to External Quad uart
controller on detachable debug board.

The Quad uart is available over GPMC chip select with physical address
0x10000000.

This physical address has been mapped to virtual address 0xFB000000
as per static mapping.

This patch is adapted from a version by Erik Gilling:
http://android.git.kernel.org/?p=kernel/omap.git;
a=commit;h=e9d72efdd88877d2d6ea74a08983ace0dcc771d3

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Erik Gilling <konkers@android.com>
---
 arch/arm/mach-omap2/board-zoom2.c    |   18 ++++++++++++++++--
 arch/arm/plat-omap/debug-low-level.c |    2 ++
 arch/arm/plat-omap/include/mach/io.h |    6 ++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 324009e..abaee66 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -19,6 +19,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 
 #include <mach/common.h>
 #include <mach/usb.h>
@@ -269,15 +270,28 @@ static void __init omap_zoom2_init(void)
 	usb_musb_init();
 }
 
+static struct map_desc zoom2_io_desc[] __initdata = {
+	{
+		.virtual	= ZOOM2_EXT_QUART_VIRT,
+		.pfn		= __phys_to_pfn(ZOOM2_EXT_QUART_PHYS),
+		.length		= ZOOM2_EXT_QUART_SIZE,
+		.type		= MT_DEVICE
+	}
+};
+
 static void __init omap_zoom2_map_io(void)
 {
 	omap2_set_globals_343x();
+
+	/* Map external quad UART virt to phy mapping */
+	iotable_init(zoom2_io_desc, ARRAY_SIZE(zoom2_io_desc));
+
 	omap2_map_common_io();
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.phys_io	= ZOOM2_EXT_QUART_PHYS,
+	.io_pg_offst	= ((ZOOM2_EXT_QUART_VIRT) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap_zoom2_map_io,
 	.init_irq	= omap_zoom2_init_irq,
diff --git a/arch/arm/plat-omap/debug-low-level.c b/arch/arm/plat-omap/debug-low-level.c
index c134694..ea68440 100644
--- a/arch/arm/plat-omap/debug-low-level.c
+++ b/arch/arm/plat-omap/debug-low-level.c
@@ -15,6 +15,8 @@ u32 get_uart_base(void)
 {
 	static u32  omap_uart_debug_ll_phy_addr;
 
+	omap_uart_debug_ll_phy_addr = 0;
+
 	if (omap_uart_debug_ll_phy_addr)
 		return omap_uart_debug_ll_phy_addr;
 
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 8d32df3..d67f06c 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -169,6 +169,12 @@
 #define DSP_MMU_34XX_VIRT	0xe2000000
 #define DSP_MMU_34XX_SIZE	SZ_4K
 
+/* Map External Quad UART for Zoom2 board */
+#define ZOOM2_EXT_QUART_PHYS		0x10000000 /* PHY address if fixed */
+#define ZOOM2_EXT_QUART_PHY_TO_VIRT_OFF	0xEB000000
+#define ZOOM2_EXT_QUART_VIRT		0xFB000000
+#define ZOOM2_EXT_QUART_SIZE		SZ_16
+
 /*
  * ----------------------------------------------------------------------------
  * Omap4 specific IO mapping
-- 
1.6.5.rc0
