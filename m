From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2010 16:51:36 -0800
Subject: [PATCH 12/19] omap3: pm: Add T2 Keypad as a wakeup source
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Message-ID: <20100212005136.24958.20312.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lesly A M <x0080970@ti.com>

Changes for setting the padconf value for sys_nirq line which is
connected to T2 INTR1. This will fix the T2 keypad wakeup.

Signed-off-by: Lesly A M <x0080970@ti.com>
Signed-off-by: Teerth Reddy <teerth@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 4278d5e..9a0821f 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -24,6 +24,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 
+#include "mux.h"
 #include "hsmmc.h"
 
 /* Zoom2 has Qwerty keyboard*/
@@ -263,9 +264,17 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
+static void enable_board_wakeup_source(void)
+{
+	/* T2 interrupt line (keypad) */
+	omap_mux_init_signal("sys_nirq",
+		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
+}
+
 void __init zoom_peripherals_init(void)
 {
 	omap_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
+	enable_board_wakeup_source();
 }
