From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 15 Oct 2010 15:46:24 +0300
Subject: [PATCH 2/2] omap: rx51: mark reserved memory earlier
In-Reply-To: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
Message-ID: <1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that omap_vram_set_sdram_vram() is called before
omap_vram_reserve_sdram_memblock().

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/board-rx51.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index a58e8cb..861079b 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -144,17 +144,22 @@ static void __init rx51_init(void)
 static void __init rx51_map_io(void)
 {
 	omap2_set_globals_3xxx();
-	rx51_video_mem_init();
 	omap34xx_map_common_io();
 }
 
+static void __init rx51_reserve(void)
+{
+	rx51_video_mem_init();
+	omap_reserve();
+}
+
 MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= rx51_map_io,
-	.reserve	= omap_reserve,
+	.reserve	= rx51_reserve,
 	.init_irq	= rx51_init_irq,
 	.init_machine	= rx51_init,
 	.timer		= &omap_timer,
-- 
1.7.3.1.2.g7fe2b
