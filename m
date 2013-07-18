From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 18 Jul 2013 22:34:55 +0400
Subject: [PATCH 04/10] ARM: clps711x: edb7211: Remove extra iotable_init() call
In-Reply-To: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374172501-26796-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The keyboard driver for the CLPS711X platform is missing, so there
is no need to call iotable_init() for this memory region.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-edb7211.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index 9dfb990..fe6184e 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -126,21 +126,6 @@ static struct gpio edb7211_gpios[] __initconst = {
 	{ EDB7211_LCDBL,	GPIOF_OUT_INIT_LOW,	"LCD BACKLIGHT" },
 };
 
-static struct map_desc edb7211_io_desc[] __initdata = {
-	{	/* Memory-mapped extra keyboard row */
-		.virtual	= IO_ADDRESS(EDB7211_EXTKBD_BASE),
-		.pfn		= __phys_to_pfn(EDB7211_EXTKBD_BASE),
-		.length		= SZ_1M,
-		.type		= MT_DEVICE,
-	},
-};
-
-void __init edb7211_map_io(void)
-{
-	clps711x_map_io();
-	iotable_init(edb7211_io_desc, ARRAY_SIZE(edb7211_io_desc));
-}
-
 /* Reserve screen memory region at the start of main system memory. */
 static void __init edb7211_reserve(void)
 {
@@ -195,7 +180,7 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_edb7211,
 	.reserve	= edb7211_reserve,
-	.map_io		= edb7211_map_io,
+	.map_io		= clps711x_map_io,
 	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
-- 
1.8.1.5
