From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Mar 2010 17:18:45 -0700
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Message-ID: <mailman.255.1269045983.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zoom2 and 3 have UARTs only on the external debug board.
GPMC needs to be mapped early to use it for DEBUG_LL.

Note that with the pending serial.c patches you need to
set console=ttyS0,115200n8 as it will be the only UART
mapped. To use DEBUG_LL, you need to pass also earlyprintk
in cmdline.

Cc: Allen Pais <allen.pais@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..355e87d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -328,6 +328,15 @@ __create_page_tables:
 	add	r0, r4, #0xd8000000 >> 18
 	str	r3, [r0]
 #endif
+#if defined(CONFIG_MACH_OMAP_ZOOM2) || defined(CONFIG_MACH_OMAP_ZOOM3)
+	/*
+	 * Zoom2 and Zoom3 have UARTs only on the debug board.
+	 * The debug board is connected to the GPMC.
+	 */
+	add	r0, r4, #0xfb000000 >> 18
+	orr	r3, r7, #0x10000000
+	str	r3, [r0]
+#endif
 #endif
 	mov	pc, lr
 ENDPROC(__create_page_tables)

--jq0ap7NbKX2Kqbes--
