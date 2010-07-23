From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jul 2010 21:58:30 +0200
Subject: [PATCH 07/11] ARM: omap: move omapfb_reserve_sram() to .init.text
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1279915120-4373-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omapfb_reserve_sram() is only called by omap_detect_sram() which lives in
.init.text.  So this is save for omapfb_reserve_sram(), too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c   |    6 +++---
 arch/arm/plat-omap/sram.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 4df210f..4c0ae4d 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -233,7 +233,7 @@ void __init omapfb_reserve_sdram(void)
  * this point, since the driver built as a module would have problem with
  * freeing / reallocating the regions.
  */
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long pstart_avail,
@@ -360,7 +360,7 @@ static int __init omap_init_fb(void)
 arch_initcall(omap_init_fb);
 
 void __init omapfb_reserve_sdram(void) {}
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long start_avail,
@@ -376,7 +376,7 @@ void omapfb_set_platform_data(struct omapfb_platform_data *data)
 }
 
 void __init omapfb_reserve_sdram(void) {}
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long start_avail,
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 226b2e8..ccd6623 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -79,7 +79,7 @@ static unsigned long omap_sram_base;
 static unsigned long omap_sram_size;
 static unsigned long omap_sram_ceil;
 
-extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+extern unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 					 unsigned long sram_vstart,
 					 unsigned long sram_size,
 					 unsigned long pstart_avail,
-- 
1.7.1
