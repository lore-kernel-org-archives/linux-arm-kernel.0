From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed,  1 Sep 2010 20:51:00 +0300
Subject: [PATCH] ep93xx: move clock initialization earlier
Message-ID: <1283363460-25825-1-git-send-email-mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7cfe24947 ("ARM: AMBA: Add pclk support to AMBA bus infrastructure")
changed AMBA bus to handle the PCLK automatically. However, in EP93xx clock
initialization is arch_initcall() which is done later than AMBA device
identification. This causes amba_get_enable_pclk() to fail resulting device
where UARTs are not functional.

So move clock initialization code before any AMBA device registration.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
Note that I'm not sure whether ep93xx_map_io() is the best place for calling
clock init code. Alternative would be to put it in ep93xx_init_devices() just
before calls to amba_device_register().

Tested on ep9302 (ts-7260) and on ep9307 (Sim.One).

 arch/arm/mach-ep93xx/clock.c                 |    4 +---
 arch/arm/mach-ep93xx/core.c                  |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 8bf3cec..119e614 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -514,7 +514,7 @@ static void __init ep93xx_dma_clock_init(void)
 	clk_m2m1.rate = clk_h.rate;
 }
 
-static int __init ep93xx_clock_init(void)
+void __init ep93xx_clock_init(void)
 {
 	u32 value;
 
@@ -558,6 +558,4 @@ static int __init ep93xx_clock_init(void)
 		clk_p.rate / 1000000);
 
 	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
-	return 0;
 }
-arch_initcall(ep93xx_clock_init);
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 4cb55d3..04e1b25 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -65,6 +65,7 @@ static struct map_desc ep93xx_io_desc[] __initdata = {
 void __init ep93xx_map_io(void)
 {
 	iotable_init(ep93xx_io_desc, ARRAY_SIZE(ep93xx_io_desc));
+	ep93xx_clock_init();
 }
 
 
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 3330b36..9b732b1 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -20,6 +20,7 @@ struct ep93xx_eth_data
 
 void ep93xx_map_io(void);
 void ep93xx_init_irq(void);
+void ep93xx_clock_init(void);
 
 /* EP93xx System Controller software locked register write */
 void ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg);
-- 
1.5.6.5
