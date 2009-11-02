From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 2 Nov 2009 11:55:12 +0100
Subject: [PATCH 3/3] msm: Add memory map for HTC Dream
Message-ID: <20091102105512.GA23559@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add memory map to HTC Dream, so that boot can proceed further.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- linux-good//arch/arm/mach-msm/board-dream.c	2009-11-02 11:54:12.000000000 +0100
+++ linux-dream-mainline/arch/arm/mach-msm/board-dream.c	2009-11-02 11:11:47.000000000 +0100
@@ -21,6 +21,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/setup.h>
 
 #include <mach/board.h>
 #include <mach/hardware.h>
@@ -44,6 +45,15 @@
 	msm_init_irq();
 }
 
+static void __init trout_fixup(struct machine_desc *desc, struct tag *tags,
+				char **cmdline, struct meminfo *mi)
+{
+	mi->nr_banks = 1;
+	mi->bank[0].start = PHYS_OFFSET;
+	mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
+	mi->bank[0].size = (101*1024*1024);
+}
+
 static void __init trout_init(void)
 {
 	platform_add_devices(devices, ARRAY_SIZE(devices));
@@ -77,6 +87,7 @@
 	.io_pg_offst	= ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
 #endif
 	.boot_params	= 0x10000100,
+	.fixup		= trout_fixup,
 	.map_io		= trout_map_io,
 	.init_irq	= trout_init_irq,
 	.init_machine	= trout_init,

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
